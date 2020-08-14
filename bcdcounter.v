module bcd_counter(reset,clk,out);
input reset,clk;
output reg[3:0]out;

initial out=0;
always@(posedge clk)
begin
 if (reset)
 begin
 out<=3'b0;
 end
    else if(out<=9)
    begin
      out<=out+1;
    end
else 
 out<=0;
  
end
endmodule 
