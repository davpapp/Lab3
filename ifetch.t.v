`include "ifetch.v"

module testifetch();
	reg           clk;        // FPGA clock
	reg write_pc, is_branch, is_jump;
	reg[15:0] branch_addr;
	reg[27:0] jump_addr;
	wire[31:0] out, pc;

	ifetch dut(
		.clk(clk),
		.write_pc(write_pc),
		.is_branch(is_branch),
		.is_jump(is_jump),
		.branch_addr(branch_addr),
		.jump_addr(jump_addr[27:2]),
		.out(out),
		.pc(pc)
		);

	initial begin
		clk=0;
	end

	always #5 clk=!clk;    // 50MHz Clock

	task checkResult;
		input[31:0] exp_val;
		input[31:0] val;
		input w_pc, is_b, is_j;
		input[15:0] b_a;
		input[25:0] j_a;

		begin
		if (val == exp_val) begin
			$display("Passed.");
		end
			else begin
				$display("Failed");
				$display("OutPut - output: %d expected: %d",val, exp_val);
				$display("WritePC: %b is_branch: %b is_jump: %b", w_pc, is_b, is_j);
				$display("Branch Address: %d", b_a);
				$display("Jump Address: %d", j_a);
			end
		end
	endtask

	initial begin
		$dumpfile("ifetch.vcd");
	    $dumpvars();

	    write_pc = 1; is_branch = 0; is_jump = 0; branch_addr = 16'd0; jump_addr = 26'b0;
	    #10//@(posedge clk);
	    checkResult(dut.pc, out, write_pc, is_branch, is_jump, branch_addr, jump_addr);

	    write_pc = 1; is_branch = 1; is_jump = 0; branch_addr = 16'd12; jump_addr = 26'b0;
	    #10//@(posedge clk);
	    checkResult(dut.pc, out, write_pc, is_branch, is_jump, branch_addr, jump_addr);

		write_pc = 1; is_branch = 0; branch_addr = -16'd4; jump_addr = 26'd28; is_jump = 1;
	    #10//@(posedge clk);
	    checkResult(dut.pc, out, write_pc, is_branch, is_jump, branch_addr, jump_addr);

	    write_pc = 1; is_branch = 0; is_jump = 0; branch_addr = 16'd4; jump_addr = 26'd32;
	    #10//@(posedge clk);
	    checkResult(dut.pc, out, write_pc, is_branch, is_jump, branch_addr, jump_addr);
	   	#20 $finish;

	end // initial
endmodule // testifetch