`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/26 15:57:47
// Design Name: 
// Module Name: ECG_Top_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ECG_Top_tb();

reg     clk;
reg     rst_n;
wire    [2:0]   class;
initial begin
    clk = 0; rst_n = 0;
    forever #10  clk = ~clk;
end
initial begin
    #16 rst_n = 1;
end
ECG_Top DUT(.clk(clk), .rst_n(rst_n), .class(class));


endmodule
