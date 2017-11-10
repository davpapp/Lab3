// Single cycle-cpu
`include "ifetch.v"
`include "control.v"
`include "datamemory.v"
`include "regfile.v"
`include "excecute.v"

// This is the top level module for our single cycle CPU
// It consists of 5 sub-modules:
// Instruction Fetch
// Instruction Decode / Register Fetch
// Execute
// Data Memory
// Write

module cpu (
  input clk;
);
	
	// Primarily used in Decode
	wire[5:0] opcode;
	wire[4:0] Rs;
	wire[4:0] Rt;
	wire[4:0] Rd;
	wire[4:0] shift;
	wire[5:0] funct;
	wire[15:0] imm;
	wire[25:0] jump_target;

	// Primarily used in Register Fetch
	wire writeData[31:0];
	wire[31:0] Da;
	wire[31:0] Db;

	// Primarily used in Execute
	wire[31:0] extended_imm; // need to extend our immediate
	wire[31:0] Operand;
	wire[31:0] ALU_result;
	wire carryout, zero, overflow; // Don't think we actually use these
	wire[2:0] command;

	// Control Wires
	wire writeReg, ALU_OperandSource, memoryRead, memoryWrite, memoryToRegister, is_jump, is_branch;

	control CPU_control(.opcode(opcode),
						.funct(funct),
						.writeReg(writeReg),
						.ALUOperandSource(ALU_OperandSource),
						.memoryRead(memoryRead),
						.memoryWrite(memoryWrite),
						.memoryToRegister(memoryToRegister),
						.command(command),
						.isjump(is_jump),
						.isbranch(is_branch));

// ----------------------------Instruction Fetch-------------------------
	// Tests: [TO DO]
	wire instruction[31:0];
	ifetch IF(.clk(clk),
				.write_pc(1'b1),
				.is_branch(is_branch),
				.is_jump(is_jump),
				.branch_addr(imm),
				.jump_addr(jump_target),
				.out(instruction)); // updates instruction, increments PC by 4

// ----------------------------Instruction Decode------------------------
	// Testing: [DONE]
	// Break the instruction into its pieces

	instructionDecoderR ID_R(instruction, opcode, Rs, Rt, Rd, shift, funct);
	instructionDecoderI ID_I(instruction, opcode, Rs, Rt, imm);
	instructionDecoderJ ID_J(instruction, opcode, jump_target);

// ---------------------------Register Fetch-----------------------------
	// Testing: [DONE]

	regfile regfile(Da, Db, writeData[31:0], Rs, Rt, Rd, regWrite, clk); // Rd is incorrect here, will fix later

// ----------------------------Execute-----------------------------------
	execute exe(ALU_result, zero, carryout, overflow, Da, Db, imm, ALU_OperandSource, command);

// ----------------------------Memory/Write-----------------------------------
	// Testing: [DONE]

	//data memory, from lab 2:
	datamemory DM(dataOut[31:0],address, WrEn,ALU_result[31:0]); 
	mux ToReg(WriteData[31:0], memoryToRegister, ALU_result[31:0],dataOut[31:0]); 

//----------------------------Control-----------------------------------
	//control CTL(opcode[5:0], regWrite, ALU_OperandSource,memoryRead,memoryWrite,memoryToRegister,command[2:0]); //inputs/outpus to control

endmodule
