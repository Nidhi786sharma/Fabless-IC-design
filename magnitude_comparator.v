`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:50:37 06/21/2019 
// Design Name: 
// Module Name:    xyz 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module xyz(o1,o2,o3,i1,i2,i3,a,b);
input i1,i2,i3;
input [3:0]a,b;
output o1,o2,o3;
assign o1=(a==b)&&(i1==1);
assign o2=(a<b)||((a==b)&&(i2==1));
assign o3=(a>b)||((a==b)&&(i3==1));



endmodule
