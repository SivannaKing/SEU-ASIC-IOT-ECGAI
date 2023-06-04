`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/13 20:02:29
// Design Name: 
// Module Name: Save_to_file
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
// 本程序将Slide_data存在一个txt文件中，以便于利用python进行比较验证
//////////////////////////////////////////////////////////////////////////////////


module B1_Slide_data_Save_to_file(
    input           clk,
    input           rst_n,
    input   [6:0]   Slide_Data_0, Slide_Data_1, Slide_Data_2, Slide_Data_3
    );

  parameter FILENAME = "Slide_Data.txt"; // 定义文件

  reg [6:0] buffer_0 [0:450]; // 定义存储器
  reg [6:0] buffer_1 [0:450];
  reg [6:0] buffer_2 [0:450];
  reg [6:0] buffer_3 [0:448];
  integer file;
  integer i;
  integer j;
  integer k;
  
  reg rst_n_0, rst_n_1, rst_n_2;
  always@(posedge clk)begin
        rst_n_0 <= rst_n;
        rst_n_1 <= rst_n_0;
        rst_n_2 <= rst_n_1;
  end
  
  
  always @(posedge clk or negedge rst_n_2) begin
    if(!rst_n_2)begin
        i = 0;
        for(k = 0; k<1803; k = k+1)begin
            buffer_0[k] <= 0;
            buffer_1[k] <= 0;
            buffer_2[k] <= 0;
            buffer_3[k] <= 0;
        end
    end
    begin
        buffer_0[i] <= Slide_Data_0; // 将输入数据存储到缓冲器中
        buffer_1[i] <= Slide_Data_1;
        buffer_2[i] <= Slide_Data_2;
        buffer_3[i] <= Slide_Data_3;
        i <= i + 1;
    end
  end
 
  always@(*)begin
    if(i == 451) begin
        file = $fopen(FILENAME, "w"); // 打开文件
        for (j = 0; j < 451; j = j + 1) begin
          $fdisplay(file, "%b", buffer_0[j]); // 将缓冲器中的数据写入文件
        end
        for (j = 0; j < 451; j = j + 1) begin
          $fdisplay(file, "%b", buffer_1[j]); // 将缓冲器中的数据接着写入文件file
        end
        for (j = 0; j < 451; j = j + 1) begin
          $fdisplay(file, "%b", buffer_2[j]); // 将缓冲器中的数据写入文件
        end
        for (j = 0; j < 449; j = j + 1) begin
          $fdisplay(file, "%b", buffer_3[j]); // 将缓冲器中的数据写入文件
        end
        $fclose(file); // 关闭文件
    end
  end


endmodule
