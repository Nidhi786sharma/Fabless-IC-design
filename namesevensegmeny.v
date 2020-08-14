module namesevensegment(a,reset,r,clk,clk_out);
input [1:0]a;
input clk,reset;
output reg[6:0]r;
output clk_out;
reg [26:0]count;
reg [3:0] counter;
wire [1:0]led_count;
reg [16:0]name_display;

frequencydivider f1(clk,clk_out);

always@(posedge clk )
begin
 if(reset)
 begin
 count=27'd0;
 counter=4'b0;
 end
  else if(count==27'd50000000)
   begin
	count=27'd0;
	if(counter<9)
	 counter=counter+1;
	else counter=0;
     end
 else 
   count=count+1;
end

	
always@(counter)
begin
case(counter)
 2'b00:r=7'b1110001;
 2'b01:r=7'b1001111;
 2'b10:r=7'b0100100;
 2'b11:r=7'b0001000;
endcase
end
endmodule
 