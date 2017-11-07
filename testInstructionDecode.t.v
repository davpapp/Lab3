`include "instructionDecoderR.v"
`include "instructionDecoderI.v"
`include "instructionDecoderJ.v"

module testInstructionDecode();
	reg[31:0] instruction;

	wire[5:0] opcode;
	wire[4:0] Rs;
	wire[4:0] Rt;
	wire[4:0] Rd;
	wire[10:0] rest;
	wire[15:0] imm;
	wire[25:0] jump_target;

	instructionDecoderR ID_R(.instruction(instruction[31:0]),
							.opcode(opcode),
							.Rs(Rs),
							.Rt(Rt),
							.Rd(Rd),
							.rest(rest));
	instructionDecoderI ID_I(.instruction(instruction[31:0]),
							.opcode(opcode),
							.Rs(Rs),
							.Rt(Rt),
							.imm(imm));
	instructionDecoderJ ID_J(.instruction(instruction[31:0]),
							.opcode(opcode),
							.jump_target(jump_target));


	task checkResult;
		input[5:0] exp_opcode;
		input[5:0] opcode;


		if (opcode == exp_opcode) begin
			$display("Passed.");
		end
		else begin
			$display("Failed");
			$display(opcode);
		end
	endtask

	initial begin
	    instruction = 32'b00000000000000000000000000000000; #10
	    checkResult(6'b000000, opcode);
	end // initial*/
endmodule