`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/07 20:56:00
// Design Name: 
// Module Name: IB_Addr_Contr_B5
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


module IB_Addr_Contr_B5(
    input                           clk,
    input                           rst_n,
    input         wire              Bin_0, Bin_1, Bin_2, Bin_3, Bin_4, Bin_5, Bin_6, Bin_7, 
                                    Bin_8, Bin_9, Bin_10, Bin_11, Bin_12, Bin_13, Bin_14, Bin_15, 
                                    Bin_16, Bin_17, Bin_18, Bin_19, Bin_20, Bin_21, Bin_22, Bin_23, 
                                    Bin_24, Bin_25, Bin_26, Bin_27, Bin_28, Bin_29, Bin_30, Bin_31,
    input         wire              Bin_0_Val,
    output   reg     [31:0]         Dout_0, Dout_1, Dout_2,  Dout_3,  Dout_4,  Dout_5,  Dout_6,  Dout_7,
                                    Dout_8, Dout_9, Dout_10, Dout_11, Dout_12, Dout_13, Dout_14, Dout_15,
                                    Dout_16, Dout_17, Dout_18, Dout_19, Dout_20, Dout_21, Dout_22, Dout_23, 
                                    Dout_24, Dout_25, Dout_26, Dout_27, Dout_28, Dout_29, Dout_30, Dout_31,
    output   reg     [ 2:0]         ADDR_0, ADDR_1, ADDR_2,  ADDR_3,  ADDR_4,  ADDR_5,  ADDR_6,  ADDR_7, 
                                    ADDR_8, ADDR_9, ADDR_10, ADDR_11, ADDR_12, ADDR_13, ADDR_14, ADDR_15, 
                                    ADDR_16, ADDR_17, ADDR_18, ADDR_19, ADDR_20, ADDR_21, ADDR_22, ADDR_23, 
                                    ADDR_24, ADDR_25, ADDR_26, ADDR_27, ADDR_28, ADDR_29, ADDR_30, ADDR_31,
    output   reg                    WEA_0, WEA_1, WEA_2,  WEA_3,  WEA_4,  WEA_5,  WEA_6,  WEA_7,  
                                    WEA_8, WEA_9, WEA_10, WEA_11, WEA_12, WEA_13, WEA_14, WEA_15, 
                                    WEA_16, WEA_17, WEA_18, WEA_19, WEA_20, WEA_21, WEA_22, WEA_23, 
                                    WEA_24, WEA_25, WEA_26, WEA_27, WEA_28, WEA_29, WEA_30, WEA_31,
    output   reg                    IB_Addr_Contr_B5_work, IB_Addr_Contr_B5_work_Done 
);
//*******************************************RAM0***************************************
reg         [4:0]       addr_cnt_0;
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        addr_cnt_0 <= 0;
    end
    else begin
        if(ADDR_0 < 4)begin
            if(Bin_0_Val) begin
                addr_cnt_0 <= addr_cnt_0 + 1;
            end
        end else if(ADDR_0 == 4)begin
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
        if(ADDR_0 < 4) begin
            if(addr_cnt_0 == 31 && !Bin_0_Val)begin
                ADDR_0_e2 <= ADDR_0_e2 + 1;
                WEA_0_e1 <= 1;
            end
            else begin
                WEA_0_e1 <= 0;
            end
        end else if(ADDR_0 == 4)begin
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
   
//***************************************************
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        IB_Addr_Contr_B5_work <= 0;
        IB_Addr_Contr_B5_work_Done <= 0;
    end
    else begin
        if(ADDR_31 != 4)begin
            if(Bin_0_Val)
                IB_Addr_Contr_B5_work <= 1;
        end
        else if(ADDR_0 == 4)begin
            IB_Addr_Contr_B5_work <= 0;
            IB_Addr_Contr_B5_work_Done <= 1;
        end
    end
end 

   
 
 
endmodule
