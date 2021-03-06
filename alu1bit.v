// ALU1bit is a 1-Bit arithmetic logic unit
// It performs the following operations:
// b000 -> ADD
// b001 -> SUB
// b010 -> XOR
// b011 -> SLT
// b100 -> AND
// b101 -> NAND
// b110 -> NOR
// b111 -> OR

`include "mux3bit.v"
`include "adder1bit.v"
`include "subtractor1bit.v"
`define AND and #30
`define OR or #30
`define NOT not #10
`define XOR xor #30
`define NOR nor #20
`define NAND nand #20


module ALU1bit
(
  output      out,
  output      cout,
  input       a,
  input       b,
  input       cin,
  input[2:0]  op
);
	// Add
	wire res_ADD;
	wire cout_ADD;
	Adder1bit adder(res_ADD, cout_ADD, a, b, cin);

	// Subtract
	wire res_SUB;
	wire cout_SUB;
	Subtractor1bit subtractor(res_SUB, cout_SUB, a, b, cin);

	// Xor
	wire res_XOR;
	`XOR(res_XOR, a, b);

	// SLT
	wire res_SLT;
	wire cout_SLT;
	Subtractor1bit slt(res_SLT, cout_SLT, a, b, cin);

	// And
	wire res_AND;
	`AND(res_AND, a, b);

	// Nand
	wire res_NAND;
	`NAND(res_NAND, a, b);

	// Nor
	wire res_NOR;
	`NOR(res_NOR, a, b);

	// Or
	wire res_OR;
	`OR(res_OR, a, b);

	// Use a behavioral mux to select operation
	wire[7:0] muxRes = {res_OR, res_NOR, res_NAND, res_AND, res_SLT, res_XOR, res_SUB, res_ADD};
	wire[7:0] muxCout = {1'b0, 1'b0, 1'b0, 1'b0, cout_SLT, 1'b0, cout_SUB, cout_ADD};
	MUX3bit mux1(out, op, muxRes);
	MUX3bit mux2(cout, op, muxCout);

endmodule