`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/30 14:42:52
// Design Name: 
// Module Name: ecg_bnn_top
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


module ecg_bnn_top(
    input                       clk,
    input                       rst_n,
    input                       ecg_rd_done,
    //============= bram ctrl =====================//
    input  [14:0]               bram_addr_a,
    input  [31:0]               bram_wrdata_a,
    input                       bram_en_a,
    input                       bram_we_a,
    //============================================//
    output                      done,
    output [4:0]                classout
    );
    
    //=================== parameter ====================//
    
      parameter SWUREGADRWID = 5;
      parameter SWUREDEPTH   = 20;
      parameter TMPWID       = 12;
      
      parameter ACTMEMADRWID = 11;
      parameter ACTREGADRWID = 5;
      
      parameter WEGREDNUM = 80;
      parameter WEGREGADRWID = 7;
      parameter WEGMEMADRWID = 13;
      
      parameter KS0 = 12;
      
    //=============== reg & wire =======================//
    
    //================= ctrl_a 2 swu ===================//
    wire wswu0vld, wswu1vld;
    wire wswu0rdy, wswu1rdy;
    wire [31:0] wswu0data, wswu1data;
    wire [SWUREGADRWID-1:0] wswuaddr;
    wire wswufin;
    
    //================ ctrl_pe 2 swu ===================//
    wire rswu0rdy, rswu1rdy;
    wire rswu0vld, rswu1vld;
    //wire [2:0] pe_cs;
    wire rswuicfin;
    wire [4:0] rswuiccnt;
    wire [31:0] int0input, int1input;
    wire [5:0] bin0input, bin1input;
    wire [191:0] den0input, den1input;
    wire rswu0fin, rswu1fin;
    
    //========== ctrl 2 ctrl_a =========================//
    
    wire [2:0] wswulyrcnt;
    wire [ACTMEMADRWID-1:0] rswumembias;
    wire ractmem0ena, ractmem1ena, ractmem0wea, ractmem1wea;
    
    //=========== ctrl 2 ctrl_w ========================//
    wire [2:0] wweglyrcnt;
    wire [WEGMEMADRWID-1:0] rwegmembias;
    
    //============ act mem to ctrl_a ==================//
    
    wire [31:0] swumemdata;
    wire [ACTMEMADRWID-1:0] ractmem0addr, ractmem1addr;
    
    //=========== pool 2 act mem =========================//
    
    wire wactmem0ena, wactmem1ena, wactmem0wea, wactmem1wea;
    wire [ACTMEMADRWID-1:0] wactmem0addr, wactmem1addr;
    wire [31:0] pool2memdata;
    
    // TMP VALUE 2 SIMULATION 
    
    //assign wactmem0ena = 1'b0;
    //assign wactmem1ena = 1'b0;
    //assign wactmem0wea = 1'b1;
    //assign wactmem1wea = 1'b1;
    //assign wactmem0addr = 'b0;
    //assign wactmem1addr = 'b0;
    //assign pool2memdata = 'b0;
    
    //============ctrl w to weg =========================//
    
    wire wweg0vld, wweg1vld, rweg0rdy, rweg1rdy;
    wire [31:0] wweg0data, wweg1data;
    wire [WEGREGADRWID-1:0] wwegaddr;
    wire wwegfin;
    
    //========== ctrl pe to  weg========================//
    
    wire wweg0rdy, wweg1rdy, rweg0vld, rweg1vld;
    wire [191:0] rweg0data, rweg1data;
    wire rweg0fin, rweg1fin;
    wire rwegolfin;
    
    //=========== ctrl w to weg mem ===================//
    
    wire wegmemena, wegmemwea;
    wire [WEGMEMADRWID-1:0] wegmemaddr;
    wire [31:0] wegmemdata;
    
    //==================================================//
    
    //=============== ctrl pe to swu ===================//
    
    wire [8:0] rswuilcnt;
    wire rlyrfin;
    
    //================= ctrl pe to ctrl a ===============//
    wire [2:0] rlyrcnt;
    //=================== ctrl pe to pe =================//
    wire ricfin;
    wire [2:0] cmp_cs, cmp_ns;
    wire rdenilfin;
    wire [31:0] wactmemdata;
    
    wire [2:0] pe_cs;
    wire ecg_start;
    assign ecg_start = ecg_rd_done;
    
    //=========== pe to pool ==============================//
    wire [383:0] peout;
    wire peouten;
    
    wire wmemnum;
    
    //============ read the class answer =================//
    
    assign done = (pe_cs == 3'b101);
    assign classout =(pe_cs == 3'b101)? wactmemdata[31-:5] : 'b0;
    
    //====================================================//
    wire thren;
    wire [255:0] threshold;
    
    wire rolfin;
    
    wire signed [11:0] class0out;
    wire signed [11:0] class1out;
    wire signed [11:0] class2out;
    wire signed [11:0] class3out;
    wire signed [11:0] class4out;
    
    //====================================================//
    
    pe_array #(
        .ACTMEMADRWID(ACTMEMADRWID),
        .TMPWID(TMPWID)
    ) u_pe_array(
        .clk(clk),
        .rst_n(rst_n),
        .rlyrcnt(rlyrcnt),
        .pe_cs(pe_cs),
        .cmp_cs(cmp_cs),
        .cmp_ns(cmp_ns),
        .bin0input(bin0input),
        .bin1input(bin1input),
        .int0input(int0input),
        .int1input(int1input),
        .rweg0data(rweg0data),
        .rweg1data(rweg1data),
        .rswu0fin(rswu0fin),
        .rswu1fin(rswu1fin),
        .ricfin(ricfin),
        .rdenilfin(rdenilfin),
        .thren(thren),
        .threshold(threshold),
        .peout(peout),
        .peouten(peouten),
        .rolfin(rolfin),
        .class0out(class0out),
        .class1out(class1out),
        .class2out(class2out),
        .class3out(class3out),
        .class4out(class4out)
        //.wactmem0ena(wactmem0ena),
        //.wactmem1ena(wactmem1ena),
        //.wactmem0wea(wactmem0wea),
        //.wactmem1wea(wactmem1wea),
        //.wactmem0addr(wactmem0addr),
        //.wactmem1addr(wactmem1addr),
        //.wactmemdata(wactmemdata)
    );
    
    //====================================================//
    
    ctrl_pe #(
        .TMPWID(TMPWID)
    )u_ctrl_pe(
        .clk(clk),
        .rst_n(rst_n),
        .rswu0vld(rswu0vld),
        .rswu1vld(rswu1vld),
        .rweg0vld(rweg0vld),
        .rweg1vld(rweg1vld),
        .rswu0fin(rswu0fin),
        .rswu1fin(rswu1fin),
        .ecg_start(ecg_start),
        .rswu0rdy(rswu0rdy),
        .rswu1rdy(rswu1rdy),
        .rweg0rdy(rweg0rdy),
        .rweg1rdy(rweg1rdy),
        .rswuicfin(rswuicfin),
        .rswuiccnt(rswuiccnt),
        .rswuilcnt(rswuilcnt),
        .rwegolfin(rwegolfin),
        .pe_cs(pe_cs),
        .rlyrcnt(rlyrcnt),
        .rlyrfin(rlyrfin),
        .ricfin(ricfin),
        .cmp_cs(cmp_cs),
        .cmp_ns(cmp_ns),
        .rdenilfin(rdenilfin),
        .thren(thren),
        .threshold(threshold),
        .rolfin(rolfin)
    );
    
    //===================================================//
    
    ctrl#(
        .WEGMEMADRWID(WEGMEMADRWID),
        .ACTMEMADRWID(ACTMEMADRWID),
        .TMPWID(TMPWID),
        .KS0(KS0)
    )u_ctrl(
        .clk(clk),
        .rst_n(rst_n),
        .wswufin(wswufin),
        .wwegfin(wwegfin),
        .wswulyrcnt(wswulyrcnt),
        .wweglyrcnt(wweglyrcnt),
        .rswumembias(rswumembias),
        .rwegmembias(rwegmembias)
    );
    
    //===================================================//
    
    ctrl_a #(
        .ACTMEMADRWID(ACTMEMADRWID),
        .ACTREGADRWID(ACTREGADRWID)
    )u_ctrl_a(
        .clk(clk),
        .rst_n(rst_n),
        .wswulyrcnt(wswulyrcnt),
        .swumemdata(swumemdata),
        .rswumembias(rswumembias),
        .wswu0rdy(wswu0rdy),
        .wswu1rdy(wswu1rdy),
        .ractmem0ena(ractmem0ena),
        .ractmem1ena(ractmem1ena),
        .ractmem0wea(ractmem0wea),
        .ractmem1wea(ractmem1wea),
        .ractmem0addr(ractmem0addr),
        .ractmem1addr(ractmem1addr),
        .wswuaddr(wswuaddr),
        .wswu0vld(wswu0vld),
        .wswu1vld(wswu1vld),
        .wswu0data(wswu0data),
        .wswu1data(wswu1data),
        .wswufin(wswufin),
        .rlyrcnt(rlyrcnt),
        .wmemnum(wmemnum)
    );
    
    //==================================================//
    
    swu #(
        .SWUREGADRWID(SWUREGADRWID),
        .SWUREDEPTH(SWUREDEPTH),
        .TMPWID (TMPWID )
    ) u_swu0(
        .clk(clk),
        .rst_n(rst_n),
        .wswuvld(wswu0vld),
        .rswurdy(rswu0rdy),
        .wswudata(wswu0data),
        .wswuaddr(wswuaddr),
        .wswufin(wswufin),
        .pe_cs(pe_cs),
        .rswuicfin(rswuicfin),
        .rswuiccnt(rswuiccnt),
        .rswuilcnt(rswuilcnt),
        .wswurdy(wswu0rdy),
        .rswuvld(rswu0vld),
        .intinput(int0input),
        .bininput(bin0input),
        .rswufin(rswu0fin),
        .rlyrfin(rlyrfin)
    );
    
    swu #(
            .SWUREGADRWID(SWUREGADRWID),
            .SWUREDEPTH(SWUREDEPTH),
            .TMPWID (TMPWID )
        ) u_swu1(
            .clk(clk),
            .rst_n(rst_n),
            .wswuvld(wswu1vld),
            .rswurdy(rswu1rdy),
            .wswudata(wswu1data),
            .wswuaddr(wswuaddr),
            .wswufin(wswufin),
            .pe_cs(pe_cs),
            .rswuicfin(rswuicfin),
            .rswuiccnt(rswuiccnt),
            .rswuilcnt(rswuilcnt),
            .wswurdy(wswu1rdy),
            .rswuvld(rswu1vld),
            .intinput(int1input),
            .bininput(bin1input),
            .rswufin(rswu1fin),
            .rlyrfin(rlyrfin)
        );
        
   //======================================================//
   
   act_unimem #(
        .ACTMEMADRWID(ACTMEMADRWID)
   ) u_act_unimem(
       .clk(clk),
       .rst_n(rst_n),
       .ractmem0ena(ractmem0ena),
       .ractmem1ena(ractmem1ena),
       .ractmem0wea(ractmem0wea),
       .ractmem1wea(ractmem1wea),
       .wactmem0ena(wactmem0ena),
       .wactmem1ena(wactmem1ena),
       .wactmem0wea(wactmem0wea),
       .wactmem1wea(wactmem1wea),
       .ractmem0addr(ractmem0addr),
       .ractmem1addr(ractmem1addr),
       .wactmem0addr(wactmem0addr),
       .wactmem1addr(wactmem1addr),
       .wactmemdata(wactmemdata),
       .swumemdata(swumemdata)
       //================bram ctrl =============//
       //.bram_addr_a(bram_addr_a),
       //.bram_wrdata_a(bram_wrdata_a),
       //.bram_en_a(bram_en_a),
       //.bram_we_a(bram_we_a)
   );
   
   //==============================================//
   
   weg #(
        .WEGREDNUM(WEGREDNUM),
        .WEGREGADRWID(WEGREGADRWID)
   )u_weg0(
       .clk(clk),
       .rst_n(rst_n),
       .wwegvld(wweg0vld),
       .rwegrdy(rweg0rdy),
       .wwegdata(wweg0data),
       .wwegaddr(wwegaddr),
       .wwegfin(wwegfin),
       .pe_cs(pe_cs),
       .rwegolfin(rwegolfin),
       .wwegrdy(wweg0rdy),
       .rwegvld(rweg0vld),
       .rwegdata(rweg0data),
       .rwegfin(rweg0fin)
   );
   
   weg #(
        .WEGREDNUM(WEGREDNUM),
        .WEGREGADRWID(WEGREGADRWID)
      )u_weg1(
        .clk(clk),
        .rst_n(rst_n),
        .wwegvld(wweg1vld),
        .rwegrdy(rweg1rdy),
        .wwegdata(wweg1data),
        .wwegaddr(wwegaddr),
        .wwegfin(wwegfin),
        .pe_cs(pe_cs),
        .rwegolfin(rwegolfin),
        .wwegrdy(wweg1rdy),
        .rwegvld(rweg1vld),
        .rwegdata(rweg1data),
        .rwegfin(rweg1fin)
      );
      
      //=======================================================//
      
      ctrl_w #(
        .WEGMEMADRWID(WEGMEMADRWID),
        .WEGREGADRWID(WEGREGADRWID)
      ) u_ctrl_w(
        .clk(clk),
        .rst_n(rst_n),
        .wweglyrcnt(wweglyrcnt),
        .wegmemdata(wegmemdata),
        .rwegmembias(rwegmembias),
        .wweg0rdy(wweg0rdy),
        .wweg1rdy(wweg1rdy),
        .wegmemena(wegmemena),
        .wegmemwea(wegmemwea),
        .wegmemaddr(wegmemaddr),
        .wwegaddr(wwegaddr),
        .wweg0vld(wweg0vld),
        .wweg1vld(wweg1vld),
        .wweg0data(wweg0data),
        .wweg1data(wweg1data),
        .wwegfin(wwegfin)
      );
      
      //=============================================//
      
      weg_mem u_weg_mem(
          .clka(clk),
          .ena(wegmemena), // enable
          .wea(wegmemwea), // 0 rd 1 wr
          .addra(wegmemaddr),
          .dina(1'b0),
          .douta(wegmemdata)
      );
      
      //=============================================//
      
      pooling #(
        .ACTMEMADRWID(ACTMEMADRWID)
      ) u_pooling (
        .clk(clk),
        .rst_n(rst_n),
        .peout(peout),
        .peouten(peouten),
        .pe_cs(pe_cs),
        //.rlyrfin(rlyrfin),
        .wactmem0addr(wactmem0addr),
        .wactmem1addr(wactmem1addr),
        .wactmem0ena(wactmem0ena),
        .wactmem1ena(wactmem1ena),
        .wactmem0wea(wactmem0wea),
        .wactmem1wea(wactmem1wea),
        .wactmemdata(wactmemdata),
        .wmemnum(wmemnum)
      );
    
endmodule
