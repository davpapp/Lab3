`include "memory.v"
`include "dff.v"
`include "mux.v"
`include "add32bit.v"

module ifetch
	(
		input clk, write_pc, is_branch, is_jump,
		input [15:0] branch_addr,
		input [31:0] jump_addr,
		output[31:0] out
		);

	wire [31:0] pc_current, pc_next, to_add, increased_pc;
	wire [31:0] branch_addr_full;

	assign branch_addr_full = {{16{branch_addr[15]}}, branch_addr};

	memory program_mem(.clk(clk),
						.regWE(0),
						.Addr(pc_current),
						.DataIn(32'b0),
						.DataOut(out));

	dff #(32) pc_reg(.clk(clk),
					.ce(write_pc),
					.dataIn(pc_next),
					.dataOut(pc_current));

	mux2to1by32 should_branch(.out(to_add),
						.address(is_branch),
						.input0(32'h4),
						.input1(branch_addr_full));

	add32bit add_to_pc(.a(pc_current),
						.b(to_add),
						.c(increased_pc),
						.overflow(_));

	mux2to1by32 should_jump(.out(pc_next),
						.address(is_jump),
						.input0(branch_addr_full),
						.input1(jump_addr));
endmodule