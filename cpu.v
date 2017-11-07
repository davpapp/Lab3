// Single cycle-cpu

// This is the top level module for our single cycle CPU
// It consists of 5 sub-modules:
// Instruction Fetch
// Instruction Decode / Register Fetch
// Execute
// Data Memory
// Write

module cpu (
  
);

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
	instructionDecoderR ID_I(instruction, opcode, Rs, Rt, imm);
	instructionDecoderR ID_J(instruction, opcode, jump_target);

// ---------------------------Register Fetch-----------------------------
	// This is the register I wrote for one of the HWs
	wire[31:0] Da;
	wire[31:0] Db;
	reg regWrite = 1; // one of the controls - this should only be enabled for certain opcodes

	wire writeData[31:0];
	register Register(Da, Db, writeData, Rs, Rt, Rd, regWrite, clk); // Rd is incorrect here, will fix later

// ----------------------------Execute-----------------------------------
	wire[31:0] resultALU;
	wire carryout, zero, overflow; // Don't think we actually use these
	wire[31:0] extended_imm; // need to extend our immediate

	wire[31:0] Db_or_imm; // need a mux to choose between Db or our immediate as the second operand in the ALU

	// Use my ALU from Lab 1 - opcode will need to be converted
	alu ALU(resultALU, carryout, zero, overflow, Da, Db, opcode);

endmodule
