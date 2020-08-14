module bit_adder32(sum,cout,a,b,cin);
parameter N=32;
output[N-1:0] sum,cout;
//output cout ;
input[N-1:0] a,b;
input cin;

genvar j; //temporary variable

generate for (j=0;j<N;j=j+1)

begin:full_add_loop
fulladd_dataflow f1(sum[j],cout[j],a[j],b[j],cin);
end //end of gen block 
endgenerate

endmodule
