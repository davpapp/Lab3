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
		input[5:0] exp_opcode, opcode;
		input[4:0] exp_rs, exp_rt, exp_rd, Rs, Rt, Rd;
		input[15:0] exp_imm, imm;
		input[25:0] exp_jump_target, jump_target;


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
	    checkResult(6'b000000, opcode, 5'b00000, 5'b00000, 5'b00000, Rs, Rt, Rd,
	    			16'b000000000000000, imm,
	    			26'b00000000000000000000000000, jump_target);

	    instruction = 32'b01000010001101010001000000000011; #10
	    checkResult(6'b010000, opcode, 5'b10001, 5'b10101, 5'b00010, Rs, Rt, Rd,
	    			16'b001000000000011, imm,
	    			26'b10001101010001000000000011, jump_target);
	    instruction = 32'b10101010101010101010101010101010; #10
	    checkResult(6'b101010, opcode, 5'b10101, 5'b01010, 5'b10101, Rs, Rt, Rd,
	    			16'b1010101010101010, imm,
	    			26'b10101010101010101010101010, jump_target);
	end
endmodule