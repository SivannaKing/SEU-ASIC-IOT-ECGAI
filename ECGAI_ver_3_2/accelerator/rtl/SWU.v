`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/05 19:16:06
// Design Name: 
// Module Name: SWU
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


module SWU(
    input           clk,
    input           rst_n,
    output  [6:0]   Slide_Data_0,
    output  [6:0]   Slide_Data_1,
    output  [6:0]   Slide_Data_2,
    output  [6:0]   Slide_Data_3,
    output          Trans_Done_0,
    output          Trans_Done_1,
    output          Trans_Done_2,
    output          Trans_Done_3,
    output          Data_Val_0,
    output          Data_Val_1,
    output          Data_Val_2,
    output          Data_Val_3
    );
    
swu_0 SWU_0(.clk(clk),
            .rst_n(rst_n),
            .slide_data(Slide_Data_0),
            .trans_done(Trans_Done_0),
            .ecg_data_val(Data_Val_0)
);
swu_1 SWU_1(.clk(clk),
            .rst_n(rst_n),
            .slide_data(Slide_Data_1),
            .trans_done(Trans_Done_1),
            .ecg_data_val(Data_Val_1)
);

swu_2 SWU_2(.clk(clk),
            .rst_n(rst_n),
            .slide_data(Slide_Data_2),
            .trans_done(Trans_Done_2),
            .ecg_data_val(Data_Val_2)
);

swu_3 SWU_3(.clk(clk),
            .rst_n(rst_n),
            .slide_data(Slide_Data_3),
            .trans_done(Trans_Done_3),
            .ecg_data_val(Data_Val_3)
);

    
    
endmodule
