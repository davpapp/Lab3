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

`define LW   6'h23
`define SW   6'h2b
`define J    6'h02
`define R    6'h00
`define JAL  6'h03
`define BNE  6'h05
`define XORI 6'h0e
`define ADDI 6'h08
`define JRF  6'h08
`define ADDF 6'h24
`define SUBF 6'h22
`define SLTF 6'h2a

module control (
	input[5:0] opcode,
	input[5:0] funct,
	output reg writeReg,
	output reg linkToPC,
	output reg ALUoperandSource, // 0 for Db, 1 for immediate
	output reg memoryRead,
	output reg memoryWrite,
	output reg memoryToRegister,
	output reg [2:0] command, // sets the command for our ALU
	output reg isjump,
	output reg isbranch
);
	// all of these will need some if cases or something
	always @(opcode or funct) begin
		case(opcode)
			// R - type
			`R: begin
				linkToPC = 0;
				ALUoperandSource = `ALUDB;
				memoryRead = 0;
				memoryWrite = 0;
				memoryToRegister = 0;
				isbranch = 0;	
				case(funct)
					// Jump Register
					`JRF: begin
						writeReg = 0;
						command = 3'h0;
						isjump = 1;
					end
					// ADD
					`ADDF: begin
						writeReg = 1;
						command = `ADD;
						isjump = 0;
					end
					// SUB
					`SUBF: begin
						writeReg = 1;
						command = `SUB;
						isjump = 0;
					end
					// SLT
					`SLTF: begin
						writeReg = 1;
						command = `SLT;
						isjump = 0;
					end
				endcase
			end

			// Load Word
			`LW: begin
				writeReg = 1;
				linkToPC = 0;
				ALUoperandSource = 0;
				memoryRead = 1;
				memoryWrite = 0;
				memoryToRegister = 1;
				command = 3'h0;
				isjump = 0;
				isbranch = 0;	
			end

			// Store Word
			`SW: begin
				writeReg = 0;
				linkToPC = 0;
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
				linkToPC = 0;
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
				writeReg = 1;
				linkToPC = 1;
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
				linkToPC = 0;
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
				linkToPC = 0;
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
				linkToPC = 0;
				ALUoperandSource = `ALUIMM;
				memoryRead = 0;
				memoryWrite = 0;
				memoryToRegister = 0;
				command = `ADD;
				isjump = 0;
				isbranch = 0;	
			end

	endcase// opcode
	end
endmodule
