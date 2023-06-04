`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/26 18:04:07
// Design Name: 
// Module Name: IB_Addr_Contr_B2
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

module IB_Addr_Contr_B2(
    input                        clk,
    input                        rst_n,
    input                        Bin_0, Bin_1, Bin_2, Bin_3, Bin_4, Bin_5, Bin_6, Bin_7,
    output   reg     [31:0]      DIN_0, DIN_1, DIN_2, DIN_3, DIN_4, DIN_5, DIN_6, DIN_7,
    output   reg     [ 4:0]      ADDR,
    output   reg                 WEA,
    output   wire                ENA,
    output   reg                 IB_Addr_Contr_B2_work, IB_Addr_Contr_B2_work_Done 
);



reg     [4:0]   cnt, ADDR_e1;
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt <= 0;
    end
    else if(ADDR_e1 < 29)begin
        cnt <= cnt + 1; //刚好ram宽度32bit,cnt从0计数到31
    end
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        WEA <= 0;
        ADDR_e1 <= 0;
    end
    else begin
        if(cnt == 31)begin
            WEA <= 1;
            ADDR_e1 <= ADDR_e1 + 1;
        end
        else begin
            WEA <= 0;
        end
    end
end
 

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        IB_Addr_Contr_B2_work <= 0;
        IB_Addr_Contr_B2_work_Done <= 0;
    end
    else begin
        if(ADDR_e1 == 0 && cnt == 31)begin
            IB_Addr_Contr_B2_work <= 1;
        end
        else if(ADDR_e1 == 29 && cnt == 0)begin
            IB_Addr_Contr_B2_work <= 0;
            IB_Addr_Contr_B2_work_Done <= 1;
        end
    end
end


assign ENA = WEA;

always@(posedge clk)begin
    ADDR <= ADDR_e1;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        DIN_0 <= 0;
        DIN_1 <= 0;
        DIN_2 <= 0;
        DIN_3 <= 0;
        DIN_4 <= 0;
        DIN_5 <= 0;
        DIN_6 <= 0;
        DIN_6 <= 0;
        DIN_7 <= 0;
    end
    else begin
//        DIN_0 <= {Bin_0, DIN_0[31:1]};这样先进去的数在最右边(LSB)
        DIN_0 <= {DIN_0[30:0], Bin_0};
        DIN_1 <= {DIN_1[30:0], Bin_1};
        DIN_2 <= {DIN_2[30:0], Bin_2};
        DIN_3 <= {DIN_3[30:0], Bin_3};
        DIN_4 <= {DIN_4[30:0], Bin_4};
        DIN_5 <= {DIN_5[30:0], Bin_5};
        DIN_6 <= {DIN_6[30:0], Bin_6};
        DIN_7 <= {DIN_7[30:0], Bin_7};
    end
end

//reg     WE;     //对于SPRAM，WE=1为写入数据，为0则是读出数据



endmodule
