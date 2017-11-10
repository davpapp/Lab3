`define AND and
`define OR or
`define NOT not
`define XOR xor
`define NOR nor
`define NAND nand

module Subtractor1bit
(
    output diff,
    output borrowout,
    input a,
    input b,
    input borrowin
);
    wire axorb;
    `XOR(axorb, a, b);
    `XOR(diff, axorb, borrowin);
    wire nota, notaandb, notaxorb, notaxorbandborrowin;
    `NOT(nota, a);
    `AND(notaandb, nota, b);
    `NOT(notaxorb, axorb);
    `AND(notaxorbandborrowin, notaxorb, borrowin);
    `OR(borrowout, notaandb, notaxorbandborrowin);
endmodule
