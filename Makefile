all: control regfile ifetch datamemory alu execute testInstructionDecode add32bit alu1bit mux3bit

cpu: cpu.v cpu.t.v
	iverilog -Wall -o cpu cpu.t.v

control: control.v control.t.v
	iverilog -Wall -o control control.t.v

regfile: regfile.v regfile.t.v
	iverilog -Wall -o regfile regfile.t.v

ifetch: ifetch.v ifetch.t.v
	iverilog -Wall -o ifetch ifetch.t.v

datamemory: datamemory.v datamemory.t.v
	iverilog -Wall -o datamemory datamemory.t.v

alu: alu.v alu.t.v
	iverilog -Wall -o alu alu.t.v

execute: execute.v execute.t.v
	iverilog -Wall -o execute execute.t.v

testInstructionDecode: testInstructionDecode.v testInstructionDecode.t.v
	iverilog -Wall -o testInstructionDecode testInstructionDecode.t.v

add32bit: add32bit.v add32bit.t.v
	iverilog -Wall -o add32bit add32bit.t.v

alu1bit: alu1bit.v alu1bit.t.v
	iverilog -Wall -o alu1bit alu1bit.t.v

mux3bit: mux3bit.v mux3bit.t.v
	iverilog -Wall -o mux3bit mux3bit.t.v


# # Assembly simulation in Verilog unified Makefile example

# include settings.mk

# GTKWAVE := gtkwave
# SIM     := vvp

# # Final waveform to produce is the combination of machine and program
# WAVEFORM := $(TOPLEVEL)-$(PROGRAM).vcd
# WAVEOPTS := filters/$(WAVEFORM:vcd=gtkw)


# # Build memory image, compile Verilog, run simulation to produce VCD trace
# $(WAVEFORM): settings.mk
# 	$(MAKE) -C asm $(MEMDUMP)
# 	$(MAKE) -C verilog $(TOPLEVEL).vvp
# 	$(SIM) verilog/$(TOPLEVEL).vvp +mem_fn=asm/$(MEMDUMP) +dump_fn=$@


# # Open waveform with saved formatting and filter options
# scope: $(WAVEFORM) $(WAVEOPTS)
# 	$(GTKWAVE) $(WAVEOPTS)


# # Remove generated files, including from subdirectories
# clean: 
# 	$(MAKE) -C asm clean
# 	$(MAKE) -C verilog clean
# 	rm -f $(WAVEFORM)

# .PHONY: scope clean
