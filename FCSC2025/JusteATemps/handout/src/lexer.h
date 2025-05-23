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
#pragma once

struct token {
	enum {
		TOK_END,
		TOK_NUMBER,

		TOK_LPAREN,
		TOK_RPAREN,

		TOK_PLUS,
		TOK_MULT,
		TOK_MINUS,
//		TOK_SLASH,
	} type;
	union {
		long number;
	};
};

const char *lexer(const char *buffer, struct token *token);
