`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:  liu zijin
// 
// Create Date: 2023/03/30 14:56:48
// Design Name: 
// Module Name: ctrl_a
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


module ctrl_a#(
        parameter ACTMEMADRWID = 11,
        parameter ACTREGADRWID = 5
    )(
        input                           clk,
        input                           rst_n,
        input [2:0]                     wswulyrcnt,
        input [31:0]                    swumemdata,
        input [ACTMEMADRWID-1:0]        rswumembias,
        input                           wswu0rdy,
        input                           wswu1rdy,
        input [2:0]                     rlyrcnt,
        input                           wmemnum,                       
        output                          ractmem0ena,
        output                          ractmem1ena,
        output                          ractmem0wea,
        output                          ractmem1wea,
        output [ACTMEMADRWID-1:0]       ractmem0addr,
        output [ACTMEMADRWID-1:0]       ractmem1addr,
        output reg [ACTREGADRWID-1:0]   wswuaddr,
        output                          wswu0vld,
        output                          wswu1vld,
        output reg [31:0]               wswu0data,
        output reg [31:0]               wswu1data,
        output                          wswufin
    );
    
    //============== localparam ======================//
    
    localparam IDLE0 = 2'b00;
    localparam WSWU0 = 2'b01;
    localparam IDLE1 = 2'b10;
    localparam WSWU1 = 2'b11;
    
    
    //============= reg & net ========================//
    
    reg [1:0] ctrl_a_cs, ctrl_a_ns;
    
    reg [ACTREGADRWID-1:0] wswu_cnt_max;
    reg [ACTREGADRWID-1:0] wswu0cnt, wswu1cnt, wswu0cnt_r, wswu1cnt_r, wswu0cnt_rr, wswu1cnt_rr;
    
    wire wswu0fin, wswu1fin;
    
    wire wrrdrdy;
    
    //============ main code ========================//
    
    //=========== main state machine ================//
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            ctrl_a_cs <= IDLE0;
        end
        else begin
            ctrl_a_cs <= ctrl_a_ns;
        end
    end
    
    assign wrrdrdy = (wswulyrcnt[0] != wmemnum);
    
    always@(*) begin
        case(ctrl_a_cs)
            IDLE0: begin
                ctrl_a_ns = wswu0rdy&wrrdrdy ? WSWU0 : IDLE0;
            end
            WSWU0: begin
                ctrl_a_ns = wswufin ? IDLE1 : WSWU0;
            end
            IDLE1: begin
                ctrl_a_ns = wswu1rdy&wrrdrdy ? WSWU1: IDLE1;
            end
            WSWU1: begin
                ctrl_a_ns = wswufin ? IDLE0 : WSWU1;
            end
        endcase
    end
    
    //================= valid & ready ======================//
    
    assign wswu0vld = ((ctrl_a_cs == IDLE0)||(ctrl_a_cs==WSWU0))&(rlyrcnt == wswulyrcnt);
    assign wswu1vld = ((ctrl_a_cs == IDLE1)||(ctrl_a_cs==WSWU1))&(rlyrcnt == wswulyrcnt);
    
    //================= generate wswufin ===================//
    
    always@(*) begin
        case(wswulyrcnt)
            3'd0: begin
                wswu_cnt_max = 5'd20;
            end
            3'd1,
            3'd2,
            3'd3,
            3'd4: begin
                wswu_cnt_max = 5'd14; // TMPWID + KL - 1 
            end
            3'd5: begin
                wswu_cnt_max = 5'd8; // 32* 8 = 256
            end
            3'd6: begin
                wswu_cnt_max = 5'd2; // 32*2= 64
            end
            default: begin
                wswu_cnt_max = 'b0;
            end
        endcase
    end
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            wswu0cnt <= 'b0;
        end
        else if((ctrl_a_cs == WSWU0)&(!wswu0fin)) begin
            wswu0cnt <= wswu0cnt + 1'b1;
        end
        else begin
            wswu0cnt <= 'b0;
        end
    end
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            wswu1cnt <= 'b0;
        end
        else if((ctrl_a_cs == WSWU1)&(!wswu1fin)) begin
            wswu1cnt <= wswu1cnt + 1'b1;
        end
        else begin
            wswu1cnt <= 'b0;
        end
    end
    
    assign wswu0fin = ((wswu0cnt == wswu_cnt_max + 1'b1)&(ctrl_a_cs == WSWU0));
    assign wswu1fin = ((wswu1cnt == wswu_cnt_max + 1'b1)&(ctrl_a_cs == WSWU1));

    assign wswufin = wswu0fin || wswu1fin ;
    
    //=======================================================================//
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            wswu0cnt_r  <= 'b0;
            wswu0cnt_rr <= 'b0;
            wswu1cnt_r  <= 'b0;
            wswu1cnt_rr <= 'b0;
        end
        else begin
            wswu0cnt_r  <= wswu0cnt;
            wswu0cnt_rr <= wswu0cnt_r;
            wswu1cnt_r  <= wswu1cnt;
            wswu1cnt_rr <= wswu1cnt_r;
        end
    end
    
    always@(*) begin
        case(ctrl_a_cs)
            WSWU0: begin
                wswuaddr = wswu0cnt_rr;
            end
            WSWU1: begin
                wswuaddr = wswu1cnt_rr;
            end
            default: begin
                wswuaddr = 'b0;
            end
        endcase
    end
    
    always@(*) begin
        case(ctrl_a_cs)
            WSWU0: begin
                wswu0data = swumemdata;
                wswu1data = 'b0;
            end
            WSWU1: begin
                wswu0data = 'b0;
                wswu1data = swumemdata;
            end
            default: begin
                wswu0data = 'b0;
                wswu1data = 'b0;
            end
        endcase
    end
    
    //=================== ctrl act mem =====================//
    
    //assign ractmem0ena = (ctrl_a_cs == WSWU0);
    assign ractmem0ena = ((ctrl_a_cs == WSWU0)||(ctrl_a_cs == WSWU1))&(!wswulyrcnt[0]);
    assign ractmem1ena = ((ctrl_a_cs == WSWU0)||(ctrl_a_cs == WSWU1))&(wswulyrcnt[0]);
    
    assign ractmem0wea = 1'b0;
    assign ractmem1wea = 1'b0;
    
    assign ractmem0addr =  ctrl_a_cs[1] ? (rswumembias + wswu1cnt) : (rswumembias + wswu0cnt);//rswumembias + wswu0cnt;
    assign ractmem1addr =  ractmem0addr;
    
endmodule
