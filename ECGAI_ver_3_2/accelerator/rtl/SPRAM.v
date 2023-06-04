`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/12 16:51:46
// Design Name: 
// Module Name: SPRAM
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


module SPRAM#(parameter ADDR_WIDTH = 8,
              parameter DATA_WIDTH = 32,
              parameter DATA_DEPTH = 226
)(
    input                               clk,
    input                               rst_n,
    input  wire [DATA_WIDTH - 1 : 0]    DINA,
    input  wire [ADDR_WIDTH - 1 : 0]    ADDRA,
    input                               WEA,
//    input  [31:0]                         M,
    input                               ENA,
    output reg  [DATA_WIDTH - 1 : 0]    DOUTA
);

//    (* ram_style = "block" *)reg [DATA_WIDTH-1:0] ram [DATA_DEPTH-1:0];
    reg [DATA_WIDTH-1:0] ram [DATA_DEPTH-1:0];    
//    integer i;
    always@(posedge clk )begin
//        if(!rst_n)begin
//            for(i=0; i<DATA_DEPTH;i=i+1) begin
//                ram[i] <= 32'h0000_0000;
//            end
//        end
//        else 
        if(ENA)begin
            if(WEA)
                ram[ADDRA] <= DINA;
        end      
    end
    
    always@(posedge clk)begin
//        if(!rst_n)begin
//            DOUTA <= 0; 
//        end
//        else 
        if(ENA)begin
            if(!WEA)
                DOUTA <= ram[ADDRA];
        end      
    end
    
//*****************************************下面的是将Block1的Output_Channel输出到txt文件的代码*****************************************
//save_data_to_txt
//    parameter FILENAME_0 = "Output_Channel_0.txt";
//    parameter FILENAME_1 = "Output_Channel_1.txt";
//    parameter FILENAME_2 = "Output_Channel_2.txt";
//    parameter FILENAME_3 = "Output_Channel_3.txt";
//    parameter FILENAME_4 = "Output_Channel_4.txt";
//    parameter FILENAME_5 = "Output_Channel_5.txt";
//    parameter FILENAME_6 = "Output_Channel_6.txt";
//    parameter FILENAME_7 = "Output_Channel_7.txt";
          
//    integer j;
//    integer file;
//    integer k;
//    always@(posedge clk or negedge rst_n)begin
//        if(!rst_n)
//            k <= 0;
//        else
//            k <= k + 1;
//    end
//    always@(*) begin
//        if(k == 470) begin
//            case(M)
//            0:  file = $fopen(FILENAME_0, "w");
//            1:  file = $fopen(FILENAME_1, "w");
//            2:  file = $fopen(FILENAME_2, "w");
//            3:  file = $fopen(FILENAME_3, "w");
//            4:  file = $fopen(FILENAME_4, "w");
//            5:  file = $fopen(FILENAME_5, "w");
//            6:  file = $fopen(FILENAME_6, "w");
//            7:  file = $fopen(FILENAME_7, "w");
//            endcase
//            for (j = 0; j < 226; j = j + 1) begin
//              $fdisplay(file, "%h", ram[j]); // 将缓冲器中的数据写入文件
//            end
//            $fclose(file); 
//        end
//    end
////*****************************************下面的是将Block2的Intput_Channel输出到txt文件的代码*****************************************
//    parameter FILENAME_0 = "B2_In_Channel_0.txt";
//    parameter FILENAME_1 = "B2_In_Channel_1.txt";
//    parameter FILENAME_2 = "B2_In_Channel_2.txt";
//    parameter FILENAME_3 = "B2_In_Channel_3.txt";
//    parameter FILENAME_4 = "B2_In_Channel_4.txt";
//    parameter FILENAME_5 = "B2_In_Channel_5.txt";
//    parameter FILENAME_6 = "B2_In_Channel_6.txt";
//    parameter FILENAME_7 = "B2_In_Channel_7.txt";
          
//    integer j;
//    integer file;
//    integer k;
//    always@(posedge clk or negedge rst_n)begin
//        if(!rst_n)
//            k <= 0;
//        else
//            k <= k + 1;
//    end
//    always@(*) begin
//        if(k == 1403) begin  //1372是看波形图看出来的
//            case(M)
//            20:  file = $fopen(FILENAME_0, "w");
//            21:  file = $fopen(FILENAME_1, "w");
//            22:  file = $fopen(FILENAME_2, "w");
//            23:  file = $fopen(FILENAME_3, "w");
//            24:  file = $fopen(FILENAME_4, "w");
//            25:  file = $fopen(FILENAME_5, "w");
//            26:  file = $fopen(FILENAME_6, "w");
//            27:  file = $fopen(FILENAME_7, "w");
//            endcase
//            for (j = 0; j < DATA_DEPTH; j = j + 1) begin
//              $fdisplay(file, "%h", ram[j]); // 将缓冲器中的数据写入文件
//            end
//            $fclose(file); 
//        end
//    end

////*****************************************下面的是将Block4的Intput_Channel输出到txt文件的代码*****************************************
//    parameter FILENAME_0 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block4_Input_Binary/B4_In_Channel_0.txt";
//    parameter FILENAME_1 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block4_Input_Binary/B4_In_Channel_1.txt";
//    parameter FILENAME_2 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block4_Input_Binary/B4_In_Channel_2.txt";
//    parameter FILENAME_3 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block4_Input_Binary/B4_In_Channel_3.txt";
//    parameter FILENAME_4 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block4_Input_Binary/B4_In_Channel_4.txt";
//    parameter FILENAME_5 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block4_Input_Binary/B4_In_Channel_5.txt";
//    parameter FILENAME_6 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block4_Input_Binary/B4_In_Channel_6.txt";
//    parameter FILENAME_7 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block4_Input_Binary/B4_In_Channel_7.txt";
//    parameter FILENAME_8 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block4_Input_Binary/B4_In_Channel_8.txt";
//    parameter FILENAME_9 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block4_Input_Binary/B4_In_Channel_9.txt";
//    parameter FILENAME_10 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block4_Input_Binary/B4_In_Channel_10.txt";
//    parameter FILENAME_11 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block4_Input_Binary/B4_In_Channel_11.txt";
//    parameter FILENAME_12 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block4_Input_Binary/B4_In_Channel_12.txt";
//    parameter FILENAME_13 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block4_Input_Binary/B4_In_Channel_13.txt";
//    parameter FILENAME_14 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block4_Input_Binary/B4_In_Channel_14.txt";
//    parameter FILENAME_15 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block4_Input_Binary/B4_In_Channel_15.txt";
//    parameter FILENAME_16 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block4_Input_Binary/B4_In_Channel_16.txt";
//    parameter FILENAME_17 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block4_Input_Binary/B4_In_Channel_17.txt";
//    parameter FILENAME_18 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block4_Input_Binary/B4_In_Channel_18.txt";
//    parameter FILENAME_19 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block4_Input_Binary/B4_In_Channel_19.txt";
//    parameter FILENAME_20 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block4_Input_Binary/B4_In_Channel_20.txt";
//    parameter FILENAME_21 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block4_Input_Binary/B4_In_Channel_21.txt";
//    parameter FILENAME_22 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block4_Input_Binary/B4_In_Channel_22.txt";
//    parameter FILENAME_23 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block4_Input_Binary/B4_In_Channel_23.txt";
//    parameter FILENAME_24 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block4_Input_Binary/B4_In_Channel_24.txt";
//    parameter FILENAME_25 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block4_Input_Binary/B4_In_Channel_25.txt";
//    parameter FILENAME_26 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block4_Input_Binary/B4_In_Channel_26.txt";
//    parameter FILENAME_27 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block4_Input_Binary/B4_In_Channel_27.txt";
//    parameter FILENAME_28 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block4_Input_Binary/B4_In_Channel_28.txt";
//    parameter FILENAME_29 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block4_Input_Binary/B4_In_Channel_29.txt";
//    parameter FILENAME_30 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block4_Input_Binary/B4_In_Channel_30.txt";
//    parameter FILENAME_31 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block4_Input_Binary/B4_In_Channel_31.txt";

      
//    integer j;
//    integer file;
//    integer k;
//    always@(posedge clk or negedge rst_n)begin
//        if(!rst_n)
//            k <= 0;
//        else
//            k <= k + 1;
//    end
//    always@(*) begin
//        if(k == 550) begin  //1372是看波形图看出来的
//            case(M)
//            40:  file = $fopen(FILENAME_0, "w");
//            41:  file = $fopen(FILENAME_1, "w");
//            42:  file = $fopen(FILENAME_2, "w");
//            43:  file = $fopen(FILENAME_3, "w");
//            44:  file = $fopen(FILENAME_4, "w");
//            45:  file = $fopen(FILENAME_5, "w");
//            46:  file = $fopen(FILENAME_6, "w");
//            47:  file = $fopen(FILENAME_7, "w");
//            48:  file = $fopen(FILENAME_8, "w");
//            49:  file = $fopen(FILENAME_9, "w");
//            410:  file = $fopen(FILENAME_10, "w");
//            411:  file = $fopen(FILENAME_11, "w");
//            412:  file = $fopen(FILENAME_12, "w");
//            413:  file = $fopen(FILENAME_13, "w");
//            414:  file = $fopen(FILENAME_14, "w");
//            415:  file = $fopen(FILENAME_15, "w");
//            416:  file = $fopen(FILENAME_16, "w");
//            417:  file = $fopen(FILENAME_17, "w");
//            418:  file = $fopen(FILENAME_18, "w");
//            419:  file = $fopen(FILENAME_19, "w");
//            420:  file = $fopen(FILENAME_20, "w");
//            421:  file = $fopen(FILENAME_21, "w");
//            422:  file = $fopen(FILENAME_22, "w");
//            423:  file = $fopen(FILENAME_23, "w");
//            424:  file = $fopen(FILENAME_24, "w");
//            425:  file = $fopen(FILENAME_25, "w");
//            426:  file = $fopen(FILENAME_26, "w");
//            427:  file = $fopen(FILENAME_27, "w");
//            428:  file = $fopen(FILENAME_28, "w");
//            429:  file = $fopen(FILENAME_29, "w");
//            430:  file = $fopen(FILENAME_30, "w");
//            431:  file = $fopen(FILENAME_31, "w");
//            endcase
//            for (j = 0; j < DATA_DEPTH; j = j + 1) begin
//              $fdisplay(file, "%h", ram[j]); // 将缓冲器中的数据写入文件
//            end
//            $fclose(file); 
//        end
//    end

//*****************************************下面的是将Block4的Intput_Channel输出到txt文件的代码*****************************************
//    parameter FILENAME_0 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_0_Verilog.txt";
//    parameter FILENAME_1 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_1_Verilog.txt";
//    parameter FILENAME_2 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_2_Verilog.txt";
//    parameter FILENAME_3 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_3_Verilog.txt";
//    parameter FILENAME_4 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_4_Verilog.txt";
//    parameter FILENAME_5 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_5_Verilog.txt";
//    parameter FILENAME_6 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_6_Verilog.txt";
//    parameter FILENAME_7 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_7_Verilog.txt";
//    parameter FILENAME_8 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_8_Verilog.txt";
//    parameter FILENAME_9 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_9_Verilog.txt";
//    parameter FILENAME_10 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_10_Verilog.txt";
//    parameter FILENAME_11 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_11_Verilog.txt";
//    parameter FILENAME_12 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_12_Verilog.txt";
//    parameter FILENAME_13 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_13_Verilog.txt";
//    parameter FILENAME_14 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_14_Verilog.txt";
//    parameter FILENAME_15 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_15_Verilog.txt";
//    parameter FILENAME_16 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_16_Verilog.txt";
//    parameter FILENAME_17 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_17_Verilog.txt";
//    parameter FILENAME_18 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_18_Verilog.txt";
//    parameter FILENAME_19 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_19_Verilog.txt";
//    parameter FILENAME_20 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_20_Verilog.txt";
//    parameter FILENAME_21 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_21_Verilog.txt";
//    parameter FILENAME_22 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_22_Verilog.txt";
//    parameter FILENAME_23 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_23_Verilog.txt";
//    parameter FILENAME_24 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_24_Verilog.txt";
//    parameter FILENAME_25 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_25_Verilog.txt";
//    parameter FILENAME_26 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_26_Verilog.txt";
//    parameter FILENAME_27 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_27_Verilog.txt";
//    parameter FILENAME_28 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_28_Verilog.txt";
//    parameter FILENAME_29 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_29_Verilog.txt";
//    parameter FILENAME_30 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_30_Verilog.txt";
//    parameter FILENAME_31 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_31_Verilog.txt";
//    parameter FILENAME_32 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_32_Verilog.txt";
//    parameter FILENAME_33 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_33_Verilog.txt";
//    parameter FILENAME_34 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_34_Verilog.txt";
//    parameter FILENAME_35 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_35_Verilog.txt";
//    parameter FILENAME_36 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_36_Verilog.txt";
//    parameter FILENAME_37 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_37_Verilog.txt";
//    parameter FILENAME_38 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_38_Verilog.txt";
//    parameter FILENAME_39 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_39_Verilog.txt";
//    parameter FILENAME_40 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_40_Verilog.txt";
//    parameter FILENAME_41 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_41_Verilog.txt";
//    parameter FILENAME_42 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_42_Verilog.txt";
//    parameter FILENAME_43 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_43_Verilog.txt";
//    parameter FILENAME_44 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_44_Verilog.txt";
//    parameter FILENAME_45 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_45_Verilog.txt";
//    parameter FILENAME_46 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_46_Verilog.txt";
//    parameter FILENAME_47 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_47_Verilog.txt";
//    parameter FILENAME_48 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_48_Verilog.txt";
//    parameter FILENAME_49 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_49_Verilog.txt";
//    parameter FILENAME_50 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_50_Verilog.txt";
//    parameter FILENAME_51 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_51_Verilog.txt";
//    parameter FILENAME_52 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_52_Verilog.txt";
//    parameter FILENAME_53 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_53_Verilog.txt";
//    parameter FILENAME_54 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_54_Verilog.txt";
//    parameter FILENAME_55 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_55_Verilog.txt";
//    parameter FILENAME_56 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_56_Verilog.txt";
//    parameter FILENAME_57 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_57_Verilog.txt";
//    parameter FILENAME_58 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_58_Verilog.txt";
//    parameter FILENAME_59 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_59_Verilog.txt";
//    parameter FILENAME_60 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_60_Verilog.txt";
//    parameter FILENAME_61 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_61_Verilog.txt";
//    parameter FILENAME_62 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_62_Verilog.txt";
//    parameter FILENAME_63 = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_63_Verilog.txt";
    
//    integer j;
//    integer file;
//    integer k;
//    always@(posedge clk or negedge rst_n)begin
//        if(!rst_n)
//            k <= 0;
//        else
//            k <= k + 1;
//    end
//    always@(*) begin
//        if(k == 200) begin  //是看波形图看出来的
//            case(M)
//            60:  file = $fopen(FILENAME_0, "w");
//            61:  file = $fopen(FILENAME_1, "w");
//            62:  file = $fopen(FILENAME_2, "w");
//            63:  file = $fopen(FILENAME_3, "w");
//            64:  file = $fopen(FILENAME_4, "w");
//            65:  file = $fopen(FILENAME_5, "w");
//            66:  file = $fopen(FILENAME_6, "w");
//            67:  file = $fopen(FILENAME_7, "w");
//            68:  file = $fopen(FILENAME_8, "w");
//            69:  file = $fopen(FILENAME_9, "w");
//            610:  file = $fopen(FILENAME_10, "w");
//            611:  file = $fopen(FILENAME_11, "w");
//            612:  file = $fopen(FILENAME_12, "w");
//            613:  file = $fopen(FILENAME_13, "w");
//            614:  file = $fopen(FILENAME_14, "w");
//            615:  file = $fopen(FILENAME_15, "w");
//            616:  file = $fopen(FILENAME_16, "w");
//            617:  file = $fopen(FILENAME_17, "w");
//            618:  file = $fopen(FILENAME_18, "w");
//            619:  file = $fopen(FILENAME_19, "w");
//            620:  file = $fopen(FILENAME_20, "w");
//            621:  file = $fopen(FILENAME_21, "w");
//            622:  file = $fopen(FILENAME_22, "w");
//            623:  file = $fopen(FILENAME_23, "w");
//            624:  file = $fopen(FILENAME_24, "w");
//            625:  file = $fopen(FILENAME_25, "w");
//            626:  file = $fopen(FILENAME_26, "w");
//            627:  file = $fopen(FILENAME_27, "w");
//            628:  file = $fopen(FILENAME_28, "w");
//            629:  file = $fopen(FILENAME_29, "w");
//            630:  file = $fopen(FILENAME_30, "w");
//            631:  file = $fopen(FILENAME_31, "w");
//            632:  file = $fopen(FILENAME_32, "w");
//            633:  file = $fopen(FILENAME_33, "w");
//            634:  file = $fopen(FILENAME_34, "w");
//            635:  file = $fopen(FILENAME_35, "w");
//            636:  file = $fopen(FILENAME_36, "w");
//            637:  file = $fopen(FILENAME_37, "w");
//            638:  file = $fopen(FILENAME_38, "w");
//            639:  file = $fopen(FILENAME_39, "w");
//            640:  file = $fopen(FILENAME_40, "w");
//            641:  file = $fopen(FILENAME_41, "w");
//            642:  file = $fopen(FILENAME_42, "w");
//            643:  file = $fopen(FILENAME_43, "w");
//            644:  file = $fopen(FILENAME_44, "w");
//            645:  file = $fopen(FILENAME_45, "w");
//            646:  file = $fopen(FILENAME_46, "w");
//            647:  file = $fopen(FILENAME_47, "w");
//            648:  file = $fopen(FILENAME_48, "w");
//            649:  file = $fopen(FILENAME_49, "w");
//            650:  file = $fopen(FILENAME_50, "w");
//            651:  file = $fopen(FILENAME_51, "w");
//            652:  file = $fopen(FILENAME_52, "w");
//            653:  file = $fopen(FILENAME_53, "w");
//            654:  file = $fopen(FILENAME_54, "w");
//            655:  file = $fopen(FILENAME_55, "w");
//            656:  file = $fopen(FILENAME_56, "w");
//            657:  file = $fopen(FILENAME_57, "w");
//            658:  file = $fopen(FILENAME_58, "w");
//            659:  file = $fopen(FILENAME_59, "w");
//            660:  file = $fopen(FILENAME_60, "w");
//            661:  file = $fopen(FILENAME_61, "w");
//            662:  file = $fopen(FILENAME_62, "w");
//            663:  file = $fopen(FILENAME_63, "w");
//            endcase
//            for (j = 0; j < DATA_DEPTH; j = j + 1) begin
//              $fdisplay(file, "%h", ram[j]); // 将缓冲器中的数据写入文件
//            end
//            $fclose(file); 
//        end
//    end
    
endmodule
