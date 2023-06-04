`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/08 15:01:36
// Design Name: 
// Module Name: IB_Addr_Contr_B6
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


module IB_Addr_Contr_B6(
    input                           clk,
    input                           rst_n,
    input         wire              Bin_0, Bin_1, Bin_2, Bin_3, Bin_4, Bin_5, Bin_6, Bin_7, 
                                    Bin_8, Bin_9, Bin_10, Bin_11, Bin_12, Bin_13, Bin_14, Bin_15, 
                                    Bin_16, Bin_17, Bin_18, Bin_19, Bin_20, Bin_21, Bin_22, Bin_23, 
                                    Bin_24, Bin_25, Bin_26, Bin_27, Bin_28, Bin_29, Bin_30, Bin_31,
                                    Bin_32, Bin_33, Bin_34, Bin_35, Bin_36, Bin_37, Bin_38, Bin_39, 
                                    Bin_40, Bin_41, Bin_42, Bin_43, Bin_44, Bin_45, Bin_46, Bin_47, 
                                    Bin_48, Bin_49, Bin_50, Bin_51, Bin_52, Bin_53, Bin_54, Bin_55, 
                                    Bin_56, Bin_57, Bin_58, Bin_59, Bin_60, Bin_61, Bin_62, Bin_63,
    input         wire              Bin_0_Val,
    output   reg     [31:0]         Dout_0, Dout_1, Dout_2,  Dout_3,  Dout_4,  Dout_5,  Dout_6,  Dout_7,
                                    Dout_8, Dout_9, Dout_10, Dout_11, Dout_12, Dout_13, Dout_14, Dout_15,
                                    Dout_16, Dout_17, Dout_18, Dout_19, Dout_20, Dout_21, Dout_22, Dout_23, 
                                    Dout_24, Dout_25, Dout_26, Dout_27, Dout_28, Dout_29, Dout_30, Dout_31,
                                    Dout_32, Dout_33, Dout_34, Dout_35, Dout_36, Dout_37, Dout_38, Dout_39, 
                                    Dout_40, Dout_41, Dout_42, Dout_43, Dout_44, Dout_45, Dout_46, Dout_47, 
                                    Dout_48, Dout_49, Dout_50, Dout_51, Dout_52, Dout_53, Dout_54, Dout_55, 
                                    Dout_56, Dout_57, Dout_58, Dout_59, Dout_60, Dout_61, Dout_62, Dout_63,
    output   reg     [ 1:0]         ADDR_0, ADDR_1, ADDR_2,  ADDR_3,  ADDR_4,  ADDR_5,  ADDR_6,  ADDR_7, 
                                    ADDR_8, ADDR_9, ADDR_10, ADDR_11, ADDR_12, ADDR_13, ADDR_14, ADDR_15, 
                                    ADDR_16, ADDR_17, ADDR_18, ADDR_19, ADDR_20, ADDR_21, ADDR_22, ADDR_23, 
                                    ADDR_24, ADDR_25, ADDR_26, ADDR_27, ADDR_28, ADDR_29, ADDR_30, ADDR_31,
                                    ADDR_32, ADDR_33, ADDR_34, ADDR_35, ADDR_36, ADDR_37, ADDR_38, ADDR_39, 
                                    ADDR_40, ADDR_41, ADDR_42, ADDR_43, ADDR_44, ADDR_45, ADDR_46, ADDR_47, 
                                    ADDR_48, ADDR_49, ADDR_50, ADDR_51, ADDR_52, ADDR_53, ADDR_54, ADDR_55, 
                                    ADDR_56, ADDR_57, ADDR_58, ADDR_59, ADDR_60, ADDR_61, ADDR_62, ADDR_63,
    output   reg                    WEA_0, WEA_1, WEA_2,  WEA_3,  WEA_4,  WEA_5,  WEA_6,  WEA_7,  
                                    WEA_8, WEA_9, WEA_10, WEA_11, WEA_12, WEA_13, WEA_14, WEA_15, 
                                    WEA_16, WEA_17, WEA_18, WEA_19, WEA_20, WEA_21, WEA_22, WEA_23, 
                                    WEA_24, WEA_25, WEA_26, WEA_27, WEA_28, WEA_29, WEA_30, WEA_31,
                                    WEA_32, WEA_33, WEA_34, WEA_35, WEA_36, WEA_37, WEA_38, WEA_39, 
                                    WEA_40, WEA_41, WEA_42, WEA_43, WEA_44, WEA_45, WEA_46, WEA_47, 
                                    WEA_48, WEA_49, WEA_50, WEA_51, WEA_52, WEA_53, WEA_54, WEA_55, 
                                    WEA_56, WEA_57, WEA_58, WEA_59, WEA_60, WEA_61, WEA_62, WEA_63,
    output   reg                    IB_Addr_Contr_B6_work, IB_Addr_Contr_B6_work_Done 
);
//*******************************************RAM0***************************************
reg         [4:0]       addr_cnt_0;
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        addr_cnt_0 <= 0;
    end
    else begin
        if(ADDR_0 < 3)begin
            if(Bin_0_Val) begin
                addr_cnt_0 <= addr_cnt_0 + 1;
            end
        end else if(ADDR_0 == 3)begin
            addr_cnt_0 <= 0;
        end
    end    
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        Dout_0 <= 0;
    end
    else begin
        if(Bin_0_Val) begin
            Dout_0 <= {Dout_0[30:0], Bin_0};
        end
    end
end
reg             WEA_0_e1;
reg   [2:0]     ADDR_0_e2, ADDR_0_e1;
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        ADDR_0_e2 <= 0;
        WEA_0_e1 <= 0;
    end else begin
        if(ADDR_0 < 3) begin
            if(addr_cnt_0 == 31 && !Bin_0_Val)begin
                ADDR_0_e2 <= ADDR_0_e2 + 1;
                WEA_0_e1 <= 1;
            end
            else begin
                WEA_0_e1 <= 0;
            end
        end else if(ADDR_0 == 3)begin
            WEA_0_e1  <= 0;
        end
    end
end
always@(posedge clk)begin
    ADDR_0_e1 <= ADDR_0_e2;
    ADDR_0 <= ADDR_0_e1;
    WEA_0 <= WEA_0_e1;
end    

//*******************************************RAM1***************************************
reg         Bin_1_Val;
always@(posedge clk)begin
    ADDR_1 <= ADDR_0;
    WEA_1 <= WEA_0;
    Bin_1_Val <= Bin_0_Val;
end
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        Dout_1 <= 0;
    end
    else begin
        if(Bin_1_Val) begin
            Dout_1 <= {Dout_1[30:0], Bin_1};
        end
    end
end

        //*******************************************RAM2***************************************
        reg         Bin_2_Val;
        always@(posedge clk)begin
            ADDR_2 <= ADDR_1;
            WEA_2 <= WEA_1;
            Bin_2_Val <= Bin_1_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_2 <= 0;
            end
            else begin
                if(Bin_2_Val) begin
                    Dout_2 <= {Dout_2[30:0], Bin_2};
                end
            end
        end
        
        //*******************************************RAM3***************************************
        reg         Bin_3_Val;
        always@(posedge clk)begin
            ADDR_3 <= ADDR_2;
            WEA_3 <= WEA_2;
            Bin_3_Val <= Bin_2_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_3 <= 0;
            end
            else begin
                if(Bin_3_Val) begin
                    Dout_3 <= {Dout_3[30:0], Bin_3};
                end
            end
        end
        
        //*******************************************RAM4***************************************
        reg         Bin_4_Val;
        always@(posedge clk)begin
            ADDR_4 <= ADDR_3;
            WEA_4 <= WEA_3;
            Bin_4_Val <= Bin_3_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_4 <= 0;
            end
            else begin
                if(Bin_4_Val) begin
                    Dout_4 <= {Dout_4[30:0], Bin_4};
                end
            end
        end
        
        //*******************************************RAM5***************************************
        reg         Bin_5_Val;
        always@(posedge clk)begin
            ADDR_5 <= ADDR_4;
            WEA_5 <= WEA_4;
            Bin_5_Val <= Bin_4_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_5 <= 0;
            end
            else begin
                if(Bin_5_Val) begin
                    Dout_5 <= {Dout_5[30:0], Bin_5};
                end
            end
        end
        
        //*******************************************RAM6***************************************
        reg         Bin_6_Val;
        always@(posedge clk)begin
            ADDR_6 <= ADDR_5;
            WEA_6 <= WEA_5;
            Bin_6_Val <= Bin_5_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_6 <= 0;
            end
            else begin
                if(Bin_6_Val) begin
                    Dout_6 <= {Dout_6[30:0], Bin_6};
                end
            end
        end
        
        //*******************************************RAM7***************************************
        reg         Bin_7_Val;
        always@(posedge clk)begin
            ADDR_7 <= ADDR_6;
            WEA_7 <= WEA_6;
            Bin_7_Val <= Bin_6_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_7 <= 0;
            end
            else begin
                if(Bin_7_Val) begin
                    Dout_7 <= {Dout_7[30:0], Bin_7};
                end
            end
        end
        
        //*******************************************RAM8***************************************
        reg         Bin_8_Val;
        always@(posedge clk)begin
            ADDR_8 <= ADDR_7;
            WEA_8 <= WEA_7;
            Bin_8_Val <= Bin_7_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_8 <= 0;
            end
            else begin
                if(Bin_8_Val) begin
                    Dout_8 <= {Dout_8[30:0], Bin_8};
                end
            end
        end
        
        //*******************************************RAM9***************************************
        reg         Bin_9_Val;
        always@(posedge clk)begin
            ADDR_9 <= ADDR_8;
            WEA_9 <= WEA_8;
            Bin_9_Val <= Bin_8_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_9 <= 0;
            end
            else begin
                if(Bin_9_Val) begin
                    Dout_9 <= {Dout_9[30:0], Bin_9};
                end
            end
        end
        
        //*******************************************RAM10***************************************
        reg         Bin_10_Val;
        always@(posedge clk)begin
            ADDR_10 <= ADDR_9;
            WEA_10 <= WEA_9;
            Bin_10_Val <= Bin_9_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_10 <= 0;
            end
            else begin
                if(Bin_10_Val) begin
                    Dout_10 <= {Dout_10[30:0], Bin_10};
                end
            end
        end
        
        //*******************************************RAM11***************************************
        reg         Bin_11_Val;
        always@(posedge clk)begin
            ADDR_11 <= ADDR_10;
            WEA_11 <= WEA_10;
            Bin_11_Val <= Bin_10_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_11 <= 0;
            end
            else begin
                if(Bin_11_Val) begin
                    Dout_11 <= {Dout_11[30:0], Bin_11};
                end
            end
        end
        
        //*******************************************RAM12***************************************
        reg         Bin_12_Val;
        always@(posedge clk)begin
            ADDR_12 <= ADDR_11;
            WEA_12 <= WEA_11;
            Bin_12_Val <= Bin_11_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_12 <= 0;
            end
            else begin
                if(Bin_12_Val) begin
                    Dout_12 <= {Dout_12[30:0], Bin_12};
                end
            end
        end
        
        //*******************************************RAM13***************************************
        reg         Bin_13_Val;
        always@(posedge clk)begin
            ADDR_13 <= ADDR_12;
            WEA_13 <= WEA_12;
            Bin_13_Val <= Bin_12_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_13 <= 0;
            end
            else begin
                if(Bin_13_Val) begin
                    Dout_13 <= {Dout_13[30:0], Bin_13};
                end
            end
        end
        
        //*******************************************RAM14***************************************
        reg         Bin_14_Val;
        always@(posedge clk)begin
            ADDR_14 <= ADDR_13;
            WEA_14 <= WEA_13;
            Bin_14_Val <= Bin_13_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_14 <= 0;
            end
            else begin
                if(Bin_14_Val) begin
                    Dout_14 <= {Dout_14[30:0], Bin_14};
                end
            end
        end
        
        //*******************************************RAM15***************************************
        reg         Bin_15_Val;
        always@(posedge clk)begin
            ADDR_15 <= ADDR_14;
            WEA_15 <= WEA_14;
            Bin_15_Val <= Bin_14_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_15 <= 0;
            end
            else begin
                if(Bin_15_Val) begin
                    Dout_15 <= {Dout_15[30:0], Bin_15};
                end
            end
        end
        
        //*******************************************RAM16***************************************
        reg         Bin_16_Val;
        always@(posedge clk)begin
            ADDR_16 <= ADDR_15;
            WEA_16 <= WEA_15;
            Bin_16_Val <= Bin_15_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_16 <= 0;
            end
            else begin
                if(Bin_16_Val) begin
                    Dout_16 <= {Dout_16[30:0], Bin_16};
                end
            end
        end
        
        //*******************************************RAM17***************************************
        reg         Bin_17_Val;
        always@(posedge clk)begin
            ADDR_17 <= ADDR_16;
            WEA_17 <= WEA_16;
            Bin_17_Val <= Bin_16_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_17 <= 0;
            end
            else begin
                if(Bin_17_Val) begin
                    Dout_17 <= {Dout_17[30:0], Bin_17};
                end
            end
        end
        
        //*******************************************RAM18***************************************
        reg         Bin_18_Val;
        always@(posedge clk)begin
            ADDR_18 <= ADDR_17;
            WEA_18 <= WEA_17;
            Bin_18_Val <= Bin_17_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_18 <= 0;
            end
            else begin
                if(Bin_18_Val) begin
                    Dout_18 <= {Dout_18[30:0], Bin_18};
                end
            end
        end
        
        //*******************************************RAM19***************************************
        reg         Bin_19_Val;
        always@(posedge clk)begin
            ADDR_19 <= ADDR_18;
            WEA_19 <= WEA_18;
            Bin_19_Val <= Bin_18_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_19 <= 0;
            end
            else begin
                if(Bin_19_Val) begin
                    Dout_19 <= {Dout_19[30:0], Bin_19};
                end
            end
        end
        
        //*******************************************RAM20***************************************
        reg         Bin_20_Val;
        always@(posedge clk)begin
            ADDR_20 <= ADDR_19;
            WEA_20 <= WEA_19;
            Bin_20_Val <= Bin_19_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_20 <= 0;
            end
            else begin
                if(Bin_20_Val) begin
                    Dout_20 <= {Dout_20[30:0], Bin_20};
                end
            end
        end
        
        //*******************************************RAM21***************************************
        reg         Bin_21_Val;
        always@(posedge clk)begin
            ADDR_21 <= ADDR_20;
            WEA_21 <= WEA_20;
            Bin_21_Val <= Bin_20_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_21 <= 0;
            end
            else begin
                if(Bin_21_Val) begin
                    Dout_21 <= {Dout_21[30:0], Bin_21};
                end
            end
        end
        
        //*******************************************RAM22***************************************
        reg         Bin_22_Val;
        always@(posedge clk)begin
            ADDR_22 <= ADDR_21;
            WEA_22 <= WEA_21;
            Bin_22_Val <= Bin_21_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_22 <= 0;
            end
            else begin
                if(Bin_22_Val) begin
                    Dout_22 <= {Dout_22[30:0], Bin_22};
                end
            end
        end
        
        //*******************************************RAM23***************************************
        reg         Bin_23_Val;
        always@(posedge clk)begin
            ADDR_23 <= ADDR_22;
            WEA_23 <= WEA_22;
            Bin_23_Val <= Bin_22_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_23 <= 0;
            end
            else begin
                if(Bin_23_Val) begin
                    Dout_23 <= {Dout_23[30:0], Bin_23};
                end
            end
        end
        
        //*******************************************RAM24***************************************
        reg         Bin_24_Val;
        always@(posedge clk)begin
            ADDR_24 <= ADDR_23;
            WEA_24 <= WEA_23;
            Bin_24_Val <= Bin_23_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_24 <= 0;
            end
            else begin
                if(Bin_24_Val) begin
                    Dout_24 <= {Dout_24[30:0], Bin_24};
                end
            end
        end
        
        //*******************************************RAM25***************************************
        reg         Bin_25_Val;
        always@(posedge clk)begin
            ADDR_25 <= ADDR_24;
            WEA_25 <= WEA_24;
            Bin_25_Val <= Bin_24_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_25 <= 0;
            end
            else begin
                if(Bin_25_Val) begin
                    Dout_25 <= {Dout_25[30:0], Bin_25};
                end
            end
        end
        
        //*******************************************RAM26***************************************
        reg         Bin_26_Val;
        always@(posedge clk)begin
            ADDR_26 <= ADDR_25;
            WEA_26 <= WEA_25;
            Bin_26_Val <= Bin_25_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_26 <= 0;
            end
            else begin
                if(Bin_26_Val) begin
                    Dout_26 <= {Dout_26[30:0], Bin_26};
                end
            end
        end
        
        //*******************************************RAM27***************************************
        reg         Bin_27_Val;
        always@(posedge clk)begin
            ADDR_27 <= ADDR_26;
            WEA_27 <= WEA_26;
            Bin_27_Val <= Bin_26_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_27 <= 0;
            end
            else begin
                if(Bin_27_Val) begin
                    Dout_27 <= {Dout_27[30:0], Bin_27};
                end
            end
        end
        
        //*******************************************RAM28***************************************
        reg         Bin_28_Val;
        always@(posedge clk)begin
            ADDR_28 <= ADDR_27;
            WEA_28 <= WEA_27;
            Bin_28_Val <= Bin_27_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_28 <= 0;
            end
            else begin
                if(Bin_28_Val) begin
                    Dout_28 <= {Dout_28[30:0], Bin_28};
                end
            end
        end
        
        //*******************************************RAM29***************************************
        reg         Bin_29_Val;
        always@(posedge clk)begin
            ADDR_29 <= ADDR_28;
            WEA_29 <= WEA_28;
            Bin_29_Val <= Bin_28_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_29 <= 0;
            end
            else begin
                if(Bin_29_Val) begin
                    Dout_29 <= {Dout_29[30:0], Bin_29};
                end
            end
        end
        
        //*******************************************RAM30***************************************
        reg         Bin_30_Val;
        always@(posedge clk)begin
            ADDR_30 <= ADDR_29;
            WEA_30 <= WEA_29;
            Bin_30_Val <= Bin_29_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_30 <= 0;
            end
            else begin
                if(Bin_30_Val) begin
                    Dout_30 <= {Dout_30[30:0], Bin_30};
                end
            end
        end
        
        //*******************************************RAM31***************************************
        reg         Bin_31_Val;
        always@(posedge clk)begin
            ADDR_31 <= ADDR_30;
            WEA_31 <= WEA_30;
            Bin_31_Val <= Bin_30_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_31 <= 0;
            end
            else begin
                if(Bin_31_Val) begin
                    Dout_31 <= {Dout_31[30:0], Bin_31};
                end
            end
        end
        
        //*******************************************RAM32***************************************
        reg         Bin_32_Val;
        always@(posedge clk)begin
            ADDR_32 <= ADDR_31;
            WEA_32 <= WEA_31;
            Bin_32_Val <= Bin_31_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_32 <= 0;
            end
            else begin
                if(Bin_32_Val) begin
                    Dout_32 <= {Dout_32[30:0], Bin_32};
                end
            end
        end
        
        //*******************************************RAM33***************************************
        reg         Bin_33_Val;
        always@(posedge clk)begin
            ADDR_33 <= ADDR_32;
            WEA_33 <= WEA_32;
            Bin_33_Val <= Bin_32_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_33 <= 0;
            end
            else begin
                if(Bin_33_Val) begin
                    Dout_33 <= {Dout_33[30:0], Bin_33};
                end
            end
        end
        
        //*******************************************RAM34***************************************
        reg         Bin_34_Val;
        always@(posedge clk)begin
            ADDR_34 <= ADDR_33;
            WEA_34 <= WEA_33;
            Bin_34_Val <= Bin_33_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_34 <= 0;
            end
            else begin
                if(Bin_34_Val) begin
                    Dout_34 <= {Dout_34[30:0], Bin_34};
                end
            end
        end
        
        //*******************************************RAM35***************************************
        reg         Bin_35_Val;
        always@(posedge clk)begin
            ADDR_35 <= ADDR_34;
            WEA_35 <= WEA_34;
            Bin_35_Val <= Bin_34_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_35 <= 0;
            end
            else begin
                if(Bin_35_Val) begin
                    Dout_35 <= {Dout_35[30:0], Bin_35};
                end
            end
        end
        
        //*******************************************RAM36***************************************
        reg         Bin_36_Val;
        always@(posedge clk)begin
            ADDR_36 <= ADDR_35;
            WEA_36 <= WEA_35;
            Bin_36_Val <= Bin_35_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_36 <= 0;
            end
            else begin
                if(Bin_36_Val) begin
                    Dout_36 <= {Dout_36[30:0], Bin_36};
                end
            end
        end
        
        //*******************************************RAM37***************************************
        reg         Bin_37_Val;
        always@(posedge clk)begin
            ADDR_37 <= ADDR_36;
            WEA_37 <= WEA_36;
            Bin_37_Val <= Bin_36_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_37 <= 0;
            end
            else begin
                if(Bin_37_Val) begin
                    Dout_37 <= {Dout_37[30:0], Bin_37};
                end
            end
        end
        
        //*******************************************RAM38***************************************
        reg         Bin_38_Val;
        always@(posedge clk)begin
            ADDR_38 <= ADDR_37;
            WEA_38 <= WEA_37;
            Bin_38_Val <= Bin_37_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_38 <= 0;
            end
            else begin
                if(Bin_38_Val) begin
                    Dout_38 <= {Dout_38[30:0], Bin_38};
                end
            end
        end
        
        //*******************************************RAM39***************************************
        reg         Bin_39_Val;
        always@(posedge clk)begin
            ADDR_39 <= ADDR_38;
            WEA_39 <= WEA_38;
            Bin_39_Val <= Bin_38_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_39 <= 0;
            end
            else begin
                if(Bin_39_Val) begin
                    Dout_39 <= {Dout_39[30:0], Bin_39};
                end
            end
        end
        
        //*******************************************RAM40***************************************
        reg         Bin_40_Val;
        always@(posedge clk)begin
            ADDR_40 <= ADDR_39;
            WEA_40 <= WEA_39;
            Bin_40_Val <= Bin_39_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_40 <= 0;
            end
            else begin
                if(Bin_40_Val) begin
                    Dout_40 <= {Dout_40[30:0], Bin_40};
                end
            end
        end
        
        //*******************************************RAM41***************************************
        reg         Bin_41_Val;
        always@(posedge clk)begin
            ADDR_41 <= ADDR_40;
            WEA_41 <= WEA_40;
            Bin_41_Val <= Bin_40_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_41 <= 0;
            end
            else begin
                if(Bin_41_Val) begin
                    Dout_41 <= {Dout_41[30:0], Bin_41};
                end
            end
        end
        
        //*******************************************RAM42***************************************
        reg         Bin_42_Val;
        always@(posedge clk)begin
            ADDR_42 <= ADDR_41;
            WEA_42 <= WEA_41;
            Bin_42_Val <= Bin_41_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_42 <= 0;
            end
            else begin
                if(Bin_42_Val) begin
                    Dout_42 <= {Dout_42[30:0], Bin_42};
                end
            end
        end
        
        //*******************************************RAM43***************************************
        reg         Bin_43_Val;
        always@(posedge clk)begin
            ADDR_43 <= ADDR_42;
            WEA_43 <= WEA_42;
            Bin_43_Val <= Bin_42_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_43 <= 0;
            end
            else begin
                if(Bin_43_Val) begin
                    Dout_43 <= {Dout_43[30:0], Bin_43};
                end
            end
        end
        
        //*******************************************RAM44***************************************
        reg         Bin_44_Val;
        always@(posedge clk)begin
            ADDR_44 <= ADDR_43;
            WEA_44 <= WEA_43;
            Bin_44_Val <= Bin_43_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_44 <= 0;
            end
            else begin
                if(Bin_44_Val) begin
                    Dout_44 <= {Dout_44[30:0], Bin_44};
                end
            end
        end
        
        //*******************************************RAM45***************************************
        reg         Bin_45_Val;
        always@(posedge clk)begin
            ADDR_45 <= ADDR_44;
            WEA_45 <= WEA_44;
            Bin_45_Val <= Bin_44_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_45 <= 0;
            end
            else begin
                if(Bin_45_Val) begin
                    Dout_45 <= {Dout_45[30:0], Bin_45};
                end
            end
        end
        
        //*******************************************RAM46***************************************
        reg         Bin_46_Val;
        always@(posedge clk)begin
            ADDR_46 <= ADDR_45;
            WEA_46 <= WEA_45;
            Bin_46_Val <= Bin_45_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_46 <= 0;
            end
            else begin
                if(Bin_46_Val) begin
                    Dout_46 <= {Dout_46[30:0], Bin_46};
                end
            end
        end
        
        //*******************************************RAM47***************************************
        reg         Bin_47_Val;
        always@(posedge clk)begin
            ADDR_47 <= ADDR_46;
            WEA_47 <= WEA_46;
            Bin_47_Val <= Bin_46_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_47 <= 0;
            end
            else begin
                if(Bin_47_Val) begin
                    Dout_47 <= {Dout_47[30:0], Bin_47};
                end
            end
        end
        
        //*******************************************RAM48***************************************
        reg         Bin_48_Val;
        always@(posedge clk)begin
            ADDR_48 <= ADDR_47;
            WEA_48 <= WEA_47;
            Bin_48_Val <= Bin_47_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_48 <= 0;
            end
            else begin
                if(Bin_48_Val) begin
                    Dout_48 <= {Dout_48[30:0], Bin_48};
                end
            end
        end
        
        //*******************************************RAM49***************************************
        reg         Bin_49_Val;
        always@(posedge clk)begin
            ADDR_49 <= ADDR_48;
            WEA_49 <= WEA_48;
            Bin_49_Val <= Bin_48_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_49 <= 0;
            end
            else begin
                if(Bin_49_Val) begin
                    Dout_49 <= {Dout_49[30:0], Bin_49};
                end
            end
        end
        
        //*******************************************RAM50***************************************
        reg         Bin_50_Val;
        always@(posedge clk)begin
            ADDR_50 <= ADDR_49;
            WEA_50 <= WEA_49;
            Bin_50_Val <= Bin_49_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_50 <= 0;
            end
            else begin
                if(Bin_50_Val) begin
                    Dout_50 <= {Dout_50[30:0], Bin_50};
                end
            end
        end
        
        //*******************************************RAM51***************************************
        reg         Bin_51_Val;
        always@(posedge clk)begin
            ADDR_51 <= ADDR_50;
            WEA_51 <= WEA_50;
            Bin_51_Val <= Bin_50_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_51 <= 0;
            end
            else begin
                if(Bin_51_Val) begin
                    Dout_51 <= {Dout_51[30:0], Bin_51};
                end
            end
        end
        
        //*******************************************RAM52***************************************
        reg         Bin_52_Val;
        always@(posedge clk)begin
            ADDR_52 <= ADDR_51;
            WEA_52 <= WEA_51;
            Bin_52_Val <= Bin_51_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_52 <= 0;
            end
            else begin
                if(Bin_52_Val) begin
                    Dout_52 <= {Dout_52[30:0], Bin_52};
                end
            end
        end
        
        //*******************************************RAM53***************************************
        reg         Bin_53_Val;
        always@(posedge clk)begin
            ADDR_53 <= ADDR_52;
            WEA_53 <= WEA_52;
            Bin_53_Val <= Bin_52_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_53 <= 0;
            end
            else begin
                if(Bin_53_Val) begin
                    Dout_53 <= {Dout_53[30:0], Bin_53};
                end
            end
        end
        
        //*******************************************RAM54***************************************
        reg         Bin_54_Val;
        always@(posedge clk)begin
            ADDR_54 <= ADDR_53;
            WEA_54 <= WEA_53;
            Bin_54_Val <= Bin_53_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_54 <= 0;
            end
            else begin
                if(Bin_54_Val) begin
                    Dout_54 <= {Dout_54[30:0], Bin_54};
                end
            end
        end
        
        //*******************************************RAM55***************************************
        reg         Bin_55_Val;
        always@(posedge clk)begin
            ADDR_55 <= ADDR_54;
            WEA_55 <= WEA_54;
            Bin_55_Val <= Bin_54_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_55 <= 0;
            end
            else begin
                if(Bin_55_Val) begin
                    Dout_55 <= {Dout_55[30:0], Bin_55};
                end
            end
        end
        
        //*******************************************RAM56***************************************
        reg         Bin_56_Val;
        always@(posedge clk)begin
            ADDR_56 <= ADDR_55;
            WEA_56 <= WEA_55;
            Bin_56_Val <= Bin_55_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_56 <= 0;
            end
            else begin
                if(Bin_56_Val) begin
                    Dout_56 <= {Dout_56[30:0], Bin_56};
                end
            end
        end
        
        //*******************************************RAM57***************************************
        reg         Bin_57_Val;
        always@(posedge clk)begin
            ADDR_57 <= ADDR_56;
            WEA_57 <= WEA_56;
            Bin_57_Val <= Bin_56_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_57 <= 0;
            end
            else begin
                if(Bin_57_Val) begin
                    Dout_57 <= {Dout_57[30:0], Bin_57};
                end
            end
        end
        
        //*******************************************RAM58***************************************
        reg         Bin_58_Val;
        always@(posedge clk)begin
            ADDR_58 <= ADDR_57;
            WEA_58 <= WEA_57;
            Bin_58_Val <= Bin_57_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_58 <= 0;
            end
            else begin
                if(Bin_58_Val) begin
                    Dout_58 <= {Dout_58[30:0], Bin_58};
                end
            end
        end
        
        //*******************************************RAM59***************************************
        reg         Bin_59_Val;
        always@(posedge clk)begin
            ADDR_59 <= ADDR_58;
            WEA_59 <= WEA_58;
            Bin_59_Val <= Bin_58_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_59 <= 0;
            end
            else begin
                if(Bin_59_Val) begin
                    Dout_59 <= {Dout_59[30:0], Bin_59};
                end
            end
        end
        
        //*******************************************RAM60***************************************
        reg         Bin_60_Val;
        always@(posedge clk)begin
            ADDR_60 <= ADDR_59;
            WEA_60 <= WEA_59;
            Bin_60_Val <= Bin_59_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_60 <= 0;
            end
            else begin
                if(Bin_60_Val) begin
                    Dout_60 <= {Dout_60[30:0], Bin_60};
                end
            end
        end
        
        //*******************************************RAM61***************************************
        reg         Bin_61_Val;
        always@(posedge clk)begin
            ADDR_61 <= ADDR_60;
            WEA_61 <= WEA_60;
            Bin_61_Val <= Bin_60_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_61 <= 0;
            end
            else begin
                if(Bin_61_Val) begin
                    Dout_61 <= {Dout_61[30:0], Bin_61};
                end
            end
        end
        
        //*******************************************RAM62***************************************
        reg         Bin_62_Val;
        always@(posedge clk)begin
            ADDR_62 <= ADDR_61;
            WEA_62 <= WEA_61;
            Bin_62_Val <= Bin_61_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_62 <= 0;
            end
            else begin
                if(Bin_62_Val) begin
                    Dout_62 <= {Dout_62[30:0], Bin_62};
                end
            end
        end
        
        //*******************************************RAM63***************************************
        reg         Bin_63_Val;
        always@(posedge clk)begin
            ADDR_63 <= ADDR_62;
            WEA_63 <= WEA_62;
            Bin_63_Val <= Bin_62_Val;
        end
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)begin
                Dout_63 <= 0;
            end
            else begin
                if(Bin_63_Val) begin
                    Dout_63 <= {Dout_63[30:0], Bin_63};
                end
            end
        end
//***************************************************
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        IB_Addr_Contr_B6_work <= 0;
        IB_Addr_Contr_B6_work_Done <= 0;
    end
    else begin
        if(ADDR_31 != 3)begin
            if(Bin_0_Val)
                IB_Addr_Contr_B6_work <= 1;
        end
        else if(ADDR_0 == 3)begin
            IB_Addr_Contr_B6_work <= 0;
            IB_Addr_Contr_B6_work_Done <= 1;
        end
    end
end        

endmodule
