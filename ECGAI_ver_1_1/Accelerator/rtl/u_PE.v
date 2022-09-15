// *****************************************************************************
// @Project Name : ECG_CPU
// @Author       : Huangjunguang
// @Email        : huangjunguang@seu.edu.cn
// @File Name    : u_PE.v
// @Module Name  : u_PE
// @Created Time : 2020-05-21 12:46
//
// @Abstract     : PE computing unit for MAC
//
//
// Modification History
// *************************************************************************
// Date			BY         		Version		Change Description
// -------------------------------------------------------------------------
// 2020-05-21  	Huangjunguang   v1.0        initial version
// 2020-06-03	Huangjunguang	v2.0		change  the way to cut off
// 2020-06-08	Huangjunguang   v2.0		change K to Calcycle
// 2021-09-10	wzx				v2.1		add eng annotations
// *************************************************************************
`timescale 1ns / 1ns
`define byte_width 8
`define halfword_width 16

module u_PE (
    input                       clk_cal,
    input                       rst_cal_n,
    input [    `byte_width-1:0] IWeight,
    input [    `byte_width-1:0] IMap,
    input                       ImapVld,
    input                       IweightVld,
    input                       INextPE_OMapVld,
    input [`halfword_width-1:0] INextPE_OMap,
    input [               10:0] Calcycle,         // = K*K*IChannel

    output [`halfword_width-1:0] OMap,
    output [    `byte_width-1:0] ONextPE_Map,
    output                       OMapVld,
    output                       ONextPE_MapVld
);

    reg  [10:0] MultiCount;
    wire        I_CalDataVld;

    assign I_CalDataVld = ImapVld & IweightVld;


    // *********************************************************************
    // MAC
    // *********************************************************************
    reg [`halfword_width-1:0] data_B_R;
    wire [`halfword_width-1:0] Multi, PEsum, data_B;
    wire [`halfword_width-1:0] Sum_a;
    wire [`halfword_width-1:0] Sum_m;

    // 8bits multiplier
    mul u_mul (
        .a       (IMap),
        .b       (IWeight),
        .data_out(Sum_m)
    );

    assign Multi  = (I_CalDataVld == 1'b1) ? Sum_m : 16'b0;
    assign data_B = data_B_R;  // sum reg

    // Ripple-Carry Adder
    RCA u_RCA (
        .A  (Multi),
        .B  (data_B),
        .out(Sum_a)
    );

    assign PEsum = (I_CalDataVld == 1'b1) ? Sum_a : 16'b0;

    // save current sum result into reg
    always @(negedge rst_cal_n or posedge clk_cal) begin
        if (!rst_cal_n) begin
            MultiCount <= 0;
            data_B_R   <= 0;
        end else begin
            if (I_CalDataVld) begin
                MultiCount <= MultiCount + 1;
                data_B_R   <= PEsum;
                if (MultiCount == (Calcycle - 1)) begin
                    MultiCount <= 0;
                    data_B_R   <= 0;
                end
            end
        end
    end


    // *********************************************************************
    // systolic array: transmit IMap to the next cycle PEs
    // *********************************************************************
    reg                   IMapVld_R;
    reg [`byte_width-1:0] ONextPE_Map_R;

    // save IMap into reg
    always @(negedge rst_cal_n or posedge clk_cal) begin
        if (!rst_cal_n) begin
            IMapVld_R     <= 0;
            ONextPE_Map_R <= 8'b0;
        end else begin
            if (I_CalDataVld) begin
                IMapVld_R <= 1'b1;
                ONextPE_Map_R <= IMap;
            end else begin
                IMapVld_R     <= 0;
                ONextPE_Map_R <= 8'b0;
            end
        end
    end

    // transmit
    assign ONextPE_MapVld = (IMapVld_R) ? 1'b1 : 0;
    assign ONextPE_Map = (ONextPE_MapVld == 1'b1) ? ONextPE_Map_R : 0;


    // *********************************************************************
    // systolic array: transmit result to the upper PE
    // *********************************************************************
    reg [`halfword_width-1:0] INextPE_OMap_R;
    wire sendflag, send_sel;

    // send PE result flag
    assign sendflag = (MultiCount == (Calcycle - 1) || INextPE_OMapVld == 1) ? 1'b1 : 0;
    assign OMapVld  = sendflag;

    // save PE result into reg
    always @(negedge rst_cal_n or posedge clk_cal) begin
        if (!rst_cal_n) begin
            INextPE_OMap_R <= 0;
        end else begin
            if (sendflag == 1'b1) begin
                INextPE_OMap_R <= INextPE_OMap;
            end else begin
                INextPE_OMap_R <= 0;
            end
        end
    end

    // send PE result to the upper PE
    assign send_sel = (MultiCount == (Calcycle - 1)) ? 1'b1 : 0;  // send PEsum
    assign OMap = (send_sel == 1 && sendflag == 1'b1) ? PEsum : INextPE_OMap_R;

endmodule
