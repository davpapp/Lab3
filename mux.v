module mux
	#(parameter width = 32)
	(
	output reg [width-1:0]  out,
	input                   address,
	input[width-1:0]        input0, input1 
	);

  always @(input0 or input1 or address) begin // if anything changes, check
    case(address)
      0: out <= input0;
      1: out <= input1;
    endcase // address
  end
endmodule

module mux2to1by32

(
output reg [31:0]  out,
input         address,
input[31:0]   input0, input1 
);

  always @(input0 or input1 or address) begin // if anything changes, check
    case(address)
      0: out <= input0;
      1: out <= input1;
    endcase // address
  end

endmodule

module addressmux
	(
	output reg out,
	input      mux_address,
	input[4:0] addr0, addr1
	);
	always @(addr0 or addr1 or mux_address) begin // if anything changes, check
    	case(mux_address)
      		0: out <= addrt0;
      		1: out <= addr1;
    	endcase // address
  end

endmodule