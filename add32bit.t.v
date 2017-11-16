// Test bench for 32 bit adder

`timescale 1 ns / 1 ps
`include "add32bit.v"

module test32bitAdder();

reg[31:0] a;
reg[31:0] b;
wire[31:0] c;
wire overflow;

add32bit test(a, b, c, overflow); 

initial begin
  // Add some numbers with no overflow
  a = 32'd7;
  b = 32'd6;
  #50;
  $display("6 + 7 = %d", c);
  $display("overlow: %b", overflow);
  a = 32'd657;
  b = 32'd912;
  #50;
  $display("657 + 912 = %d", c);
  $display("overlow: %b", overflow);
  a = 32'd700;
  b = 32'd900;
  #50;
  $display("700 + 900 = %d", c);
  $display("overlow: %b", overflow);
  // Add some numbers with overflow
  a = 32'd2**31-5;
  b = 32'd2**31-10;
  #50;
  $display("overflow: %d", c);
  $display("overlow: %b", overflow);
  a = -32'sd2**31-5;
  b = -32'sd2**31-10;
  #50;
  $display("overflow %d", c);
  $display("overlow: %b", overflow);
  // add a positive and a negative
  a = -32'sd700;	
  b = 32'd900;
  #50;
  $display("-700 + 900 = %d", c);
  $display("overlow: %b", overflow);
end
endmodule