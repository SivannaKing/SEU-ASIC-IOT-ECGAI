`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/11 16:53:21
// Design Name: 
// Module Name: swu_rom_3
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


module swu_rom_3#(parameter DEPTH = 29
)(
    input               clk,
    input               rst_n,
    input               enable,
    input       [4:0]   addr,
    output  reg [31:0]  data_o
);
    
    
//    (* ram_style = "block" *)reg [31:0] rom [DEPTH - 1 : 0];
    reg [31:0] rom [DEPTH - 1 : 0];
    initial begin
        $readmemb("G:\\ECG_BNN_9160\\Data\\ECG\\ecg_a3.txt", rom);
    end
    always@(posedge clk)begin
//        if(!rst_n)begin
//            data_o <= 0;
//        end
//        else 
        if(enable)begin
            data_o <=  rom[addr];
        end
//        else
//            data_o <= 0;
    end
endmodule
