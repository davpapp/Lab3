// Single cycle-cpu
`include "ifetch.v"
`include "control.v"
`include "datamemory.v"
`include "register.v"

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

	control CPU_control(opcode, writeReg, /*etc etc didn't finish this */, command);

// ----------------------------Instruction Fetch-------------------------
	wire instruction[31:0];
	ifetch IF(/* */); // updates instruction, increments PC by 4

// ----------------------------Instruction Decode------------------------
	// Break the instruction into its pieces
	wire[5:0] opcode;
	wire[4:0] Rs;
	wire[4:0] Rt;
	wire[4:0] Rd;
	wire[10:0] rest;
	wire[15:0] imm;
	wire[25:0] jump_target;

	instructionDecoderR ID_R(instruction, opcode, Rs, Rt, Rd, rest);
	instructionDecoderI ID_I(instruction, opcode, Rs, Rt, imm);
	instructionDecoderJ ID_J(instruction, opcode, jump_target);

// ---------------------------Register Fetch-----------------------------
	// This is the register I wrote for one of the HWs
	wire[31:0] Da;
	wire[31:0] Db;

	wire writeData[31:0];
	regfile register(Da, Db, writeData, Rs, Rt, Rd, regWrite, clk); // Rd is incorrect here, will fix later
																	//Q: Could you include a testfile?

// ----------------------------Execute-----------------------------------
	always @(imm) //not sure if this is exactly correct, but not sure if this op can run continuously
		extended_imm <= {{16{imm[15]}}, imm}; // extending the immediate
	end
	wire[31:0] extended_imm; // need to extend our immediate
	wire[31:0] Operand;	
	mux ALUSource(Operand,ALU_OperandSource, Db, extended_imm); // choose between Db or our immediate as the second operand in the ALU
							//Q: Db/ALU_operandsource???
	// Use my ALU from Lab 1 - opcode will need to be converted
	wire[31:0] ALU_result;
	wire carryout, zero, overflow; // Don't think we actually use these
	wire[2:0] command;
	alu ALU(ALU_result, carryout, zero, overflow, Da, Operand, command[2:0]);

// ----------------------------Memory/Write-----------------------------------
//data memory, from lab 2:
datamemory DM(clk,dataOut,address, WrEn,dataIn); 
mux ToReg(WriteData[31:0], memoryToRegister, ALU_result,dataOut); 

//----------------------------Control-----------------------------------
control CTL(opcode[5:0], regWrite, ALU_OperandSource,memoryRead,memoryWrite,memoryToRegister,command[2:0]); //inputs/outpus to control

endmodule