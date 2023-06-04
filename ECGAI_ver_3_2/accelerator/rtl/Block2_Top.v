`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/26 17:05:55
// Design Name: 
// Module Name: Block2_Top
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


module Block2_Top(
    input                           clk,
    input                           rst_n,
    input             wire          binary_in_val,
    input             wire          Bin_0, Bin_1, Bin_2, Bin_3, Bin_4, Bin_5, Bin_6, Bin_7,
    output            wire          Bout_0, Bout_1, Bout_2,  Bout_3,  Bout_4,  Bout_5,  Bout_6,  Bout_7,
                                    Bout_8, Bout_9, Bout_10, Bout_11, Bout_12, Bout_13, Bout_14, Bout_15,
    output            wire          Bout_0_Val, o_0_val
);

wire    [31:0]      DIN_0, DIN_1, DIN_2, DIN_3, DIN_4, DIN_5, DIN_6, DIN_7;
wire    [31:0]      DOUTA_0, DOUTA_1, DOUTA_2, DOUTA_3, DOUTA_4, DOUTA_5, DOUTA_6, DOUTA_7;
wire    [4:0]       ADDR_0, ADDR_1, ADDR_2, ADDR_3, ADDR_4, ADDR_5, ADDR_6, ADDR_7, IB_Addr_Contr_ADDR, SWU_ADDR;
//wire                WEA, ENA;
wire                WEA_0, WEA_1,  WEA_2, WEA_3, WEA_4, WEA_5, WEA_6, WEA_7;
wire                ENA_0, ENA_1,  ENA_2, ENA_3, ENA_4, ENA_5, ENA_6, ENA_7;
wire                IB_Addr_Contr_WEA, IB_Addr_Contr_ENA;
wire                SWU_WEA, SWU_ENA;
wire                PE_EN;

wire                IB_Addr_Cont_B2_work, IB_Addr_Cont_B2_work_Done;
wire                SWU_work, SWU_work_Done, Weight_Trans_Done;

wire    [6:0]       Slide_data_0, Slide_data_1, Slide_data_2, Slide_data_3, Slide_data_4, Slide_data_5, Slide_data_6, Slide_data_7;
wire    [6:0]       w_0, w_1, w_2, w_3, w_4, w_5, w_6, w_7;
wire    [15:0]      new_weight_val;
wire    [6:0]       o_0, o_1, o_2, o_3, o_4, o_5, o_6, o_7, o_8, o_9, o_10, o_11, o_12, o_13, o_14, o_15;

IB_Addr_Contr_B2 IB_Con_2(  .clk(clk),     .rst_n(binary_in_val),
                            .Bin_0(Bin_0), .Bin_1(Bin_1), .Bin_2(Bin_2), .Bin_3(Bin_3), 
                            .Bin_4(Bin_4), .Bin_5(Bin_5), .Bin_6(Bin_6), .Bin_7(Bin_7),
                            .DIN_0(DIN_0),  .DIN_1(DIN_1), .DIN_2(DIN_2), .DIN_3(DIN_3), .DIN_4(DIN_4), .DIN_5(DIN_5), .DIN_6(DIN_6), .DIN_7(DIN_7),
                            .ADDR(IB_Addr_Contr_ADDR),    .WEA(IB_Addr_Contr_WEA),   .ENA(IB_Addr_Contr_ENA), .IB_Addr_Contr_B2_work(IB_Addr_Cont_B2_work),
                            .IB_Addr_Contr_B2_work_Done(IB_Addr_Cont_B2_work_Done)
);

assign  ADDR_0 = IB_Addr_Cont_B2_work? IB_Addr_Contr_ADDR : (SWU_work? SWU_ADDR : 0);
assign  ADDR_1 = IB_Addr_Cont_B2_work? IB_Addr_Contr_ADDR : (SWU_work? SWU_ADDR : 0);
assign  ADDR_2 = IB_Addr_Cont_B2_work? IB_Addr_Contr_ADDR : (SWU_work? SWU_ADDR : 0);
assign  ADDR_3 = IB_Addr_Cont_B2_work? IB_Addr_Contr_ADDR : (SWU_work? SWU_ADDR : 0);
assign  ADDR_4 = IB_Addr_Cont_B2_work? IB_Addr_Contr_ADDR : (SWU_work? SWU_ADDR : 0);
assign  ADDR_5 = IB_Addr_Cont_B2_work? IB_Addr_Contr_ADDR : (SWU_work? SWU_ADDR : 0);
assign  ADDR_6 = IB_Addr_Cont_B2_work? IB_Addr_Contr_ADDR : (SWU_work? SWU_ADDR : 0);
assign  ADDR_7 = IB_Addr_Cont_B2_work? IB_Addr_Contr_ADDR : (SWU_work? SWU_ADDR : 0);

assign  WEA_0 = IB_Addr_Cont_B2_work? IB_Addr_Contr_WEA : (SWU_work? SWU_WEA : 0);
assign  WEA_1 = IB_Addr_Cont_B2_work? IB_Addr_Contr_WEA : (SWU_work? SWU_WEA : 0);
assign  WEA_2 = IB_Addr_Cont_B2_work? IB_Addr_Contr_WEA : (SWU_work? SWU_WEA : 0);
assign  WEA_3 = IB_Addr_Cont_B2_work? IB_Addr_Contr_WEA : (SWU_work? SWU_WEA : 0);
assign  WEA_4 = IB_Addr_Cont_B2_work? IB_Addr_Contr_WEA : (SWU_work? SWU_WEA : 0);
assign  WEA_5 = IB_Addr_Cont_B2_work? IB_Addr_Contr_WEA : (SWU_work? SWU_WEA : 0);
assign  WEA_6 = IB_Addr_Cont_B2_work? IB_Addr_Contr_WEA : (SWU_work? SWU_WEA : 0);
assign  WEA_7 = IB_Addr_Cont_B2_work? IB_Addr_Contr_WEA : (SWU_work? SWU_WEA : 0);

assign  ENA_0 = IB_Addr_Cont_B2_work? IB_Addr_Contr_ENA : (SWU_work? SWU_ENA : 0);
assign  ENA_1 = IB_Addr_Cont_B2_work? IB_Addr_Contr_ENA : (SWU_work? SWU_ENA : 0);
assign  ENA_2 = IB_Addr_Cont_B2_work? IB_Addr_Contr_ENA : (SWU_work? SWU_ENA : 0);
assign  ENA_3 = IB_Addr_Cont_B2_work? IB_Addr_Contr_ENA : (SWU_work? SWU_ENA : 0);
assign  ENA_4 = IB_Addr_Cont_B2_work? IB_Addr_Contr_ENA : (SWU_work? SWU_ENA : 0);
assign  ENA_5 = IB_Addr_Cont_B2_work? IB_Addr_Contr_ENA : (SWU_work? SWU_ENA : 0);
assign  ENA_6 = IB_Addr_Cont_B2_work? IB_Addr_Contr_ENA : (SWU_work? SWU_ENA : 0);
assign  ENA_7 = IB_Addr_Cont_B2_work? IB_Addr_Contr_ENA : (SWU_work? SWU_ENA : 0);

Input_Buffer_B2 IB_2(   .clk(clk),       .rst_n(rst_n),
                        .DIN_0(DIN_0),   .DIN_1(DIN_1), .DIN_2(DIN_2), .DIN_3(DIN_3), .DIN_4(DIN_4), .DIN_5(DIN_5), .DIN_6(DIN_6), .DIN_7(DIN_7), 
                        .ADDR_0(ADDR_0), .ADDR_1(ADDR_1), .ADDR_2(ADDR_2), .ADDR_3(ADDR_3), .ADDR_4(ADDR_4), .ADDR_5(ADDR_5), .ADDR_6(ADDR_6), .ADDR_7(ADDR_7),
                        .WEA_0(WEA_0),   .WEA_1(WEA_1),   .WEA_2(WEA_2),   .WEA_3(WEA_3),   .WEA_4(WEA_4),   .WEA_5(WEA_5),   .WEA_6(WEA_6),   .WEA_7(WEA_7),
                        .ENA_0(ENA_0),   .ENA_1(ENA_1),   .ENA_2(ENA_2),   .ENA_3(ENA_3),   .ENA_4(ENA_4),   .ENA_5(ENA_5),   .ENA_6(ENA_6),   .ENA_7(ENA_7),
                        .DOUTA_0(DOUTA_0), .DOUTA_1(DOUTA_1), .DOUTA_2(DOUTA_2), .DOUTA_3(DOUTA_3), .DOUTA_4(DOUTA_4), .DOUTA_5(DOUTA_5), .DOUTA_6(DOUTA_6), .DOUTA_7(DOUTA_7)       
);

Weight_Control_B2 WC_B2 (   .clk(clk),       .rst_n(IB_Addr_Cont_B2_work_Done), 
                            .w_0(w_0), .w_1(w_1), .w_2(w_2), .w_3(w_3), .w_4(w_4), .w_5(w_5), .w_6(w_6), .w_7(w_7),
                            .new_weight_val(new_weight_val), .Weight_Trans_Done(Weight_Trans_Done)  
);

IB_SWU_Addr_Contr_B2 SWU_B2(    .clk(clk),       .rst_n(Weight_Trans_Done), 
                                .DIN_0(DOUTA_0), .DIN_1(DOUTA_1), .DIN_2(DOUTA_2), .DIN_3(DOUTA_3), 
                                .DIN_4(DOUTA_4), .DIN_5(DOUTA_5), .DIN_6(DOUTA_6), .DIN_7(DOUTA_7), 
                                .ADDR(SWU_ADDR), .WEA(SWU_WEA),   .ENA(SWU_ENA),   .IB_Addr_SWU_work(SWU_work),   .IB_Addr_SWU_work_Done(SWU_work_Done),
                                .Slide_data_0(Slide_data_0), .Slide_data_1(Slide_data_1), .Slide_data_2(Slide_data_2), .Slide_data_3(Slide_data_3),
                                .Slide_data_4(Slide_data_4), .Slide_data_5(Slide_data_5), .Slide_data_6(Slide_data_6), .Slide_data_7(Slide_data_7),
                                .PE_EN(PE_EN)
);

//B2_SlideData_Save_to_file Save_SWU_DATA(.clk(clk), .rst_n(PE_EN), .Slide_data_0(Slide_data_0), .Slide_data_1(Slide_data_1), .Slide_data_2(Slide_data_2), .Slide_data_3(Slide_data_3),
//                                .Slide_data_4(Slide_data_4), .Slide_data_5(Slide_data_5), .Slide_data_6(Slide_data_6), .Slide_data_7(Slide_data_7) );

//PE阵列的rst_n相当于pe的enable，为1后pe开始计算，他不会影响pe权重的存入。
PE_Array_B2 PE_Array_Block2(    .clk(clk), .rst_n(PE_EN), .new_weight_val(new_weight_val), 
                                .Slide_data_0(Slide_data_0), .Slide_data_1(Slide_data_1), .Slide_data_2(Slide_data_2), .Slide_data_3(Slide_data_3),
                                .Slide_data_4(Slide_data_4), .Slide_data_5(Slide_data_5), .Slide_data_6(Slide_data_6), .Slide_data_7(Slide_data_7),
                                .o_0(o_0), .o_1(o_1), .o_2(o_2),   .o_3(o_3),   .o_4(o_4),   .o_5(o_5),   .o_6(o_6),   .o_7(o_7),
                                .o_8(o_8), .o_9(o_9), .o_10(o_10), .o_11(o_11), .o_12(o_12), .o_13(o_13), .o_14(o_14), .o_15(o_15),
                                .o_0_val(o_0_val),
                                .w_0(w_0), .w_1(w_1), .w_2(w_2), .w_3(w_3), .w_4(w_4), .w_5(w_5), .w_6(w_6), .w_7(w_7)
);


Maxpool_Thre_B2 MP_Thre(.clk(clk), .rst_n(rst_n), .B2_rst_n(binary_in_val), 
                        .o_0(o_0), .o_1(o_1), .o_2(o_2),   .o_3(o_3),   .o_4(o_4),   .o_5(o_5),   .o_6(o_6),   .o_7(o_7),
                        .o_8(o_8), .o_9(o_9), .o_10(o_10), .o_11(o_11), .o_12(o_12), .o_13(o_13), .o_14(o_14), .o_15(o_15),
                        .o_0_val(o_0_val),
                        .Bout_0(Bout_0),   .Bout_1(Bout_1),   .Bout_2(Bout_2),   .Bout_3(Bout_3), 
                        .Bout_4(Bout_4),   .Bout_5(Bout_5),   .Bout_6(Bout_6),   .Bout_7(Bout_7), 
                        .Bout_8(Bout_8),   .Bout_9(Bout_9),   .Bout_10(Bout_10), .Bout_11(Bout_11), 
                        .Bout_12(Bout_12), .Bout_13(Bout_13), .Bout_14(Bout_14), .Bout_15(Bout_15),
                        .Bout_0_Val(Bout_0_Val)
                        );
 
endmodule
