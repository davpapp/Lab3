`define MEMSIZE = 32

module instruction_memory
(
  input clk, regWE,
  input[31:0] Addr,
  input[31:0] DataIn,
  output[31:0]  DataOut
);

  reg [31:0] mem[60:0];  
  //initial $readmemh(“test_mem.dat”, mem);
  assign DataOut = mem[Addr];

  initial begin
    mem[0] <= 32'h0;
    mem[4] <= 32'h3;
    mem[8] <= 32'h7;
    mem[12] <= 32'h11;
    mem[16] <= 32'h15;
    mem[20] <= 32'h19;
    mem[24] <= 32'h23;
    mem[28] <= 32'h27;
    mem[32] <= 32'h31;
    mem[36] <= 32'h35;
    mem[40] <= 32'h39;
    mem[44] <= 32'h43;
    mem[48] <= 32'h47;
    mem[52] <= 32'h51;
    mem[56] <= 32'h55;
    mem[60] <= 32'h59;
  end
  always @(posedge clk) begin
    if (regWE) begin
      mem[Addr] <= DataIn;
    end
  end
  
endmodule