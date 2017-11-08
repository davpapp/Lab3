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