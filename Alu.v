module Alu 
(
    input[1:0] S,
    input[2:0] A,
    input[2:0] B,
    output reg [4:0] answer,
    // output reg DZ,
    // output reg Z

    // output [4:0] answer,
    output DZ,
    output Z
);

wire [4:0] L;
wire [4:0] M;
wire [4:0] R;

add_sub unit1
(
    .operation(S[0]),
    .A(A),
    .B(B),
    .C(L)
);

multioper unit2 
(
    .A(A),
    .B(B),
    .p(M)

);

Remoper unit3
(
    .A(A),
    .B(B),
    .R(R),
    .ZeroDiv(DZ)
);

// mux unit4
// (
//     .select(s),
//     .sum(L),
//     .product(M),
//     .remainder(R),
//     .answer(answer)

// );

always@(*) begin 
    case (S) 
        2'b00: answer<= M;
        2'b01: answer<= R;
        2'b10: answer<= L;
        2'b11: answer<= L;
        default: answer<=0;
    endcase
end

assign Z=~(answer[0]||answer[1]||answer[2]||answer[3]);


endmodule