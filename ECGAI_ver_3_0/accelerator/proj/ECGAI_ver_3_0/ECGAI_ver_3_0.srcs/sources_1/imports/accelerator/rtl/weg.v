`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/30 18:31:44
// Design Name: 
// Module Name: weg
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


module weg#(
        parameter WEGREDNUM = 80,
        parameter WEGREGADRWID = 7
    )(
    input                       clk,
    input                       rst_n,
    input                       wwegvld,
    input                       rwegrdy,
    input [31:0]                wwegdata,
    input [WEGREGADRWID-1:0]    wwegaddr,
    input                       wwegfin,
    input [2:0]                 pe_cs,
    input                       rwegolfin,
    output                      wwegrdy,
    output                      rwegvld,
    output reg [191:0]          rwegdata,
    output                      rwegfin
    );
    
    //========== local param ================================//
    
    localparam IDLEW = 2'b00;
    localparam WWEG  = 2'b01;
    localparam IDLER = 2'b10;
    localparam RWEG  = 2'b11;
    
    localparam IDLE    = 3'b000;
    localparam INT_CMP = 3'b001;
    localparam BIN_CMP = 3'b010;
    localparam DEN_CMP = 3'b011;
    localparam DONE    = 3'b100;
    
    //=========== reg & net =================================//
    
    reg [1:0] weg_cs, weg_ns;
    reg [31:0] weg_reg [WEGREDNUM-1:0];
    reg [WEGREGADRWID-1:0] rweg_cnt;
    reg [WEGREGADRWID-1:0] rweg_cnt_max;
    
    //================== state machine =====================//
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            weg_cs <= 'b0;
        end
        else begin
            weg_cs <= weg_ns;
        end
    end
    
    always@(*) begin
        case(weg_cs)
            IDLEW: begin
                weg_ns = wwegvld ? WWEG:IDLEW;
            end
            WWEG: begin
                weg_ns = wwegfin ? IDLER:WWEG;
            end
            IDLER: begin
                weg_ns = rwegrdy ? RWEG: IDLER;
            end
            RWEG: begin
                if(rwegfin) begin
                    if(pe_cs == INT_CMP) begin
                        weg_ns = rwegolfin ? IDLEW:IDLER;
                    end
                    else begin
                        weg_ns = IDLEW;
                    end
                end
                else begin
                    weg_ns = RWEG;
                end
            end
        endcase
    end
    
    //========================valid ready ==========================//
    
    assign wwegrdy = (weg_cs == WWEG);
    assign rwegvld = ((weg_cs == IDLER)||(weg_cs == RWEG));
    
    //============== weg reg =====================================//
    
    generate
        genvar i;
        for(i=0;i<WEGREDNUM;i=i+1'b1) begin: weg_reg_loop
            always@(posedge clk or negedge rst_n) begin
                if(!rst_n) begin
                    weg_reg[i] <= 'b0;
                end
                else if((weg_cs == WWEG)&&(wwegaddr==i)) begin
                    weg_reg[i] <= wwegdata;
                end
            end
        end
    endgenerate
    
    //=================== read weg ===========================//
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            rweg_cnt <= 'b0;
        end
        else if(rwegfin) begin
            rweg_cnt <= 'b0;
        end
        else if(weg_ns == RWEG) begin
            rweg_cnt <= rweg_cnt + 1'b1;
        end
    end
    
    always@(*) begin
        case(pe_cs)
            INT_CMP: begin
                rweg_cnt_max = 7'd20; // 20*4=80
            end
            BIN_CMP: begin
                rweg_cnt_max = 7'd12;
            end
            DEN_CMP: begin
                rweg_cnt_max = 1'b1;
            end
            default: begin
                rweg_cnt_max = 1'b1;
            end
        endcase
    end
    
    assign rwegfin = (rweg_cnt == rweg_cnt_max);
    
    //===================== read weg reg ==========================//
    
    //================ INT CMP  weg read ==========================//
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            rwegdata <= 'b0;
        end
        else if(weg_ns == RWEG) begin
            case(pe_cs)
                INT_CMP:begin
                    rwegdata <= {64'b0, weg_reg[{rweg_cnt[4:0],2'b0}+2'b11], weg_reg[{rweg_cnt[4:0],2'b0}+2'b10], weg_reg[{rweg_cnt[4:0],2'b0}+2'b01], weg_reg[{rweg_cnt[4:0],2'b0}]};
                end
                BIN_CMP,
                DEN_CMP:begin
                    rwegdata <= {weg_reg[3'd5], weg_reg[3'd4], weg_reg[3'd3],
                                 weg_reg[3'd2], weg_reg[3'd1], weg_reg[3'd0]};
                end
                default: begin
                    rwegdata <= 'b0;
                end
            endcase
        end
        else begin
            rwegdata <= 'b0;
        end
    end
    
    
    
    
endmodule
