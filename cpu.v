// Single cycle-cpu
`ifdef 
`include "ifetch.v"
`include "control.v"
`include "regfile.v"
`include "execute.v"
`include "instructionDecoderR.v"
`include "instructionDecoderI.v"
`include "instructionDecoderJ.v"
`endif

// This is the top level module for our single cycle CPU
// It consists of 5 sub-modules:
// Instruction Fetch
// Instruction Decode / Register Fetch
// Execute
// Data Memory
// Write

module cpu (
  input clk
);
	wire[31:0] pc;
	// Primarily used in Decode
	wire[5:0] opcode;
	wire[4:0] Rs;
	wire[4:0] Rt;
	wire[4:0] Rd, reg_to_write, regAddr;
	wire[4:0] shift;
	wire[5:0] funct;
	wire[15:0] imm;
	wire[25:0] jump_target, temp_jump_target;

	// Primarily used in Register Fetch
	wire[31:0] writeData, tempWriteData, dataOut;
	wire[31:0] Da;
	wire[31:0] Db;

	// Primarily used in Execute
	wire[31:0] extended_imm; // need to extend our immediate
	wire[31:0] Operand;
	wire[31:0] ALU_result;
	wire carryout, zero, overflow; // Don't think we actually use these
	wire[2:0] command;

	// Control Wires
	wire writeReg, linkToPC, ALU_OperandSource, memoryRead, memoryWrite, memoryToRegister, is_jump, isjr, is_branch, branch_taken;

	control CPU_control(.opcode(opcode),
						.funct(funct),
						.writeReg(writeReg),
						.linkToPC(linkToPC),
						.ALUoperandSource(ALU_OperandSource),
						.memoryRead(memoryRead),
						.memoryWrite(memoryWrite),
						.memoryToRegister(memoryToRegister),
						.command(command),
						.isjump(is_jump),
						.isjr(isjr),
						.isbranch(is_branch));

// ----------------------------Instruction Fetch-------------------------
	// Tests: [DONE]
	wire[31:0] instruction;
	and (branch_taken, is_branch, !zero);
	ifetch IF(.clk(clk),
				.write_pc(1'b1),
				.is_branch(branch_taken),
				.is_jump(is_jump),
				.branch_addr(imm[15:0]),
				.jump_addr(jump_target[25:0]),
				.out(instruction[31:0]),
				.increased_pc(pc[31:0])); // updates instruction, increments PC by 4

// ----------------------------Instruction Decode------------------------
	// Testing: [DONE]

	instructionDecoderR ID_R(instruction[31:0], opcode[5:0], Rs[4:0], Rt[4:0], Rd[4:0], shift[4:0], funct[5:0]);
	instructionDecoderI ID_I(instruction[31:0], opcode[5:0], Rs[4:0], Rt[4:0], imm[15:0]);
	instructionDecoderJ ID_J(instruction[31:0], opcode[5:0], temp_jump_target[25:0]);

// ---------------------------Register Fetch-----------------------------
	// Testing: [DONE]

	regfile regfile(Da, Db, writeData[31:0], Rs, Rt, regAddr, writeReg, clk); // Rd is incorrect here, will fix later

// ----------------------------Execute-----------------------------------

	execute exe(ALU_result, zero, carryout, overflow, Da, Db, imm, ALU_OperandSource, command);

// ----------------------------Memory/Write-----------------------------------

	memory memory0(.clk(clk),.regWE(memoryWrite), .Addr(ALU_result[31:0]), .DataIn(Db), .DataOut(dataOut)); //the only time we're writing to mem is during sw, so it 																									//will only ever be this.
	mux #(.width(32)) ToReg(.out(tempWriteData[31:0]),				 // Chooses between writing the ALU result or the output of DataMemory
					.address(memoryToRegister),						 //  to the Register File
					.input0(ALU_result[31:0]),
					.input1(dataOut[31:0]));
	mux #(32) dataOrPC(writeData[31:0], linkToPC, tempWriteData[31:0], pc); // Chooses between writing the above value or PC (JAL) to the
																			//  Register File.
//----------------------------Misc.-----------------------------------

	mux #(26) jumpto(jump_target, isjr, temp_jump_target, Da[25:0]); // If instruction is j/jal, jump to temp_jump_target.
																	 //  If instruction is jr, jump to the value stored in the register given 
																	 //  (jr $ra means PC = Reg[ra])
	mux #(5) Rd_or_Rt(.out(reg_to_write), 
						.address(memoryRead),
						.input0(Rd), 
						.input1(Rt));								 // Chooses between writing to Reg[Rd] for R-type or Reg[Rt] for I-type
	mux #(5) writeRA(regAddr, linkToPC, reg_to_write, 5'd31);		 // Chooses between writing Rd/Rt in the reg file or $31 (for JAL)
endmodule
