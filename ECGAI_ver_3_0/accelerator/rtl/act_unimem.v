`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/30 18:09:29
// Design Name: 
// Module Name: act_unimem
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


module act_unimem#(
        parameter ACTMEMADRWID = 10
    )(
    input                       clk,
    input                       rst_n,
    input                       ractmem0ena,
    input                       ractmem1ena,
    input                       ractmem0wea,
    input                       ractmem1wea,
    input                       wactmem0ena,
    input                       wactmem1ena,
    input                       wactmem0wea,
    input                       wactmem1wea,
    input [ACTMEMADRWID-1:0]    ractmem0addr,
    input [ACTMEMADRWID-1:0]    ractmem1addr,
    input [ACTMEMADRWID-1:0]    wactmem0addr,
    input [ACTMEMADRWID-1:0]    wactmem1addr,
    input  [31:0]               wactmemdata,
    //==========bram ctrl ======================//
    //input  [14:0]               bram_addr_a,
    //input  [31:0]               bram_wrdata_a,
    //input                       bram_en_a,
    //input                       bram_we_a,
    //==========================================//
    output [31:0]               swumemdata
    );
    
    wire [31:0] swumem0data, swumem1data;
    wire [ACTMEMADRWID-1:0] actmem0addr, actmem1addr;
    wire actmem0ena, actmem0wea, actmem1ena, actmem1wea;
    
    wire [31:0] wactdata;
    
    //assign wactdata = bram_en_a ? bram_wrdata_a : wactmemdata;
    assign wactdata =  wactmemdata;
    
    assign actmem0ena = ractmem0ena || wactmem0ena;
    assign actmem1ena = ractmem1ena || wactmem1ena;
    
    assign actmem0wea = wactmem0ena ? 1'b1 : 1'b0;
    assign actmem1wea = wactmem1ena ? 1'b1 : 1'b0;
    
    assign swumemdata = ractmem0ena ? swumem0data : swumem1data;
    
    assign actmem0addr = ractmem0ena ? ractmem0addr : wactmem0addr;
    assign actmem1addr = ractmem1ena ? ractmem1addr : wactmem1addr;
    
    
    act_mem_0 u_act_mem0(
         .clka(clk),
         .ena(actmem0ena), // enable
         .wea(actmem0wea), // 0 rd 1 wr
         .addra(actmem0addr),
         .dina(wactdata),
         .douta(swumem0data)
    );
    
    act_mem_1 u_act_mem1(
         .clka(clk),
         .ena(actmem1ena), // enable
         .wea(actmem1wea), // 0 rd 1 wr
         .addra(actmem1addr),
         .dina(wactdata),
         .douta(swumem1data)
    );
    
endmodule
