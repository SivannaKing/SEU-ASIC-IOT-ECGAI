`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/30 20:04:47
// Design Name: 
// Module Name: ctrl_w
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


module ctrl_w#(
    parameter WEGMEMADRWID = 13,
    parameter WEGREGADRWID = 7
    )(
    input                           clk,
    input                           rst_n,
    input [2:0]                     wweglyrcnt,
    input [31:0]                    wegmemdata,
    input [WEGMEMADRWID-1:0]        rwegmembias,
    input                           wweg0rdy,
    input                           wweg1rdy,
    output                          wegmemena,
    output                          wegmemwea,
    output reg [WEGMEMADRWID-1:0]   wegmemaddr,
    output reg [WEGREGADRWID-1:0]   wwegaddr,
    output                          wweg0vld,
    output                          wweg1vld,
    output reg [31:0]               wweg0data,
    output reg [31:0]               wweg1data,
    output                          wwegfin
    );
    
    //================ local param ============================//
    
    localparam IDLE0 = 2'b00;
    localparam WWEG0 = 2'b01;
    localparam IDLE1 = 2'b10;
    localparam WWEG1 = 2'b11;
    
    //================= reg & net =============================//
    
    reg [1:0] ctrl_w_cs, ctrl_w_ns;
    reg [WEGREGADRWID-1:0] wweg0cnt, wweg1cnt, wweg0cnt_r, wweg0cnt_rr, wweg1cnt_r, wweg1cnt_rr, wweg_cnt_max;
    
    wire wweg0fin, wweg1fin;
    
    //=================== state machine =======================//
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            ctrl_w_cs <= IDLE0;
        end
        else begin
            ctrl_w_cs <= ctrl_w_ns;
        end
    end
    
    always@(*) begin
        case(ctrl_w_cs)
            IDLE0: begin
                ctrl_w_ns = wweg0rdy ? WWEG0 : IDLE0;
            end
            WWEG0: begin
                ctrl_w_ns = wwegfin ? IDLE1 : WWEG0;
            end
            IDLE1: begin
                ctrl_w_ns = wweg1rdy ? WWEG1: IDLE1;
            end
            WWEG1: begin
                ctrl_w_ns = wwegfin ? IDLE0 : WWEG1;
            end
        endcase
    end
    
    //================= valid & ready ==========================//
    
    assign wweg0vld = ((ctrl_w_cs == WWEG0)||(ctrl_w_cs == IDLE0));
    assign wweg1vld = ((ctrl_w_cs == WWEG1)||(ctrl_w_cs == IDLE1));
    
    //=========== weg mem ctrl ================================//
    
    assign wegmemena = ((ctrl_w_cs == WWEG0)||(ctrl_w_cs == WWEG1));
    assign wegmemwea = 1'b0;
    
    always@(*) begin
        if(wweglyrcnt == 'b0) begin
            wweg_cnt_max = 7'd80;
        end
        else if(wweglyrcnt < 3'd5) begin
            wweg_cnt_max = 7'd6;
        end
        else if(wweglyrcnt < 3'd7) begin
            wweg_cnt_max = 7'd6;
        end
        else begin
            wweg_cnt_max = 'b0;
        end
    end
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            wweg0cnt <= 'b0;
        end
        else if((ctrl_w_cs == WWEG0)&&(!wweg0fin)) begin
            wweg0cnt <= wweg0cnt + 1'b1;
        end
        else begin
            wweg0cnt <= 'b0;
        end
    end
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            wweg1cnt <= 'b0;
        end
        else if((ctrl_w_cs == WWEG1)&&(!wweg1fin)) begin
            wweg1cnt <= wweg1cnt + 1'b1;
        end
        else begin
            wweg1cnt <= 'b0;
        end
    end
    
    assign wweg0fin = ((ctrl_w_cs == WWEG0)&&(wweg0cnt == (wweg_cnt_max + 1'b1)));
    assign wweg1fin = ((ctrl_w_cs == WWEG1)&&(wweg1cnt == (wweg_cnt_max + 1'b1)));
    
    assign wwegfin = wweg0fin || wweg1fin ;
    
    //================= ctrl weg mem ========================================//
    
    assign wegmemena = ((ctrl_w_cs == WWEG0)||(ctrl_w_cs == WWEG1));
    assign wegmemwea = 1'b0;
    
    always@(*) begin
        if(ctrl_w_cs == WWEG0) begin
            wegmemaddr = rwegmembias + wweg0cnt;
        end
        else if(ctrl_w_cs == WWEG1) begin
            wegmemaddr = rwegmembias + wweg1cnt;
        end
    end
    
    //===================== write data to weg ===============================//
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            wweg0cnt_r  <= 'b0;
            wweg0cnt_rr <= 'b0;
            wweg1cnt_r  <= 'b0;
            wweg1cnt_rr <= 'b0;
        end
        else begin
            wweg0cnt_r  <= wweg0cnt;
            wweg0cnt_rr <= wweg0cnt_r;
            wweg1cnt_r  <= wweg1cnt;
            wweg1cnt_rr <= wweg1cnt_r;
        end
    end
    
    always@(*) begin
        case(ctrl_w_cs)
            WWEG0: begin
                wwegaddr = wweg0cnt_rr;
            end
            WWEG1: begin
                wwegaddr = wweg1cnt_rr;
            end
            default: begin
                wwegaddr = 'b0;
            end
        endcase
    end
    
    always@(*) begin
        case(ctrl_w_cs)
            WWEG0: begin
                wweg0data = wegmemdata;
                wweg1data = 'b0;
            end
            WWEG1: begin
                wweg0data = 'b0;
                wweg1data = wegmemdata;
            end 
            default: begin
                wweg0data = 'b0;
                wweg1data = 'b0;
            end
        endcase
    end
    
endmodule
