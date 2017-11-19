`define MEMSIZE = 32

module instruction_memory
(
  input clk, regWE,
  input[31:0] Addr,
  input[31:0] DataIn,
  output[31:0]  DataOut
);

  reg [31:0] mem[4095:0];  
  //initial $readmemh("file.dat", mem);
  assign DataOut = mem[Addr];

  //initial $readmemh("file.dat", mem);
  /*initial begin
    mem[0] <= 32'd0;
    mem[4] <= 32'd4;
    mem[8] <= 32'd8;
    mem[12] <= 32'd12;
    mem[16] <= 32'd16;
    mem[20] <= 32'd20;
    mem[24] <= 32'd24;
    mem[28] <= 32'd28;
    mem[32] <= 32'd32;
    mem[36] <= 32'd36;
    mem[40] <= 32'd40;
    mem[44] <= 32'd44;
    mem[48] <= 32'd48;
    mem[52] <= 32'd52;
    mem[56] <= 32'd56;
    mem[60] <= 32'd60;
  end*/
  always @(Addr) begin
    if (regWE) begin
      mem[Addr] <= DataIn;
    end
  end
  
endmodule

module memory
(
  input clk, regWE,
  input[31:0] Addr,
  input[31:0] DataIn,
  output[31:0]  DataOut
);

  reg [31:0] mem[4095:0];  
  //initial $readmemh("data", mem);

  always @(negedge clk) begin
    if (regWE) begin
      mem[Addr] <= DataIn;
      $display("Wrote %h to Memory at address %h", DataIn, Addr);
    end
  end

  assign DataOut = mem[{2'b0, Addr[31:2]}];

endmodule
