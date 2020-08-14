module adderfull_1bit (sum,cout,a,b,cin);
output sum,cout;
input a,b,cin;
wire c1,c2,c3,c4,c5,c6,c7;

nand n1(c1,a,b);
nand n2(c2,c1,a);
nand n3(c3,c1,b);
nand n4(c4,c2,c3);
nand n5(c5,c4,cin);
nand n6(c6,c4,c5);
nand n7(c7,c5,cin);
nand n8(cout,c1,c5);
nand n9(sum,c7,c6);

endmodule
