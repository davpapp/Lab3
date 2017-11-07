`include "ifetch.v"

module testifetch();
	reg           clk;        // FPGA clock
	reg write_pc, is_branch, is_jump;
	reg[15:0] branch_addr;
	reg[31:0] jump_addr;
	wire[31:0] out;

	ifetch dut(
		.clk(clk),
		.write_pc(write_pc),
		.is_branch(is_branch),
		.is_jump(is_jump),
		.branch_addr(branch_addr),
		.jump_addr(jump_addr),
		.out(out)
		);

	initial begin
		clk=0;
		assign dut.pc_reg.mem = 32'b0;
	end

	always #5 clk=!clk;    // 50MHz Clock

	initial begin
		$dumpfile("ifetch.vcd");
	    $dumpvars();

	    // Some Nonsense
	    write_pc = 1; is_branch = 0; is_jump = 0; branch_addr = 16'b0; jump_addr = 31'b0; # 10
	    write_pc = 0;
	    $display("OutPut: %h", out); #10

	    write_pc = 1; is_branch = 1; is_jump = 0; branch_addr = 16'd12; jump_addr = 31'b0; # 10
	    write_pc = 0;

	    $display("OutPut: %h", out); #10

		write_pc = 1; is_branch = 0; is_jump = 1; branch_addr = 16'b0; jump_addr = 31'd32; # 10
	    write_pc = 0;
	    $display("OutPut: %h", out);
	   	#100 $finish;

	end // initial
endmodule // testifetch