
module TFF1(q,t_clk,rst);
output q ; 
input t_clk,rst;
wire d;
DFF dff0(q,d,t_clk,rst);
not n1(d,q);
endmodule

