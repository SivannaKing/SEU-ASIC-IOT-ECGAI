`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: liu zijin
// 
// Create Date: 2023/03/30 13:40:54
// Design Name: 
// Module Name: swu
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


module swu#(
    parameter SWUREGADRWID = 5,
    parameter SWUREDEPTH   = 20,
    parameter TMPWID       = 12
    )(
        input                       clk,
        input                       rst_n,
        input                       wswuvld,
        input                       rswurdy,
        input [31:0]                wswudata,
        input [SWUREGADRWID-1:0]    wswuaddr,
        input                       wswufin,
        input [2:0]                 pe_cs,
        input                       rswuicfin,
        input [4:0]                 rswuiccnt,
        input [8:0]                 rswuilcnt,
        input                       rlyrfin,
        output                      wswurdy,
        output                      rswuvld,
        output reg [31:0]           intinput,
        output reg [5:0]            bininput,
        //output reg [191:0]          deninput,
        output                      rswufin
    );
    
    //=================== localparam =================//
    
    localparam IDLEW = 2'b00;
    localparam WSWU  = 2'b01;
    localparam IDLER = 2'b10;
    localparam RSWU  = 2'b11;
    
    localparam IDLE    = 3'b000;
    localparam INT_CMP = 3'b001;
    localparam BIN_CMP = 3'b010;
    localparam DEN_CMP = 3'b011;
    localparam AVG_POL = 3'b100;
    
    //=============== reg & net ====================//
    
    wire [287:0] swu_regall;
    
    reg [1:0] swu_cs, swu_ns;
    reg [31:0] swu_reg [SWUREDEPTH-1:0];
    
    reg [SWUREGADRWID-1:0] rswu_cnt;
    reg [SWUREGADRWID-1:0] rswu_cnt_max;
    //======================================//
    
    assign swu_regall = {swu_reg[6],swu_reg[5],swu_reg[4],swu_reg[3],
                        swu_reg[2],swu_reg[1],swu_reg[0]};
    
    //============= main code =====================//
    //=============================================//
    //============ swu state machine ==============//
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            swu_cs <= IDLEW;
        end
        else begin
            swu_cs <= swu_ns;
        end
    end
    
    always@(*) begin
        case(swu_cs)
            IDLEW: begin
                swu_ns = wswuvld ? WSWU : IDLEW;
            end
            WSWU: begin
                swu_ns = wswufin ? IDLER : WSWU;
            end
            IDLER: begin
                swu_ns = rswurdy ? RSWU : IDLER;
            end
            RSWU: begin
                if(rswufin) begin
                    if((pe_cs == BIN_CMP)&&(!rswuicfin)) begin
                        swu_ns = IDLER;
                    end
                    else if(pe_cs == DEN_CMP) begin
                        swu_ns = rlyrfin ? IDLEW: IDLER;
                    end
                    else begin
                        swu_ns = IDLEW;
                    end
                end
                else begin
                    swu_ns = RSWU;
                end
            end
        endcase
    end
    
    //================== valid / ready ===================//
    
    assign wswurdy = (swu_cs == WSWU);
    assign rswuvld = ((swu_cs == IDLER)||(swu_cs == RSWU));
    
    //=============== generate rswufin ==================//
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            rswu_cnt <= 'b0;
        end
        else if(rswufin) begin
            rswu_cnt <= 'b0;
        end
        else if(swu_ns == RSWU) begin
            rswu_cnt <= rswu_cnt + 1'b1;
        end
    end
    
    always@(*) begin
        case(pe_cs)
            INT_CMP: begin
                rswu_cnt_max = 5'd20;
            end
            BIN_CMP: begin
                rswu_cnt_max = TMPWID;
            end
            DEN_CMP: begin
                rswu_cnt_max = 1'b1;
            end
            default: begin
                rswu_cnt_max = 1'b1;
            end
        endcase
    end
    
    assign rswufin = (rswu_cnt == rswu_cnt_max );
    
    //============== swu reg =================================//
    
    generate
        genvar i;
        for(i=0;i<SWUREDEPTH;i=i+1'b1) begin: swu_reg_gen
            always@(posedge clk or negedge rst_n) begin
                if(!rst_n) begin
                    swu_reg[i] <= 'b0;
                end
                else if((swu_cs == WSWU)&(wswuaddr == i)) begin
                    swu_reg[i] <= wswudata;
                end
            end
        end
    endgenerate
    
    //=================== read swu reg ====================//
    
    //=============== read intinput =======================//
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            intinput <= 'b0;
        end
        else if((pe_cs == INT_CMP)&(swu_ns == RSWU)) begin
            intinput <= swu_reg[rswu_cnt];
        end
        else begin
            intinput <= 'b0;
        end
    end
    
    //============= read bin input ==========================//
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            bininput <= 'b0;
        end
        else if((pe_cs == BIN_CMP)&(swu_ns == RSWU)) begin
            bininput <= {swu_reg[rswu_cnt][rswuiccnt], swu_reg[rswu_cnt+2'b01][rswuiccnt], 
                        swu_reg[rswu_cnt+2'b10][rswuiccnt],swu_reg[rswu_cnt][rswuiccnt+1'b1], 
                        swu_reg[rswu_cnt+2'b01][rswuiccnt+1'b1], swu_reg[rswu_cnt+2'b10][rswuiccnt+1'b1]};
        end
        else if((pe_cs == DEN_CMP)&(swu_ns == RSWU)) begin
            //bininput <= {swu_reg[rswuilcnt[8:5]][rswuilcnt[4:0] +:6]};
            bininput <= swu_regall[rswuilcnt+:6];
        end
        else begin
            bininput <= 'b0;
        end
    end
    
    //============= read den input ===========================//
    /*
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            deninput <= 'b0;
        end
        else if((pe_cs == DEN_CMP)&(swu_cs == RSWU)) begin
            deninput <= {swu_reg[0], swu_reg[1], swu_reg[2],
                         swu_reg[3], swu_reg[4], swu_reg[5]};
        end
    end
    */
    
    
    
endmodule
