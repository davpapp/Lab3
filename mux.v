module mux2to1by32
(
output[31:0]  out,
input         address,
input[31:0]   input0, input1 
);

  wire[1:0] mux[31:0];			// Create a 2D array of wires
  assign mux[0] = input0;		// Connect the sources of the array
  assign mux[1] = input1;

  assign out = mux[address];	// Connect the output of the array
endmodule