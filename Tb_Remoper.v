`timescale 1ns/100ps
module Tb_Remoper;

    reg [2:0] A,B;
    wire [4:0] R;
    wire ZeroDiv;
    Remoper testunit(
        .A(A),
        .B(B),
        .R(R),
        .ZeroDiv(ZeroDiv)
    );



integer num1;
integer num2;

initial begin
for(num1=0;num1< 8; num1=num1+1) begin
    A=num1[2:0];
    #100;

    for(num2=0; num2< 8; num2=num2+1) begin
        B=num2[2:0];
        #100;

        if (R[4]!=A[2])begin
            $error("Incorrect sign for inputs %b rem %b | %b  Divide by zero flag: %b", A,B,R,ZeroDiv );
        end
        else begin
            if((B[0]==0 & B[1]==0) &  ((ZeroDiv!=1)) ) begin
             $error("Incorrect divide by zero flag for inputs %b rem %b | %b  Divide by zero flag: %b", A,B,R,ZeroDiv );
            end 
            else begin
                if(((A[0]==0&A[1]==0)||(B[0]==0 &B[1]==0))&(R[1]!=0 &R[0]!=0)) begin
                 $error("Incorrect ortput for inputs %b rem %b | %b  Divide by zero flag: %b", A,B,R,ZeroDiv );
                end
                else begin
                    if ((A[1]==B[1]&A[0]==B[0]) & (R[1]!=0 & R[0]!=0)) begin
                        $error("Incorrect ortput for inputs %b rem %b | %b  Divide by zero flag: %b", A,B,R,ZeroDiv );
                    end
                    else begin 
                        if((A[0]==1 & A[1]==0)&(R[0]!=1 & R[1]!=0)) begin 
                            $error("Incorrect ortput for inputs %b rem %b | %b  Divide by zero flag: %b", A,B,R,ZeroDiv );
                        end
                        else begin 
                            if ((B[0]==1&B[1]==0) & (R[1]!=0 & R[0]!=0)) begin  
                                $error("Incorrect ortput for inputs %b rem %b | %b  Divide by zero flag: %b", A,B,R,ZeroDiv );
                            end
                            else begin 
                                if( ( (A[1]==1&A[0]==0) & (R[1]!=1&R[0]!=0) )  || ((A[1]==1&A[0]==1) & (R[1]!=0 & R[0]!=1)) ) begin 
                                    $error("Incorrect ortput for inputs %b rem %b | %b  Divide by zero flag: %b", A,B,R,ZeroDiv );
                                end
                                else begin 
                                    $display("%b rem %b  | %b Divide by zero flag: %b all passed",A,B,R,ZeroDiv);
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