`timescale 1 ns / 1 ps
`include "register32zero.v"

module register32test();
  wire[31:0] out;
  reg[31:0] in;
  reg wrenable, clk;

  register32zero zeroRegister(out, in, wrenable, clk);

  integer numTests = 2;
  integer numTestsPassed = 0;
  initial begin
  	wrenable = 1;
  	in=32'b1111000000000000000000000000001; #5000
  	#5 clk=1; #5 clk=0;	// Generate single clock pulse
  	if (out == 0) begin
  		numTestsPassed = numTestsPassed + 1;
  	end
  	in=32'b0000000000011000000000000000001; #5000
  	#5 clk=1; #5 clk=0;	// Generate single clock pulse
  	if (out == 0) begin
  		numTestsPassed = numTestsPassed + 1;
  	end

  	$display("%2d / %2d tests passed.", numTestsPassed, numTests);
  end

 endmodule