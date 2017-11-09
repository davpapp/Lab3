`include "instructionDecoderR.v"
`include "instructionDecoderI.v"
`include "instructionDecoderJ.v"

module testInstructionDecode();
	reg[31:0] instruction;

	wire[5:0] opcode;
	wire[4:0] Rs;
	wire[4:0] Rt;
	wire[4:0] Rd;
	wire[4:0] shift;
	wire[5:0] funct;
	wire[15:0] imm;
	wire[25:0] jump_target;

	instructionDecoderR ID_R(.instruction(instruction[31:0]),
							.opcode(opcode),
							.Rs(Rs),
							.Rt(Rt),
							.Rd(Rd),
							.shift(shift),
							.funct(funct));
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
		input[4:0] exp_rs, exp_rt, exp_rd, exp_imm, exp_jump_target;
		input[5:0] opcode, Rs, Rt, Rd, imm, jump_target;


		if ((opcode == exp_opcode) && (Rs == exp_rs) && (Rt == exp_rt) && (Rd == exp_rd) && (imm == exp_imm) && (jump_target == exp_jump_target)) begin
			$display("Passed.");
		end
		else begin
			$display("Failed");
			$display(opcode);
		end
	endtask

	initial begin
	    instruction = 32'b00000000000000000000000000000000; #10
	    checkResult(6'b000000, 5'b00000, 5'b00000, 5'b00000, 15'b000000000000000, 25'b0000000000000000000000000, opcode, Rs, Rt, Rd, imm, jump_target);

	    instruction = 32'b01000010001101010001000000000011; #10
	    checkResult(6'b010000, 5'b10001, 5'b10101, 5'b00010, 15'b010000000000011, 25'b0000000000000000000000011, opcode, Rs, Rt, Rd, imm, jump_target);
	end // initial*/
endmodule