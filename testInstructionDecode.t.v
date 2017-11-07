`include "instructionDecoderR.v"
`include "instructionDecoderI.v"
`include "instructionDecoderJ.v"

module testInstructionDecode();
	reg[31:0] instruction;

	wire[5:0] opcode;
	wire[5:0] Rs;
	wire[4:0] Rt;
	wire[4:0] Rd;
	wire[10:0] rest;
	wire[15:0] imm;
	wire[25:0] jump_target;

	instructionDecoderR ID_R(.instruction(instruction[31:0]),
							.opcode(opcode));
	/*instructionDecoderI ID_I(.instruction(instruction[31:0]),
							.opcode(opcode));
	instructionDecoderJ ID_J(.instruction(instruction[31:0]),
							.opcode(opcode));*/
							///*, Rs[4:0], Rt[4:0], Rd[4:0], rest[10:0]*/);
	//instructionDecoderI ID_I(instruction[31:0], opcode[6:0], Rs[4:0], Rt[4:0], imm[15:0]);
	//instructionDecoderJ ID_J(instruction, opcode, jump_target);


	function checkResult;
		input[5:0] exp_opcode;
		input[5:0] opcode;

		if (opcode == exp_opcode) begin
			$display("Passed.");
		end
		else begin
			$display("Failed");
		end
	endfunction

	initial begin
	    instruction = 32'b00000000000000000000000000000000;
	    checkResult(6'b000000, opcode);
	end // initial*/
endmodule