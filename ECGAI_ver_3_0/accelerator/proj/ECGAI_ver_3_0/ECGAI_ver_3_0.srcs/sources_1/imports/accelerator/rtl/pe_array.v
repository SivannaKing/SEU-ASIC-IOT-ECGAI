`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/03 14:06:59
// Design Name: 
// Module Name: pe_array
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


module pe_array#(
        parameter ACTMEMADRWID = 10,
        parameter TMPWID = 12
    )(
    input clk,
    input rst_n,
    input [2:0]                 rlyrcnt,
    input [2:0]                 pe_cs,
    input [2:0]                 cmp_cs,
    input [2:0]                 cmp_ns,
    input [5:0]                 bin0input,
    input [5:0]                 bin1input,
    input [31:0]                int0input,
    input [31:0]                int1input,
    input [191:0]               rweg0data,
    input [191:0]               rweg1data,
    input                       rswu0fin,
    input                       rswu1fin,
    input                       ricfin,
    input                       rolfin,
    input                       rdenilfin,
    input                       thren,
    input [255:0]               threshold,
    //output                      wactmem0ena,
    //output                      wactmem1ena,
    //output                      wactmem0wea,
    //output                      wactmem1wea,
    //output [ACTMEMADRWID-1:0]   wactmem0addr,
    //output [ACTMEMADRWID-1:0]   wactmem1addr,
    //output [31:0]               wactmemdata
    output [383:0]                peout,    //32 12bit output ; 32*12=384
    output                        peouten,
    output signed [11:0]          class0out,
    output signed [11:0]          class1out,
    output signed [11:0]          class2out,
    output signed [11:0]          class3out,
    output signed [11:0]          class4out
    );
    
    //================ local param ===========================//
    
    //state pe
    localparam IDLE    = 3'b000;
    localparam INT_CMP = 3'b001;
    localparam BIN_CMP = 3'b010;
    localparam DEN_CMP = 3'b011;
    localparam AVG_POL = 3'b100;
    
    
     //pe compute state
     localparam S0W0IDLE = 3'b000;
     localparam S0W0CMP  = 3'b001;
     localparam S0W1IDLE = 3'b010;
     localparam S0W1CMP  = 3'b011;
     localparam S1W0IDLE = 3'b100;
     localparam S1W0CMP  = 3'b101;
     localparam S1W1IDLE = 3'b110;
     localparam S1W1CMP  = 3'b111;
     
     // act mem lyr bias
         localparam LYR0ACTBIAS = 11'd0;
         localparam LYR2ACTBIAS = 11'd900; // 3600/4 32bit = 4* 8bit
         localparam LYR4ACTBIAS = 11'd150 + LYR2ACTBIAS;//75*64/32=150
         localparam LYR6ACTBIAS = 11'd2 + LYR4ACTBIAS;
         
         localparam LYR1ACTBIAS = 11'd0;
         localparam LYR3ACTBIAS = 11'd300;// ic:64 il:150 => 64*150/32 = 300
         localparam LYR5ACTBIAS = 11'd8 + LYR3ACTBIAS; // 256/32=8
    
    
    //=========== reg & net ==================================//
    
    wire                        sel;
    reg                         pe_en;
    reg [$clog2(TMPWID)-1:0]    accsel;
    wire                        rswufin;
    
    reg [5:0]                   binweight [31:0];
    
    reg out_en, out_en_r, out_en_rr;
    
    wire [TMPWID-1:0]           binoutput [31:0];
    
    wire [5:0]                  bininput;

    wire [31:0]                 intinput;

    wire [191:0]                rwegdata;
    
    wire [31:0]                 outvalid;
    
    reg [383:0]                 peoutreg;
    reg                         peoutenr;
    
    reg [3:0]                   wactmemcnt;
    reg                         wactmemena;
    
    reg [ACTMEMADRWID-1:0]      write0addr;
    reg [ACTMEMADRWID-1:0]      write1addr;
    
    reg  [10:0] threshold_array [31:0];
    
    wire   signed [11:0]        classout [31:0];
    
    wire avg_pol_signal;
    
    assign avg_pol_signal = (rlyrcnt == 3'd4);
    
    assign class0out = classout[0];
    assign class1out = classout[1];
    assign class2out = classout[2];
    assign class3out = classout[3];
    assign class4out = classout[4];
    
    //======================================================//
    
    assign bininput = (cmp_cs[2]) ? bin1input : bin0input;
    assign intinput = (cmp_cs[2]) ? int1input : int0input;
    assign rwegdata = (cmp_cs[1]) ? rweg1data : rweg0data;
    
    //assign wactmemdata = peoutarray[wactmemcnt];
    
    //=======================================================//
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            out_en_r <= 'b0;
            out_en_rr <= 'b0;
        end
        else begin
            out_en_r <= out_en;
            out_en_rr <= out_en_r;
        end
    end
    //========================================================//
    //assign wactmem0ena = wactmemena & (rlyrcnt[0]);
    //assign wactmem1ena = wactmemena & (!rlyrcnt[0]);
    //assign wactmem0wea = 1'b1;
    //assign wactmem1wea = 1'b1;
    
    //assign wactmem0addr = write0addr + wactmemcnt;
    //assign wactmem1addr = write1addr + wactmemcnt;
    
    //=======================================================//
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            peoutreg <= 'b0;
        end
        else if(out_en_rr) begin
            peoutreg <= {binoutput[31], binoutput[30], binoutput[29], binoutput[28],
                        binoutput[27], binoutput[26], binoutput[25], binoutput[24],
                        binoutput[23], binoutput[22], binoutput[21], binoutput[20],
                        binoutput[19], binoutput[18], binoutput[17], binoutput[16],
                        binoutput[15], binoutput[14], binoutput[13], binoutput[12],
                        binoutput[11], binoutput[10], binoutput[9], binoutput[8],
                        binoutput[7], binoutput[6], binoutput[5], binoutput[4],
                        binoutput[8], binoutput[2], binoutput[1], binoutput[0]
                        };
        end
    end
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            peoutenr <= 1'b0;
        end
        else begin
            peoutenr <= out_en_rr;
        end
    end
    
    assign peout = peoutreg;
    assign peouten = peoutenr;
    
 
    //=======================================================//
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            wactmemcnt <= 'b0;
        end
        else if(wactmemena) begin
            wactmemcnt <= wactmemcnt + 1'b1;
        end
        else begin
            wactmemcnt <= 'b0;
        end
    end
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            wactmemena <= 1'b0;
        end
        else if(out_en_rr) begin
            wactmemena <= 1'b1;
        end
        else begin
            case(pe_cs)
                INT_CMP: begin
                    if(wactmemcnt == 1'b0) begin
                        wactmemena <= 1'b0;
                    end
                end
                BIN_CMP,
                DEN_CMP: begin
                    if(wactmemcnt == 3'd5) begin
                        wactmemena <= 1'b0;
                    end
                end
                default: begin
                    wactmemena <= 1'b0;
                end
            endcase
        end
    end

    //=======================================================//
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            write0addr <= 10'd900;
        end
        else if(out_en_rr & (!rlyrcnt[0])) begin
            case(pe_cs)
                INT_CMP: begin
                    write0addr <= write0addr + 3'd1;
                end
                BIN_CMP,
                DEN_CMP: begin
                    write0addr <= write0addr + 3'd6;
                end
            endcase
        end
    end
    
    always@(posedge clk or negedge rst_n) begin
            if(!rst_n) begin
                write1addr <= 10'd0;
            end
            else if(out_en_rr & (rlyrcnt[0])) begin
                case(pe_cs)
                    INT_CMP: begin
                        write1addr <= write1addr + 3'd1;
                    end
                    BIN_CMP,
                    DEN_CMP: begin
                        write1addr <= write1addr + 3'd6;
                    end
                endcase
            end
        end
    
    //=================main code ============================//
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            pe_en <= 1'b0;
        end
        else begin
            case(pe_cs)
                INT_CMP,
                BIN_CMP: begin
                    if(!cmp_ns[0]) begin
                        pe_en <= 1'b0;
                    end
                    else if(cmp_cs[0]) begin
                        pe_en <= 1'b1;
                    end
                    else begin
                        pe_en <= 1'b0;
                    end
                end
                DEN_CMP: begin
                    if(cmp_cs[0]) begin
                        pe_en <= 1'b1;
                    end
                    else begin
                        pe_en <= 1'b0;
                    end
                end
                default: begin
                    pe_en <= 1'b0;
                end
            endcase
        end
    end
    
    //====================================================//
    
    assign sel = (pe_cs == INT_CMP) ? 1'b0:1'b1;
    assign rswufin = rswu0fin || rswu1fin;
    
    //====================================================//
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            accsel <= 'b0;
        end
        else begin
            case(pe_cs)
                INT_CMP: begin
                    if(pe_en) begin
                        if(rswufin) begin
                            if(accsel == 4'd11) begin
                                accsel <= 'b0;
                            end
                            else begin
                                accsel <= accsel + 1'b1;
                            end
                        end
                    end
                end
                BIN_CMP: begin
                    if(rlyrcnt == 3'd4) begin
                        accsel <= 'b0;
                    end
                    else if(pe_en) begin
                        if(rswufin) begin
                            accsel <= 'b0;
                        end
                        else begin
                            accsel <= accsel + 1'b1;
                        end
                    end
                end
                default: begin
                    accsel <= 'b0;
                end
            endcase
        end        
    end
    
    //====================================================//
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            out_en <= 1'b0;
        end
        else begin
            case(pe_cs)
                INT_CMP: begin
                    if(rswufin&(accsel == 4'd11)) begin
                        out_en <= 1'b1;
                    end
                    else begin
                        out_en <= 1'b0;
                    end
                end
                BIN_CMP: begin
                    if(rswufin & ricfin) begin
                        if(rlyrcnt == 3'd4) begin
                            out_en <= rolfin;
                        end
                        else begin
                            out_en <= 1'b1;
                        end
                    end
                    else begin
                        out_en <= 1'b0;
                    end
                end
                DEN_CMP: begin
                    if(rswufin & rdenilfin) begin
                        out_en <= 1'b1;
                    end
                    else begin
                        out_en <= 1'b0;
                    end
                end
                default: begin
                    out_en <= 1'b0;
                end
            endcase
        end
    end
    
    //=========================================================//
    
    integer j;
    always@(*) begin
        for(j=0;j<32;j=j+1'b1) begin
            binweight[j] = {rwegdata[160+j], rwegdata[128+j], rwegdata[96+j],
                            rwegdata[64+j], rwegdata[32+j], rwegdata[j]};
        end
    end
    
    //==========================================================//
    // threshold
    generate
        genvar i1;
        for(i1=0;i1<32;i1=i1+1'b1) begin: threshold_loop
            always@(posedge clk or negedge rst_n) begin
                if(!rst_n) begin
                    threshold_array[i1] <= 'b0;
                end
                else if(pe_cs == DEN_CMP) begin
                    threshold_array[i1] <= 'b0;
                end
                else if(thren) begin
                    threshold_array[i1] <= {{3{threshold[(i1*8)+7]}},threshold[(i1*8)+:8]};
                end
            end
        end
    endgenerate
    
    
    //==========================================================//
    
    generate
        genvar i;
        for(i=0;i<32;i=i+1'b1) begin: pe_loop
            pe #(
                .TMPWID(TMPWID),
                .MIDWID(11)
            ) u_pe_i(
                .clk(clk),
                .rst_n(rst_n),
                .bininput(bininput),
                .intinput(intinput),
                .binweight(binweight[i]),
                .out_en(out_en),
                .pe_en(pe_en),
                .sel(sel),
                .accsel(accsel),
                .threshold(threshold_array[i]),                          
                .binout(binoutput[i]),
                .classout(classout[i]),
                .avg_pol_signal(avg_pol_signal)
                //.outvalid(outvalid[i])
            );
        end
    endgenerate
    
    
    
endmodule
