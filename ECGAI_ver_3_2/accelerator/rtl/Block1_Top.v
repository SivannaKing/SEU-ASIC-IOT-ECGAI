`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/10 09:14:49
// Design Name: 
// Module Name: Block1_Top
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


module Block1_Top(
    input                            clk,
    input                            rst_n,
    output             wire          binary_out_val,
    output             wire          Bin_0, Bin_1, Bin_2, Bin_3, Bin_4, Bin_5, Bin_6, Bin_7 
);

wire    [6:0]   w_00, w_10, w_20, w_30, w_40, w_50, w_60, w_70;
wire            new_weight_val;

Weight_Control_B1 WC_Block1 (   .clk(clk)  , .rst_n(rst_n),
                                .w_00(w_00), .w_10(w_10), .w_20(w_20), .w_30(w_30), 
                                .w_40(w_40), .w_50(w_50), .w_60(w_60), .w_70(w_70),
                                .new_weight_val(new_weight_val)                     );


wire    [6:0]   Slide_Data_0, Slide_Data_1, Slide_Data_2, Slide_Data_3;
wire            Trans_Done_0, Trans_Done_1, Trans_Done_2, Trans_Done_3;
wire            Data_Val_0, Data_Val_1, Data_Val_2, Data_Val_3;
reg swu_en;
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        swu_en <= 0;
    else if(new_weight_val)
        swu_en <= 1;
end

SWU Slide_Window_Block1(    .clk(clk)   , .rst_n(swu_en),
                            .Slide_Data_0(Slide_Data_0), .Slide_Data_1(Slide_Data_1),
                            .Slide_Data_2(Slide_Data_2), .Slide_Data_3(Slide_Data_3),
                            .Trans_Done_0(Trans_Done_0), .Trans_Done_1(Trans_Done_1),
                            .Trans_Done_2(Trans_Done_2), .Trans_Done_3(Trans_Done_3),
                            .Data_Val_0(Data_Val_0), .Data_Val_1(Data_Val_1),
                            .Data_Val_2(Data_Val_2), .Data_Val_3(Data_Val_3)
                             );
//将Slide_data存入txt文件中以在python中进行验�?
//Save_to_file SF(.clk(clk), .rst_n(swu_en), .Slide_Data_0(Slide_Data_0), .Slide_Data_1(Slide_Data_1),
//                            .Slide_Data_2(Slide_Data_2), .Slide_Data_3(Slide_Data_3));



//计算Block1的卷�?
wire    signed [3:0]    o_00, o_01, o_02, o_03, o_10, o_11, o_12, o_13, o_20, o_21, o_22, o_23, o_30, o_31, o_32, o_33, 
                        o_40, o_41, o_42, o_43, o_50, o_51, o_52, o_53, o_60, o_61, o_62, o_63, o_70, o_71, o_72, o_73 ;
PE_Array_B1 PE_Array_Block1(    .clk(clk)   , .rst_n(Data_Val_0),
                                .new_weight_val(new_weight_val), 
                                .w_00(w_00), .w_10(w_10), .w_20(w_20), .w_30(w_30), 
                                .w_40(w_40), .w_50(w_50), .w_60(w_60), .w_70(w_70),
                                .slide_data_0(Slide_Data_0), .slide_data_1(Slide_Data_1),
                                .slide_data_2(Slide_Data_2), .slide_data_3(Slide_Data_3),
                                .o_00(o_00), .o_01(o_01), .o_02(o_02), .o_03(o_03),
                                .o_10(o_10), .o_11(o_11), .o_12(o_12), .o_13(o_13),
                                .o_20(o_20), .o_21(o_21), .o_22(o_22), .o_23(o_23),
                                .o_30(o_30), .o_31(o_31), .o_32(o_32), .o_33(o_33),
                                .o_40(o_40), .o_41(o_41), .o_42(o_42), .o_43(o_43),
                                .o_50(o_50), .o_51(o_51), .o_52(o_52), .o_53(o_53),
                                .o_60(o_60), .o_61(o_61), .o_62(o_62), .o_63(o_63),
                                .o_70(o_70), .o_71(o_71), .o_72(o_72), .o_73(o_73)    );
//将计算出�?4bit数据整合�?32bit，接�?产生单口RAM的相关信号，�?32bit的数据存入其�?
wire    [31:0]      OB_Data_0, OB_Data_1, OB_Data_2, OB_Data_3, OB_Data_4, OB_Data_5, OB_Data_6, OB_Data_7;

wire    [ 7:0]      ADDR_0, ADDR_1, ADDR_2, ADDR_3,
                    ADDR_4, ADDR_5, ADDR_6, ADDR_7;
wire    [ 7:0]      OB_Addr_ADDR_0, OB_Addr_ADDR_1, OB_Addr_ADDR_2, OB_Addr_ADDR_3,
                    OB_Addr_ADDR_4, OB_Addr_ADDR_5, OB_Addr_ADDR_6, OB_Addr_ADDR_7;
wire    [ 7:0]      MP_ADDR;
                   
wire    [31:0]      DOUTA_0, DOUTA_1, DOUTA_2, DOUTA_3, 
                    DOUTA_4, DOUTA_5, DOUTA_6, DOUTA_7;

wire                WEA_0, WEA_1, WEA_2, WEA_3, WEA_4, WEA_5, WEA_6, WEA_7;                     
wire                OB_Addr_WEA_0, OB_Addr_WEA_1, OB_Addr_WEA_2, OB_Addr_WEA_3,
                    OB_Addr_WEA_4, OB_Addr_WEA_5, OB_Addr_WEA_6, OB_Addr_WEA_7;
wire                MP_WEA;
                    
wire                ENA_0, ENA_1, ENA_2, ENA_3, 
                    ENA_4, ENA_5, ENA_6, ENA_7;
wire                OB_Addr_ENA_0, OB_Addr_ENA_1, OB_Addr_ENA_2, OB_Addr_ENA_3, 
                    OB_Addr_ENA_4, OB_Addr_ENA_5, OB_Addr_ENA_6, OB_Addr_ENA_7;                    
wire                MP_ENA;                  


                                                                        
OB_Addr_Contr_B1 OB_Control_Block1(  
                                .clk(clk)   , .rst_n(Data_Val_0),
                                .o_00(o_00), .o_01(o_01), .o_02(o_02), .o_03(o_03),
                                .o_10(o_10), .o_11(o_11), .o_12(o_12), .o_13(o_13),
                                .o_20(o_20), .o_21(o_21), .o_22(o_22), .o_23(o_23),
                                .o_30(o_30), .o_31(o_31), .o_32(o_32), .o_33(o_33),
                                .o_40(o_40), .o_41(o_41), .o_42(o_42), .o_43(o_43),
                                .o_50(o_50), .o_51(o_51), .o_52(o_52), .o_53(o_53),
                                .o_60(o_60), .o_61(o_61), .o_62(o_62), .o_63(o_63),
                                .o_70(o_70), .o_71(o_71), .o_72(o_72), .o_73(o_73),
                                .Trans_Done_0(Trans_Done_0), .Trans_Done_3(Trans_Done_3),
                                .OB_Data_0(OB_Data_0), .OB_Data_1(OB_Data_1), .OB_Data_2(OB_Data_2), .OB_Data_3(OB_Data_3),
                                .OB_Data_4(OB_Data_4), .OB_Data_5(OB_Data_5), .OB_Data_6(OB_Data_6), .OB_Data_7(OB_Data_7),
                                .ADDR_0(OB_Addr_ADDR_0), .ADDR_1(OB_Addr_ADDR_1), .ADDR_2(OB_Addr_ADDR_2), .ADDR_3(OB_Addr_ADDR_3), 
                                .ADDR_4(OB_Addr_ADDR_4), .ADDR_5(OB_Addr_ADDR_5), .ADDR_6(OB_Addr_ADDR_6), .ADDR_7(OB_Addr_ADDR_7), 
                                .write_enable_0(OB_Addr_WEA_0), .write_enable_1(OB_Addr_WEA_1), .write_enable_2(OB_Addr_WEA_2), .write_enable_3(OB_Addr_WEA_3), 
                                .write_enable_4(OB_Addr_WEA_4), .write_enable_5(OB_Addr_WEA_5), .write_enable_6(OB_Addr_WEA_6), .write_enable_7(OB_Addr_WEA_7),
                                .ENA_0(OB_Addr_ENA_0), .ENA_1(OB_Addr_ENA_1), .ENA_2(OB_Addr_ENA_2), .ENA_3(OB_Addr_ENA_3), 
                                .ENA_4(OB_Addr_ENA_4), .ENA_5(OB_Addr_ENA_5), .ENA_6(OB_Addr_ENA_6), .ENA_7(OB_Addr_ENA_7)                                   
);


//max_pool的rst_n信号控制
reg     max_pool_rst_n;

always @(posedge clk or negedge rst_n)begin
    if(!rst_n) begin
        max_pool_rst_n <= 0;
    end
    else if(ADDR_7 == 169)begin //虽然SRAM的深度是226，但是由于ADDR控制器的存储策略，最后一个数据是存的169，第226个数据在3~4个clk前就已经存好�?
         max_pool_rst_n <= 1;
    end
end

Maxpooling_B1 MP_Thre( .clk(clk),  .rst_n(max_pool_rst_n), .system_rst_n(rst_n), 
                    .ADDR(MP_ADDR),
                    .WEA(MP_WEA),
                    .ENA(MP_ENA), 
                    .DOUTA_0(DOUTA_0), .DOUTA_1(DOUTA_1), .DOUTA_2(DOUTA_2), .DOUTA_3(DOUTA_3), 
                    .DOUTA_4(DOUTA_4), .DOUTA_5(DOUTA_5), .DOUTA_6(DOUTA_6), .DOUTA_7(DOUTA_7),
                    .Bin_0(Bin_0), .Bin_1(Bin_1),  .Bin_2(Bin_2),  .Bin_3(Bin_3),  
                    .Bin_4(Bin_4), .Bin_5(Bin_5),  .Bin_6(Bin_6),  .Bin_7(Bin_7),
                    .max_val(), .binary_val(binary_out_val)               
);

assign WEA_0 = max_pool_rst_n? MP_WEA : OB_Addr_WEA_0; //�?1证明maxpool启动了，那么SPRAM由MP模块的WEA接管，为0则由Output_Buffer接管
assign WEA_1 = max_pool_rst_n? MP_WEA : OB_Addr_WEA_1;
assign WEA_2 = max_pool_rst_n? MP_WEA : OB_Addr_WEA_2;
assign WEA_3 = max_pool_rst_n? MP_WEA : OB_Addr_WEA_3;
assign WEA_4 = max_pool_rst_n? MP_WEA : OB_Addr_WEA_4;
assign WEA_5 = max_pool_rst_n? MP_WEA : OB_Addr_WEA_5;
assign WEA_6 = max_pool_rst_n? MP_WEA : OB_Addr_WEA_6;
assign WEA_7 = max_pool_rst_n? MP_WEA : OB_Addr_WEA_7;

assign ADDR_0 = max_pool_rst_n? MP_ADDR : OB_Addr_ADDR_0;
assign ADDR_1 = max_pool_rst_n? MP_ADDR : OB_Addr_ADDR_1;
assign ADDR_2 = max_pool_rst_n? MP_ADDR : OB_Addr_ADDR_2;
assign ADDR_3 = max_pool_rst_n? MP_ADDR : OB_Addr_ADDR_3;
assign ADDR_4 = max_pool_rst_n? MP_ADDR : OB_Addr_ADDR_4;
assign ADDR_5 = max_pool_rst_n? MP_ADDR : OB_Addr_ADDR_5;
assign ADDR_6 = max_pool_rst_n? MP_ADDR : OB_Addr_ADDR_6;
assign ADDR_7 = max_pool_rst_n? MP_ADDR : OB_Addr_ADDR_7;

assign ENA_0 = max_pool_rst_n? MP_ENA : OB_Addr_ENA_0;
assign ENA_1 = max_pool_rst_n? MP_ENA : OB_Addr_ENA_1;
assign ENA_2 = max_pool_rst_n? MP_ENA : OB_Addr_ENA_2;
assign ENA_3 = max_pool_rst_n? MP_ENA : OB_Addr_ENA_3;
assign ENA_4 = max_pool_rst_n? MP_ENA : OB_Addr_ENA_4;
assign ENA_5 = max_pool_rst_n? MP_ENA : OB_Addr_ENA_5;
assign ENA_6 = max_pool_rst_n? MP_ENA : OB_Addr_ENA_6;
assign ENA_7 = max_pool_rst_n? MP_ENA : OB_Addr_ENA_7;


//SPRAM   Output_Buffer10( .clk(clk),  .rst_n(Data_Val_0), .DINA(OB_Data_0), .ADDRA(ADDR_0), .WEA(WEA_0), .DOUTA(DOUTA_0),  .ENA(ENA_0) );
//SPRAM   Output_Buffer11( .clk(clk),  .rst_n(Data_Val_0), .DINA(OB_Data_1), .ADDRA(ADDR_1), .WEA(WEA_1), .DOUTA(DOUTA_1),  .ENA(ENA_1) );
//SPRAM   Output_Buffer12( .clk(clk),  .rst_n(Data_Val_0), .DINA(OB_Data_2), .ADDRA(ADDR_2), .WEA(WEA_2), .DOUTA(DOUTA_2),  .ENA(ENA_2) );
//SPRAM   Output_Buffer13( .clk(clk),  .rst_n(Data_Val_0), .DINA(OB_Data_3), .ADDRA(ADDR_3), .WEA(WEA_3), .DOUTA(DOUTA_3),  .ENA(ENA_3) );
//SPRAM   Output_Buffer14( .clk(clk),  .rst_n(Data_Val_0), .DINA(OB_Data_4), .ADDRA(ADDR_4), .WEA(WEA_4), .DOUTA(DOUTA_4),  .ENA(ENA_4) );
//SPRAM   Output_Buffer15( .clk(clk),  .rst_n(Data_Val_0), .DINA(OB_Data_5), .ADDRA(ADDR_5), .WEA(WEA_5), .DOUTA(DOUTA_5),  .ENA(ENA_5) );
//SPRAM   Output_Buffer16( .clk(clk),  .rst_n(Data_Val_0), .DINA(OB_Data_6), .ADDRA(ADDR_6), .WEA(WEA_6), .DOUTA(DOUTA_6),  .ENA(ENA_6) );
//SPRAM   Output_Buffer17( .clk(clk),  .rst_n(Data_Val_0), .DINA(OB_Data_7), .ADDRA(ADDR_7), .WEA(WEA_7), .DOUTA(DOUTA_7),  .ENA(ENA_7) );
Output_Buffer_B1_IP Output_Buffer10(.clka(clk), .ena(ENA_0), .wea(WEA_0), .addra(ADDR_0), .dina(OB_Data_0), .douta(DOUTA_0));
Output_Buffer_B1_IP Output_Buffer11(.clka(clk), .ena(ENA_1), .wea(WEA_1), .addra(ADDR_1), .dina(OB_Data_1), .douta(DOUTA_1));
Output_Buffer_B1_IP Output_Buffer12(.clka(clk), .ena(ENA_2), .wea(WEA_2), .addra(ADDR_2), .dina(OB_Data_2), .douta(DOUTA_2));
Output_Buffer_B1_IP Output_Buffer13(.clka(clk), .ena(ENA_3), .wea(WEA_3), .addra(ADDR_3), .dina(OB_Data_3), .douta(DOUTA_3));
Output_Buffer_B1_IP Output_Buffer14(.clka(clk), .ena(ENA_4), .wea(WEA_4), .addra(ADDR_4), .dina(OB_Data_4), .douta(DOUTA_4));
Output_Buffer_B1_IP Output_Buffer15(.clka(clk), .ena(ENA_5), .wea(WEA_5), .addra(ADDR_5), .dina(OB_Data_5), .douta(DOUTA_5));
Output_Buffer_B1_IP Output_Buffer16(.clka(clk), .ena(ENA_6), .wea(WEA_6), .addra(ADDR_6), .dina(OB_Data_6), .douta(DOUTA_6));
Output_Buffer_B1_IP Output_Buffer17(.clka(clk), .ena(ENA_7), .wea(WEA_7), .addra(ADDR_7), .dina(OB_Data_7), .douta(DOUTA_7));



endmodule
