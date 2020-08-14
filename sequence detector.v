module sequence_detector_mealy1010(inp,clk,reset,y);
input inp,clk,reset;
output reg y;
reg[1:0]present,next;
parameter first=2'b00;
parameter second=2'b01;
parameter third=2'b10;
parameter fourth=2'b11;

always@(posedge clk)
begin
if(reset)
present<=first;
else
present<=next;
end

always@(present or inp)
begin
case(present)
first:if(inp==1)
begin
next=second;
y=0;
end
else
begin
next=present;
y=0;
end

second:if(inp==0)
begin
next=third;
y=0;
end
else
begin
next=present;
y=0;
end

third:if(inp==1)
begin
next=fourth;
y=0;
end
else
begin
next=first;
y=0;
end

fourth:if(inp==0)
begin
y=1;
next=third;
end
else
begin
next=second;
y=0;
end

default:next=first;
endcase
end
endmodule
