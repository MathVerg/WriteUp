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

enum operand {
	OP_NUMBER,
	OP_ADD,
	OP_SUBTRACT,
	OP_MULTIPLY,
};

struct op {
	enum operand type;
	union {
		long number;
		struct { struct op *left; struct op *right; };
	};
};

const char* parse(const char *buffer, struct op **tree);
void op_del(struct op *op);
void op_dump(const struct op *op);
