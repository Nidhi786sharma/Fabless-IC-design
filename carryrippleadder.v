module carry_ripple_adder(sum,cout,a,b,cin);
input [3:0]a,b;//4bit input a and b.
input cin;//carry input.
output [3:0]sum;//4bit output of sum.
output cout;//carry output.
wire w1,w2,w3;
//Full Adder Module Instantiation.
Full_Adder cr1(.sum(sum[0]),.cout(w1),.a(a[0]),.b(b[0]),.cin(cin));
Full_Adder cr2(.sum(sum[1]),.cout(w2),.a(a[1]),.b(b[1]),.cin(w1));
Full_Adder cr3(.sum(sum[2]),.cout(w3),.a(a[2]),.b(b[2]),.cin(w2));
Full_Adder cr4(.sum(sum[3]),.cout(cout),.a(a[3]),.b(b[3]),.cin(w3));
endmodule                                                                                                                                                                                      module Full_Adder(a,b,cin,sum,cout);
input a,b,cin;  //input a , b and carry input.
output sum,cout; //output sum and carry output.
assign sum=a^b^cin; //Ex-oring of inputs.
assign cout=(a&b)|(b&cin)|(cin&a);//carry out equation.
endmodule
