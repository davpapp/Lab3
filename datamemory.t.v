//test datamemory.v

`include "datamemory.v"

module testDM();

	wire[31:0] dOut;
	reg[31:0] dIn;
	reg WrEn;
	reg[6:0] address;

	datamemory DM(dOut[31:0], address[6:0], WrEn, dIn[31:0]);

	initial begin
		WrEn=1;
		dIn[31:0]= 32'd20;
		address[6:0]=7'd5;
		#15
		$display("%b",dOut[31:0]);

		WrEn=0;
		dIn[31:0]= 32'd20;
		address[6:0]=7'd5;
		#15
		$display("%b",dOut[31:0]);

		WrEn=1;
		dIn[31:0]= 32'd15;
		address[6:0]=7'd7;
		#15
		$display("%b",dOut[31:0]);

		WrEn=0;
		dIn[31:0]= 32'd30;
		address[6:0]=7'd7;
		#15;
		$display("%b",dOut[31:0]); 

	end 
endmodule