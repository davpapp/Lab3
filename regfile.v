//------------------------------------------------------------------------------
// MIPS register file
//   width: 32 bits
//   depth: 32 words (reg[0] is static zero register)
//   2 asynchronous read ports
//   1 synchronous, positive edge triggered write port
//------------------------------------------------------------------------------
`include "register32zero.v"
`include "register32.v"
`include "mux32to1by1.v"
`include "decoders.v"
`include "mux32to1by32.v"


module regfile
(
output[31:0]	ReadData1,	// Contents of first register read
output[31:0]	ReadData2,	// Contents of second register read
input[31:0]	WriteData,	// Contents to write to register
input[4:0]	ReadRegister1,	// Address of first register to read
input[4:0]	ReadRegister2,	// Address of second register to read
input[4:0]	WriteRegister,	// Address of register to write
input		RegWrite,	// Enable writing of register when High
input		Clk		// Clock (Positive Edge Triggered)
);


  wire[31:0] decoder;
  wire[31:0] reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8, reg9;
  wire[31:0] reg10, reg11, reg12, reg13, reg14, reg15, reg16, reg17, reg18, reg19;
  wire[31:0] reg20, reg21, reg22, reg23, reg24, reg25, reg26, reg27, reg28, reg29;
  wire[31:0] reg30, reg31;

  decoder1to32 dec(decoder, RegWrite, WriteRegister);
  register32zero r0(reg0, WriteData, decoder[0], Clk);
  register32 r1(reg1, WriteData, decoder[1], Clk);
  register32 r2(reg2, WriteData, decoder[2], Clk);
  register32 r3(reg3, WriteData, decoder[3], Clk);
  register32 r4(reg4, WriteData, decoder[4], Clk);
  register32 r5(reg5, WriteData, decoder[5], Clk);
  register32 r6(reg6, WriteData, decoder[6], Clk);
  register32 r7(reg7, WriteData, decoder[7], Clk);
  register32 r8(reg8, WriteData, decoder[8], Clk);
  register32 r9(reg9, WriteData, decoder[9], Clk);
  register32 r10(reg10, WriteData, decoder[10], Clk);
  register32 r11(reg11, WriteData, decoder[11], Clk);
  register32 r12(reg12, WriteData, decoder[12], Clk);
  register32 r13(reg13, WriteData, decoder[13], Clk);
  register32 r14(reg14, WriteData, decoder[14], Clk);
  register32 r15(reg15, WriteData, decoder[15], Clk);
  register32 r16(reg16, WriteData, decoder[16], Clk);
  register32 r17(reg17, WriteData, decoder[17], Clk);
  register32 r18(reg18, WriteData, decoder[18], Clk);
  register32 r19(reg19, WriteData, decoder[19], Clk);
  register32 r20(reg20, WriteData, decoder[20], Clk);
  register32 r21(reg21, WriteData, decoder[21], Clk);
  register32 r22(reg22, WriteData, decoder[22], Clk);
  register32 r23(reg23, WriteData, decoder[23], Clk);
  register32 r24(reg24, WriteData, decoder[24], Clk);
  register32 r25(reg25, WriteData, decoder[25], Clk);
  register32 r26(reg26, WriteData, decoder[26], Clk);
  register32 r27(reg27, WriteData, decoder[27], Clk);
  register32 r28(reg28, WriteData, decoder[28], Clk);
  register32 r29(reg29, WriteData, decoder[29], Clk);
  register32 r30(reg30, WriteData, decoder[30], Clk);
  register32 r31(reg31, WriteData, decoder[31], Clk);

  mux32to1by32 mux1(ReadData1, ReadRegister1, reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8, reg9, reg10, reg11, reg12, reg13, reg14, reg15, reg16, reg17, reg18, reg19, reg20, reg21, reg22, reg23, reg24, reg25, reg26, reg27, reg28, reg29, reg30, reg31);
  mux32to1by32 mux2(ReadData2, ReadRegister2, reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8, reg9, reg10, reg11, reg12, reg13, reg14, reg15, reg16, reg17, reg18, reg19, reg20, reg21, reg22, reg23, reg24, reg25, reg26, reg27, reg28, reg29, reg30, reg31);

endmodule