`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/31 22:10:16
// Design Name: 
// Module Name: ctrl_pe
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


module ctrl_pe#(
        parameter TMPWID = 12
    )(
    input               clk,
    input               rst_n,
    input               rswu0vld,
    input               rswu1vld,
    input               rweg0vld,
    input               rweg1vld,
    input               rswu0fin,
    input               rswu1fin,
    input               ecg_start,
    output              rswu0rdy,
    output              rswu1rdy,
    output              rweg0rdy,
    output              rweg1rdy,
    output              rswuicfin,
    output [4:0]        rswuiccnt,
    output [8:0]        rswuilcnt,
    output              rwegolfin,
    output              thren,
    output [255:0]      threshold,
    output reg [2:0]    pe_cs,
    output reg [2:0]    rlyrcnt,
    output reg          rlyrfin,
    output reg          ricfin,
    output reg [2:0]    cmp_cs,
    output reg [2:0]    cmp_ns,
    output reg          rdenilfin,
    output reg          rolfin
    );
    
    //=============================local parameter =====================//
    
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
    
    //state pe
    localparam IDLE    = 3'b000;
    localparam INT_CMP = 3'b001;
    localparam BIN_CMP = 3'b010;
    localparam DEN_CMP = 3'b011;
    localparam AVG_POL = 3'b100;
    localparam DONE    = 3'b101;
     
     
     //pe compute state
     localparam S0W0IDLE = 3'b000;
     localparam S0W0CMP  = 3'b001;
     localparam S0W1IDLE = 3'b010;
     localparam S0W1CMP  = 3'b011;
     localparam S1W0IDLE = 3'b100;
     localparam S1W0CMP  = 3'b101;
     localparam S1W1IDLE = 3'b110;
     localparam S1W1CMP  = 3'b111;
     
    
    //============================ reg & net ==========================//
    
    wire [8:0] lyrolmax [4:0];
    wire [8:0] lyrocmax [4:0];
    wire [8:0] lyricmax [4:0];
    
    reg [8:0] rol_cnt;
    reg [8:0] ric_cnt;
    reg [8:0] roc_cnt;
    reg [8:0] rdenil_cnt;
    reg [6:0] rdenol_cnt;
    
    reg roc_incr;
    
    //reg [2:0] rlyrcnt;
    
    reg [2:0] pe_ns;
    
    //reg rlyrfin;
    reg  rocfin;//, ricfin;
    //reg rdenilfin,
    reg rdenolfin;

    
    wire avg_pol_fin;
    
    wire rswufin;
    
    //=========================== main code ==========================//
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            cmp_cs <= S0W0IDLE;
        end
        else begin
            cmp_cs <= cmp_ns;
        end
    end
    
    always@(*) begin
        case(cmp_cs)
            S0W0IDLE: begin
                cmp_ns = (rswu0vld & rweg0vld) ? S0W0CMP : S0W0IDLE;
            end
            S0W0CMP: begin
                if(!rswufin) begin
                    cmp_ns = S0W0CMP;
                end
                else begin
                    case(pe_cs)
                        INT_CMP: cmp_ns = rolfin ? S1W1IDLE : S1W0IDLE;
                        BIN_CMP: cmp_ns = rswuicfin ? S1W1IDLE : S0W1IDLE;
                        DEN_CMP: cmp_ns = rlyrfin ? S1W0IDLE : S0W1IDLE;
                        default: cmp_ns = S0W0IDLE;
                    endcase
                end
            end
            S0W1IDLE: begin
                cmp_ns = (rswu0vld & rweg1vld) ? S0W1CMP : S0W1IDLE;
            end
            S0W1CMP: begin
                if(!rswufin) begin
                    cmp_ns = S0W1CMP;
                end
                else begin
                    case(pe_cs)
                        INT_CMP: cmp_ns = rolfin ? S1W0IDLE : S1W1IDLE;
                        BIN_CMP: cmp_ns = rswuicfin ? S1W0IDLE : S0W0IDLE;
                        DEN_CMP: cmp_ns = rlyrfin ? S1W0IDLE : S0W0IDLE;
                        default: cmp_ns = S0W0IDLE;
                    endcase
                end
            end
            S1W0IDLE: begin
                cmp_ns = (rswu1vld & rweg0vld) ? S1W0CMP : S1W0IDLE;
            end
            S1W0CMP: begin
                if(!rswufin) begin
                    cmp_ns = S1W0CMP;
                end
                else begin
                    case(pe_cs)
                        INT_CMP: cmp_ns = rolfin ? S0W1IDLE : S0W0IDLE;
                        BIN_CMP: cmp_ns = rswuicfin ? S0W1IDLE : S1W1IDLE;
                        DEN_CMP: cmp_ns = S1W1IDLE;
                        default: cmp_ns = S0W0IDLE;
                    endcase
                end
            end
            S1W1IDLE: begin
                cmp_ns = (rswu1vld & rweg1vld) ? S1W1CMP : S1W1IDLE; 
            end
            S1W1CMP: begin
                if(!rswufin) begin
                    cmp_ns = S1W1CMP;
                end
                else begin
                    case(pe_cs)
                        INT_CMP: cmp_ns = rolfin ? S0W0IDLE : S0W1IDLE;
                        BIN_CMP: cmp_ns = rswuicfin ? S0W0IDLE : S1W0IDLE;
                        DEN_CMP: cmp_ns = S1W0IDLE;
                        default: cmp_ns = S0W0IDLE;
                    endcase
                end
            end
        endcase
    end
    
    //======================= valid ready ============================//
    assign rswu0rdy = ((cmp_cs == S0W0CMP)||(cmp_cs == S0W1CMP));
    assign rswu1rdy = ((cmp_cs == S1W0CMP)||(cmp_cs == S1W1CMP));
    assign rweg0rdy = ((cmp_cs == S0W0CMP)||(cmp_cs == S1W0CMP));
    assign rweg1rdy = ((cmp_cs == S0W1CMP)||(cmp_cs == S1W1CMP));
    
    //=============================state =============================//
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            pe_cs <= IDLE;
        end
        else begin
            pe_cs <= pe_ns;
        end
    end
    
    always@(*) begin
        case(pe_cs)
            IDLE: begin
                pe_ns = ecg_start ? INT_CMP: IDLE;
            end
            INT_CMP: begin
                pe_ns = rlyrfin ? BIN_CMP : INT_CMP;
            end
            BIN_CMP: begin
                pe_ns = (rlyrfin & (rlyrcnt == 3'd4)) ? DEN_CMP : BIN_CMP;
            end
            AVG_POL: begin
                pe_ns = avg_pol_fin ? DEN_CMP : AVG_POL;
            end
            DEN_CMP: begin
                pe_ns = (rlyrfin & (rlyrcnt == 3'd6)) ? DONE : DEN_CMP;
            end
            DONE: begin
                pe_ns = DONE;
            end
            default: begin
                pe_ns = IDLE;
            end
        endcase
    end
    
    
    //=========================== read lyr cnt =======================//
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            rlyrcnt <= 'b0;
        end
        else if(rlyrfin) begin
            rlyrcnt <= rlyrcnt + 1'b1;
        end
    end
    
    //==============================================================//
    
    assign rswufin = rswu0fin || rswu1fin;
    
    
    //==================== count ol ===============================//
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            rol_cnt <= 'b0;
        end
        else if(rswufin) begin
            case(pe_cs)
                INT_CMP: begin
                    if(rolfin) begin
                        rol_cnt <= 'b0;
                    end
                    else begin
                        rol_cnt <= rol_cnt + 1'b1;
                    end
                end
                BIN_CMP: begin
                    if(ricfin) begin
                        if(rolfin) begin
                            rol_cnt <= 'b0;
                        end
                        else begin
                            rol_cnt <= rol_cnt + TMPWID;
                        end
                    end
                end
                default: begin
                    rol_cnt <= 'b0;
                end
            endcase
        end
    end
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            rolfin <= 1'b0;
        end
        else begin
            case(pe_cs)
                INT_CMP,
                BIN_CMP: begin
                    if(rol_cnt >= lyrolmax[rlyrcnt]) begin
                        rolfin <= 1'b1; 
                    end
                    else begin
                        rolfin <= 1'b0;
                    end
                end
                default: begin
                    rolfin <= 1'b0;
                end
            endcase
        end
    end
    

      assign  lyrolmax[0] = LYR0OL - 1'b1;
      assign  lyrolmax[1] = LYR1OL - TMPWID;
      assign  lyrolmax[2] = LYR2OL - TMPWID;
      assign  lyrolmax[3] = LYR3OL - TMPWID;
      assign  lyrolmax[4] = LYR4OL - TMPWID;
 
    
    //===================== ic count ============================//
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            ric_cnt <= 'b0;
        end
        else if(rswufin) begin
            case(pe_cs)
                BIN_CMP: begin
                    if(ricfin) begin
                        ric_cnt <= 'b0;
                    end
                    else begin
                        ric_cnt <= ric_cnt + 2'd2;
                    end
                end
                default: begin
                    ric_cnt <= 'b0;
                end
            endcase
        end
    end
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            ricfin <= 1'b0;
        end
        else begin
            case(pe_cs)
                BIN_CMP: begin
                    if(ric_cnt >= lyricmax[rlyrcnt]) begin
                        ricfin <= 1'b1;
                    end
                    else begin
                        ricfin <= 1'b0;
                    end
                end
                default: begin
                    ricfin <= 1'b0;
                end
            endcase
        end
    end
    

      assign  lyricmax[0] = 'b0;
      assign  lyricmax[1] = LYR1IC - 2'd2;
      assign  lyricmax[2] = LYR2IC - 2'd2;
      assign  lyricmax[3] = LYR3IC - 2'd2;
      assign  lyricmax[4] = LYR4IC - 2'd2;

    
    //================================================================//
    
    assign rswuiccnt = ric_cnt[4:0];
    assign rswuicfin = (rswuiccnt >= 5'd30);
    assign rwegolfin = (pe_cs == INT_CMP) & rswufin & rolfin;
    assign rswuilcnt = rdenil_cnt;
    
    //======================= oc count ===============================//
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            roc_cnt <= 'b0;
        end
        else if(rswufin) begin
            case(pe_cs)
                INT_CMP: begin
                    if(rolfin) begin
                        if(rocfin) begin
                            roc_cnt <= 'b0;
                        end
                        else begin
                            roc_cnt <= roc_cnt + 6'd32;
                        end
                    end
                end
                BIN_CMP: begin
                    if(rolfin & ricfin) begin
                        if(rocfin) begin
                            roc_cnt <= 'b0;
                        end
                        else begin
                            roc_cnt <= roc_cnt + 6'd32;
                        end
                    end
                end
            endcase
        end
    end
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            rocfin <= 1'b0;
        end
        else begin
            case(pe_cs)
                INT_CMP,
                BIN_CMP: begin
                    if(roc_cnt >= lyrocmax[rlyrcnt]) begin
                        rocfin <= 1'b1;
                    end
                    else begin
                        rocfin <= 1'b0;
                    end
                end
                default: begin
                    rocfin <= 1'b0;
                end
            endcase
        end
    end
    
  
     assign   lyrocmax[0] = LYR0OC - 6'd32;
     assign   lyrocmax[1] = LYR1OC - 6'd32;
     assign   lyrocmax[2] = LYR2OC - 6'd32;
     assign   lyrocmax[3] = LYR3OC - 6'd32;
     assign   lyrocmax[4] = LYR4OC - 6'd32;

    
    //====================== den cmp ===========================//
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            rdenil_cnt <= 'b0;
        end
        else if(pe_cs == DEN_CMP) begin
            if(rswufin & (rswu0rdy || rswu1rdy)) begin
                if(rdenilfin) begin
                    rdenil_cnt <= 'b0;
                end
                else begin
                    rdenil_cnt <= rdenil_cnt + 3'd6;
                end
            end
        end
        else begin
            rdenil_cnt <= 'b0;
        end
    end
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            rdenilfin <= 1'b0;
        end
        else if(pe_cs == DEN_CMP) begin
            case(rlyrcnt)
                3'd5: begin
                    if(rdenil_cnt >= 9'd250) begin
                        rdenilfin <= 1'b1;
                    end
                    else begin
                        rdenilfin <= 1'b0;
                    end
                end
                3'd6: begin
                    if(rdenil_cnt >= 9'd58) begin
                        rdenilfin <= 1'b1;
                    end
                    else begin
                        rdenilfin <= 1'b0;
                    end
                end
                default: begin
                    rdenilfin <= 1'b0;
                end
            endcase
        end
        else begin
            rdenilfin <= 1'b0;
        end
    end
    
    //=================================================================//
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            rdenol_cnt <= 'b0;
        end
        else if(pe_cs == DEN_CMP) begin
            if(rswufin & (rswu0rdy || rswu1rdy)) begin
                if(rdenilfin) begin
                    if(rdenolfin) begin
                        rdenol_cnt <= 'b0;
                    end
                    else begin
                        rdenol_cnt <= rdenol_cnt + 6'd32;
                    end
                end
            end
        end
        else begin
            rdenol_cnt <= 'b0;
        end
    end
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            rdenolfin <= 1'b0;           
        end
        else if(rlyrcnt == 3'd5) begin
            if(rdenol_cnt >= 7'd32) begin
                rdenolfin <= 1'b1; 
            end
            else begin
                rdenolfin <= 1'b0; 
            end
        end
        else if(rlyrcnt == 3'd6) begin
            rdenolfin <= 1'b1; 
        end
        else begin
            rdenolfin <= 1'b1; 
        end
    end
    
    //================== rlyrfin ==============================//
    
    always@(*) begin
        case(pe_cs)
            INT_CMP: begin
                rlyrfin = rswufin & rolfin & rocfin;
            end
            BIN_CMP: begin
                rlyrfin = rocfin & ricfin & rolfin & rswufin;
            end
            DEN_CMP: begin
                rlyrfin = rdenilfin & rdenolfin & rswufin & (rswu0rdy || rswu1rdy);
            end
            default: begin
                rlyrfin = 1'b0;
            end
        endcase
    end
    
    //=================== Threshold ====================================//
    
    localparam LYR0TREBASE = 8'd0;
    localparam LYR1TREBASE = 8'd16; // 64 output channels, each channel 8bit threshold;64*8/32=16
    localparam LYR2TREBASE = LYR1TREBASE + 8'd16;
    localparam LYR3TREBASE = LYR2TREBASE + 8'd32;
    localparam LYR4TREBASE = LYR3TREBASE + 8'd32;
    // total len is 160
    
    
    reg [7:0] thre_addr_base;
    //wire [7:0] thre_addr_base_next;
    wire [7:0] thre_addr_base_lyr [4:0];
    
    assign thre_addr_base_lyr[0] = LYR0TREBASE;
    assign thre_addr_base_lyr[1] = LYR1TREBASE;
    assign thre_addr_base_lyr[2] = LYR2TREBASE;
    assign thre_addr_base_lyr[3] = LYR3TREBASE;
    assign thre_addr_base_lyr[4] = LYR4TREBASE;
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            thre_addr_base <= 'b0;
        end
        else if(rlyrfin) begin
            thre_addr_base <= thre_addr_base_lyr[rlyrcnt + 1'b1];
        end
        else if(thren) begin
            thre_addr_base <= thre_addr_base + 8'd8;
        end
    end
    
    // each times need 32 threshold ==> 8 lines of threshold mem ; need 8cycles to read;
    // the fasted conv longer than 8 cycle
    //===================================================================//
    
    wire thr_mem_ena;
    wire [7:0] thr_mem_addr;
    wire [31:0] thr_mem_data;
    
    reg thr_mem_ena_r, thr_mem_ena_rr;
    
    reg [3:0] thr_mem_rdcnt, thr_mem_rdcnt_r;// read 8 lines of data, need 10 cycles
    reg rd_thr_mem_cs ,rd_thr_mem_ns;
    wire thr_mem_rd_fin;
    //==================================================================//
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            rd_thr_mem_cs <= 1'b1;
        end
        else begin
            rd_thr_mem_cs <= rd_thr_mem_ns;
        end
    end
    
    always@(*) begin
        case(rd_thr_mem_cs)
            1'b0: begin
                rd_thr_mem_ns = roc_incr ? 1'b1:1'b0;
            end
            1'b1: begin
                rd_thr_mem_ns = thr_mem_rd_fin ? 1'b0: 1'b1;
            end
            default: begin
                rd_thr_mem_ns = 1'b0;
            end
        endcase
    end
    

   
    //==================================================================//
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            thr_mem_rdcnt <= 'b0;
        end
        else if(rd_thr_mem_cs) begin
            thr_mem_rdcnt <= thr_mem_rdcnt + 1'b1;
        end
        else begin
            thr_mem_rdcnt <= 'b0;
        end
    end
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            thr_mem_rdcnt_r <= 'b0;
        end
        else begin
            thr_mem_rdcnt_r <= thr_mem_rdcnt;
        end
    end
    
    assign thr_mem_rd_fin = (thr_mem_rdcnt_r == 4'd7);
    
    //==================================================================//
    threshold_mem u_threshold_mem(
         .clka(clk),
         .ena(thr_mem_ena), // enable
         .wea(1'b0), // 0 rd 1 wr
         .addra(thr_mem_addr),
         .dina('b0),
         .douta(thr_mem_data)
    );
    
    assign thr_mem_addr = thre_addr_base + thr_mem_rdcnt;
    assign thr_mem_ena = rd_thr_mem_cs;
    //==================================================================//
    reg [31:0] thre_tmp [7:0];
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            thr_mem_ena_r <= 1'b0;
            thr_mem_ena_rr <= 1'b0;
        end
        else begin
            thr_mem_ena_r <= thr_mem_ena;
            thr_mem_ena_rr <= thr_mem_ena_r;
        end
    end
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            thre_tmp[7] <= 'b0;
        end
        else if(thr_mem_ena_r) begin
            thre_tmp[7] <= thr_mem_data;
        end
    end
    
    generate
        genvar i1;
        for(i1=1;i1<8;i1=i1+1'b1) begin: tre_tmp_loop
            always@(posedge clk or negedge rst_n) begin
                if(!rst_n) begin
                    thre_tmp[7-i1] <= 'b0;
                end
                else if(thr_mem_ena_r) begin
                    thre_tmp[7-i1] <= thre_tmp[7-i1+1'b1];
                end
            end
        end
    endgenerate
    
    assign thren = (!thr_mem_ena_r) & thr_mem_ena_rr;
    assign threshold = {thre_tmp[7],thre_tmp[6],thre_tmp[5],thre_tmp[4],
                        thre_tmp[3],thre_tmp[2],thre_tmp[1],thre_tmp[0]};
    
    //==================================================================//
    // a signal means oc incr
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            roc_incr <= 1'b0;
        end
        else if(rswufin) begin
            case(pe_cs)
                INT_CMP: begin
                    if(rolfin) begin
                        roc_incr <= 1'b1;
                    end
                    else begin
                        roc_incr <= 1'b0;
                    end
                end
                BIN_CMP: begin
                    if(rolfin & ricfin) begin
                        roc_incr <= 1'b1;
                    end
                    else begin
                        roc_incr <= 1'b0;
                    end
                end
            endcase
        end
        else begin
            roc_incr <= 1'b0;
        end
    end
    //==================================================================//
    
endmodule
