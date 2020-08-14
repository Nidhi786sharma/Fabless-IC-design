//deine a factorial with recursive fn
module top;
//define fn
function automatic integer factorial;
input [31:0] oper;
integer i;
begin
if (oper>=2)
factorial=factorial(oper-1)*oper; // recursive call
else 
factorial=1;
end 
endfunction

//call the function
integer result;
initial 
begin
result=factorial(25);
$display("factorial of 25 is %0d",result);
end 
endmodule
 

