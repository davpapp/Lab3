
module instructionDecoderR (
	input[31:0] instruction,
	output[5:0] opcode,
	output[4:0] Rs,
	output[4:0] Rt,
	output[4:0] Rd,
	output[10:0] rest
);
	// R-type
	assign opcode = instruction[31:26];
	assign Rs = instruction[25:21];
	assign Rt = instruction[20:16];
	assign Rd = instruction[15:11];
	assign rest = instruction[10:0];

endmodule
