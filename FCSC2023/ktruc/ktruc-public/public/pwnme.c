/* SPDX-License-Identifier: GPL-2.0-or-later
 *
 * This program is free software: you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation, either version 2 of the License, or (at your option) any later
 * version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
 * details.
 *
 * You should have received a copy of the GNU General Public License along with
 * this program. If not, see <https://www.gnu.org/licenses/>.
 */
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/proc_fs.h>

#define PROC_NAME "pwnme"

struct fatptr {
	void *data;
	size_t size;
};

struct args_create { size_t size; };
struct args_switch { long index;  };

#define IOCTL_CREATE _IOW('p', 0, struct args_create)
#define IOCTL_SWITCH _IOW('p', 1, struct args_switch)

static struct fatptr *banks = NULL;
static size_t count = 0;
static long index = 0;

DEFINE_MUTEX(lock);

static int getData(void **data, size_t *length, off_t offset, size_t size)
{
	void *d;
	size_t s;

	// You must create an object first
	if(0 == count)
		return -ENXIO;

	// This can only happen during init (when count == 0)
	BUG_ON(index > count);

	// banks might be reallocated somewhere else, lock the mutex
	mutex_lock(&lock);
	d = banks[index].data;
	s = banks[index].size;
	mutex_unlock(&lock);

	*length = offset + size < s ? size : s - offset;
	*data   = d + offset;

	return 0;
}

static ssize_t
mod_read(struct file *file, char __user *out, size_t size, loff_t *off)
{
	void *data;
	size_t len;

	int r = getData(&data, &len, *off, size);
	if(0 != r)
		return r;

	if(copy_to_user(out, data, len))
		return -EFAULT;

	return len;
}

static ssize_t
mod_write(struct file *file, const char __user *out, size_t size, loff_t *off)
{
	void *data;
	size_t len;

	int r = getData(&data, &len, *off, size);
	if(0 != r)
		return r;

	if(copy_from_user(data, out, len))
		return -EFAULT;

	return len;
}

static long ioctl_create(const struct args_create __user *ptr)
{
	struct args_create args;
	void *data;

	if(copy_from_user(&args, ptr, sizeof(args)))
		return -EFAULT;

	// Allocate a new buffer
	data = kmalloc(args.size, GFP_KERNEL);
	if(NULL == data)
		return -ENOMEM;

	// Push the new object
	mutex_lock(&lock);
	banks = krealloc(banks, sizeof(*banks) * (count + 1), GFP_KERNEL);
	banks[count] = (struct fatptr){
		.data = data,
		.size = args.size,
	};
	mutex_unlock(&lock);

	return count++;
}

static long ioctl_switch(const struct args_switch __user *ptr)
{
	struct args_switch args;

	if(copy_from_user(&args, ptr, sizeof(args)))
		return -EFAULT;

	if(args.index > count)
		return -EINVAL;

	index = args.index;
	return index;
}

static long mod_ioctl(struct file *file, unsigned int arg, unsigned long ptr)
{
	switch(arg) {
		case IOCTL_CREATE:
			return ioctl_create((struct args_create*)ptr);

		case IOCTL_SWITCH:
			return ioctl_switch((struct args_switch*)ptr);

		default:
			return -ENOSYS;
	}
}

static struct proc_dir_entry *entry;

static int __init ctor(void)
{
	static const struct proc_ops ops = {
		.proc_read  = mod_read,
		.proc_write = mod_write,
		.proc_ioctl = mod_ioctl,
	};

	entry = proc_create(PROC_NAME, 0, NULL, &ops);

	if(!entry)
		return -ENOMEM;

	return 0;
}

static void __exit dtor(void)
{
	proc_remove(entry);

	for(size_t i = 0; i < count; i++)
		kfree(banks[i].data);

	kfree(banks);
}

module_init(ctor);
module_exit(dtor);

MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("Vulnerable device driver for FCSC 2023");
