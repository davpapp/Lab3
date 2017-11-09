`include "control.v"

`define LW   6'h23
`define SW   6'h2b
`define J    6'h02
`define R    6'h00
`define JAL  6'h03
`define BNE  6'h05
`define XORI 6'h0e
`define ADDI 6'h08
`define JR   6'h08
`define ADD  6'h24
`define SUB  6'h22
`define SLT  6'h2a

module testControl();

// 		LW, SW, J, JR, JAL, BNE, XORI, ADDI, ADD, SUB, SLT
// op:	h23 h2b h2 h0  h03  h05  h0e   h08   h00  h00  h00
// fun: --  --  -- h8  --   --   --    --    h24  h22  h2a

	reg[5:0] opcode;
	reg[5:0] funct = 6'h0;
	wire writeReg, ALU_OperandSource, memoryRead, memoryWrite, memoryToRegister, is_jump, is_branch;
	wire[2:0] command;

	control dut(.opcode(opcode),
				.funct(funct),
				.writeReg(writeReg),
				.ALUoperandSource(ALU_OperandSource),
				.memoryRead(memoryRead),
				.memoryWrite(memoryWrite),
				.memoryToRegister(memoryToRegister),
				.command(command),
				.isjump(is_jump),
				.isbranch(is_branch));

	task checkResult;
		input[2:0] exp_command;
		input exp_wr, exp_alu_choose, exp_mr, exp_mw, exp_m2r, exp_j, exp_b;
		input[2:0] command;
		input wr, alu_choose, mr, mw, m2r, j, b;

		begin
		if ((command == exp_command) && (wr == exp_wr) &&
			(alu_choose == exp_alu_choose) && (mr == exp_mr) && 
			(mw == exp_mw) && (m2r == exp_m2r) && 
			(m2r == exp_m2r) && (j == exp_j) && (b == exp_b)) begin
			$display("Passed.");
		end
		else begin
			$display("Failed");
			$display(opcode, funct);
		end
		end
	endtask

	initial begin
		
		opcode = `LW; #10
		checkResult(3'h0, 1'b1, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0,
				command, writeReg, ALU_OperandSource, memoryRead, memoryWrite, 
				memoryToRegister, is_jump, is_branch);

		opcode = `SW; #10
		checkResult(3'h0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0,
				command, writeReg, ALU_OperandSource, memoryRead, memoryWrite, 
				memoryToRegister, is_jump, is_branch);

		opcode = `J; #10
		checkResult(3'h0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0,
				command, writeReg, ALU_OperandSource, memoryRead, memoryWrite, 
				memoryToRegister, is_jump, is_branch);

		opcode = `JAL; #10
		checkResult(3'h0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0,
				command, writeReg, ALU_OperandSource, memoryRead, memoryWrite, 
				memoryToRegister, is_jump, is_branch);

		opcode = `BNE; #10
		checkResult(3'h1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1,
				command, writeReg, ALU_OperandSource, memoryRead, memoryWrite, 
				memoryToRegister, is_jump, is_branch);

		opcode = `XORI; #10
		checkResult(3'b011, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
				command, writeReg, ALU_OperandSource, memoryRead, memoryWrite, 
				memoryToRegister, is_jump, is_branch);

		opcode = `ADDI; #10
		checkResult(3'h0, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
				command, writeReg, ALU_OperandSource, memoryRead, memoryWrite, 
				memoryToRegister, is_jump, is_branch);

		opcode = `R;
		funct = `JR; #10
		checkResult(3'h0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0,
				command, writeReg, ALU_OperandSource, memoryRead, memoryWrite, 
				memoryToRegister, is_jump, is_branch);

		funct = `ADD; #10
		checkResult(3'h0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
				command, writeReg, ALU_OperandSource, memoryRead, memoryWrite, 
				memoryToRegister, is_jump, is_branch);

		funct = `SUB; #10
		checkResult(3'b001, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
				command, writeReg, ALU_OperandSource, memoryRead, memoryWrite, 
				memoryToRegister, is_jump, is_branch);

		funct = `SLT; #10
		checkResult(3'b010, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
				command, writeReg, ALU_OperandSource, memoryRead, memoryWrite, 
				memoryToRegister, is_jump, is_branch);

	end // initial
endmodule // testControl
