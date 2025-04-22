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
#include "lexer.h"

#include <stdlib.h>
#include <ctype.h>

static const char* spaces(const char *buffer)
{
	while(isspace(*buffer))
		buffer++;

	return buffer;
}

const char *lexer(const char *buffer, struct token *token)
{
	buffer = spaces(buffer);

	if(0 == *buffer) {
		token->type = TOK_END;
		return buffer;
	}

	if('(' == *buffer) {
		token->type = TOK_LPAREN;
		return buffer + 1;
	}

	if(')' == *buffer) {
		token->type = TOK_RPAREN;
		return buffer + 1;
	}

	if('+' == *buffer) {
		token->type = TOK_PLUS;
		return buffer + 1;
	}

	if('-' == *buffer) {
		token->type = TOK_MINUS;
		return buffer + 1;
	}

	if('*' == *buffer) {
		token->type = TOK_MULT;
		return buffer + 1;
	}

	if(isdigit(*buffer)) {
		token->type   = TOK_NUMBER;
		token->number = 0;

		do {
			token->number *= 10;
			token->number += (*buffer) - '0';
			buffer++;
		} while(isdigit(*buffer));

		return buffer;
	}

	// Error
	return NULL;
}
