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
#include "parser.h"

#include <stdio.h>
#include <stdlib.h>

#include "lexer.h"

/* Grammar
 * expression = term (('+' | '-') term)*
 * term       = factor (('*' | '/') factor)*
 * factor     = number | '(' expression ')'
 * number     = [0-9]+
 *
 * TODO: oops, I forgot negative numbers were a thing xD
 *       you can do (0-n) to get a negative number
 */
static struct op *op_number(long n)
{
	struct op *ret = malloc(sizeof(*ret));

	if(NULL == ret)
		return NULL;

	ret->type   = OP_NUMBER;
	ret->number = n;

	return ret;
}

static struct op *op_op(enum operand type, struct op *left, struct op *right)
{
	struct op *ret = malloc(sizeof(*ret));

	if(NULL == ret)
		return NULL;

	ret->type  = type;
	ret->left  = left;
	ret->right = right;

	return ret;
}

static const char* term  (const char *buffer, struct op **tree);
static const char* factor(const char *buffer, struct op **tree);

static const char* factor(const char *buffer, struct op **tree)
{
	struct op *op = NULL;

	struct token tok;
	buffer = lexer(buffer, &tok);

	if(NULL == buffer)
		return NULL;

	// number
	if(TOK_NUMBER == tok.type) {
		op = op_number(tok.number);
		if(NULL == op)
			return NULL;

		*tree = op;
		return buffer;
	}

	// parenthesis
	if(TOK_LPAREN == tok.type) {
		buffer = parse(buffer, &op);
		if(NULL == buffer)
			return NULL;

		// ensure we have an rpar
		buffer = lexer(buffer, &tok);
		if(NULL == buffer || TOK_RPAREN != tok.type) {
			op_del(op);
			return NULL;
		}

		*tree = op;
		return buffer;
	}

	// Invalid token
	return NULL;
}

static const char* term(const char *buffer, struct op **tree)
{
	struct op *left = NULL;
	buffer = factor(buffer, &left);

	if(NULL == left)
		return NULL;

	while(1) {
		struct token tok;

		const char *p = lexer(buffer, &tok);
		if(NULL == p) {
			op_del(left);
			return NULL;
		}

		if(TOK_MULT != tok.type)
			break;

		struct op *right = NULL;
		buffer = factor(p, &right);

		if(NULL == buffer) {
			op_del(left);
			return NULL;
		}

		enum operand o = OP_MULTIPLY;
		left = op_op(o, left, right);
	}

	*tree = left;
	return buffer;
}

const char* parse(const char *buffer, struct op **tree)
{
	struct op *left = NULL;
	buffer = term(buffer, &left);

	if(NULL == left)
		return NULL;

	while(1) {
		struct token tok;
		const char *p = lexer(buffer, &tok);
		if(NULL == p) {
			op_del(left);
			return NULL;
		}

		if(TOK_PLUS != tok.type && TOK_MINUS != tok.type)
			break;

		struct op *right = NULL;
		buffer = term(p, &right);

		if(NULL == buffer) {
			op_del(left);
			return NULL;
		}

		enum operand o = TOK_PLUS == tok.type ? OP_ADD : OP_SUBTRACT;
		left = op_op(o, left, right);
	}

	*tree = left;
	return buffer;
}

void op_del(struct op *op)
{
	if(OP_NUMBER != op->type) {
		op_del(op->left);
		op_del(op->right);

		op->left  = NULL;
		op->right = NULL;
	}

	free(op);
}

void op_dump(const struct op *op)
{
	printf("%p ", op);

	if(OP_NUMBER == op->type)
		printf("OP_NUMBER   ");
	else if(OP_ADD == op->type)
		printf("OP_ADD      ");
	else if(OP_SUBTRACT == op->type)
		printf("OP_SUBTRACT ");
	else if(OP_MULTIPLY == op->type)
		printf("OP_MULTIPLY ");

	if(OP_NUMBER == op->type)
		printf("%ld\n", op->number);
	else {
		printf("%p %p\n", op->left, op->right);

		op_dump(op->left);
		op_dump(op->right);
	}
}
