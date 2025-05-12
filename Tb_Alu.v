`timescale 1ns/100ps
module Tb_Alu();
reg [2:0] A;
reg [2:0] B;
reg [1:0] Sel;
wire [4:0] answer ;
wire dividebyzero;
wire Zeroflag;

Alu DUT
(
    .A(A),
    .B(B),
    .S(Sel),
    .answer(answer),
    .DZ(dividebyzero),
    .Z(Zeroflag)

);

integer num1;
integer num2;
integer num3;

initial begin 
for(num1=0;num1< 4; num1=num1+1) begin
    Sel=num1[1:0];
    #100;
    for(num2=0; num2< 8; num2=num2+1) begin
        A=num2[2:0];
        #100;
        for(num3=0; num3< 8; num3=num3+1) begin
        B=num3[2:0];
        #100;
        if(A == 3'b100 || B == 3'b100) begin
        end
        else if(answer[0]==0 && answer[1]==0 && answer[2]==0 && answer[3]==0 && Zeroflag!=1) begin 
            $error("Incorrect divide by zero answer flag" );
        end
        else begin 
            if(Sel[0]==1 && Sel[1]==0 && B[0]==0 && B[1]==0 && dividebyzero!=1) begin 
                $error("Incorrect divide by zero flag");
            end
            else begin 
                if(Sel[0]==1 & Sel[1]==0 & answer[4]!=A[2]) begin
                     $error("Incorrect sign for remaider operation");
                end
                else begin 
                    if(Sel[0]==0 && Sel[1]==0 && ((answer[4]!=A[2]^B[2] && A[1:0] != 0  && B[1:0] != 0)|| answer[3:0]!=A[1:0]*B[1:0]))  begin
                        $error("Incorrect selection of multiplication operation A=%b , B=%b, A*B=result=%b, signed flag=%b, Zero flag=%b",A,B,answer,answer[4],Zeroflag);
                    end
                    else begin 
                        if(((Sel[0]==0&Sel[1]==1)||(Sel[0]==1&Sel[1]==1))  &  (((answer[4] == 0? 1:-1) * answer[2:0]) !=(A[2] == 0? 1:-1) * A[1:0] + (Sel[0] == 0? 1:-1) * (B[2] == 0? 1:-1) * B[1:0])) begin 
                        $error("Incorrect selection of Addition or subtraction operation A=%b , B=%b, A+B=result=%b, signed flag=%b, Zero flag=%b",A,B,answer,answer[4],Zeroflag);
                    end
                    else begin 
                         if(Sel[0]==0 & Sel[1]==0) begin 
                            $display("[all Passed] A=%b , B=%b, A*B=result=%b, signed flag=%b, Zero flag=%b",A,B,answer,answer[4],Zeroflag);
                            end
                            else begin 
                            if(Sel[0]==1 & Sel[1]==0) begin 
                            $display("[all Passed] A=%b , B=%b,  A mod B=result=%b, signed flag=%b, Zero flag=%b, div_by_Zero flag=%b",A,B,answer,answer[4],Zeroflag,dividebyzero);
                            end
                            else begin
                            if(Sel[0]==0 & Sel[1]==1) begin 
                            $display("[all Passed] A=%b , B=%b, A+B=result=%b, signed flag=%b, Zero flag=%b",A,B,answer,answer[4],Zeroflag);
                            end
                            else begin 
                            if(Sel[0]==1 & Sel[1]==1) begin 
                            $display("[all Passed] A=%b , B=%b, A-B=result=%b, signed flag=%b, Zero flag=%b",A,B,answer,answer[4],Zeroflag);
                            end
                            end
                            end
                            end
                    end
                    end
                end
            end
        end


    
    
     
end
end
end
end

endmodule