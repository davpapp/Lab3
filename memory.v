`define MEMSIZE = 32

module memory
(
  input clk, regWE,
  input[MEMSIZE-1:0] Addr,
  input[31:0] DataIn,
  output[31:0]  DataOut
);
  
  reg [31:0] mem[(2**MEMSIZE)-1:0];  

  always @(posedge clk) begin
    if (regWE) begin
      mem[Addr] <= DataIn;
    end
  end'
  
  initial $readmemh(“test_mem.dat”, mem);
  assign DataOut = mem[Addr];
endmodule