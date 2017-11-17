# Project-specific settings

## Assembly settings

# Assembly program (minus .asm extension)
PROGRAM := inefficient_mult

# Memory image(s) to create from the assembly program
MEMDUMP := $(PROGRAM).text.hex


## Verilog settings

# Top-level module/filename (minus .v/.t.v extension)
TOPLEVEL := testInstructionDecode
#cpu

# All circuits included by the toplevel $(TOPLEVEL).t.v
CIRCUITS := instructionDecoderR.v instructionDecoderI.v instructionDecoderJ.v 

#adder32bit.v adder1bit.v adder_subtracter.v alu.v alu1bit.v aluK.v and_32bit.v control.v cpu.v datamemory.v decoders.v dff.v execute.v ifetch.v 
