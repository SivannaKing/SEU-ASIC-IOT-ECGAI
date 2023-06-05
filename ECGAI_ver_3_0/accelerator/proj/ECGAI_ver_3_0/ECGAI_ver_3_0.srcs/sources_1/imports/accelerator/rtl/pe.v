`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/02 22:01:00
// Design Name: 
// Module Name: pe
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


module pe#(
        parameter TMPWID = 12,
        parameter MIDWID = 11
    )(
    input                                   clk,
    input                                   rst_n,
    input           [5:0]                   bininput,
    input           [31:0]                  intinput,
    input           [5:0]                   binweight,
    input                                   out_en,
    input                                   pe_en,
    input                                   sel,
    input           [$clog2(TMPWID)-1:0]    accsel,
    input   signed  [MIDWID-1:0]            threshold,  
    input                                   avg_pol_signal,                        
    output  reg     [TMPWID-1:0]            binout,
    output  signed  [11:0]                  classout
    );
    //================ reg & net ========================//
   
    
    wire signed [7:0] intmulti [3:0];
   
    // first stage
    reg signed [3:0] binmulti; 
    reg signed [MIDWID-1:0] intmultisum;
    reg out_en_r;
    reg [$clog2(TMPWID)-1:0] accsel_r;
    reg pe_en_r;
    
    reg signed [MIDWID-1:0] tmpvalue    [TMPWID-1:0];

    
    reg signed [11:0] classout_reg;
    
    //==================================================//
    
    wire signed [10:0] thre_new;
    
    assign thre_new = avg_pol_signal ? (threshold * 5'd18): threshold;
    
    //==================================================//
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            classout_reg <= 'b0;
        end
        else if(out_en) begin
            classout_reg <= tmpvalue [0];
        end
    end
    
    assign classout = classout_reg;
    
    //==================================================//
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            out_en_r    <= 1'b0;
            accsel_r    <= 'b0;
            pe_en_r     <= 'b0;
        end
        else begin
            out_en_r    <= out_en;
            accsel_r    <= accsel;
            pe_en_r     <= pe_en;
        end
    end
    
    
    //============== pipeline first statge ==============//
        
    //================== bin multi ======================//
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            binmulti <= 'b0;
        end
        else if(sel&pe_en) begin
            binmulti <= binxnor(bininput, binweight);
        end
        else begin
            binmulti <= 'b0;
        end
    end
    
    //==================== int multi ====================//
    
    assign intmulti[0] = $signed(binintxnor(intinput[0+:8], binweight[0]));
    assign intmulti[1] = $signed(binintxnor(intinput[8+:8], binweight[1]));
    assign intmulti[2] = $signed(binintxnor(intinput[16+:8], binweight[2]));
    assign intmulti[3] = $signed(binintxnor(intinput[24+:8], binweight[3]));
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            intmultisum <= 'b0;
        end
        else if(!sel) begin
            intmultisum <= intmulti[0] + intmulti[1] + intmulti[2] + intmulti[3];
        end
    end

    
    function signed [3:0] binxnor;
        input [5:0] binin;
        input [5:0] binweg;
        reg [5:0] inxnorweg;
        reg [2:0] inxnorwegsum;
        reg signed [3:0] realsum;
        begin
            inxnorweg       = binin^~binweg;
            inxnorwegsum    = {2'b0,inxnorweg[0]} + {2'b0,inxnorweg[1]} + {2'b0,inxnorweg[2]}
                            + {2'b0,inxnorweg[3]} + {2'b0,inxnorweg[4]} + {2'b0,inxnorweg[5]};
            binxnor        =  $signed({inxnorwegsum,1'b0}) - $signed(4'd6);
        end
    endfunction
    
    function [7:0] binintxnor;
        input [7:0] intin;
        input binweg;
        begin
            binintxnor = binweg ? intin : (~intin + 1'b1);
        end
    endfunction
    
    //============== pipeline second statge ==============//
    
    generate
        genvar i;
        for(i=0;i<TMPWID;i=i+1'b1) begin: tmpvalue_loop
            always@(posedge clk or negedge rst_n) begin
                if(!rst_n) begin
                    tmpvalue[i] <= 'b0;
                end
                else if(out_en_r) begin
                    tmpvalue[i] <= 'b0;
                end
                else if((accsel_r == i)&pe_en_r) begin
                    tmpvalue[i] <= tmpvalue[i] + (sel?binmulti :intmultisum);
                end
            end
        end
    endgenerate
    
    
    //============== pipeline third stage =====================//
    
    generate
        genvar j;
        for(j=0;j<TMPWID;j=j+1) begin
            always@(posedge clk or negedge rst_n) begin
                if(!rst_n) begin
                    binout[j] <= 1'b0;
                end
                else if(out_en_r) begin
                    binout[j] <= (tmpvalue[j]>thre_new);
                end
                else begin
                    binout[j] <= 1'b0;
                end
            end
        end
    endgenerate
    
    
endmodule
