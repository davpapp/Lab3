`define MEMSIZE = 32

module memory
(
  input clk, regWE,
  input[31:0] Addr,
  input[31:0] DataIn,
  output[31:0]  DataOut
);
  reg [31:0] mem[60:0];  
  initial begin
    mem[0] <= 32'h0;
    mem[3] <= 32'h3;
    mem[7] <= 32'h7;
    mem[11] <= 32'h11;
    mem[15] <= 32'h15;
    mem[19] <= 32'h19;
    mem[23] <= 32'h23;
    mem[27] <= 32'h27;
    mem[31] <= 32'h31;
    mem[35] <= 32'h35;
    mem[39] <= 32'h39;
    mem[43] <= 32'h43;
    mem[47] <= 32'h47;
    mem[51] <= 32'h51;
    mem[55] <= 32'h55;
    mem[59] <= 32'h59;
  end
  always @(posedge clk) begin
    if (regWE) begin
      mem[Addr] <= DataIn;
    end
  end
  
  //initial $readmemh(“test_mem.dat”, mem);
  assign DataOut = mem[Addr];
endmodule