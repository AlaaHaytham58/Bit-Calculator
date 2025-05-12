module add_sub_2sComplement_4bits_tb();

reg operation;
reg signed [3:0]operand1;
reg signed [3:0]operand2;

wire signed [3:0]result;

add_sub_2sComplement_4bits DUT(operation, operand1, operand2, result);

integer number;
initial begin
for(number = 0; number < 10'b10_0000_0000; number = number + 1) begin

    assign operand1 = number[3:0];
    assign operand2 = number[7:4];
    assign operation = number[8];

    #100;

    if(number[3:0] > 4'b0011 && number[3:0] < 4'b1101 || number[7:4] > 4'b0011 && number[7:4] < 4'b1101 )begin
    end

    else if ((operand1 + (number[8] == 0? 1:-1) * operand2) == result ) begin
        $display("passed %d %s %d = %d",operand1, (number[8] == 0? "+":"-"), operand2, result);
    end
    else begin
        $error("failed %d %s %d = %d",operand1, (number[8] == 0? "+":"-"), operand2, result);
    end
end

end

endmodule

module add_sub_tb();

reg operation;
reg [2:0]a; 
reg [2:0]b;

wire [4:0]c;


add_sub DUT (operation, a, b, c);

integer number;
initial begin

    for(number = 0; number < 128; number = number + 1) begin
    
    assign a = number [2:0];
    assign b = number [5:3];
    assign operation = number [6];

    #100;

    if(number[2:0] == 3'b100 || number[5:3] == 3'b100) begin
    end
    else if((((c[4] == 0)? 1:-1) * c[2:0]) == (((number[2] == 0)? 1:-1) * number[1:0] + ((number[6] == 0)? 1: -1) * ((number[5] == 0)? 1:-1) * number[4:3])) begin
        $display("passed %s%d %s %s%d = %s%d", number[2]==0?"":"-", number[1:0], number[6] == 0?"+":"-", number[5]==0?"":"-", number[4:3], c[3]==0?"":"-", c[2:0]);
    end
    else
    begin
        $error("failed %s%d %s %s%d = %s%d", number[2]==0?"":"-", number[1:0], number[6] == 0?"+":"-", number[5]==0?"":"-", number[4:3], c[4]==0?"":"-", c[2:0]);
    end

    end

end


endmodule