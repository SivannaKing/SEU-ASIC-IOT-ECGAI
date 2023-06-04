`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/28 17:11:44
// Design Name: 
// Module Name: B2_SlideData_Save_to_file
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


module B2_SlideData_Save_to_file(
    input           clk,
    input           rst_n,
    input   [6:0]   Slide_data_0, Slide_data_1, Slide_data_2, Slide_data_3, Slide_data_4, Slide_data_5, Slide_data_6, Slide_data_7
);

  parameter FILENAME_0 = "B2_Slide_Data_0_Verilog.txt",
            FILENAME_1 = "B2_Slide_Data_1_Verilog.txt", 
            FILENAME_2 = "B2_Slide_Data_2_Verilog.txt", 
            FILENAME_3 = "B2_Slide_Data_3_Verilog.txt", 
            FILENAME_4 = "B2_Slide_Data_4_Verilog.txt", 
            FILENAME_5 = "B2_Slide_Data_5_Verilog.txt", 
            FILENAME_6 = "B2_Slide_Data_6_Verilog.txt",
            FILENAME_7 = "B2_Slide_Data_7_Verilog.txt"; // 定义文件

  reg [6:0] buffer_0 [0:901]; 
  reg [6:0] buffer_1 [0:901];
  reg [6:0] buffer_2 [0:901];
  reg [6:0] buffer_3 [0:901];
  reg [6:0] buffer_4 [0:901]; 
  reg [6:0] buffer_5 [0:901];
  reg [6:0] buffer_6 [0:901];
  reg [6:0] buffer_7 [0:901];
  integer file_0, file_1, file_2, file_3, file_4, file_5, file_6, file_7;
  integer i;
  integer j;
  integer k, m;
  
  initial begin
        for(m = 0; m <902; m = m + 1)begin
            buffer_0[m] <= 0;
            buffer_1[m] <= 0;
            buffer_2[m] <= 0;
            buffer_3[m] <= 0;
            buffer_4[m] <= 0;
            buffer_5[m] <= 0;
            buffer_6[m] <= 0;
            buffer_7[m] <= 0;
        end
  end
  
  reg rst_n_0, rst_n_1, rst_n_2, rst_n_3;
  always@(posedge clk)begin
        rst_n_0 <= rst_n;
        rst_n_1 <= rst_n_0;
        rst_n_2 <= rst_n_1;
        rst_n_3 <= rst_n_2;
  end
  
  
  always @(posedge clk or negedge rst_n_3) begin
    if(!rst_n_3)begin
        i <= 0;
//        for(k = 0; k<902; k = k+1)begin
//            buffer_0[k] <= 0;
//            buffer_1[k] <= 0;
//            buffer_2[k] <= 0;
//            buffer_3[k] <= 0;
//            buffer_4[k] <= 0;
//            buffer_5[k] <= 0;
//            buffer_6[k] <= 0;
//            buffer_7[k] <= 0;
//        end
    end
    else begin
        buffer_0[i] <= Slide_data_0;
        buffer_1[i] <= Slide_data_1;
        buffer_2[i] <= Slide_data_2;
        buffer_3[i] <= Slide_data_3;
        buffer_4[i] <= Slide_data_4;
        buffer_5[i] <= Slide_data_5;
        buffer_6[i] <= Slide_data_6;
        buffer_7[i] <= Slide_data_7;
        i <= i + 1;
    end
  end
 
  always@(*)begin
    if(i == 902) begin
        file_0 = $fopen(FILENAME_0, "w");
        file_1 = $fopen(FILENAME_1, "w");
        file_2 = $fopen(FILENAME_2, "w");
        file_3 = $fopen(FILENAME_3, "w");
        file_4 = $fopen(FILENAME_4, "w");
        file_5 = $fopen(FILENAME_5, "w");
        file_6 = $fopen(FILENAME_6, "w");
        file_7 = $fopen(FILENAME_7, "w"); 
        for (j = 0; j < 902; j = j + 1) begin
          $fdisplay(file_0, "%b", buffer_0[j]); // 将缓冲器中的数据写入文件
        end
        for (j = 0; j < 902; j = j + 1) begin
          $fdisplay(file_1, "%b", buffer_1[j]); // 将缓冲器中的数据写入文件
        end
        for (j = 0; j < 902; j = j + 1) begin
          $fdisplay(file_2, "%b", buffer_2[j]); // 将缓冲器中的数据写入文件
        end
        for (j = 0; j < 902; j = j + 1) begin
          $fdisplay(file_3, "%b", buffer_3[j]); // 将缓冲器中的数据写入文件
        end
        for (j = 0; j < 902; j = j + 1) begin
          $fdisplay(file_4, "%b", buffer_4[j]); // 将缓冲器中的数据写入文件
        end
        for (j = 0; j < 902; j = j + 1) begin
          $fdisplay(file_5, "%b", buffer_5[j]); // 将缓冲器中的数据写入文件
        end
        for (j = 0; j < 902; j = j + 1) begin
          $fdisplay(file_6, "%b", buffer_6[j]); // 将缓冲器中的数据写入文件
        end
        for (j = 0; j < 902; j = j + 1) begin
          $fdisplay(file_7, "%b", buffer_7[j]); // 将缓冲器中的数据写入文件
        end
        $fclose(file_0);
        $fclose(file_1); 
        $fclose(file_2); 
        $fclose(file_3); 
        $fclose(file_4); 
        $fclose(file_5); 
        $fclose(file_6); 
        $fclose(file_7); 
        
         
    end
  end

endmodule
