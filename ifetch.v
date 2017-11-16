`include "memory.v"
`include "dff.v"
`include "mux.v"
`include "add32bit.v"

module ifetch
	(
		input clk,                // clk updates the PC
		input write_pc,           // if write_pc is high, pc can change
		input is_branch,          // is_branch selects between add 4 (0) and add branch (1) 
		input  is_jump,           // is jump selects between incrementing by 4/branch (0) or putting PC to jump_addr (1)
		input [15:0] branch_addr, // add this to PC to go to the branch location
		input [25:0] jump_addr,   // instruction memory address to jump to
		output[31:0] out,         // returns instruction encoding (32 bits)
		output[31:0] pc           // returns the PC for use in JAL
		);

	wire [31:0] pc_next, to_add, increased_pc; // create connecting wires
	reg [31:0] pc = 32'd0, branch_addr_full = 32'd4; // pc keeps track of position, branch_addr_full is the sign extended version of branch_addr 

	// Get instruction encoding from the instruction memory
	memory program_mem(.clk(clk), // only happens on clock edge
						.regWE(0), // We don't want to write to instruction memory
						.Addr(pc), // pc is the 32 bit address
						.DataIn(32'b0), // doesn't actually matter, we're not writing
						.DataOut(out)); // this will be instruction encoding

	mux2to1by32 should_branch(.out(to_add), // to_add is either 4 or the branch value
						.address(is_branch), // selector
						.input0(32'd4),      // constant 4 (normal incrememnt)
						.input1({{16{branch_addr[15]}}, branch_addr})); // second option is the se branch addr

	add32bit add_to_pc(.a(pc), // pc is base
						.b(to_add), // add to_add
						.c(increased_pc), // the potential incremented value
						.overflow(_)); // I don't think we care about overflow

	mux2to1by32 should_jump(.out(pc_next), // next PC value
						.address(is_jump), // chooses either the incrememnted value (4/branch) or a jump
						.input0(increased_pc),
						.input1({pc[31:28], jump_addr, 2'b0}));

	always @(posedge clk) begin // update on clock
		//branch_addr_full <= {{16{branch_addr[15]}}, branch_addr}; // se branch_addr
		if(write_pc == 1) begin // register!
			pc <= pc_next;
		end
	end

	// having a should_branch and should_jump here gets messy
	// I'm making a Control black-box that takes the opcode (first 6 bits of the instructions)
	// and sets a bunch of single registers accordingly.
	// For example, when the opcode is a 2, which will correspond to jump (see control.v)
	// writeEnable might be disabled.
	// written by: David
	
endmodule