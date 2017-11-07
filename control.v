// The control takes the Opcode from the 32 bit instruction
// and sets all the control variables (such as writeEnables)

// opcodes we need to support:
// LW, SW, J, JR, JAL, BNE, XORI, ADDI, ADD, SUB, SLT
// 0   1   2  3   4    5    6     7     8    9    10

// Look at https://e38023e2-a-62cb3a1a-s-sites.googlegroups.com/site/ca15fall/resources/mips/MIPS%20ISA%20reference%20sheet.pdf?attachauth=ANoY7cqBDQ7Y2L9gl38Ata9LoT33HXrgLIcfZGyyWXWELK3mOaaB59pGRnrwE4lDBmDA64rAC2hCeXCNGDZb-Y5LwJZ1S6LZmF8T_j2k2B70hea9dxapbp3X8_3wooXREV1YfHpN45ZdYlOescfbK9-Z3BJQyEySFN7LaRW2RZB8mzmAd2oHi0p2E5p6giQILkiFsewYNZBaD3D7phihwIttjuySwyhvY5eyn-TEIn-HYbo08El6SfbGph-G8B2777q_LaPweDk_&attredirects=0
// to find what each opcode should do
module control (
	input[5:0] opcode,
	output writeReg,
	output operandBSource

);
	// just an example here:
	if (opcode == 7) begin // ADDI
		operandBSource = 1; // this will allow a MUX to choose the immediate for operandB
	end

endmodule
