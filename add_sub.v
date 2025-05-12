module signMagnitudeTo2sComplementConverter
(
    input sign,
    input a0,
    input a1,
    output b3,
    output b2,
    output b1,
    output b0
);

assign b0 = a0;

assign b2 = sign;

assign b3 = sign;

assign b1 = (a1 ^ sign) | (~a0 & a1);

endmodule

module four_bit_adder 
(
    input cin,
    input [3:0]a,
    input [3:0]b,
    output [3:0]sum,
    output carry
);

assign {carry, sum} = a + b + cin;

endmodule

module add_sub_2sComplement_4bits
(
    input operation,
    input [3:0]op1,
    input [3:0]op2,
    output [3:0]result
);

wire [3:0]secondOperandWire;

assign secondOperandWire[0] = op2[0] ^ operation;
assign secondOperandWire[1] = op2[1] ^ operation;
assign secondOperandWire[2] = op2[2] ^ operation;
assign secondOperandWire[3] = op2[3] ^ operation;

four_bit_adder adder(operation, op1, secondOperandWire, result);

endmodule

module TwosComplementTosignMagnitudeConverter
(
    input a0,
    input a1,
    input a2,
    input a3,
    output sign,
    output b2,
    output b1,
    output b0
);

assign b0 = a0;

assign sign = a3;

assign b2 = (a2 ^ a3) | (~a0 & ~a1 & a2);

assign b1 = (a1 & ~a3) | (a1 & ~a0) | (~a1 & a0 & a3);

endmodule

module add_sub
(
    input operation,
    input [2:0]A,
    input [2:0]B,
    output [4:0]C
);
assign C[3]=0;
wire [3:0]D;
wire [3:0]E;

signMagnitudeTo2sComplementConverter convertAtoD (A[2], A[0], A[1], D[3], D[2], D[1], D[0]);
signMagnitudeTo2sComplementConverter converttBoE (B[2], B[0], B[1], E[3], E[2], E[1], E[0]);

wire [3:0]S;

add_sub_2sComplement_4bits add_sub_operation (operation, D, E, S);

TwosComplementTosignMagnitudeConverter convertStoC (S[0], S[1], S[2], S[3], C[4], C[2], C[1], C[0]);

endmodule

