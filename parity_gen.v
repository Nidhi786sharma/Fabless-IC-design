module parity_gen(ep,op,x);
output ep,op;
input [8:0]x;
assign ep=^x;
assign op=~ep;
endmodule
