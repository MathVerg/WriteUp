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
#include <sys/mman.h>
#include <string.h>
#include <stdbool.h>
#include <assert.h>
#include <limits.h>
#include <unistd.h>

#include "lexer.h"
#include "parser.h"
#include "jit.h"

#define SIZE (1 << 16)

[[noreturn]]
static void panic(void)
{
	static const char str[] = "\x1B[31mError\x1B[0m: too much maths\n"
		"Starting emergency procedure\n";
	write(STDOUT_FILENO, str, __builtin_strlen(str));

	sleep(3);

	_exit(EXIT_FAILURE);
	asm("hlt");
}

int main(int argc, char* const argv[static argc + 1])
{
	setlinebuf(stdout);

	// Allocate an rwx map for the JIT
	void *jit = mmap(NULL, SIZE, PROT_READ | PROT_WRITE | PROT_EXEC,
		MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);

	if(MAP_FAILED == jit) {
		perror("mmap");
		return EXIT_FAILURE;
	}

	printf("JIT page @ %p\n", jit);

	size_t s;
	char *buffer = NULL;

	while(0 < getline(&buffer, &s, stdin)) {
		// CE on calculators actually stands for "Clear and Execve"
		if(0 == strcmp(buffer, "clear\n")) {
			execv("/proc/self/exe", argv);
			perror("execve");
			exit(EXIT_FAILURE);
		}

		// Parse the line
		struct op *ast = NULL;
		const char *p = parse(buffer, &ast);
		if(NULL == p) {
			puts("Could not parse expression");
			continue;
		}

		// Ensure there's nothing left
		struct token tok;
		p = lexer(p, &tok);
		if(NULL == p || TOK_END != tok.type) {
			puts("Could not parse expression");
			continue;
		}

		// Compile the code to make it go fast
		size_t s = compile(jit, ast);

		// Compiled code is too large… try with smaller numbers?
		if(s > SIZE)
			panic();

		// We don't need the AST anymore
		op_del(ast);

		long (*f)(void) = jit;
		printf("%ld\n", f());
	}

	free(buffer);
	munmap(jit, SIZE);

	return EXIT_SUCCESS;
}
