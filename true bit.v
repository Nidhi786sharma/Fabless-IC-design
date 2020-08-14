module true_bit;
reg[15:0] flag;
integer i,count;
initial 
begin
flag = 16'b0010_0010_0010_0000;
i=0;
count=0;
begin :block1
while(i<16)
begin
if(flag[i])
begin
$display("encountered a true bit at element no. %d",i);
count=count+1;
//disable block1;
end
i=i+1;
end
$display("count=%d",count);
end
end
endmodule

