module par_multiplier(y,a1,b);

//parameter declare
parameter a1_width=8;
parameter b_width=8;

//localparameter declare
localparam y_width=a_width + b_width;

//port declare
output [y_width-1:0]y;
input [a1_width-1:0]a1;
input [b_width-1:0]b;

generate
if (a1_width<8) || (b_width<8)
cla_multiplier #(a1_width,b_width) m0 (y,a1,b);  //carrylookahead adder multiplier is instantiated
else
tree_multiplier #(a1_width,b_width) m0 (y,a1,b);  //tree mltiplier is instantiated
endgenerate
endmodule
