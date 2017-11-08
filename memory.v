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
    mem[4] <= 32'h4;
    mem[8] <= 32'h8;
    mem[12] <= 32'h12;
    mem[16] <= 32'h16;
    mem[20] <= 32'h20;
    mem[24] <= 32'h24;
    mem[28] <= 32'h28;
    mem[32] <= 32'h32;
    mem[36] <= 32'h36;
    mem[40] <= 32'h40;
    mem[44] <= 32'h44;
    mem[48] <= 32'h48;
    mem[52] <= 32'h52;
    mem[56] <= 32'h56;
    mem[60] <= 32'h60;
  end
  always @(posedge clk) begin
    if (regWE) begin
      mem[Addr] <= DataIn;
    end
  end
  
endmodule