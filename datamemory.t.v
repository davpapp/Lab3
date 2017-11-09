//test datamemory.v
`include "datamemory.v"

module testDM();
	wire [31:0] dOut;
	reg [31:0] dIn;
	reg WrEn;
	reg [6:0] address;

	datamemory DM(dOut[31:0], address[6:0], WrEn, dIn[31:0]);

	initial begin
		assign dOut= 


	end
end module