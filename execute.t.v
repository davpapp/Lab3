`include "execute.v"

`define LW   6'h23
`define DB   0
`define IMM  1
`define ADD  3'd0
`define SUB  3'd1
`define XOR  3'd2
`define SLT  3'd3

module testExecute();

	reg[31:0] Da, Db;
	reg[15:0] imm;
	reg ALU_OperandSource;
	reg[2:0] ALU_cmd;
	wire zero, carryout, overflow;
	wire[31:0] result;

	execute dut(.result(result),
			.zero(zero),
			.carryout(carryout),
			.overflow(overflow),
			.Da(Da),
			.Db(Db),
			.imm(imm),
			.ALU_OperandSource(ALU_OperandSource),
			.command(ALU_cmd));

	task checkResult;
		input[31:0] exp_result;
		input exp_zero, exp_carryout, exp_overflow;

		input[31:0] result;
		input zero, carryout, overflow;

		begin
		if ((result == exp_result) && (zero == exp_zero) &&
			(carryout == exp_carryout) && (overflow == exp_overflow))
		begin
			$display("Passed.");
		end
		else begin
			$display("Failed");
			$display("result: %d", result);
			$display("expected: %d", exp_result);
			$display("zero %b, carryout %b, overflow %b", zero, carryout, overflow);
		end
		end
	endtask

	initial begin
		$dumpfile("dump_exec.vcd");
		$dumpvars();
		// try adding two iputs
		Da = 32'd500;
		Db = 32'd612;
		imm = 16'd90;
		ALU_OperandSource = `DB;
		ALU_cmd = `ADD;
		#1000;
		checkResult(32'd1112,0,0,0,
			result, zero, carryout, overflow);
		// add the immediate to the input
		#500
		ALU_OperandSource = `IMM;
		#1000;
		checkResult(32'd590,0,0,0,
			result, zero, carryout, overflow);
		// Test negative numbers, carryout, overflow and zero flag
		imm = -32'sd500;
		#1000;
		checkResult(32'd0,1,1,0,
			result, zero, carryout, overflow);
		#3000;

	end // initial
endmodule // testControl