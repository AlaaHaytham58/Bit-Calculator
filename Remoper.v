module Remoper
(
    input [2:0] A,
    input [2:0] B,
    output[4:0] R,
    output ZeroDiv

);
assign R[4]= A[2];
assign R[3]= 0;
assign R[2]= 0;
assign R[1]= !A[0] & A[1] & B[0] & B[1];
assign R[0]= A[0]& B[1]& ~(A[1]&B[0]);  
assign ZeroDiv= ~(B[0]||B[1]);

endmodule
