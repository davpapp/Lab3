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
	always @(opcode)
	case(opcode)
		// LW - Load word 
		5'd0: begin
		end

		// SW - store word
		5'd1: begin	
			memoryWrite = 1;

		end

		// J - jump register
		5'd2: begin
		end

		// JR - 
		5'd3: begin
		end

		// JAL - jump and link
		5'd4: begin
		end

		// BNE - 
		5'd5: begin
		end

		// XORI -
		5'd6: begin
			ALUoperandSource = 1; 

		end

		// ADDI - 
		5'd7: begin

			ALUoperandSource = 1;
			writeReg = 1;
			command = 3'b000;

		end

		// ADD - add (with overflow)
		5'd8: begin

			ALUoperandSource = 0;
			writeReg = 1;
			command = 3'b000;

		end
		// SUB - 
		5'd9: begin

			ALUoperandSource = 1;
			command = 3'b001;

		end

		// SLT - 
		5'd10: begin

			command = 3'b011;

		end
	endcase // opcode
	

endmodule
