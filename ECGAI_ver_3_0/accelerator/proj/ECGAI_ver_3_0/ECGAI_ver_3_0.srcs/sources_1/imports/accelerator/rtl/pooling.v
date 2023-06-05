`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/29 16:49:44
// Design Name: 
// Module Name: pooling
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


module pooling#(
    parameter ACTMEMADRWID = 10
    )(
    input                       clk,
    input                       rst_n,
    input [383:0]               peout,
    input                       peouten,
    input [2:0]                 pe_cs,
    //input                       rlyrfin,
    output [ACTMEMADRWID-1:0]   wactmem0addr,
    output [ACTMEMADRWID-1:0]   wactmem1addr,
    output                      wactmem0ena,
    output                      wactmem1ena,
    output                      wactmem0wea,
    output                      wactmem1wea,
    output [31:0]               wactmemdata,
    output                      wmemnum
    );
    
    //===============================================================//
    // param initial
    localparam L0OL = 8'd150;
    localparam L1OL = 8'd75;
    localparam L2OL = 8'd38;
    localparam L3OL = 8'd19;
    localparam L4OL = 8'd1;
    localparam L5OL = 8'd1;
    localparam L6OL = 8'd1;

    localparam L0OC = 9'd32;
    localparam L1OC = 9'd32;
    localparam L2OC = 9'd96;
    localparam L3OC = 9'd96;
    localparam L4OC = 9'd224;
    localparam L5OC = 9'd32;
    localparam L6OC = 9'd5;
    
    // state machine
    localparam IDLE  = 2'b00;
    localparam POL   = 2'b01;
    localparam WMEM  = 2'b10;
    localparam PAD   = 2'b11;
    
    //===============================================================//
    // param initial
    wire [7:0] lyrol [6:0];
    wire [8:0] lyroc [6:0];
    // count lyr ; oc ; ol
    wire wocfin, wolfin;
    wire wmemfin;
    // peout array
    wire [11:0] peout_array [31:0];
    wire [31:0] polout_lines [5:0];
    // wmem
    wire wmemena, wmemwea;
    reg [ACTMEMADRWID-1:0] wmemaddr;
    //wire [31:0] wmemdata;
    
    // count lyr ; oc ; ol
    reg [3:0] wlyrcnt;
    reg [8:0] woccnt;
    reg [7:0] wolcnt;
    
    reg [3:0] wmemcnt;
    
    // state machine
    reg [1:0] polcs, polns;
    
    // pooling
    reg [5:0] polout_array [31:0];
    
    // no pooling
    reg [31:0] nopolout;
    
    //================= param initial ==============================//
    
    assign lyrol[0] = L0OL;
    assign lyrol[1] = L1OL;
    assign lyrol[2] = L2OL;
    assign lyrol[3] = L3OL;
    assign lyrol[4] = L4OL;
    assign lyrol[5] = L5OL;
    assign lyrol[6] = L6OL;
    
    assign lyroc[0] = L0OC;
    assign lyroc[1] = L1OC;
    assign lyroc[2] = L2OC;
    assign lyroc[3] = L3OC;
    assign lyroc[4] = L4OC;
    assign lyroc[5] = L5OC;
    assign lyroc[6] = L6OC;
    
    //====================lyr oc ol cnt     ==========================//
    // lyr
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            wlyrcnt <= 'b0;
        end
        else if(wolfin & wocfin & wmemfin)begin
            wlyrcnt <= wlyrcnt + 1'b1;
        end
    end
    // oc
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            woccnt <= 'b0;
        end
        else if(wolfin&wmemfin) begin
            if(wocfin) begin
                woccnt <= 'b0;
            end
            else begin
                woccnt <= woccnt + 9'd32;
            end
        end
    end   
    // ol
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            wolcnt <= 'b0;
        end
        else if(wmemfin) begin
            if(wolfin) begin
                wolcnt <= 'b0;
            end
            else begin
                wolcnt <= wolcnt + 8'd6;
            end
        end
    end
    //============= state machine =============================//
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            polcs <= PAD;
        end
        else begin
            polcs <= polns;
        end
    end
    
    always@(*) begin
        case(polcs)
            IDLE: begin
                polns = peouten ? POL : IDLE;
            end
            POL: begin
                polns = WMEM;
            end
            WMEM: begin
                polns = wmemfin? (wolfin ? PAD : IDLE) : WMEM;
            end
            PAD: begin
                polns = IDLE;
            end
            default: begin
                polns = IDLE;
            end
        endcase
    end
    
    //=================== pooling =================================//
    
    generate
        genvar i1;
        for(i1=0;i1<32;i1=i1+1) begin: pe_array_loop
           assign peout_array[i1] = peout[(i1*12)+:12];
        end
    endgenerate
    
    generate
        genvar i2;
        for(i2=0;i2<32;i2=i2+1) begin: pol_loop
            always@(posedge clk or negedge rst_n) begin
                if(!rst_n) begin
                    polout_array[i2] <= 'b0;
                end
                else if(polns == POL) begin
                    polout_array[i2] <= {peout_array[i2][11],peout_array[i2][9], peout_array[i2][7],
                                        peout_array[i2][5], peout_array[i2][3], peout_array[i2][1]}|
                                        {peout_array[i2][10],peout_array[i2][8], peout_array[i2][6],
                                        peout_array[i2][4], peout_array[i2][2], peout_array[i2][0]};
                end
            end
        end
    endgenerate
    
    generate
        genvar i3;
        for(i3=0;i3<6;i3=i3+1) begin: pol_line_loop
            assign polout_lines[i3] = {polout_array[31][i3], polout_array[30][i3], polout_array[29][i3], polout_array[28][i3],
                                       polout_array[27][i3], polout_array[26][i3], polout_array[25][i3], polout_array[24][i3],
                                       polout_array[23][i3], polout_array[22][i3], polout_array[21][i3], polout_array[20][i3],
                                       polout_array[19][i3], polout_array[18][i3], polout_array[17][i3], polout_array[16][i3],
                                       polout_array[15][i3], polout_array[14][i3], polout_array[13][i3], polout_array[12][i3],
                                       polout_array[11][i3], polout_array[10][i3], polout_array[9][i3], polout_array[8][i3],
                                       polout_array[7][i3], polout_array[6][i3], polout_array[5][i3], polout_array[4][i3],
                                       polout_array[3][i3], polout_array[2][i3], polout_array[1][i3], polout_array[0][i3]};
        end
    endgenerate
    
    //=================== dense output ================================//
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            nopolout <= 'b0;
        end
        else if(polns == POL) begin
            nopolout <= {peout_array[31][0], peout_array[30][0], peout_array[29][0], peout_array[28][0],
                        peout_array[27][0], peout_array[26][0], peout_array[25][0], peout_array[24][0],
                        peout_array[23][0], peout_array[22][0], peout_array[21][0], peout_array[20][0],
                        peout_array[19][0], peout_array[18][0], peout_array[17][0], peout_array[16][0],
                        peout_array[15][0], peout_array[14][0], peout_array[13][0], peout_array[12][0],
                        peout_array[11][0], peout_array[10][0], peout_array[9][0], peout_array[8][0],
                        peout_array[7][0], peout_array[6][0], peout_array[5][0], peout_array[4][0],
                        peout_array[3][0], peout_array[2][0], peout_array[1][0], peout_array[0][0]};
        end
    end
    
    
    //=============== wmem cnt =======================================================================================================//
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            wmemcnt <= 'b0;
        end
        else if(polcs == WMEM) begin
            if(wmemfin) begin
                wmemcnt <= 'b0;
            end
            else begin
                wmemcnt <= wmemcnt + 1'b1;
            end
        end
        else begin
            wmemcnt <= 'b0;
        end
    end
    
    assign wmemfin = (pe_cs == 3'b011)? 1'b1:(wmemcnt == 3'd5);
    assign wocfin = (woccnt == lyroc[wlyrcnt]);
    assign wolfin = (pe_cs == 3'b011)? 1'b1: ((wolcnt+3'd6) >= lyrol[wlyrcnt]);
    
    
    //=========================wmem ==================================================================================================//
    
    assign wmemwea = 1'b1;
    assign wmemena = (polcs == WMEM)|(polcs == PAD);
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            wmemaddr <= 'b0;
        end
        else if(polcs == PAD) begin
            wmemaddr <= wmemaddr + 1'b1;
        end
        else if(wmemfin) begin
            if(wolfin) begin
                if(wocfin) begin
                    wmemaddr <= 'b0; // finish a lyr
                end
                else begin
                    wmemaddr <= (woccnt[8:5] + 1'b1)*(lyrol[wlyrcnt] + 2'b10);
                end
            end
            else begin
                wmemaddr <= wmemaddr + 3'd6;
            end
        end
        else if(polns == PAD) begin
            wmemaddr <= wmemaddr + 1'b1;
        end
    end
    
    assign wactmemdata = (wlyrcnt > 4'd3) ? nopolout : polout_lines[wmemcnt];
    
    assign wactmem0addr = wmemaddr+wmemcnt;
    assign wactmem1addr = wmemaddr+wmemcnt;
    
    assign wactmem0wea = 1'b1;
    assign wactmem1wea = 1'b1;
    
    assign wactmem0ena = (wlyrcnt[0] == 1'b1)&wmemena;
    assign wactmem1ena = (wlyrcnt[0] == 1'b0)&wmemena;
    
    assign wmemnum = !wlyrcnt[0];
    
endmodule
