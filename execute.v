// Execude block for CPU
`include "aluK.v"
`include "mux.v"

module execute(
  output[31:0] result,
  output zero,
  output carryout,
  output overflow,
  input[31:0] Da,
  input[31:0] Db,
  input[15:0] imm,
  input ALU_OperandSource,
  input[2:0] command
);
reg[31:0] extended_imm;
wire[31:0] Operand;
always @(imm) begin//not sure if this is exactly correct, but not sure if this op can run continuously
                extended_imm <= {{16{imm[15]}}, imm}; // extending the immediate
        end

        mux2to1by32 ALUSource(.out(Operand),
                                                .address(ALU_OperandSource),
                                                .input0(Db),
                                                .input1(extended_imm)); // choose between Db or our immediate as the second operand in the ALU
                                                        //Q: Db/ALU_operandsource???
        // Use my ALU from Lab 1 - opcode will need to be converted
        ALUcontrolLUT Alu(carryout, overflow, zero, result [31:0],command[2:0],Da, Operand);
endmodule
