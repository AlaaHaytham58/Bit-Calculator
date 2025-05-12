`timescale 1ns/100ps
module TB_multioper();
// now inputs will be entered
reg [2:0] A,B;

wire [4:0] p;


/*multioper DUT(
.A(A),
.B(B),
.p(p),
.SF(SF)
);*/
multioper test
(
  .A(A),
  .B(B),
  .p(p)
);

integer a;
integer b;

initial begin 
for(a=0;a<=7;a=a+1) begin 
  A=a[2:0];
  #100;
  for(b=0;b<=7;b=b+1) begin
    B=b[2:0];
    #100;
    /*if((ZF==1) & (p==4'b0000) & (p==A[1:0]*B[1:0]))begin 
       $display("%b %b  %b %b| %b all passed",A,B,ZF,SF,p);
    end else if((A[2]!=B[2])& (SF==1)& (p==A[1:0]*B[1:0]))begin
    $display("%b %b  %b %b| %b all passed",A,B,ZF,SF,p);
    end else begin 
        $error("incorrect operation For inputs %b %b  %b %b| %b",A,B,ZF,SF,p);
      end
    end*/

    /*if (ZF==1 & (p!=4'b0000))begin 
      $error("incorrect Zero Flag For inputs %b %b * |%b %b%b",A,B,ZF,SF,p);
    end*/
    
      if(((A[2]!=B[2])& (p[4]==0)) || (A[2]==B[2])& (p[4]==1)) begin 
        $error("incorrect Sign For inputs %b %b * | %b",A,B,p);
      end
      else begin 
        if((p[3:0]!=A[1:0]*B[1:0])) begin 
          $error("incorrect operations For inputs %b %b * | %b",A,B,p);
        end
        else begin 
           $display("%b * %b | %b all passed",A,B,p);
        end
      end
    end
  end
 $finish();
  end
  

endmodule
