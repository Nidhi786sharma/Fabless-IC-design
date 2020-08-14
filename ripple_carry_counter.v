

module TFF1(q,t_clk,rst);
output q ; 
input t_clk,rst;
wire d;
DFF dff0(q,d,t_clk,rst);
not n1(d,q);
endmodule


module DFF(q,d,clk,reset);
output q;
input d,clk,reset;
reg q;
always@(posedge reset or negedge  clk)
if(reset)
q <=1'b0;
else
q <=d;
endmodule
