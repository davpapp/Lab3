
module instructionDecoderI (
	input[31:0] instruction,
	output[5:0] opcode,
	output[4:0] Rs,
	output[4:0] Rt,
	output[15:0] imm
);
	// I-type
	wire[5:0] opcode = instruction[31:26];
	wire[4:0] Rs = instruction[25:21];
	wire[4:0] Rt = instruction[20:16];
	wire[15:0] imm = instruction[15:0];

endmodule
