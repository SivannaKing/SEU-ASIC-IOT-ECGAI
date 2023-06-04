`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/04 19:27:59
// Design Name: 
// Module Name: Maxpool_Thre_B3
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


module Maxpool_Thre_B3(
    input                       clk,
    input                       rst_n,
    input   wire signed [7:0]   o_0, o_1, o_2, o_3, o_4, o_5, o_6, o_7, o_8, o_9, o_10, o_11, o_12, o_13, o_14, o_15,
                                o_16, o_17, o_18, o_19, o_20, o_21, o_22, o_23, o_24, o_25, o_26, o_27, o_28, o_29, o_30, o_31, 
    input                       o_0_val,
    output  wire                Bout_0, Bout_1, Bout_2,  Bout_3,  Bout_4,  Bout_5,  Bout_6,  Bout_7,
                                Bout_8, Bout_9, Bout_10, Bout_11, Bout_12, Bout_13, Bout_14, Bout_15,
                                Bout_16, Bout_17, Bout_18, Bout_19, Bout_20, Bout_21, Bout_22, Bout_23,
                                Bout_24, Bout_25, Bout_26, Bout_27, Bout_28, Bout_29, Bout_30, Bout_31,
    output  reg                 Bout_0_Val           
);
//***************************读取阈�?�函数并存储在自己的寄存器中,向比较模型传递这些阈值让其存�?************************
reg     [4:0]     Thre_ROM_ADDR;
wire              enable;
wire    [23:0]    data_o;
reg     [5:0]     thre_cnt;
reg     [31:0]    loadthrehold, loadthrehold_e1;
//ThreholdBuffer_ROM_B3  #(.ADDR_WIDTH(5), .DATA_WIDTH(24),.DATA_DEPTH(32)) ThreholdBuffer_B3(.clk(clk),  .enable(enable),  .addr(Thre_ROM_ADDR),  .data_o(data_o));
ThreholdBuffer_ROM_B3_IP ThreholdBuffer_B3 (
  .clka(clk),    // input wire clka
  .ena(enable),      // input wire ena
  .addra(Thre_ROM_ADDR),  // input wire [4 : 0] addra
  .douta(data_o)  // output wire [21 : 0] douta
);
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        Thre_ROM_ADDR <= 0;
    end else begin
        if(thre_cnt < 32 )begin
            Thre_ROM_ADDR <= Thre_ROM_ADDR + 1 ;
        end else if(thre_cnt == 32)begin
            Thre_ROM_ADDR <= 0;
        end
    end
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        thre_cnt <= 0;
        loadthrehold_e1 <= 0;
    end else begin
        if(thre_cnt < 32)begin
            thre_cnt <= thre_cnt + 1;
            loadthrehold_e1 <= {loadthrehold_e1[30:0], 1'b1};
        end
        else if(thre_cnt == 32)begin
            thre_cnt <= 32;
        end
    end
end

always@(posedge clk)begin
    loadthrehold <= loadthrehold_e1;
end
assign enable = (rst_n & thre_cnt!= 32);

//***************************读取阈�?�函数并存储在自己的寄存器中************************
reg     [55:0]      Conpare_In_seven_0, Conpare_In_seven_1, Conpare_In_seven_2, Conpare_In_seven_3, Conpare_In_seven_4, Conpare_In_seven_5, Conpare_In_seven_6, Conpare_In_seven_7,
                    Conpare_In_seven_8, Conpare_In_seven_9, Conpare_In_seven_10, Conpare_In_seven_11, Conpare_In_seven_12, Conpare_In_seven_13, Conpare_In_seven_14, Conpare_In_seven_15,
                    Conpare_In_seven_16, Conpare_In_seven_17, Conpare_In_seven_18, Conpare_In_seven_19, Conpare_In_seven_20, Conpare_In_seven_21, Conpare_In_seven_22, Conpare_In_seven_23,
                    Conpare_In_seven_24, Conpare_In_seven_25, Conpare_In_seven_26, Conpare_In_seven_27, Conpare_In_seven_28, Conpare_In_seven_29, Conpare_In_seven_30, Conpare_In_seven_31;
reg     [2:0]       cnt_7_0;
reg     [1:0]       cnt_2_0; //首先cnt�?7后，即集�?7�?7bit数据于上面的49bit寄存器�?�接�?就开始一二�?�一二的计数，来让Maxpool的步长为2
wire                maxpool_0_enable;
reg                 maxpool_0_enable_d1;
always@(posedge clk or negedge o_0_val)begin
    if(!o_0_val)begin
        Conpare_In_seven_0 <= 0;
        Conpare_In_seven_1 <= 0;
        Conpare_In_seven_2 <= 0;
        Conpare_In_seven_3 <= 0;
        Conpare_In_seven_4 <= 0;
        Conpare_In_seven_5 <= 0;
        Conpare_In_seven_6 <= 0;
        Conpare_In_seven_7 <= 0;
        Conpare_In_seven_8 <= 0;
        Conpare_In_seven_9 <= 0;
        Conpare_In_seven_10 <= 0;
        Conpare_In_seven_11 <= 0;
        Conpare_In_seven_12 <= 0;
        Conpare_In_seven_13 <= 0;
        Conpare_In_seven_14 <= 0;
        Conpare_In_seven_15 <= 0;
        Conpare_In_seven_16 <= 0; 
        Conpare_In_seven_17 <= 0; 
        Conpare_In_seven_18 <= 0; 
        Conpare_In_seven_19 <= 0; 
        Conpare_In_seven_20 <= 0; 
        Conpare_In_seven_21 <= 0; 
        Conpare_In_seven_22 <= 0; 
        Conpare_In_seven_23 <= 0; 
        Conpare_In_seven_24 <= 0; 
        Conpare_In_seven_25 <= 0; 
        Conpare_In_seven_26 <= 0; 
        Conpare_In_seven_27 <= 0; 
        Conpare_In_seven_28 <= 0; 
        Conpare_In_seven_29 <= 0; 
        Conpare_In_seven_30 <= 0; 
        Conpare_In_seven_31 <= 0;       
    end else begin
        Conpare_In_seven_0 <= {Conpare_In_seven_0[47:0], o_0[7:0]};
        Conpare_In_seven_1 <= {Conpare_In_seven_1[47:0], o_1[7:0]};
        Conpare_In_seven_2 <= {Conpare_In_seven_2[47:0], o_2[7:0]};
        Conpare_In_seven_3 <= {Conpare_In_seven_3[47:0], o_3[7:0]};
        Conpare_In_seven_4 <= {Conpare_In_seven_4[47:0], o_4[7:0]};
        Conpare_In_seven_5 <= {Conpare_In_seven_5[47:0], o_5[7:0]};
        Conpare_In_seven_6 <= {Conpare_In_seven_6[47:0], o_6[7:0]};
        Conpare_In_seven_7 <= {Conpare_In_seven_7[47:0], o_7[7:0]};
        Conpare_In_seven_8 <= {Conpare_In_seven_8[47:0], o_8[7:0]};
        Conpare_In_seven_9 <= {Conpare_In_seven_9[47:0], o_9[7:0]};
        Conpare_In_seven_10 <= {Conpare_In_seven_10[47:0], o_10[7:0]};
        Conpare_In_seven_11 <= {Conpare_In_seven_11[47:0], o_11[7:0]};
        Conpare_In_seven_12 <= {Conpare_In_seven_12[47:0], o_12[7:0]};
        Conpare_In_seven_13 <= {Conpare_In_seven_13[47:0], o_13[7:0]};
        Conpare_In_seven_14 <= {Conpare_In_seven_14[47:0], o_14[7:0]};
        Conpare_In_seven_15 <= {Conpare_In_seven_15[47:0], o_15[7:0]};
        Conpare_In_seven_16 <= {Conpare_In_seven_16[47:0], o_16[7:0]};
        Conpare_In_seven_17 <= {Conpare_In_seven_17[47:0], o_17[7:0]};
        Conpare_In_seven_18 <= {Conpare_In_seven_18[47:0], o_18[7:0]};
        Conpare_In_seven_19 <= {Conpare_In_seven_19[47:0], o_19[7:0]};
        Conpare_In_seven_20 <= {Conpare_In_seven_20[47:0], o_20[7:0]};
        Conpare_In_seven_21 <= {Conpare_In_seven_21[47:0], o_21[7:0]};
        Conpare_In_seven_22 <= {Conpare_In_seven_22[47:0], o_22[7:0]};
        Conpare_In_seven_23 <= {Conpare_In_seven_23[47:0], o_23[7:0]};
        Conpare_In_seven_24 <= {Conpare_In_seven_24[47:0], o_24[7:0]};
        Conpare_In_seven_25 <= {Conpare_In_seven_25[47:0], o_25[7:0]};
        Conpare_In_seven_26 <= {Conpare_In_seven_26[47:0], o_26[7:0]};
        Conpare_In_seven_27 <= {Conpare_In_seven_27[47:0], o_27[7:0]};
        Conpare_In_seven_28 <= {Conpare_In_seven_28[47:0], o_28[7:0]};
        Conpare_In_seven_29 <= {Conpare_In_seven_29[47:0], o_29[7:0]};
        Conpare_In_seven_30 <= {Conpare_In_seven_30[47:0], o_30[7:0]};
        Conpare_In_seven_31 <= {Conpare_In_seven_31[47:0], o_31[7:0]};              
    end
end

always@(posedge clk or negedge o_0_val)begin
    if(!o_0_val)begin
        cnt_7_0 <= 0;
        cnt_2_0 <= 0;
    end else begin
        if(cnt_7_0!=7)begin
            cnt_7_0 <= cnt_7_0 + 1;
        end
        else if(cnt_7_0 == 7)begin
            if(cnt_2_0 != 2)begin
                cnt_2_0 <= cnt_2_0 + 1;
            end else if(cnt_2_0 == 2)begin
                cnt_2_0 <= 1;
            end
        end
    end
end
assign  maxpool_0_enable = cnt_7_0 == 7 && (cnt_2_0 == 0 || cnt_2_0 == 2);
//由于寄存器的缘故，延�?1个clk的波形才是正对着步长�?2的max_value�?
//但是阈�?�比较为0�?1也有�?个延迟，故除去第�?个时钟脉冲，之后的时钟脉冲又对应�?正确�?0�?1被输出的clk
always@(posedge clk)begin
    maxpool_0_enable_d1 <= maxpool_0_enable;
    Bout_0_Val <= maxpool_0_enable_d1;
end

Compare_Block3 Channel_0_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_0), .loadthrehold(loadthrehold[0]), .threhold(data_o), .binary(Bout_0));
Compare_Block3 Channel_1_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_1), .loadthrehold(loadthrehold[1]), .threhold(data_o), .binary(Bout_1));
Compare_Block3 Channel_2_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_2), .loadthrehold(loadthrehold[2]), .threhold(data_o), .binary(Bout_2));
Compare_Block3 Channel_3_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_3), .loadthrehold(loadthrehold[3]), .threhold(data_o), .binary(Bout_3));
Compare_Block3 Channel_4_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_4), .loadthrehold(loadthrehold[4]), .threhold(data_o), .binary(Bout_4));
Compare_Block3 Channel_5_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_5), .loadthrehold(loadthrehold[5]), .threhold(data_o), .binary(Bout_5));
Compare_Block3 Channel_6_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_6), .loadthrehold(loadthrehold[6]), .threhold(data_o), .binary(Bout_6));
Compare_Block3 Channel_7_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_7), .loadthrehold(loadthrehold[7]), .threhold(data_o), .binary(Bout_7));
Compare_Block3 Channel_8_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_8), .loadthrehold(loadthrehold[8]), .threhold(data_o), .binary(Bout_8));
Compare_Block3 Channel_9_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_9), .loadthrehold(loadthrehold[9]), .threhold(data_o), .binary(Bout_9));
Compare_Block3 Channel_10_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_10), .loadthrehold(loadthrehold[10]), .threhold(data_o), .binary(Bout_10));
Compare_Block3 Channel_11_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_11), .loadthrehold(loadthrehold[11]), .threhold(data_o), .binary(Bout_11));
Compare_Block3 Channel_12_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_12), .loadthrehold(loadthrehold[12]), .threhold(data_o), .binary(Bout_12));
Compare_Block3 Channel_13_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_13), .loadthrehold(loadthrehold[13]), .threhold(data_o), .binary(Bout_13));
Compare_Block3 Channel_14_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_14), .loadthrehold(loadthrehold[14]), .threhold(data_o), .binary(Bout_14));
Compare_Block3 Channel_15_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_15), .loadthrehold(loadthrehold[15]), .threhold(data_o), .binary(Bout_15));
Compare_Block3 Channel_16_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_16), .loadthrehold(loadthrehold[16]), .threhold(data_o), .binary(Bout_16));
Compare_Block3 Channel_17_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_17), .loadthrehold(loadthrehold[17]), .threhold(data_o), .binary(Bout_17));
Compare_Block3 Channel_18_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_18), .loadthrehold(loadthrehold[18]), .threhold(data_o), .binary(Bout_18));
Compare_Block3 Channel_19_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_19), .loadthrehold(loadthrehold[19]), .threhold(data_o), .binary(Bout_19));
Compare_Block3 Channel_20_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_20), .loadthrehold(loadthrehold[20]), .threhold(data_o), .binary(Bout_20));
Compare_Block3 Channel_21_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_21), .loadthrehold(loadthrehold[21]), .threhold(data_o), .binary(Bout_21));
Compare_Block3 Channel_22_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_22), .loadthrehold(loadthrehold[22]), .threhold(data_o), .binary(Bout_22));
Compare_Block3 Channel_23_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_23), .loadthrehold(loadthrehold[23]), .threhold(data_o), .binary(Bout_23));
Compare_Block3 Channel_24_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_24), .loadthrehold(loadthrehold[24]), .threhold(data_o), .binary(Bout_24));
Compare_Block3 Channel_25_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_25), .loadthrehold(loadthrehold[25]), .threhold(data_o), .binary(Bout_25));
Compare_Block3 Channel_26_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_26), .loadthrehold(loadthrehold[26]), .threhold(data_o), .binary(Bout_26));
Compare_Block3 Channel_27_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_27), .loadthrehold(loadthrehold[27]), .threhold(data_o), .binary(Bout_27));
Compare_Block3 Channel_28_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_28), .loadthrehold(loadthrehold[28]), .threhold(data_o), .binary(Bout_28));
Compare_Block3 Channel_29_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_29), .loadthrehold(loadthrehold[29]), .threhold(data_o), .binary(Bout_29));
Compare_Block3 Channel_30_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_30), .loadthrehold(loadthrehold[30]), .threhold(data_o), .binary(Bout_30));
Compare_Block3 Channel_31_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_31), .loadthrehold(loadthrehold[31]), .threhold(data_o), .binary(Bout_31));
endmodule
