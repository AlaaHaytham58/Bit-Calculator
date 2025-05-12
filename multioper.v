module multioper(
input [2:0]A,
input[2:0]B,
output reg [4:0]p
//output ZF,
);


 
 reg a1b0;
 reg a0b1;
 //wire for carry 
 wire carry1;
 reg a1b1;
 wire p1;
 wire p2;
 wire p3;


 always@(*)begin
  p[0]=A[0]&B[0];
 a1b0=A[1]&B[0];
 a0b1=A[0]&B[1];
 a1b1=A[1]&B[1];
 //p[4]=(A[2]^B[2]);
 end
 half_adder first(
.x(a1b0),
.y(a0b1),
.s(p1),
.c(carry1)
 );

 half_adder second(
.x(carry1),
.y(a1b1),
.s(p2),
.c(p3)
 );
 always@(*)begin
 p[1]=p1;
 p[2]=p2;
 p[3]=p3;
 end
assign p[4]=(A[2]^B[2]);
// assign p[4]=~p[0]& ~p[1] & ~p[2] & ~p[3];
endmodule
