
module instructionDecoderJ (
	input[31:0] instruction,
	output[5:0] opcode,
	output[25:0] jump_target
);
		// J-type
	wire[5:0] opcode = instruction[31:26];
	wire[25:0] jump_target = instruction[25:0];

endmodule
