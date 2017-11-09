module register32
(
output reg[31:0]	q,
input[31:0]		d,
input		wrenable,
input		clk
);

    always @(posedge clk) begin
    	if (wrenable == 1)
    		q = d;
    end

endmodule