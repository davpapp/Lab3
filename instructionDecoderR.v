
module instructionDecoderR (
	input[31:0] instruction,
	output[5:0] opcode,
	output[4:0] Rs,
	output[4:0] Rt,
	output[4:0] Rd,
	output[10:0] rest
);
	// R-type
	wire[5:0] opcode = instruction[31:26];
	wire[4:0] Rs = instruction[25:21];
	wire[4:0] Rt = instruction[20:16];
	wire[4:0] Rd = instruction[15:11];
	wire[10:0] rest = instruction[10:0]; // not sure what to do with this

endmodule
