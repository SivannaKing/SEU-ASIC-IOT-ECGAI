`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/08 10:45:32
// Design Name: 
// Module Name: Maxpool_Thre_B5
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


module Maxpool_Thre_B5(
    input                       clk,
    input                       rst_n,
    input   wire signed [8:0]   o_0, o_1, o_2, o_3, o_4, o_5, o_6, o_7, o_8, o_9, o_10, o_11, o_12, o_13, o_14, o_15,
                                o_16, o_17, o_18, o_19, o_20, o_21, o_22, o_23, o_24, o_25, o_26, o_27, o_28, o_29, o_30, o_31,
                                o_32, o_33, o_34, o_35, o_36, o_37, o_38, o_39, o_40, o_41, o_42, o_43, o_44, o_45, o_46, o_47, 
                                o_48, o_49, o_50, o_51, o_52, o_53, o_54, o_55, o_56, o_57, o_58, o_59, o_60, o_61, o_62, o_63, 
    input                       o_0_val,
    output  wire                Bout_0, Bout_1, Bout_2,  Bout_3,  Bout_4,  Bout_5,  Bout_6,  Bout_7,
                                Bout_8, Bout_9, Bout_10, Bout_11, Bout_12, Bout_13, Bout_14, Bout_15,
                                Bout_16, Bout_17, Bout_18, Bout_19, Bout_20, Bout_21, Bout_22, Bout_23,
                                Bout_24, Bout_25, Bout_26, Bout_27, Bout_28, Bout_29, Bout_30, Bout_31,
                                Bout_32, Bout_33, Bout_34, Bout_35, Bout_36, Bout_37, Bout_38, Bout_39, 
                                Bout_40, Bout_41, Bout_42, Bout_43, Bout_44, Bout_45, Bout_46, Bout_47,
                                Bout_48, Bout_49, Bout_50, Bout_51, Bout_52, Bout_53, Bout_54, Bout_55, 
                                Bout_56, Bout_57, Bout_58, Bout_59, Bout_60, Bout_61, Bout_62, Bout_63, 
    output  reg                 Bout_0_Val           
);


//***************************读取阈�?�函数并存储在自己的寄存器中,向比较模型传递这些阈值让其存�?************************
reg     [5:0]     Thre_ROM_ADDR;
wire              enable;
wire    [23:0]    data_o;
reg     [5:0]     thre_cnt;
reg     [63:0]    loadthrehold, loadthrehold_e1;
//ThreholdBuffer_ROM_B5  #(.ADDR_WIDTH(6), .DATA_WIDTH(24),.DATA_DEPTH(64)) ThreholdBuffer_B5(.clk(clk),  .enable(enable),  .addr(Thre_ROM_ADDR),  .data_o(data_o));
ThreholdBuffer_ROM_B5_IP ThreholdBuffer_B5 (
  .clka(clk),    // input wire clka
  .ena(enable),      // input wire ena
  .addra(Thre_ROM_ADDR),  // input wire [5 : 0] addra
  .douta(data_o)  // output wire [21 : 0] douta
);
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        Thre_ROM_ADDR <= 0;
    end else begin
        if(thre_cnt < 64 )begin
            Thre_ROM_ADDR <= Thre_ROM_ADDR + 1 ;
        end else if(thre_cnt == 64)begin
            Thre_ROM_ADDR <= 0;
        end
    end
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        thre_cnt <= 0;
        loadthrehold_e1 <= 0;
    end else begin
        if(thre_cnt < 64)begin
            thre_cnt <= thre_cnt + 1;
            loadthrehold_e1 <= {loadthrehold_e1[62:0], 1'b1};
        end
        else if(thre_cnt == 64)begin
            thre_cnt <= 32;
        end
    end
end

always@(posedge clk)begin
    loadthrehold <= loadthrehold_e1;
end

assign enable = (rst_n & thre_cnt!= 64);

//***************************读取阈�?�函数并存储在自己的寄存器中************************
reg     [62:0]      Conpare_In_seven_0, Conpare_In_seven_1, Conpare_In_seven_2, Conpare_In_seven_3, Conpare_In_seven_4, Conpare_In_seven_5, Conpare_In_seven_6, Conpare_In_seven_7,
                    Conpare_In_seven_8, Conpare_In_seven_9, Conpare_In_seven_10, Conpare_In_seven_11, Conpare_In_seven_12, Conpare_In_seven_13, Conpare_In_seven_14, Conpare_In_seven_15,
                    Conpare_In_seven_16, Conpare_In_seven_17, Conpare_In_seven_18, Conpare_In_seven_19, Conpare_In_seven_20, Conpare_In_seven_21, Conpare_In_seven_22, Conpare_In_seven_23,
                    Conpare_In_seven_24, Conpare_In_seven_25, Conpare_In_seven_26, Conpare_In_seven_27, Conpare_In_seven_28, Conpare_In_seven_29, Conpare_In_seven_30, Conpare_In_seven_31,
                    Conpare_In_seven_32, Conpare_In_seven_33, Conpare_In_seven_34, Conpare_In_seven_35, Conpare_In_seven_36, Conpare_In_seven_37, Conpare_In_seven_38, Conpare_In_seven_39, 
                    Conpare_In_seven_40, Conpare_In_seven_41, Conpare_In_seven_42, Conpare_In_seven_43, Conpare_In_seven_44, Conpare_In_seven_45, Conpare_In_seven_46, Conpare_In_seven_47, 
                    Conpare_In_seven_48, Conpare_In_seven_49, Conpare_In_seven_50, Conpare_In_seven_51, Conpare_In_seven_52, Conpare_In_seven_53, Conpare_In_seven_54, Conpare_In_seven_55, 
                    Conpare_In_seven_56, Conpare_In_seven_57, Conpare_In_seven_58, Conpare_In_seven_59, Conpare_In_seven_60, Conpare_In_seven_61, Conpare_In_seven_62, Conpare_In_seven_63;
reg     [2:0]       cnt_7_0;
reg     [1:0]       cnt_2_0; //首先cnt�?7后，即集�?7�?9bit数据于上面的63bit寄存器�?�接�?就开始一二�?�一二的计数，来让Maxpool的步长为2
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
        Conpare_In_seven_32 <= 0; 
        Conpare_In_seven_33 <= 0; 
        Conpare_In_seven_34 <= 0; 
        Conpare_In_seven_35 <= 0; 
        Conpare_In_seven_36 <= 0; 
        Conpare_In_seven_37 <= 0; 
        Conpare_In_seven_38 <= 0; 
        Conpare_In_seven_39 <= 0; 
        Conpare_In_seven_40 <= 0; 
        Conpare_In_seven_41 <= 0; 
        Conpare_In_seven_42 <= 0; 
        Conpare_In_seven_43 <= 0; 
        Conpare_In_seven_44 <= 0; 
        Conpare_In_seven_45 <= 0; 
        Conpare_In_seven_46 <= 0; 
        Conpare_In_seven_47 <= 0; 
        Conpare_In_seven_48 <= 0; 
        Conpare_In_seven_49 <= 0; 
        Conpare_In_seven_50 <= 0; 
        Conpare_In_seven_51 <= 0; 
        Conpare_In_seven_52 <= 0; 
        Conpare_In_seven_53 <= 0; 
        Conpare_In_seven_54 <= 0; 
        Conpare_In_seven_55 <= 0; 
        Conpare_In_seven_56 <= 0; 
        Conpare_In_seven_57 <= 0; 
        Conpare_In_seven_58 <= 0; 
        Conpare_In_seven_59 <= 0; 
        Conpare_In_seven_60 <= 0; 
        Conpare_In_seven_61 <= 0; 
        Conpare_In_seven_62 <= 0; 
        Conpare_In_seven_63 <= 0; 

    end else begin
        Conpare_In_seven_0 <= {Conpare_In_seven_0[53:0], o_0[8:0]};
        Conpare_In_seven_1 <= {Conpare_In_seven_1[53:0], o_1[8:0]};
        Conpare_In_seven_2 <= {Conpare_In_seven_2[53:0], o_2[8:0]};
        Conpare_In_seven_3 <= {Conpare_In_seven_3[53:0], o_3[8:0]};
        Conpare_In_seven_4 <= {Conpare_In_seven_4[53:0], o_4[8:0]};
        Conpare_In_seven_5 <= {Conpare_In_seven_5[53:0], o_5[8:0]};
        Conpare_In_seven_6 <= {Conpare_In_seven_6[53:0], o_6[8:0]};
        Conpare_In_seven_7 <= {Conpare_In_seven_7[53:0], o_7[8:0]};
        Conpare_In_seven_8 <= {Conpare_In_seven_8[53:0], o_8[8:0]};
        Conpare_In_seven_9 <= {Conpare_In_seven_9[53:0], o_9[8:0]};
        Conpare_In_seven_10 <= {Conpare_In_seven_10[53:0], o_10[8:0]};
        Conpare_In_seven_11 <= {Conpare_In_seven_11[53:0], o_11[8:0]};
        Conpare_In_seven_12 <= {Conpare_In_seven_12[53:0], o_12[8:0]};
        Conpare_In_seven_13 <= {Conpare_In_seven_13[53:0], o_13[8:0]};
        Conpare_In_seven_14 <= {Conpare_In_seven_14[53:0], o_14[8:0]};
        Conpare_In_seven_15 <= {Conpare_In_seven_15[53:0], o_15[8:0]};
        Conpare_In_seven_16 <= {Conpare_In_seven_16[53:0], o_16[8:0]};
        Conpare_In_seven_17 <= {Conpare_In_seven_17[53:0], o_17[8:0]};
        Conpare_In_seven_18 <= {Conpare_In_seven_18[53:0], o_18[8:0]};
        Conpare_In_seven_19 <= {Conpare_In_seven_19[53:0], o_19[8:0]};
        Conpare_In_seven_20 <= {Conpare_In_seven_20[53:0], o_20[8:0]};
        Conpare_In_seven_21 <= {Conpare_In_seven_21[53:0], o_21[8:0]};
        Conpare_In_seven_22 <= {Conpare_In_seven_22[53:0], o_22[8:0]};
        Conpare_In_seven_23 <= {Conpare_In_seven_23[53:0], o_23[8:0]};
        Conpare_In_seven_24 <= {Conpare_In_seven_24[53:0], o_24[8:0]};
        Conpare_In_seven_25 <= {Conpare_In_seven_25[53:0], o_25[8:0]};
        Conpare_In_seven_26 <= {Conpare_In_seven_26[53:0], o_26[8:0]};
        Conpare_In_seven_27 <= {Conpare_In_seven_27[53:0], o_27[8:0]};
        Conpare_In_seven_28 <= {Conpare_In_seven_28[53:0], o_28[8:0]};
        Conpare_In_seven_29 <= {Conpare_In_seven_29[53:0], o_29[8:0]};
        Conpare_In_seven_30 <= {Conpare_In_seven_30[53:0], o_30[8:0]};
        Conpare_In_seven_31 <= {Conpare_In_seven_31[53:0], o_31[8:0]};   
        Conpare_In_seven_32 <= {Conpare_In_seven_32[53:0], o_32[8:0]};
        Conpare_In_seven_33 <= {Conpare_In_seven_33[53:0], o_33[8:0]};
        Conpare_In_seven_34 <= {Conpare_In_seven_34[53:0], o_34[8:0]};
        Conpare_In_seven_35 <= {Conpare_In_seven_35[53:0], o_35[8:0]};
        Conpare_In_seven_36 <= {Conpare_In_seven_36[53:0], o_36[8:0]};
        Conpare_In_seven_37 <= {Conpare_In_seven_37[53:0], o_37[8:0]};
        Conpare_In_seven_38 <= {Conpare_In_seven_38[53:0], o_38[8:0]};
        Conpare_In_seven_39 <= {Conpare_In_seven_39[53:0], o_39[8:0]};
        Conpare_In_seven_40 <= {Conpare_In_seven_40[53:0], o_40[8:0]};
        Conpare_In_seven_41 <= {Conpare_In_seven_41[53:0], o_41[8:0]};
        Conpare_In_seven_42 <= {Conpare_In_seven_42[53:0], o_42[8:0]};
        Conpare_In_seven_43 <= {Conpare_In_seven_43[53:0], o_43[8:0]};
        Conpare_In_seven_44 <= {Conpare_In_seven_44[53:0], o_44[8:0]};
        Conpare_In_seven_45 <= {Conpare_In_seven_45[53:0], o_45[8:0]};
        Conpare_In_seven_46 <= {Conpare_In_seven_46[53:0], o_46[8:0]};
        Conpare_In_seven_47 <= {Conpare_In_seven_47[53:0], o_47[8:0]};
        Conpare_In_seven_48 <= {Conpare_In_seven_48[53:0], o_48[8:0]};
        Conpare_In_seven_49 <= {Conpare_In_seven_49[53:0], o_49[8:0]};
        Conpare_In_seven_50 <= {Conpare_In_seven_50[53:0], o_50[8:0]};
        Conpare_In_seven_51 <= {Conpare_In_seven_51[53:0], o_51[8:0]};
        Conpare_In_seven_52 <= {Conpare_In_seven_52[53:0], o_52[8:0]};
        Conpare_In_seven_53 <= {Conpare_In_seven_53[53:0], o_53[8:0]};
        Conpare_In_seven_54 <= {Conpare_In_seven_54[53:0], o_54[8:0]};
        Conpare_In_seven_55 <= {Conpare_In_seven_55[53:0], o_55[8:0]};
        Conpare_In_seven_56 <= {Conpare_In_seven_56[53:0], o_56[8:0]};
        Conpare_In_seven_57 <= {Conpare_In_seven_57[53:0], o_57[8:0]};
        Conpare_In_seven_58 <= {Conpare_In_seven_58[53:0], o_58[8:0]};
        Conpare_In_seven_59 <= {Conpare_In_seven_59[53:0], o_59[8:0]};
        Conpare_In_seven_60 <= {Conpare_In_seven_60[53:0], o_60[8:0]};
        Conpare_In_seven_61 <= {Conpare_In_seven_61[53:0], o_61[8:0]};
        Conpare_In_seven_62 <= {Conpare_In_seven_62[53:0], o_62[8:0]};
        Conpare_In_seven_63 <= {Conpare_In_seven_63[53:0], o_63[8:0]};
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

//之所以用Block4的模块，是因�?5�?4输入通道都是�?样的
Compare_Block4 Channel_0_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_0), .loadthrehold(loadthrehold[0]), .threhold(data_o), .binary(Bout_0));
Compare_Block4 Channel_1_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_1), .loadthrehold(loadthrehold[1]), .threhold(data_o), .binary(Bout_1)); 
Compare_Block4 Channel_2_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_2), .loadthrehold(loadthrehold[2]), .threhold(data_o), .binary(Bout_2)); 
Compare_Block4 Channel_3_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_3), .loadthrehold(loadthrehold[3]), .threhold(data_o), .binary(Bout_3)); 
Compare_Block4 Channel_4_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_4), .loadthrehold(loadthrehold[4]), .threhold(data_o), .binary(Bout_4)); 
Compare_Block4 Channel_5_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_5), .loadthrehold(loadthrehold[5]), .threhold(data_o), .binary(Bout_5)); 
Compare_Block4 Channel_6_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_6), .loadthrehold(loadthrehold[6]), .threhold(data_o), .binary(Bout_6)); 
Compare_Block4 Channel_7_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_7), .loadthrehold(loadthrehold[7]), .threhold(data_o), .binary(Bout_7)); 
Compare_Block4 Channel_8_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_8), .loadthrehold(loadthrehold[8]), .threhold(data_o), .binary(Bout_8)); 
Compare_Block4 Channel_9_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_9), .loadthrehold(loadthrehold[9]), .threhold(data_o), .binary(Bout_9)); 
Compare_Block4 Channel_10_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_10), .loadthrehold(loadthrehold[10]), .threhold(data_o), .binary(Bout_10)); 
Compare_Block4 Channel_11_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_11), .loadthrehold(loadthrehold[11]), .threhold(data_o), .binary(Bout_11)); 
Compare_Block4 Channel_12_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_12), .loadthrehold(loadthrehold[12]), .threhold(data_o), .binary(Bout_12)); 
Compare_Block4 Channel_13_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_13), .loadthrehold(loadthrehold[13]), .threhold(data_o), .binary(Bout_13)); 
Compare_Block4 Channel_14_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_14), .loadthrehold(loadthrehold[14]), .threhold(data_o), .binary(Bout_14)); 
Compare_Block4 Channel_15_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_15), .loadthrehold(loadthrehold[15]), .threhold(data_o), .binary(Bout_15)); 
Compare_Block4 Channel_16_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_16), .loadthrehold(loadthrehold[16]), .threhold(data_o), .binary(Bout_16)); 
Compare_Block4 Channel_17_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_17), .loadthrehold(loadthrehold[17]), .threhold(data_o), .binary(Bout_17)); 
Compare_Block4 Channel_18_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_18), .loadthrehold(loadthrehold[18]), .threhold(data_o), .binary(Bout_18)); 
Compare_Block4 Channel_19_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_19), .loadthrehold(loadthrehold[19]), .threhold(data_o), .binary(Bout_19)); 
Compare_Block4 Channel_20_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_20), .loadthrehold(loadthrehold[20]), .threhold(data_o), .binary(Bout_20)); 
Compare_Block4 Channel_21_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_21), .loadthrehold(loadthrehold[21]), .threhold(data_o), .binary(Bout_21)); 
Compare_Block4 Channel_22_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_22), .loadthrehold(loadthrehold[22]), .threhold(data_o), .binary(Bout_22)); 
Compare_Block4 Channel_23_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_23), .loadthrehold(loadthrehold[23]), .threhold(data_o), .binary(Bout_23)); 
Compare_Block4 Channel_24_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_24), .loadthrehold(loadthrehold[24]), .threhold(data_o), .binary(Bout_24)); 
Compare_Block4 Channel_25_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_25), .loadthrehold(loadthrehold[25]), .threhold(data_o), .binary(Bout_25)); 
Compare_Block4 Channel_26_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_26), .loadthrehold(loadthrehold[26]), .threhold(data_o), .binary(Bout_26)); 
Compare_Block4 Channel_27_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_27), .loadthrehold(loadthrehold[27]), .threhold(data_o), .binary(Bout_27)); 
Compare_Block4 Channel_28_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_28), .loadthrehold(loadthrehold[28]), .threhold(data_o), .binary(Bout_28)); 
Compare_Block4 Channel_29_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_29), .loadthrehold(loadthrehold[29]), .threhold(data_o), .binary(Bout_29)); 
Compare_Block4 Channel_30_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_30), .loadthrehold(loadthrehold[30]), .threhold(data_o), .binary(Bout_30)); 
Compare_Block4 Channel_31_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_31), .loadthrehold(loadthrehold[31]), .threhold(data_o), .binary(Bout_31)); 
Compare_Block4 Channel_32_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_32), .loadthrehold(loadthrehold[32]), .threhold(data_o), .binary(Bout_32)); 
Compare_Block4 Channel_33_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_33), .loadthrehold(loadthrehold[33]), .threhold(data_o), .binary(Bout_33)); 
Compare_Block4 Channel_34_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_34), .loadthrehold(loadthrehold[34]), .threhold(data_o), .binary(Bout_34)); 
Compare_Block4 Channel_35_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_35), .loadthrehold(loadthrehold[35]), .threhold(data_o), .binary(Bout_35)); 
Compare_Block4 Channel_36_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_36), .loadthrehold(loadthrehold[36]), .threhold(data_o), .binary(Bout_36)); 
Compare_Block4 Channel_37_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_37), .loadthrehold(loadthrehold[37]), .threhold(data_o), .binary(Bout_37)); 
Compare_Block4 Channel_38_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_38), .loadthrehold(loadthrehold[38]), .threhold(data_o), .binary(Bout_38)); 
Compare_Block4 Channel_39_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_39), .loadthrehold(loadthrehold[39]), .threhold(data_o), .binary(Bout_39)); 
Compare_Block4 Channel_40_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_40), .loadthrehold(loadthrehold[40]), .threhold(data_o), .binary(Bout_40)); 
Compare_Block4 Channel_41_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_41), .loadthrehold(loadthrehold[41]), .threhold(data_o), .binary(Bout_41)); 
Compare_Block4 Channel_42_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_42), .loadthrehold(loadthrehold[42]), .threhold(data_o), .binary(Bout_42)); 
Compare_Block4 Channel_43_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_43), .loadthrehold(loadthrehold[43]), .threhold(data_o), .binary(Bout_43)); 
Compare_Block4 Channel_44_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_44), .loadthrehold(loadthrehold[44]), .threhold(data_o), .binary(Bout_44)); 
Compare_Block4 Channel_45_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_45), .loadthrehold(loadthrehold[45]), .threhold(data_o), .binary(Bout_45)); 
Compare_Block4 Channel_46_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_46), .loadthrehold(loadthrehold[46]), .threhold(data_o), .binary(Bout_46)); 
Compare_Block4 Channel_47_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_47), .loadthrehold(loadthrehold[47]), .threhold(data_o), .binary(Bout_47)); 
Compare_Block4 Channel_48_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_48), .loadthrehold(loadthrehold[48]), .threhold(data_o), .binary(Bout_48)); 
Compare_Block4 Channel_49_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_49), .loadthrehold(loadthrehold[49]), .threhold(data_o), .binary(Bout_49)); 
Compare_Block4 Channel_50_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_50), .loadthrehold(loadthrehold[50]), .threhold(data_o), .binary(Bout_50)); 
Compare_Block4 Channel_51_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_51), .loadthrehold(loadthrehold[51]), .threhold(data_o), .binary(Bout_51)); 
Compare_Block4 Channel_52_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_52), .loadthrehold(loadthrehold[52]), .threhold(data_o), .binary(Bout_52)); 
Compare_Block4 Channel_53_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_53), .loadthrehold(loadthrehold[53]), .threhold(data_o), .binary(Bout_53)); 
Compare_Block4 Channel_54_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_54), .loadthrehold(loadthrehold[54]), .threhold(data_o), .binary(Bout_54)); 
Compare_Block4 Channel_55_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_55), .loadthrehold(loadthrehold[55]), .threhold(data_o), .binary(Bout_55)); 
Compare_Block4 Channel_56_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_56), .loadthrehold(loadthrehold[56]), .threhold(data_o), .binary(Bout_56)); 
Compare_Block4 Channel_57_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_57), .loadthrehold(loadthrehold[57]), .threhold(data_o), .binary(Bout_57)); 
Compare_Block4 Channel_58_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_58), .loadthrehold(loadthrehold[58]), .threhold(data_o), .binary(Bout_58)); 
Compare_Block4 Channel_59_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_59), .loadthrehold(loadthrehold[59]), .threhold(data_o), .binary(Bout_59)); 
Compare_Block4 Channel_60_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_60), .loadthrehold(loadthrehold[60]), .threhold(data_o), .binary(Bout_60)); 
Compare_Block4 Channel_61_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_61), .loadthrehold(loadthrehold[61]), .threhold(data_o), .binary(Bout_61)); 
Compare_Block4 Channel_62_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_62), .loadthrehold(loadthrehold[62]), .threhold(data_o), .binary(Bout_62)); 
Compare_Block4 Channel_63_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_63), .loadthrehold(loadthrehold[63]), .threhold(data_o), .binary(Bout_63)); 
endmodule
