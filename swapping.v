module swapping(a,b,clk);
input clk;
output reg a,b;
initial
begin;
a=1'b0;
b=1'b1;
end
always@(posedge clk)
begin
a<=b;
b<=a;
end
endmodule
