module bcd_adder(a,b,cin,reset,sum,cout,co);
input [3:0] a,b;
input cin,reset;
output cout,co;
output [3:0]sum;
wire [3:0]v;
wire [2:0]w,c;

full_add fa1(v,w[0],a,b,cin);

and a1(w[1],v[2],v[3]);
and a2(w[2],v[1],v[3]);
or o1(cout,w[0],w[1],w[2]);


adderfull_1bit fa2(sum[0],c[0],v[0],reset,reset);
adderfull_1bit fa3(sum[1],c[1],v[1],cout,c[0]);
adderfull_1bit fa4(sum[2],c[2],v[2],cout,c[1]);
adderfull_1bit fa5(sum[3],co,v[3],reset,c[2]);


endmodule
