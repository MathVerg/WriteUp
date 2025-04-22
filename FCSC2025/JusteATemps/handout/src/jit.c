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
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>

#include "parser.h"

static size_t emit_insns(void *map, const void *insns, size_t size)
{
	memcpy(map, insns, size);
	return size;
}

static size_t emit_op2(void *map, const void *insns, size_t size)
{
	static const unsigned char prologue[] = {
		0x5A, // pop rdx
		0x58, // pop rax
	};

	static const unsigned char epilogue[] = {
		0x50, // push rax
	};

	size_t ret = 0;

	ret += emit_insns(map + ret, prologue, sizeof(prologue));
	ret += emit_insns(map + ret, insns, size);
	ret += emit_insns(map + ret, epilogue, sizeof(epilogue));

	return ret;
}

static size_t emit_push8(void *map, char n)
{
	const unsigned char insns[] = {
		0x6A, n, // push n
	};
	return emit_insns(map, insns, sizeof(insns));
}

static size_t emit_push32(void *map, int n)
{
	const unsigned char insns[] = {
		0x68, n, n >> 8, n >> 16, n >> 24 // push n
	};
	return emit_insns(map, insns, sizeof(insns));
}

static size_t emit_push64(void *map, long n)
{
	const unsigned char insns[] = {
		0x48, 0xB8, n, n >> 8, n >> 16, n >> 24,
			n >> 32, n >> 40, n >> 48, n >> 56, // mov rax, n
		0x50, // push rax
	};
	return emit_insns(map, insns, sizeof(insns));
}

static size_t emit_push(void *map, long n)
{
	if(CHAR_MIN <= n && n <= CHAR_MAX)
		return emit_push8(map, n);

	if(INT_MIN <= n && n <= INT_MAX)
		return emit_push32(map, n);

	return emit_push64(map, n);
}

static size_t emit_add(void *map)
{
	static const unsigned char insns[] = {
		0x48, 0x01, 0xD0, // add rax, rdx
	};

	return emit_op2(map, insns, sizeof(insns));
}

static size_t emit_sub(void *map)
{
	static const unsigned char insns[] = {
		0x48, 0x29, 0xD0, // sub rax, rdx
	};

	return emit_op2(map, insns, sizeof(insns));
}

static size_t emit_mul(void *map)
{
	static const unsigned char insns[] = {
		0x48, 0xF7, 0xE2, // mul rdx
	};

	return emit_op2(map, insns, sizeof(insns));
}

static size_t emit_epilogue(void *map)
{
	static const unsigned char insns[] = {
		0x58, // pop rax
		0xC3, // ret
	};
	return emit_insns(map, insns, sizeof(insns));
}

static size_t process(void *map, const struct op *ast)
{
	if(OP_NUMBER == ast->type)
		return emit_push(map, ast->number);

	size_t ret = 0;

	switch(ast->type) {
	case OP_ADD:
		ret += process(map + ret, ast->left);
		ret += process(map + ret, ast->right);
		ret += emit_add(map + ret);
		break;

	case OP_SUBTRACT:
		ret += process(map + ret, ast->left);
		ret += process(map + ret, ast->right);
		ret += emit_sub(map + ret);
		break;

	case OP_MULTIPLY:
		ret += process(map + ret, ast->left);
		ret += process(map + ret, ast->right);
		ret += emit_mul(map + ret);
		break;

	default:
		exit(EXIT_FAILURE); // ????
	}

	return ret;
}

size_t compile(void *map, const struct op *ast)
{
	//op_dump(ast);

	size_t s = process(map, ast);
	return s + emit_epilogue(map + s);
}
