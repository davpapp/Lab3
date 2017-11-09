// The control takes the opcode from the 32 bit instruction
// and sets all the control variables (such as writeEnables)

// opcodes we need to support:
// LW, SW, J, JR, JAL, BNE, XORI, ADDI, ADD, SUB, SLT

// define controls for ALU
`define ADD 3'b000
`define SUB 3'b001
`define SLT 3'b010
`define XOR 3'b011
`define ALUDB 0
`define ALUIMM 1

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
		6'h0: begin
			ALUoperandSource = `ALUDB;
			memoryRead = 0;
			memoryWrite = 0;
			memoryToRegister = 0;
			isbranch = 0;	
			case(funct)
				// Jump Register
				6'h08: begin
					writeReg = 0;
					command = 3'h0;
					isjump = 1;
				end
				// ADD
				6'h24: begin
					writeReg = 1;
					command = `ADD;
					isjump = 0;
				end
				// SUB
				6'h22: begin
					writeReg = 1;
					command = `SUB;
					isjump = 0;
				end
				// SLT
				6'h2a: begin
					writeReg = 1;
					command = `SLT;
					isjump = 0;
				end
		end

		// Load Word
		6'h23: begin
			writeReg = 1;
			ALUoperandSource = 0;
			memoryRead = 1;
			memoryWrite = 0;
			memoryToRegister = 1;
			command = 3'h0;
			isjump = 0;
			isbranch = 0;	
		end

		// Store Word
		6'h2b: begin
			writeReg = 0;
			ALUoperandSource = 0;
			memoryRead = 0;
			memoryWrite = 1;
			memoryToRegister = 0;
			command = 3'h0;
			isjump = 0;
			isbranch = 0;	
		end

		// Jump 
		6'h2: begin
			writeReg = 0;
			ALUoperandSource = 0;
			memoryRead = 0;
			memoryWrite = 0;
			memoryToRegister = 0;
			command = 3'h0;
			isjump = 1;
			isbranch = 0;	
		end

		// Jump ad Link
		6'h3: begin
			writeReg = 0;
			ALUoperandSource = 0;
			memoryRead = 0;
			memoryWrite = 0;
			memoryToRegister = 0;
			command = 3'h0;
			isjump = 1;
			isbranch = 0;	
		end

		// BNE 
		6'h5: begin
			writeReg = 0;
			ALUoperandSource = `ALUDB;
			memoryRead = 0;
			memoryWrite = 0;
			memoryToRegister = 0;
			command = `SUB;
			isjump = 0;
			isbranch = 1;	
		end

		// XORI -
		6'h0e: begin
			writeReg = 1;
			ALUoperandSource = `ALUIMM;
			memoryRead = 0;
			memoryWrite = 0;
			memoryToRegister = 0;
			command = `XOR;
			isjump = 0;
			isbranch = 0;	
		end

		// ADDI - 
		6'h8: begin
			writeReg = 1;
			ALUoperandSource = `ALUIMM;
			memoryRead = 0;
			memoryWrite = 0;
			memoryToRegister = 0;
			command = `ADD;
			isjump = 0;
			isbranch = 0;	
		end

	endcase // opcode
	

endmodule
