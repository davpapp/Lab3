`include "instructionDecoderR.v"
//`include "instructionDecoderI.v"
//`include "instructionDecoderJ.v"

module testInstructionDecode();
	reg[31:0] instruction;

	reg[5:0] opcode;
	reg[5:0] Rs;
	reg[4:0] Rt;
	reg[4:0] Rd;
	reg[10:0] rest;
	reg[15:0] imm;
	reg[25:0] jump_target;

	instructionDecoderR ID_R(instruction, opcode/*, Rs, Rt, Rd, rest*/);
	//instructionDecoderR ID_I(instruction, opcode, Rs, Rt, imm);
	//instructionDecoderR ID_J(instruction, opcode, jump_target);


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
	    instruction = 32'b00000000000000000000000000000000; #10
	    checkResult(6'b000000, opcode);
	end // initial
endmodule