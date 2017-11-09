// The control takes the opcode from the 32 bit instruction
// and sets all the control variables (such as writeEnables)

// opcodes we need to support:
// LW, SW, J, JR, JAL, BNE, XORI, ADDI, ADD, SUB, SLT
// 0   1   2  3   4    5    6     7     8    9    10

// Look at http://www.mrc.uidaho.edu/mrc/people/jff/digital/MIPSir.html
// to find what each opcode should do
module control (
	input[5:0] opcode,
	input[5:0] funct,
	output writeReg,
	output ALUoperandSource, // 0 for Db, 1 for immediate
	output memoryRead,
	output memoryWrite,
	output memoryToRegister,
	output[2:0] command // sets the command for our ALU
	output isjump,
	output isbranch
);
	// all of these will need some if cases or something
	always @(opcode)
	case(opcode)
		// R - type
		5'h0: begin
			case(funct)
				// Jump Register
				5'h08: begin
				end
				// ADD
				5'h24: begin
				end
				// SUB
				5'h22: begin
				end
				// SLT
				5'h2a: begin
				end
		end

		// Load Word
		5'h23: begin
			writeReg = 1;
			ALUoperandSource = 0;
			memoryRead = 1;
			memoryWrite = 0;
			memoryToRegister = 0;
			command = 3'h0;
			isjump = 0;
			isbranch = 0;	
		end

		// Store Word
		5'h2b: begin
			writeReg = 0;
			ALUoperandSource = 0;
			memoryRead = 0;
			memoryWrite = 0;
			memoryToRegister = 0;
			command = 3'h0;
			isjump = 0;
			isbranch = 0;	
		end

		// Jump 
		5'h2: begin
			writeReg = 0;
			ALUoperandSource = 0;
			memoryRead = 0;
			memoryWrite = 0;
			memoryToRegister = 0;
			command = 3'h0;
			isjump = 0;
			isbranch = 0;	
		end

		// Jump ad Link
		5'h3: begin
			writeReg = 0;
			ALUoperandSource = 0;
			memoryRead = 0;
			memoryWrite = 0;
			memoryToRegister = 0;
			command = 3'h0;
			isjump = 0;
			isbranch = 0;	
		end

		// BNE 
		5'h5: begin
			writeReg = 0;
			ALUoperandSource = 0;
			memoryRead = 0;
			memoryWrite = 0;
			memoryToRegister = 0;
			command = 3'h0;
			isjump = 0;
			isbranch = 0;	
		end

		// XORI -
		5'h0e: begin
			writeReg = 0;
			ALUoperandSource = 1;
			memoryRead = 0;
			memoryWrite = 0;
			memoryToRegister = 0;
			command = 3'h0;
			isjump = 0;
			isbranch = 0;	
		end

		// ADDI - 
		5'h8: begin
			writeReg = 1;
			ALUoperandSource = 1;
			memoryRead = 0;
			memoryWrite = 0;
			memoryToRegister = 0;
			command = 3'h0;
			isjump = 0;
			isbranch = 0;	
		end

	endcase // opcode
	

endmodule
