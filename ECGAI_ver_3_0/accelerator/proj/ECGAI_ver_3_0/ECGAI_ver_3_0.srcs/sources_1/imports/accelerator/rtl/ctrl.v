`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/30 21:22:14
// Design Name: 
// Module Name: ctrl
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


module ctrl#(
    parameter WEGMEMADRWID = 13,
    parameter ACTMEMADRWID = 11,
    parameter TMPWID       = 12,
    parameter KS0          = 12
    )(
    input                           clk,
    input                           rst_n,
    input                           wswufin,
    input                           wwegfin,
    //input   [2:0]                   rlyrcnt,
    output reg [2:0]                wswulyrcnt,
    output reg [2:0]                wweglyrcnt,
    output reg [ACTMEMADRWID-1:0]   rswumembias,
    output reg [WEGMEMADRWID-1:0]   rwegmembias
    );
    
    //==================local param ========================//
    
    // ol max
    localparam LYR0OL = 9'd300;
    localparam LYR1OL = 9'd150;
    localparam LYR2OL = 9'd75;
    localparam LYR3OL = 9'd37;
    localparam LYR4OL = 9'd18;
        
    //ic max
    localparam LYR0IC = 8'd1;
    localparam LYR1IC = 8'd64;
    localparam LYR2IC = 8'd64;
    localparam LYR3IC = 8'd128;
    localparam LYR4IC = 8'd128;
        
    //oc max
    localparam LYR0OC = 9'd64;
    localparam LYR1OC = 9'd64;
    localparam LYR2OC = 9'd128;
    localparam LYR3OC = 9'd128;
    localparam LYR4OC = 9'd256;
    
    localparam LYR1IL = 8'd150;
    localparam LYR2IL = 8'd75;
    localparam LYR3IL = 8'd37;
    localparam LYR4IL = 8'd18;
    
    // act mem lyr bias
    //localparam LYR0ACTBIAS = 11'd0;
    //localparam LYR2ACTBIAS = 11'd900; // 3600/4 32bit = 4* 8bit
    //localparam LYR4ACTBIAS = 11'd150 + LYR2ACTBIAS;//75*64/32=150
    //localparam LYR6ACTBIAS = 11'd2 + LYR4ACTBIAS;
    
    //localparam LYR1ACTBIAS = 11'd0;
    //localparam LYR3ACTBIAS = 11'd300;// ic:64 il:150 => 64*150/32 = 300
    //localparam LYR5ACTBIAS = 11'd8 + LYR3ACTBIAS; // 256/32=8
    
    // weg mem lyr bias
    localparam LYR0WEGBIAS = 13'd0;
    localparam LYR1WEGBIAS = 13'd160; // 80*64/32 = 160
    localparam LYR2WEGBIAS = 13'd384 + LYR1WEGBIAS; //64*64*3/32
    localparam LYR3WEGBIAS = 13'd768 + LYR2WEGBIAS; //64*128*3/32
    localparam LYR4WEGBIAS = 13'd1536 + LYR3WEGBIAS;//128*128*3/32
    localparam LYR5WEGBIAS = 13'd3072 + LYR4WEGBIAS;//128*256*3/32
    localparam LYR6WEGBIAS = 13'd512 + LYR5WEGBIAS; // 256*64/32
    
    //============= reg & wire ============================//
    
    // write swu
    reg wswu_ic_fin, wswu_ol_fin, wswu_oc_fin;
    
    reg wswulyrfin;
    
    reg [8:0] wswu_oc_cnt, wswu_ic_cnt, wswu_ol_cnt;
    reg [8:0] wswu_oc_max, wswu_ic_max, wswu_ol_max;
    
    wire [10:0] lyractbias [6:0];
    wire [7:0] lyril [6:0]; // used for compute act address
    
    // write weg
    reg  wweg_ic_fin, wweg_oc_fin, wweg_den_il_fin, wweg_den_ol_fin, wweg_ol_fin;
    
    reg wweglyrfin;
    
    reg [8:0] wweg_oc_cnt, wweg_ic_cnt, wweg_den_il_cnt, wweg_den_ol_cnt;
    reg [8:0] wweg_oc_max, wweg_ic_max, wweg_den_il_max, wweg_den_ol_max;
    
    wire [WEGMEMADRWID-1:0] lyrwegbias [6:0];
    
    reg [8:0] wweg_ol_cnt;
    reg [8:0] wweg_ol_max; 
    
    wire [9:0] lyriclen [6:0];
    
    
    //=============== count write swu ======================//
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            wswulyrcnt <= 'b0;
        end
        else if(wswulyrfin) begin
            wswulyrcnt <= wswulyrcnt + 1'b1;
        end
    end
    
    //===============================================================//
    // lyr = 0; ol_fin => oc+32 ; oc_fin => lyr_fin
    // lyr = 1~4: ic_fin => ol + TMPWID; ol_fin => oc+32; oc_fin => lyr_fin
    // lyr 5,6: wswufin => lyr_fin
    //============  write swu ol count ==============================//
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            wswu_ol_cnt <= 'b0;
        end
        else if(wswufin) begin
            if(wswulyrcnt == 3'd0) begin
                if(wswu_ol_fin) begin
                    wswu_ol_cnt <= 'b0;
                end
                else begin
                    wswu_ol_cnt <= wswu_ol_cnt + 1'b1;
                end
            end
            else if (wswulyrcnt < 3'd5) begin
                if(wswu_ic_fin) begin
                    if(wswu_ol_fin) begin
                        wswu_ol_cnt <= 'b0;
                    end
                    else begin
                        wswu_ol_cnt <= wswu_ol_cnt + TMPWID;
                    end
                end
            end
        end
    end
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            wswu_ol_max <= LYR0OL - 1'b1;
        end
        else if(wswulyrfin) begin
            case(wswulyrcnt)
                3'd0: begin
                    wswu_ol_max <= LYR1OL - TMPWID;
                end
                3'd1: begin
                    wswu_ol_max <= LYR2OL - TMPWID;
                end
                3'd2: begin
                    wswu_ol_max <= LYR3OL - TMPWID;
                end
                3'd3: begin
                    wswu_ol_max <= LYR4OL - TMPWID;
                end
                default: begin
                    wswu_ol_max <= 'b0;
                end
            endcase
        end
    end
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            wswu_ol_fin <= 1'b0;
        end
        else if(wswu_ol_cnt >= wswu_ol_max) begin
            wswu_ol_fin <= 1'b1;
        end
        else begin
            wswu_ol_fin <= 1'b0;
        end
    end
    
    //assign wswu_ol_fin = (wswu_ol_cnt >= wswu_ol_max );
    
    //============  write swu ic count ==============================//
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            wswu_ic_cnt <= 'b0;
        end
        else if(wswulyrcnt == 'b0) begin
            wswu_ic_cnt <= 'b0;
        end
        else if(wswulyrcnt < 3'd5) begin
            if(wswufin) begin
                if(wswu_ic_fin) begin
                    wswu_ic_cnt <= 'b0;
                end
                else begin
                    wswu_ic_cnt <= wswu_ic_cnt + 6'd32;
                end
            end
        end
        else begin
            wswu_ic_cnt <= 'b0;
        end
    end

    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            wswu_ic_max <= 'b0;
        end
        else if(wswulyrfin) begin
                case(wswulyrcnt)
                    3'd0: begin
                        wswu_ic_max <= LYR1IC - 6'd32;
                    end
                    3'd1: begin
                        wswu_ic_max <= LYR2IC - 6'd32;
                    end
                    3'd2: begin
                        wswu_ic_max <= LYR3IC - 6'd32;
                    end
                    3'd3: begin
                        wswu_ic_max <= LYR4IC - 6'd32;
                    end
                    default: begin
                        wswu_ic_max <= 'b0;
                    end
                endcase            
        end
    end
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            wswu_ic_fin <= 1'b0;
        end
        else if(wswu_ic_cnt >= wswu_ic_max) begin
            wswu_ic_fin <= 1'b1;
        end
        else begin
            wswu_ic_fin <= 1'b0;
        end
    end
    
    //assign wswu_ic_fin = (wswu_ic_cnt >= wswu_ic_max);
    
    //============  write swu oc count ==============================//
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            wswu_oc_cnt <= 'b0;
        end
        else if(wswulyrcnt == 3'd0) begin
            if(wswu_ol_fin & wswufin) begin
                if(wswu_oc_fin) begin
                    wswu_oc_cnt <= 'b0; 
                end
                else begin
                    wswu_oc_cnt <= wswu_oc_cnt + 6'd32;
                end
            end
        end
        else if(wswulyrcnt < 3'd5) begin
            if(wswufin & wswu_ic_fin & wswu_ol_fin) begin
                if(wswu_oc_fin) begin
                    wswu_oc_cnt <= 'b0;
                end
                else begin
                    wswu_oc_cnt <= wswu_oc_cnt + 6'd32;
                end
            end
        end
    end
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            wswu_oc_max <= LYR0OC - 6'd32;
        end
        else if(wswulyrfin) begin
                case(wswulyrcnt)
                    3'd0: begin
                        wswu_oc_max <= LYR1OC - 6'd32;
                    end
                    3'd1: begin
                        wswu_oc_max <= LYR2OC - 6'd32;
                    end
                    3'd2: begin
                        wswu_oc_max <= LYR3OC - 6'd32;
                    end
                    3'd3: begin
                        wswu_oc_max <= LYR4OC - 6'd32;
                    end
                    default: begin
                        wswu_oc_max <= 'b0;
                    end
                endcase            
        end
    end
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            wswu_oc_fin <= 1'b0;
        end
        else if(wswu_oc_cnt >= wswu_oc_max) begin
            wswu_oc_fin <= 1'b1;
        end
        else begin
            wswu_oc_fin <= 1'b0;
        end
    end
    
    //assign wswu_oc_fin = (wswu_oc_cnt >= wswu_oc_max);
    
    //====================================================//
    
    
    //====================================================//
    
    always@(*) begin
        case(wswulyrcnt)
            3'd0: begin
                wswulyrfin = wswufin & wswu_ol_fin & wswu_oc_fin;
            end
            3'd1,
            3'd2,
            3'd3,
            3'd4: begin
                wswulyrfin = wswufin & wswu_ic_fin & wswu_oc_fin & wswu_ol_fin;
            end
            3'd5,
            3'd6: begin
                wswulyrfin = wswufin;
            end
            default: begin
                wswulyrfin = 1'b0;
            end
        endcase
    end
    
    //==================== read act mem addr bias =========================//
    // lyr=0;    addrbias = lyrbias + ol_cnt * KS0
    // lyr=1~4:  addrbias = lyrbias + (ic_cnt/32)*KL + ol_cnt*KS
    // lyr=5,6:  addrboas = lyrbias + il_cnt
    //====================================================================//
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            rswumembias <= 'b0;
        end
        else if(wswufin) begin
            case(wswulyrcnt)
                3'd0: begin
                    if(wswu_ol_fin) begin
                        rswumembias <= 'b0;
                    end
                    else begin
                        rswumembias <= rswumembias + 3'd3;//  wswu finished => ol+1 => il+KS0
                    end
                end
                3'd1,
                3'd2,
                3'd3,
                3'd4: begin
                    if(wswu_ic_fin) begin
                        if(wswu_ol_fin) begin
                            rswumembias <='b0;
                        end
                        else begin
                            rswumembias <= wswu_ol_cnt + TMPWID;
                        end
                    end
                    else begin
                        if(wswu_ol_fin) begin
                            rswumembias <= lyril[wswulyrcnt]*wswu_ic_cnt[8:5];
                        end
                        else begin
                            rswumembias <= wswu_ol_cnt + TMPWID;
                        end
                    end
                end
                3'd5: begin
                    if(wswufin) begin
                        rswumembias <= 'b0;
                    end
                end
                default: begin
                    rswumembias <= 'b0;
                end
            endcase
        end
    end
    
    //====================================================================//

      //assign  lyractbias[0] = LYR0ACTBIAS;
      //assign  lyractbias[1] = LYR1ACTBIAS;
      //assign  lyractbias[2] = LYR2ACTBIAS;
      //assign  lyractbias[3] = LYR3ACTBIAS;
      //assign  lyractbias[4] = LYR4ACTBIAS;
      //assign  lyractbias[5] = LYR5ACTBIAS;
      //assign  lyractbias[6] = LYR6ACTBIAS;

    
   
     assign   lyril[0] = 'b0;
     assign   lyril[1] = LYR1IL;
     assign   lyril[2] = LYR2IL;
     assign   lyril[3] = LYR3IL;
     assign   lyril[4] = LYR4IL;
     assign   lyril[5] = 'b0;
     assign   lyril[6] = 'b0;

    
    //====================================================================//
    
    //====================== count wirte weg =============================//
    //lyr=0:   wwegfin => oc_cnt + 32; oc_fin = > lyr_fin
    //lyr=1~4: wwegfin => ic_cnt + 2; ic_fin = > oc_cnt + 32 ; oc_fin => lyrfin
    //lyr=5,6: wwegfin => il_cnt + 6; il_fin => ol+32; ol_fin =>lyrfin
    //====================================================================//
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            wweglyrcnt <= 'b0;
        end
        else if(wweglyrfin) begin
            wweglyrcnt <= wweglyrcnt + 1'b1;
        end
    end
    
    //=======================  write weg ic count =======================//
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            wweg_ic_cnt <= 'b0;
        end
        else if(wweglyrcnt == 3'd0) begin
            wweg_ic_cnt <= 'b0;
        end
        else if(wweglyrcnt < 3'd5) begin
            if(wwegfin) begin
                if(wweg_ic_fin) begin
                    wweg_ic_cnt <= 'b0;
                end
                else begin
                    wweg_ic_cnt <= wweg_ic_cnt + 2'b10;
                end
            end
        end
        else begin
            wweg_ic_cnt <= 'b0;
        end
    end
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            wweg_ic_max <= 3'b0;
        end
        else if(wweglyrfin) begin
            case(wweglyrcnt)
                3'd0: begin
                    wweg_ic_max <= LYR1IC - 2'd2;
                end
                3'd1: begin
                    wweg_ic_max <= LYR2IC - 2'd2;
                end
                3'd2: begin
                    wweg_ic_max <= LYR3IC - 2'd2;
                end
                3'd3: begin
                    wweg_ic_max <= LYR4IC - 2'd2;
                end
                default: begin
                    wweg_ic_max <= 3'd0;
                end
            endcase
        end
    end
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            wweg_ic_fin <= 1'b0;
        end
        else if( wweg_ic_cnt >= wweg_ic_max) begin
            wweg_ic_fin <= 1'b1;
        end
        else begin
            wweg_ic_fin <= 1'b0;
        end
    end
    
    //======================= wweg oc count =============================//
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            wweg_oc_cnt <= 'b0;
        end
        else if(wwegfin) begin
            if(wweglyrcnt == 3'd0) begin
                if(wweg_oc_fin) begin
                    wweg_oc_cnt <= 'b0;
                end
                else begin
                    wweg_oc_cnt <= wweg_oc_cnt + 6'd32;
                end
            end
            else if(wweglyrcnt < 3'd5) begin
                if(wweg_ic_fin & wweg_ol_fin) begin
                    if(wweg_oc_fin) begin
                        wweg_oc_cnt <= 'b0;
                    end
                    else begin
                        wweg_oc_cnt <= wweg_oc_cnt + 6'd32;
                    end
                end
            end
            else begin
                wweg_oc_cnt <= 'b0;
            end
        end
    end
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            wweg_oc_max <= LYR0OC - 6'd32;
        end
        else if(wweglyrfin) begin
            case(wweglyrcnt)
                3'd0: begin
                    wweg_oc_max <= LYR1OC - 6'd32;
                end
                3'd1: begin
                    wweg_oc_max <= LYR2OC - 6'd32;
                end
                3'd2: begin
                    wweg_oc_max <= LYR3OC - 6'd32;
                end
                3'd3: begin
                    wweg_oc_max <= LYR4OC - 6'd32;
                end
                default: begin
                    wweg_oc_max <= 'b0;
                end
            endcase
        end
    end
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            wweg_oc_fin <= 1'b0;
        end
        else if(wweg_oc_cnt >= wweg_oc_max) begin
            wweg_oc_fin <= 1'b1;
        end
        else begin
            wweg_oc_fin <= 1'b0;
        end
    end
    
    //================= wweg ol count =========================//
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            wweg_ol_cnt <= 'b0;
        end
        else if(wwegfin) begin
            case(wweglyrcnt)
                3'd1,
                3'd2,
                3'd3,
                3'd4: begin
                    if(wweg_ic_fin) begin
                        if(wweg_ol_fin) begin
                            wweg_ol_cnt <= 'b0;
                        end
                        else begin
                            wweg_ol_cnt <= wweg_ol_cnt + TMPWID;
                        end
                    end
                end
                default: begin
                    wweg_ol_cnt <= 'b0;
                end
            endcase
        end
    end
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            wweg_ol_max <= 'b0;
        end
        else if(wweglyrfin) begin
            case(wweglyrcnt)
                3'd0: begin
                    wweg_ol_max <= LYR1OL - TMPWID;
                end
                3'd1: begin
                    wweg_ol_max <= LYR2OL - TMPWID;
                end
                3'd2: begin
                    wweg_ol_max <= LYR3OL - TMPWID;
                end
                3'd3: begin
                    wweg_ol_max <= LYR4OL - TMPWID;
                end
                default: begin
                    wweg_ol_max <= 'b0;
                end
            endcase
        end
    end
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            wweg_ol_fin <= 1'b0;
        end
        else if(wweg_ol_cnt >= wweg_ol_max) begin
            wweg_ol_fin <= 1'b1;
        end
        else begin
            wweg_ol_fin <= 1'b0;
        end
    end
    
    //================den weg count ==========================//
    
    //=============== den weg il count =======================//
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            wweg_den_il_cnt <= 'b0;
        end
        else if(wwegfin &(wweglyrcnt > 3'd4)) begin
            if(wweg_den_il_fin) begin
                wweg_den_il_cnt <= 'b0;
            end
            else begin
                wweg_den_il_cnt <= wweg_den_il_cnt + 3'd6;
            end
        end
    end
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            wweg_den_il_fin <= 1'b0;
        end
        else begin
            case(wweglyrcnt)
                3'd5: begin
                    if(wweg_den_il_cnt >= 9'd250) begin
                        wweg_den_il_fin <= 1'b1;
                    end
                    else begin
                        wweg_den_il_fin <= 1'b0;
                    end
                end
                3'd6: begin
                   if(wweg_den_il_cnt >= 9'd58) begin
                        wweg_den_il_fin <= 1'b1;
                   end
                   else begin
                        wweg_den_il_fin <= 1'b0;
                   end 
                end
                default: begin
                    wweg_den_il_fin <= 1'b0;
                end
            endcase
        end
    end
    
    //================= den weg ol cnt =============================//
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            wweg_den_ol_cnt <= 'b0;
        end
        else if((wweglyrcnt > 3'd4) & wwegfin & wweg_den_il_fin) begin
            if(wweg_den_ol_fin) begin
                wweg_den_ol_cnt <= 'b0;
            end
            else begin
                wweg_den_ol_cnt <= wweg_den_ol_cnt + 6'd32;
            end
        end
    end
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            wweg_den_ol_fin <= 1'b0;
        end
        else if(wweglyrcnt == 3'd5) begin
            if(wweg_den_ol_cnt >= 6'd32) begin
                wweg_den_ol_fin <= 1'b1;
            end
            else begin
                wweg_den_ol_fin <= 1'b0;
            end
        end
        else begin
            wweg_den_ol_fin <= 1'b0;
        end
    end
    
    //=========== wweg fin ================================//
    always@(*) begin
        case(wweglyrcnt)
            3'd0: begin
                wweglyrfin = wwegfin & wweg_oc_fin;
            end
            3'd1,
            3'd2,
            3'd3,
            3'd4: begin
                wweglyrfin = wwegfin & wweg_ic_fin & wweg_oc_fin & wweg_ol_fin;
            end
            3'd5: begin
                wweglyrfin = wwegfin & wweg_den_il_fin & wweg_den_ol_fin;
            end
            3'd6: begin
                wweglyrfin = wwegfin & wweg_den_il_fin;
            end
            default: begin
                wweglyrfin = 1'b0;
            end
        endcase
    end
    
    //============= read weg mem addr bias ==============================//
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            rwegmembias <= 'b0;
        end
        else if(wwegfin) begin
            case(wweglyrcnt)
                3'd0: begin
                    if(wweg_oc_fin) begin
                        rwegmembias <= lyrwegbias[1];
                    end
                    else begin
                        rwegmembias <= rwegmembias + 7'd80;
                    end
                end
                3'd1,
                3'd2,
                3'd3,
                3'd4: begin
                    if(wweg_ic_fin) begin
                        if(wweg_ol_fin) begin
                            if(wweg_oc_fin) begin
                                rwegmembias <= lyrwegbias[wweglyrcnt + 1'b1];
                            end
                            else begin
                                rwegmembias <= lyrwegbias[wweglyrcnt] + wweg_oc_cnt[8:5]*lyriclen[wweglyrcnt] + lyriclen[wweglyrcnt];
                            end
                        end
                        else begin
                            rwegmembias <= lyrwegbias[wweglyrcnt] + wweg_oc_cnt[8:5]*lyriclen[wweglyrcnt];
                        end
                    end
                    else begin
                        rwegmembias <= rwegmembias + 3'd6;
                    end
                end
                3'd5: begin
                    if(wweg_den_il_fin) begin
                        if(wweg_den_ol_fin) begin
                            rwegmembias <= lyrwegbias[6];
                        end
                        else begin
                            rwegmembias <= lyrwegbias[6]+ 9'd256;
                        end
                    end
                    else begin
                        rwegmembias <= rwegmembias + 3'd6;
                    end
                end
                3'd6: begin
                    if(!wweg_den_il_fin) begin
                        rwegmembias <= rwegmembias + 3'd6;
                    end
                end
                default: begin
                    rwegmembias <= 'b0;
                end
            endcase
        end
    end
    
    //================================================================//
    

     assign   lyrwegbias [0] = LYR0WEGBIAS;
     assign   lyrwegbias [1] = LYR1WEGBIAS;
     assign   lyrwegbias [2] = LYR2WEGBIAS;
     assign   lyrwegbias [3] = LYR3WEGBIAS;
     assign   lyrwegbias [4] = LYR4WEGBIAS;
     assign   lyrwegbias [5] = LYR5WEGBIAS;
     assign   lyrwegbias [6] = LYR6WEGBIAS;
    

     assign   lyriclen[0] = 'b0;
     assign   lyriclen[1] = LYR1IC*3'd3;
     assign   lyriclen[2] = LYR2IC*3'd3;
     assign   lyriclen[3] = LYR3IC*3'd3;
     assign   lyriclen[4] = LYR4IC*3'd3;
     assign   lyriclen[5] = 'b0;
     assign   lyriclen[6] = 'b0;
    
endmodule
