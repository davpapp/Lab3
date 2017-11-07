
module instructionDecoderR (
	input[31:0] instruction,
	output[5:0] opcode
	/*output reg[4:0] Rs,
	output reg[4:0] Rt,
	output reg[4:0] Rd,
	output reg[10:0] rest*/
);
	// R-type
	//reg[5:0]
	 opcode = instruction[31:26];
	/*assign Rs = instruction[25:21];
	assign Rt = instruction[20:16];
	assign Rd = instruction[15:11];
	assign rest = instruction[10:0]; // not sure what to do with this*/

endmodule
