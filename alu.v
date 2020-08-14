module alu(a,b,c,y);
input [2:0]c;
input [2:0]a,b;
output reg[7:0]y;

always@(a,b,c)
begin
case(c)

 3'b000:y=a+b;
 3'b001:y=a-b;
 3'b010:y=a&b;
 3'b011:y=a|b;
 3'b100:y=a^b;
 3'b101:y=a+1;
 3'b110:y=a-1;
 3'b111:begin y=a;
y=y>>1'b1 ;
end
endcase
$display("output=%b",y);
end
endmodule