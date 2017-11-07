// The control takes the opcode from the 32 bit instruction
// and sets all the control variables (such as writeEnables)

// opcodes we need to support:
// LW, SW, J, JR, JAL, BNE, XORI, ADDI, ADD, SUB, SLT
// 0   1   2  3   4    5    6     7     8    9    10

// Look at http://www.mrc.uidaho.edu/mrc/people/jff/digital/MIPSir.html
// to find what each opcode should do
module control (
	input[5:0] opcode,
	output writeReg,
	output ALUoperandSource, // 0 for Db, 1 for immediate
	output memoryRead,
	output memoryWrite,
	output memoryToRegister,
	output[2:0] command // sets the command for our ALU

);
	// all of these will need some if cases or something

	// LW - Load word 

	// SW - store word
		memoryWrite = 1;

	// J - jump register

	// JR - 

	// JAL - jump and link

	// BNE - 

	// XORI -
		ALUoperandSource = 1; 

	// ADDI - 
		ALUoperandSource = 1;
		writeReg = 1;
		command = 3'b000;

	// ADD - add (with overflow)
		ALUoperandSource = 0;
		writeReg = 1;
		command = 3'b000;
	// SUB - 
		ALUoperandSource = 1;
		command = 3'b001;

	// SLT - 
		command = 3'b011;
	

endmodule
