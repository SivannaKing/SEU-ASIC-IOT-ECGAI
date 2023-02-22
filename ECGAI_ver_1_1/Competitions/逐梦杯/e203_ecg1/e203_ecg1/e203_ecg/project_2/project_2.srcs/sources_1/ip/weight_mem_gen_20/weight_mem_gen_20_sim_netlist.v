// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.1 (win64) Build 2188600 Wed Apr  4 18:40:38 MDT 2018
// Date        : Mon Nov 29 14:57:39 2021
// Host        : DESKTOP-5DABIT8 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/FPGA/e203_ecg/e203_ecg/project_2/project_2.srcs/sources_1/ip/weight_mem_gen_20/weight_mem_gen_20_sim_netlist.v
// Design      : weight_mem_gen_20
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a200tfbg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "weight_mem_gen_20,blk_mem_gen_v8_4_1,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_1,Vivado 2018.1" *) 
(* NotValidForBitStream *)
module weight_mem_gen_20
   (clka,
    ena,
    wea,
    addra,
    dina,
    clkb,
    enb,
    addrb,
    doutb);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [13:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [7:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB EN" *) input enb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [13:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [7:0]doutb;

  wire [13:0]addra;
  wire [13:0]addrb;
  wire clka;
  wire clkb;
  wire [7:0]dina;
  wire [7:0]doutb;
  wire ena;
  wire enb;
  wire [0:0]wea;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [7:0]NLW_U0_douta_UNCONNECTED;
  wire [13:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [13:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [7:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "14" *) 
  (* C_ADDRB_WIDTH = "14" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "1" *) 
  (* C_COUNT_36K_BRAM = "2" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     4.123218 mW" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "1" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "1" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "weight_mem_gen_20.mem" *) 
  (* C_INIT_FILE_NAME = "weight_mem_gen_20.mif" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "1" *) 
  (* C_MEM_TYPE = "1" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "10178" *) 
  (* C_READ_DEPTH_B = "10178" *) 
  (* C_READ_WIDTH_A = "8" *) 
  (* C_READ_WIDTH_B = "8" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "10178" *) 
  (* C_WRITE_DEPTH_B = "10178" *) 
  (* C_WRITE_MODE_A = "NO_CHANGE" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "8" *) 
  (* C_WRITE_WIDTH_B = "8" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  weight_mem_gen_20_blk_mem_gen_v8_4_1 U0
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(NLW_U0_douta_UNCONNECTED[7:0]),
        .doutb(doutb),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(enb),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[13:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[13:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[7:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(1'b0));
endmodule

(* ORIG_REF_NAME = "bindec" *) 
module weight_mem_gen_20_bindec
   (ena_array,
    addra,
    ena);
  output [0:0]ena_array;
  input [2:0]addra;
  input ena;

  wire [2:0]addra;
  wire ena;
  wire [0:0]ena_array;

  LUT4 #(
    .INIT(16'h1000)) 
    \ENOUT_inferred__3/i_ 
       (.I0(addra[1]),
        .I1(addra[0]),
        .I2(addra[2]),
        .I3(ena),
        .O(ena_array));
endmodule

(* ORIG_REF_NAME = "bindec" *) 
module weight_mem_gen_20_bindec_0
   (enb_array,
    addrb,
    enb);
  output [0:0]enb_array;
  input [2:0]addrb;
  input enb;

  wire [2:0]addrb;
  wire enb;
  wire [0:0]enb_array;

  LUT4 #(
    .INIT(16'h1000)) 
    \ENOUT_inferred__3/i_ 
       (.I0(addrb[1]),
        .I1(addrb[0]),
        .I2(addrb[2]),
        .I3(enb),
        .O(enb_array));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_generic_cstr" *) 
module weight_mem_gen_20_blk_mem_gen_generic_cstr
   (doutb,
    clka,
    clkb,
    enb,
    addra,
    addrb,
    dina,
    wea,
    ena);
  output [7:0]doutb;
  input clka;
  input clkb;
  input enb;
  input [13:0]addra;
  input [13:0]addrb;
  input [7:0]dina;
  input [0:0]wea;
  input ena;

  wire [13:0]addra;
  wire [13:0]addrb;
  wire clka;
  wire clkb;
  wire [7:0]dina;
  wire [7:0]doutb;
  wire ena;
  wire [4:4]ena_array;
  wire enb;
  wire [4:4]enb_array;
  wire [7:0]ram_doutb;
  wire \ramloop[1].ram.r_n_0 ;
  wire \ramloop[1].ram.r_n_1 ;
  wire \ramloop[1].ram.r_n_2 ;
  wire \ramloop[1].ram.r_n_3 ;
  wire \ramloop[1].ram.r_n_4 ;
  wire \ramloop[1].ram.r_n_5 ;
  wire \ramloop[1].ram.r_n_6 ;
  wire \ramloop[1].ram.r_n_7 ;
  wire \ramloop[2].ram.r_n_0 ;
  wire \ramloop[2].ram.r_n_1 ;
  wire \ramloop[2].ram.r_n_2 ;
  wire \ramloop[2].ram.r_n_3 ;
  wire \ramloop[2].ram.r_n_4 ;
  wire \ramloop[2].ram.r_n_5 ;
  wire \ramloop[2].ram.r_n_6 ;
  wire \ramloop[2].ram.r_n_7 ;
  wire [0:0]wea;

  weight_mem_gen_20_bindec \bindec_a.bindec_inst_a 
       (.addra(addra[13:11]),
        .ena(ena),
        .ena_array(ena_array));
  weight_mem_gen_20_bindec_0 \bindec_b.bindec_inst_b 
       (.addrb(addrb[13:11]),
        .enb(enb),
        .enb_array(enb_array));
  weight_mem_gen_20_blk_mem_gen_mux__parameterized0 \has_mux_b.B 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ({\ramloop[1].ram.r_n_0 ,\ramloop[1].ram.r_n_1 ,\ramloop[1].ram.r_n_2 ,\ramloop[1].ram.r_n_3 ,\ramloop[1].ram.r_n_4 ,\ramloop[1].ram.r_n_5 ,\ramloop[1].ram.r_n_6 ,\ramloop[1].ram.r_n_7 }),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 (ram_doutb),
        .DOBDO({\ramloop[2].ram.r_n_0 ,\ramloop[2].ram.r_n_1 ,\ramloop[2].ram.r_n_2 ,\ramloop[2].ram.r_n_3 ,\ramloop[2].ram.r_n_4 ,\ramloop[2].ram.r_n_5 ,\ramloop[2].ram.r_n_6 ,\ramloop[2].ram.r_n_7 }),
        .addrb(addrb[13:11]),
        .clkb(clkb),
        .doutb(doutb),
        .enb(enb));
  weight_mem_gen_20_blk_mem_gen_prim_width \ramloop[0].ram.r 
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .dina(dina),
        .\doutb[7] (ram_doutb),
        .ena(ena),
        .enb(enb),
        .wea(wea));
  weight_mem_gen_20_blk_mem_gen_prim_width__parameterized0 \ramloop[1].ram.r 
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .dina(dina),
        .\doutb[7] ({\ramloop[1].ram.r_n_0 ,\ramloop[1].ram.r_n_1 ,\ramloop[1].ram.r_n_2 ,\ramloop[1].ram.r_n_3 ,\ramloop[1].ram.r_n_4 ,\ramloop[1].ram.r_n_5 ,\ramloop[1].ram.r_n_6 ,\ramloop[1].ram.r_n_7 }),
        .ena(ena),
        .enb(enb),
        .wea(wea));
  weight_mem_gen_20_blk_mem_gen_prim_width__parameterized1 \ramloop[2].ram.r 
       (.DOBDO({\ramloop[2].ram.r_n_0 ,\ramloop[2].ram.r_n_1 ,\ramloop[2].ram.r_n_2 ,\ramloop[2].ram.r_n_3 ,\ramloop[2].ram.r_n_4 ,\ramloop[2].ram.r_n_5 ,\ramloop[2].ram.r_n_6 ,\ramloop[2].ram.r_n_7 }),
        .addra(addra[10:0]),
        .addrb(addrb[10:0]),
        .clka(clka),
        .clkb(clkb),
        .dina(dina),
        .ena_array(ena_array),
        .enb(enb),
        .enb_array(enb_array),
        .wea(wea));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_mux" *) 
module weight_mem_gen_20_blk_mem_gen_mux__parameterized0
   (doutb,
    enb,
    addrb,
    clkb,
    DOBDO,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 );
  output [7:0]doutb;
  input enb;
  input [2:0]addrb;
  input clkb;
  input [7:0]DOBDO;
  input [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ;
  input [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ;

  wire [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ;
  wire [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ;
  wire [7:0]DOBDO;
  wire [2:0]addrb;
  wire clkb;
  wire [7:0]doutb;
  wire enb;
  wire [2:0]sel_pipe;
  wire [2:0]sel_pipe_d1;

  LUT6 #(
    .INIT(64'h0F004F4F0F004040)) 
    \doutb[0]_INST_0 
       (.I0(sel_pipe_d1[0]),
        .I1(DOBDO[0]),
        .I2(sel_pipe_d1[2]),
        .I3(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram [0]),
        .I4(sel_pipe_d1[1]),
        .I5(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 [0]),
        .O(doutb[0]));
  LUT6 #(
    .INIT(64'h0F004F4F0F004040)) 
    \doutb[1]_INST_0 
       (.I0(sel_pipe_d1[0]),
        .I1(DOBDO[1]),
        .I2(sel_pipe_d1[2]),
        .I3(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram [1]),
        .I4(sel_pipe_d1[1]),
        .I5(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 [1]),
        .O(doutb[1]));
  LUT6 #(
    .INIT(64'h0F004F4F0F004040)) 
    \doutb[2]_INST_0 
       (.I0(sel_pipe_d1[0]),
        .I1(DOBDO[2]),
        .I2(sel_pipe_d1[2]),
        .I3(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram [2]),
        .I4(sel_pipe_d1[1]),
        .I5(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 [2]),
        .O(doutb[2]));
  LUT6 #(
    .INIT(64'h0F004F4F0F004040)) 
    \doutb[3]_INST_0 
       (.I0(sel_pipe_d1[0]),
        .I1(DOBDO[3]),
        .I2(sel_pipe_d1[2]),
        .I3(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram [3]),
        .I4(sel_pipe_d1[1]),
        .I5(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 [3]),
        .O(doutb[3]));
  LUT6 #(
    .INIT(64'h0F004F4F0F004040)) 
    \doutb[4]_INST_0 
       (.I0(sel_pipe_d1[0]),
        .I1(DOBDO[4]),
        .I2(sel_pipe_d1[2]),
        .I3(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram [4]),
        .I4(sel_pipe_d1[1]),
        .I5(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 [4]),
        .O(doutb[4]));
  LUT6 #(
    .INIT(64'h0F004F4F0F004040)) 
    \doutb[5]_INST_0 
       (.I0(sel_pipe_d1[0]),
        .I1(DOBDO[5]),
        .I2(sel_pipe_d1[2]),
        .I3(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram [5]),
        .I4(sel_pipe_d1[1]),
        .I5(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 [5]),
        .O(doutb[5]));
  LUT6 #(
    .INIT(64'h0F004F4F0F004040)) 
    \doutb[6]_INST_0 
       (.I0(sel_pipe_d1[0]),
        .I1(DOBDO[6]),
        .I2(sel_pipe_d1[2]),
        .I3(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram [6]),
        .I4(sel_pipe_d1[1]),
        .I5(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 [6]),
        .O(doutb[6]));
  LUT6 #(
    .INIT(64'h0F004F4F0F004040)) 
    \doutb[7]_INST_0 
       (.I0(sel_pipe_d1[0]),
        .I1(DOBDO[7]),
        .I2(sel_pipe_d1[2]),
        .I3(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram [7]),
        .I4(sel_pipe_d1[1]),
        .I5(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 [7]),
        .O(doutb[7]));
  FDRE #(
    .INIT(1'b0)) 
    \no_softecc_norm_sel2.has_mem_regs.WITHOUT_ECC_PIPE.ce_pri.sel_pipe_d1_reg[0] 
       (.C(clkb),
        .CE(enb),
        .D(sel_pipe[0]),
        .Q(sel_pipe_d1[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \no_softecc_norm_sel2.has_mem_regs.WITHOUT_ECC_PIPE.ce_pri.sel_pipe_d1_reg[1] 
       (.C(clkb),
        .CE(enb),
        .D(sel_pipe[1]),
        .Q(sel_pipe_d1[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \no_softecc_norm_sel2.has_mem_regs.WITHOUT_ECC_PIPE.ce_pri.sel_pipe_d1_reg[2] 
       (.C(clkb),
        .CE(enb),
        .D(sel_pipe[2]),
        .Q(sel_pipe_d1[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \no_softecc_sel_reg.ce_pri.sel_pipe_reg[0] 
       (.C(clkb),
        .CE(enb),
        .D(addrb[0]),
        .Q(sel_pipe[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \no_softecc_sel_reg.ce_pri.sel_pipe_reg[1] 
       (.C(clkb),
        .CE(enb),
        .D(addrb[1]),
        .Q(sel_pipe[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \no_softecc_sel_reg.ce_pri.sel_pipe_reg[2] 
       (.C(clkb),
        .CE(enb),
        .D(addrb[2]),
        .Q(sel_pipe[2]),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module weight_mem_gen_20_blk_mem_gen_prim_width
   (\doutb[7] ,
    clka,
    clkb,
    enb,
    addra,
    addrb,
    dina,
    wea,
    ena);
  output [7:0]\doutb[7] ;
  input clka;
  input clkb;
  input enb;
  input [13:0]addra;
  input [13:0]addrb;
  input [7:0]dina;
  input [0:0]wea;
  input ena;

  wire [13:0]addra;
  wire [13:0]addrb;
  wire clka;
  wire clkb;
  wire [7:0]dina;
  wire [7:0]\doutb[7] ;
  wire ena;
  wire enb;
  wire [0:0]wea;

  weight_mem_gen_20_blk_mem_gen_prim_wrapper_init \prim_init.ram 
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .dina(dina),
        .\doutb[7] (\doutb[7] ),
        .ena(ena),
        .enb(enb),
        .wea(wea));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module weight_mem_gen_20_blk_mem_gen_prim_width__parameterized0
   (\doutb[7] ,
    clka,
    clkb,
    enb,
    addra,
    addrb,
    dina,
    wea,
    ena);
  output [7:0]\doutb[7] ;
  input clka;
  input clkb;
  input enb;
  input [13:0]addra;
  input [13:0]addrb;
  input [7:0]dina;
  input [0:0]wea;
  input ena;

  wire [13:0]addra;
  wire [13:0]addrb;
  wire clka;
  wire clkb;
  wire [7:0]dina;
  wire [7:0]\doutb[7] ;
  wire ena;
  wire enb;
  wire [0:0]wea;

  weight_mem_gen_20_blk_mem_gen_prim_wrapper_init__parameterized0 \prim_init.ram 
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .dina(dina),
        .\doutb[7] (\doutb[7] ),
        .ena(ena),
        .enb(enb),
        .wea(wea));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module weight_mem_gen_20_blk_mem_gen_prim_width__parameterized1
   (DOBDO,
    clka,
    clkb,
    ena_array,
    enb_array,
    enb,
    addra,
    addrb,
    dina,
    wea);
  output [7:0]DOBDO;
  input clka;
  input clkb;
  input [0:0]ena_array;
  input [0:0]enb_array;
  input enb;
  input [10:0]addra;
  input [10:0]addrb;
  input [7:0]dina;
  input [0:0]wea;

  wire [7:0]DOBDO;
  wire [10:0]addra;
  wire [10:0]addrb;
  wire clka;
  wire clkb;
  wire [7:0]dina;
  wire [0:0]ena_array;
  wire enb;
  wire [0:0]enb_array;
  wire [0:0]wea;

  weight_mem_gen_20_blk_mem_gen_prim_wrapper_init__parameterized1 \prim_init.ram 
       (.DOBDO(DOBDO),
        .addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .dina(dina),
        .ena_array(ena_array),
        .enb(enb),
        .enb_array(enb_array),
        .wea(wea));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module weight_mem_gen_20_blk_mem_gen_prim_wrapper_init
   (\doutb[7] ,
    clka,
    clkb,
    enb,
    addra,
    addrb,
    dina,
    wea,
    ena);
  output [7:0]\doutb[7] ;
  input clka;
  input clkb;
  input enb;
  input [13:0]addra;
  input [13:0]addrb;
  input [7:0]dina;
  input [0:0]wea;
  input ena;

  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_1_n_0 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_2_n_0 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_75 ;
  wire [13:0]addra;
  wire [13:0]addrb;
  wire clka;
  wire clkb;
  wire [7:0]dina;
  wire [7:0]\doutb[7] ;
  wire ena;
  wire enb;
  wire [0:0]wea;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED ;
  wire [31:8]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED ;
  wire [3:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(1),
    .DOB_REG(1),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0203028405028604848100000581008583018305860284870483878384010187),
    .INIT_01(256'h0581000005020103020082888282830001018502018304000305830204028404),
    .INIT_02(256'h0287068205048483020586840300818400010082008102818388810001838686),
    .INIT_03(256'h0000820085840185848282030706028102850104830483850281020085050301),
    .INIT_04(256'h0001818502840004838101040383018588858604040583028201818303860403),
    .INIT_05(256'h8488858105078202838284848585010707060704050281058481008481848201),
    .INIT_06(256'h0285888982030500000201000101030481000505050584858902020104010085),
    .INIT_07(256'h0402008201008400040001828503830205858402028302030081018884000305),
    .INIT_08(256'h0281020285850206828104840085810282030200848682840104008302818586),
    .INIT_09(256'h0284028283018302820004810583838181830000030187018200818183820501),
    .INIT_0A(256'h0001850301050084038402010283830382048101010004008482848786870282),
    .INIT_0B(256'h8485820001000287828500010403020081000404860481048181818384018181),
    .INIT_0C(256'h0484028405000282860102818581020281840285010604830004000003848582),
    .INIT_0D(256'h0482008101030283830001028204040087888301018205050084008100028103),
    .INIT_0E(256'h8202030201868584018402038387838381830284040003888481028181008381),
    .INIT_0F(256'h8582868284848301028283010302848104830081848186850082018302828182),
    .INIT_10(256'h8585830302818282058389840085860101818283030202028183848383000181),
    .INIT_11(256'h8202018383820503820081020383830104818100038181818582040186850383),
    .INIT_12(256'h0202858383020201038282858101020001810281840305008184030001000305),
    .INIT_13(256'h0383820001838202858401840283860304008181020200008382038682818501),
    .INIT_14(256'h0404000081010101000101008281008683868381858202018700820300010081),
    .INIT_15(256'h0284810403828D00810000830403040104810082018601010184020000820000),
    .INIT_16(256'h0000830300008381000000858281008184000081820100018183830101018202),
    .INIT_17(256'h028304828201810105000283030200820300018C810503838100818182860201),
    .INIT_18(256'h8501810482818881050581880000060186018202838185830600828501010282),
    .INIT_19(256'h82000081008686838285818C8101058489830001810202810481048202038100),
    .INIT_1A(256'h0404818587020400048201830000050203820206048204008288888601820288),
    .INIT_1B(256'h0082840402820200028286030102010181058A84818385030686820405850001),
    .INIT_1C(256'h0281008288858302000300850203838301818683010200820084838184030383),
    .INIT_1D(256'h8382858400008200878183828301010285838281020203820182018182008381),
    .INIT_1E(256'h8382000000838101048202818381828407828181838281010100840201030684),
    .INIT_1F(256'h0102830302000101828384018183858685818181828283858403010205028183),
    .INIT_20(256'h8482810084838200020282050681010085048282048186810200010105018382),
    .INIT_21(256'h0500000184850103010103028188040383018301818282008201000404858600),
    .INIT_22(256'h0102838184018485838300008201828384820003028184000083818200848181),
    .INIT_23(256'h8500000100028201030200040101000301838183000001028282818182820083),
    .INIT_24(256'h0182830183000082000000018181008101810102008382810181838382028381),
    .INIT_25(256'h8382008203008500828281018182838284018181018183820404818100008282),
    .INIT_26(256'h0302820083830000820183008100818182828100848383028202828284838282),
    .INIT_27(256'h8181810001038382810103828181008282010182038100008100030603810183),
    .INIT_28(256'h8582008282838383028185810082838281010201008281818482000081828300),
    .INIT_29(256'h8381008302028101830281838181018203030082008382818200828282840282),
    .INIT_2A(256'h0085850100828202818584810281038181848484008181008281830181828300),
    .INIT_2B(256'h0000828486840101010284020184030282838382810102038102020300850103),
    .INIT_2C(256'h8200010082810102830102848302820004030481040304850000040001000000),
    .INIT_2D(256'h8402000282030384020081018186858383838300828384828101830305028200),
    .INIT_2E(256'h8401008182018181028183000000038401000002028182810281010101810001),
    .INIT_2F(256'h0402018985008301038283840382030602010302030002010001838102028285),
    .INIT_30(256'h0081830204020181020100020381018300810183010003040101030100010101),
    .INIT_31(256'h0304000084820104818300818382848283838501000001020101038281828400),
    .INIT_32(256'h0001000200038289020183850382868102008302000201010184818200830183),
    .INIT_33(256'h8102840201018202018202820183810383010502840504818581828181038200),
    .INIT_34(256'h8185030481010182828181040201830402010281008201810104010200010183),
    .INIT_35(256'h8386018183000202020303038205040186038403030085818202820484000100),
    .INIT_36(256'h8582858581050004000181028400008202020182038383838383818382008283),
    .INIT_37(256'h8202818100820282838103010083810281820202838302038302028103028486),
    .INIT_38(256'h0002818102810002020282838481018101000401868B84048100820281840102),
    .INIT_39(256'h0381008202000283840081848401058286850183820100028283880104020289),
    .INIT_3A(256'h8402030082810202830081810482828185000381878883018485020181898402),
    .INIT_3B(256'h8386030400870000830281010381828481050400830404008783838483810100),
    .INIT_3C(256'h028681028103040201818301008581818503040101890103010082038A020204),
    .INIT_3D(256'h8781020303838500830102858602008301008203888181850181828286810500),
    .INIT_3E(256'h8281020283838185848284850283858987820304030302008786858288858686),
    .INIT_3F(256'h0501038283818584840000860301010301840181850301830002838301020103),
    .INIT_40(256'h0381810103858102008385820100010103028381030203818200050501048382),
    .INIT_41(256'h8200828102818281018484028382018382820083848684030484838581820202),
    .INIT_42(256'h0205030282020004010200000100010202828281838282010100830283828282),
    .INIT_43(256'h8182820381840084020085838281838787008202820082020404818703010182),
    .INIT_44(256'h8885838488830000828281820002898685018187850200018103038184830002),
    .INIT_45(256'h0383848103000001848381038301848481838100810184840082830001000085),
    .INIT_46(256'h0081828283018383810403030285828200008202820100810281028200818202),
    .INIT_47(256'h0002820000810281828284820181018183820183848383818300018482830084),
    .INIT_48(256'h0084828585858583010101838281810100008282000282830183838402028382),
    .INIT_49(256'h0182018184828183830001018201820102830283028182008282828481810083),
    .INIT_4A(256'h0081840182018281838184828382828200818283848102848281820382820000),
    .INIT_4B(256'h8283000284018383818381010000828400838401810284818282830181040001),
    .INIT_4C(256'h8281048104040301008102020283038384000003828203848482000082818101),
    .INIT_4D(256'h0301858684828282810282828788030181818200018101008300818484818202),
    .INIT_4E(256'h0181020081828281000381020081038102018281020181820200010004818300),
    .INIT_4F(256'h0405020002028281050503858582000201000003000201050181000104030404),
    .INIT_50(256'h8101828103008284000001010506060181000005838584848202828201000500),
    .INIT_51(256'h8104840001818206020500010183008102000281000482010100830184000084),
    .INIT_52(256'h0281828282030282018383030282830181838203000005818481878384000402),
    .INIT_53(256'h8103810206040200020202010181030004070504030002828300850083000181),
    .INIT_54(256'h8384038100008181810181000283820403028481838381828482000081020182),
    .INIT_55(256'h848481858381838184818483838903040404010101020081008103818300878B),
    .INIT_56(256'h0403048102030481858681840000818181020003028282818203020201018202),
    .INIT_57(256'h0003818485870001850301010083820002050001810302050300830183830200),
    .INIT_58(256'h0201020001008387878382828183008182838101828302820381820003830285),
    .INIT_59(256'h0101040100830000858387848601820403838281028200020406000305060606),
    .INIT_5A(256'h0183020101020204010084830182010202020103848281038481820102830281),
    .INIT_5B(256'h8181810000018304810181810100818204818100820303828381840402040302),
    .INIT_5C(256'h0101018101020202000382030300020502030302008286840081028301828203),
    .INIT_5D(256'h0483820082020181830281008103028181050402060301810100838681030082),
    .INIT_5E(256'h8681060281830504010302050181020381830304020301020202000206018103),
    .INIT_5F(256'h8481010381830183000004040701018300820001828201810102008100008487),
    .INIT_60(256'h0181848181848504070504070605820802068202038305010000030102810100),
    .INIT_61(256'h8603830103818987818181830283020281830384858201848582858484000203),
    .INIT_62(256'h0A00038300010084840281040003820100858500860482020001040103028385),
    .INIT_63(256'h8183000001008383038302828503040508040002020082818201810203820504),
    .INIT_64(256'h0204018104828382020101018403028482838185878701858500810081858202),
    .INIT_65(256'h8100830004830100838483008484028181018181028502020181858302008281),
    .INIT_66(256'h0381018101810281028103020001848587838301810606050000010201818102),
    .INIT_67(256'h0101810481020104008181818200820001058183060003020201050206030181),
    .INIT_68(256'h0303018401010100020402820081020100828185828584828283000003028102),
    .INIT_69(256'h018481838603020201058C818182820502000102028203818182030204820805),
    .INIT_6A(256'h8100038101810184868385000102810101028301028400830605848501000085),
    .INIT_6B(256'h8382828202080205008185838504030202020181070908850706828685018200),
    .INIT_6C(256'h8282030200048386888181858381850101810402000500838402040300030181),
    .INIT_6D(256'h8381028581040184010381840187008181848181830301000404010003080807),
    .INIT_6E(256'h0002000001010302038104060484028182830181820206840301840001828300),
    .INIT_6F(256'h0181820201860400868485008200018500010103028400818583810281048383),
    .INIT_70(256'h0083000381858302028282850381830500048104818104888405818684818101),
    .INIT_71(256'h0184848583898181818283818281028283810700850102020283820408038602),
    .INIT_72(256'h8383838182000284000000020201818201810183830104868103838281810603),
    .INIT_73(256'h8107000381818384828304060403018204008382040202810200810403810282),
    .INIT_74(256'h0103008303818100818201030000810204030483018203020100020201020182),
    .INIT_75(256'h0501040283840084848683848383020181820281018300828700848100020404),
    .INIT_76(256'h0882010181820004050405028302010182030105040381000103868787878702),
    .INIT_77(256'h010182810281000282810303028481038501010200000201838405000709080A),
    .INIT_78(256'h8100820581018284848204810201040381818383810202810282000100828300),
    .INIT_79(256'h8484838786838205000301038202050403010183838402828200848302818300),
    .INIT_7A(256'h0301030381850204000104060004858887898486848107830083820002848282),
    .INIT_7B(256'h0382828281020083010284000202830183830184010001000001050204040504),
    .INIT_7C(256'h8300858200018183838102040082810201818683838189028281020002820401),
    .INIT_7D(256'h0204038102828202020201000103050104810581810081838381820100820081),
    .INIT_7E(256'h00810000038184830283858108838586010A08848E8601000103000386018304),
    .INIT_7F(256'h0504058482868400008102818887830101838289820283848484828300858682),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(9),
    .READ_WIDTH_B(9),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("NO_CHANGE"),
    .WRITE_MODE_B("NO_CHANGE"),
    .WRITE_WIDTH_A(9),
    .WRITE_WIDTH_B(9)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({1'b1,addra[11:0],1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b1,addrb[11:0],1'b1,1'b1,1'b1}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clkb),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,dina}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:0]),
        .DOBDO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:8],\doutb[7] }),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:1],\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_75 }),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_1_n_0 ),
        .ENBWREN(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_2_n_0 ),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(enb),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .WEA({wea,wea,wea,wea}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
  LUT3 #(
    .INIT(8'h02)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_1 
       (.I0(ena),
        .I1(addra[12]),
        .I2(addra[13]),
        .O(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h02)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_2 
       (.I0(enb),
        .I1(addrb[12]),
        .I2(addrb[13]),
        .O(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_2_n_0 ));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module weight_mem_gen_20_blk_mem_gen_prim_wrapper_init__parameterized0
   (\doutb[7] ,
    clka,
    clkb,
    enb,
    addra,
    addrb,
    dina,
    wea,
    ena);
  output [7:0]\doutb[7] ;
  input clka;
  input clkb;
  input enb;
  input [13:0]addra;
  input [13:0]addrb;
  input [7:0]dina;
  input [0:0]wea;
  input ena;

  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_1__0_n_0 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_2__0_n_0 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_75 ;
  wire [13:0]addra;
  wire [13:0]addrb;
  wire clka;
  wire clkb;
  wire [7:0]dina;
  wire [7:0]\doutb[7] ;
  wire ena;
  wire enb;
  wire [0:0]wea;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED ;
  wire [31:8]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED ;
  wire [3:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(1),
    .DOB_REG(1),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h048181018102868582828102828385010383020101828109050000050B008600),
    .INIT_01(256'h818182000103030385070A04048586030A810182820001018285020101018681),
    .INIT_02(256'h0501000202820282820382000387878200040283858A8A830503050183838482),
    .INIT_03(256'h048201858C01040002848301848503048183860103020D048188810300000100),
    .INIT_04(256'h0081848300010406848481058185030A03830103828289878182008303010000),
    .INIT_05(256'h8100810201820482818482020300010188818482830402080603898A878B8405),
    .INIT_06(256'h8601060181028285888B02030602820382010182838401018384818105818300),
    .INIT_07(256'h0181810303028383010386820304048484838987028282008383018100810184),
    .INIT_08(256'h0100820201030282030083018181830084020000010204010201810001020302),
    .INIT_09(256'h0301828304848183828202000182000000018201818300838383848201028181),
    .INIT_0A(256'h8283810100030005040104818281020381000381058281818101040100830204),
    .INIT_0B(256'h8100008484838684030303818585000481848201030303830081830285828300),
    .INIT_0C(256'h8301020383010181830101830283040203000302010284040002840202820282),
    .INIT_0D(256'h0200820181810401030503058101838103838202020382010104038201008200),
    .INIT_0E(256'h0300038181008302830182008382008684838684830002818284838582038281),
    .INIT_0F(256'h8181830083838203830003008384018483860082838383818481060081828281),
    .INIT_10(256'h0806010383848200838184830281010003010282008200020400018200018381),
    .INIT_11(256'h0182000082818281810203060084870082028203818300030183818102830602),
    .INIT_12(256'h8382820002810182828884850902000202060601018103810181010282020202),
    .INIT_13(256'h8182898607030003818182828185018381810000828502020101008205838301),
    .INIT_14(256'h0600828100028281028302010381818106008303048104038283030804028182),
    .INIT_15(256'h8402828101828281810102818602088181860182000000838388858700030306),
    .INIT_16(256'h8204010281010200818287828787868182830382838100810000040100028200),
    .INIT_17(256'h8181030203048203018400828682858184020104020406058103040202828200),
    .INIT_18(256'h0083868286028100828B84838682030303028388868187880302030502838381),
    .INIT_19(256'h0482828584820383008103018303010184010101848100020383868789870181),
    .INIT_1A(256'h0303030202018586838183000183020301830402010505818384028282830000),
    .INIT_1B(256'h0501040503018101820081000202048486848584018282030002028201830782),
    .INIT_1C(256'h0083828383010301828681050382838100838402030100018584838384870082),
    .INIT_1D(256'h0385838885020302020588818703020181838205020086850000010100030386),
    .INIT_1E(256'h8201018484010808818201870606068281838381840381828382878205050500),
    .INIT_1F(256'h8400820004830482828384828484000006858685010082018302028202828486),
    .INIT_20(256'h8486810284858181048303818203030187848405850300028100820184018103),
    .INIT_21(256'h8882008400830201830300018385000082000200018100020601058281838784),
    .INIT_22(256'h0382878684810482060201838184020284838384008284828581858987828102),
    .INIT_23(256'h040183828682840203068B8B8C00020282868807030581020004000503050483),
    .INIT_24(256'h8102018501830406068785870383050202028685868101048881870481040003),
    .INIT_25(256'h8201868384048105030005878286020405020508020300820407000101848181),
    .INIT_26(256'h8603030304070100828484020281030001828183820284000089878986898781),
    .INIT_27(256'h0283810082830603020100838501878887840004000084830201818301030181),
    .INIT_28(256'h8303848481038182818102008381040102000082008201840381040582830082),
    .INIT_29(256'h0202810400008103810082838400008285830884040083820186838182000003),
    .INIT_2A(256'h0386030604820402018105040502010589058500810081828184020782820202),
    .INIT_2B(256'h0382020300048381830285000402000081830282020001848302820303058101),
    .INIT_2C(256'h0085008282858281010100038203858103018503830202828382020485000005),
    .INIT_2D(256'h0303038300830103038582008301028401830602820101000783810100018101),
    .INIT_2E(256'h0604020003018383818281038383830381820383818103040083008102828100),
    .INIT_2F(256'h8181838202020185000181838504030603080281018304848300040600810081),
    .INIT_30(256'h8284860184850002008400010004018581008581028103810303820202010202),
    .INIT_31(256'h8685810101818183828482040102868401818101820483010204010404028302),
    .INIT_32(256'h0381030205030500810281040104810682060302058684030282058302038387),
    .INIT_33(256'h0305068201020004820182018105810181838382028185000181840301838184),
    .INIT_34(256'h0081028100018185848602000200830384878587078184848183838183018300),
    .INIT_35(256'h0104868100828484018289888200038381810100838603030182818683030300),
    .INIT_36(256'h0101000202020204820202828300000282878282028182030183840504848302),
    .INIT_37(256'h8100838381000102820083000000018600848181810404028301010581018302),
    .INIT_38(256'h0005050585028282028301030482848405030006828203838601830187888401),
    .INIT_39(256'h8283828300020403828481018386838186028105010381020581850504848281),
    .INIT_3A(256'h8202060203040082008588848581820184018205818500040003040702030081),
    .INIT_3B(256'h8503820000818183838201838183018407050385848381058185818284828202),
    .INIT_3C(256'h0002070500048486010383838388008601000103068A8C820082880005028581),
    .INIT_3D(256'h8200860101838103858185018184820501848185828300040282818286050100),
    .INIT_3E(256'h0702810285860101828104818184010383878481010804818200810301068382),
    .INIT_3F(256'h82030703000384048100858C01028102818286898B0102038789838184820506),
    .INIT_40(256'h0301060508040281868381868782008685040103018201850002038202858285),
    .INIT_41(256'h8B00888601840084810104050683878B84010104040900010182828484898A83),
    .INIT_42(256'h8586880104010181840482028786828403030304068C858B8A84860503018A87),
    .INIT_43(256'h850081858686818683838983008586848A848481818789018281820189810106),
    .INIT_44(256'h03830088858684828785050382848484838A880001078484868283818A878501),
    .INIT_45(256'h0183020083858385838383828106070300018389878887860283028989820205),
    .INIT_46(256'h0387020403048484040288008B83848986830184858100848486818184868581),
    .INIT_47(256'h88018A82848181878A03820285868C0188000282868782028183838587010101),
    .INIT_48(256'h03040406838387830008028B8487830408880004838805818782840302010701),
    .INIT_49(256'h0E8B86078584848402020284838A090501848302008684840185018384028186),
    .INIT_4A(256'h8709830400820002868100820082818683010100000100020181828682098904),
    .INIT_4B(256'h8102858489850002838600810003820606870101000181858484838402840683),
    .INIT_4C(256'h0504010083058281810383858784828984040482040001850104068281820100),
    .INIT_4D(256'h8502820400848406018300020201810400830084850004018601060382858700),
    .INIT_4E(256'h0284848603038286008286850002820000820082840002840281008384050185),
    .INIT_4F(256'h8201028102818301000502868582060103860102820182048381048382020000),
    .INIT_50(256'h0502018603818381810283010102828201878902848184820285810102020181),
    .INIT_51(256'h8583838501068282030400018301000084000806040383838684010001038884),
    .INIT_52(256'h0002830002820003810381838583030282038100820182000101020406868181),
    .INIT_53(256'h0401838583000003020084838483008383040183828282070882848383848282),
    .INIT_54(256'h0202058583818584858102010204018301010085860303810103028182818583),
    .INIT_55(256'h83848181818404850184008A8702028104008781060006010485008200020184),
    .INIT_56(256'h0082018383000082838188858485870283008185028283028201048481828285),
    .INIT_57(256'h8481868100018186838200048382030185810101820001018389018386008282),
    .INIT_58(256'h0001000182820084828182820082818385828583010000010100000181810284),
    .INIT_59(256'h8501820181038383850282018281030084828402020282810104000183048281),
    .INIT_5A(256'h0084038184028400028300828300850281000400838383008500848400820185),
    .INIT_5B(256'h8483830282838183028301018381020201028283008400000302830102018382),
    .INIT_5C(256'h0183830304038381008202840081838201018481850203000085838501008202),
    .INIT_5D(256'h8483818184018182850001828101020381030284840084818482838201020184),
    .INIT_5E(256'h010284030104010482868201000082020002810302010284828487888481838A),
    .INIT_5F(256'h8607020583000385848201010185848400028282028304060282008581018201),
    .INIT_60(256'h8485810306810284838104048781828485000302028181848204028484058388),
    .INIT_61(256'h0002020100028182010706878484028302038104828283848181050081820400),
    .INIT_62(256'h0203810282008205020606070382850084858903820304018181848405050482),
    .INIT_63(256'h82810085898881040081050003060505820A8A88848182010081040305010202),
    .INIT_64(256'h0606840001000004060202898987838781030084018200030100020202000101),
    .INIT_65(256'h0200048183000281028485008300018284028281820283868205070105010706),
    .INIT_66(256'h0082838683830001078583850003008281030301050603058385008382828185),
    .INIT_67(256'h0103838485008200868101838103030201038101838104038302840084040303),
    .INIT_68(256'h8202008204828383838382018100040081020184868700810181040284818402),
    .INIT_69(256'h8588840082000403848586838204850500020200810000810486848588858484),
    .INIT_6A(256'h0284848202820400020200038201850483018285008300860101040582828281),
    .INIT_6B(256'h0184028281018282070202830383830081028302018501038182028300818501),
    .INIT_6C(256'h0405030483830181828102020281008200830502828101028303020284020204),
    .INIT_6D(256'h0003020184820581068100818681820304848182830601040101000403028301),
    .INIT_6E(256'h0103028201028483820185848283008181858585820000028202030085840183),
    .INIT_6F(256'h8281858387058204818281038301020081820406008204018687858302820082),
    .INIT_70(256'h0004818182818382850305018201018105018400030301040304858287850000),
    .INIT_71(256'h8381020905040102030205020203830082848483840005030102000082838206),
    .INIT_72(256'h0083850484848686848300038682878282830283810400820200810382058203),
    .INIT_73(256'h0506018203028204030304850002810100020500818585828201840404060206),
    .INIT_74(256'h8381010282830108060306008282878784020103000082040601010305030601),
    .INIT_75(256'h838482888183050182848381898C8500010B8101820003048101018585820201),
    .INIT_76(256'h8789820383810104048100000503008281010385030203838300070002810481),
    .INIT_77(256'h0601828102020303828200818183838300010101040300050585840082020288),
    .INIT_78(256'h0604060004010305810501818302830281830205020081010002830100028281),
    .INIT_79(256'h8789868201048384878603850101850100818283060003028184050004008184),
    .INIT_7A(256'h0104050384010383858582000183060004828281828400830004010081888601),
    .INIT_7B(256'h8581008787010700000101010506050302870483810201820183848402060081),
    .INIT_7C(256'h8301028585838682830303000283010302010404020302030281020301828603),
    .INIT_7D(256'h8104070002818302008386818185838282028304838202010287818484818188),
    .INIT_7E(256'h0281000281028382810402008305000200028384828184828301848202020001),
    .INIT_7F(256'h8181008185020301008185020086840000028402020705820000058282848181),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(9),
    .READ_WIDTH_B(9),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("NO_CHANGE"),
    .WRITE_MODE_B("NO_CHANGE"),
    .WRITE_WIDTH_A(9),
    .WRITE_WIDTH_B(9)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({1'b1,addra[11:0],1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b1,addrb[11:0],1'b1,1'b1,1'b1}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clkb),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,dina}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:0]),
        .DOBDO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:8],\doutb[7] }),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:1],\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_75 }),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_1__0_n_0 ),
        .ENBWREN(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_2__0_n_0 ),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(enb),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .WEA({wea,wea,wea,wea}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
  LUT3 #(
    .INIT(8'h08)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_1__0 
       (.I0(addra[12]),
        .I1(ena),
        .I2(addra[13]),
        .O(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_1__0_n_0 ));
  LUT3 #(
    .INIT(8'h08)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_2__0 
       (.I0(addrb[12]),
        .I1(enb),
        .I2(addrb[13]),
        .O(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_2__0_n_0 ));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module weight_mem_gen_20_blk_mem_gen_prim_wrapper_init__parameterized1
   (DOBDO,
    clka,
    clkb,
    ena_array,
    enb_array,
    enb,
    addra,
    addrb,
    dina,
    wea);
  output [7:0]DOBDO;
  input clka;
  input clkb;
  input [0:0]ena_array;
  input [0:0]enb_array;
  input enb;
  input [10:0]addra;
  input [10:0]addrb;
  input [7:0]dina;
  input [0:0]wea;

  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM18.ram_n_35 ;
  wire [7:0]DOBDO;
  wire [10:0]addra;
  wire [10:0]addrb;
  wire clka;
  wire clkb;
  wire [7:0]dina;
  wire [0:0]ena_array;
  wire enb;
  wire [0:0]enb_array;
  wire [0:0]wea;
  wire [15:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM18.ram_DOADO_UNCONNECTED ;
  wire [15:8]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM18.ram_DOBDO_UNCONNECTED ;
  wire [1:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM18.ram_DOPADOP_UNCONNECTED ;
  wire [1:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM18.ram_DOPBDOP_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB18E1 #(
    .DOA_REG(1),
    .DOB_REG(1),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h8304030502038308000383868402850200830281020381018284000082008400),
    .INIT_01(256'h8685888281850181838385000183810607838601838300810103048284828181),
    .INIT_02(256'h8582020082830404040200828203020300038288048383818206010208810281),
    .INIT_03(256'h8286848A00010401898502030301000181828781008381838201820805048401),
    .INIT_04(256'h06058382820001840102838304010202000A048105048285060188048101008B),
    .INIT_05(256'h8A86030702840382030187018584020383010504080383058402810283840204),
    .INIT_06(256'h8105010101000081020204000202010104038B06810303860285828402000002),
    .INIT_07(256'h8200830185840381840300030101870284030086048302000381020484000182),
    .INIT_08(256'h8108878D00848382080284008181028284000286038A82008787050506008301),
    .INIT_09(256'h0182038404848284000281838600898100040388010381850203810589030188),
    .INIT_0A(256'h0288848304020081810602848501040181888601028301008182008100028585),
    .INIT_0B(256'h01040181038189018307838A04838287030381048605028606008887028A8582),
    .INIT_0C(256'h8501818381058183848388000186050100848501820584818282008703890103),
    .INIT_0D(256'h818A838400008384000506018A02818701048289048782840584018582028103),
    .INIT_0E(256'h0101828204850103850083820103010284038484018304030303820101840084),
    .INIT_0F(256'h0087000200820802038382010181060B03830581840486080200028381038585),
    .INIT_10(256'h8285068108000481090001060083010002810A82050184818304818201820001),
    .INIT_11(256'h8500010301000709828183820082810382048601078383060183008582040381),
    .INIT_12(256'h010484030083810003000B000400818383088104000382048187020681820602),
    .INIT_13(256'h01030500088782058202830B05018A0502838284820104028282038102010404),
    .INIT_14(256'h06010A0604000181010400030382810582830103010001048201810181010703),
    .INIT_15(256'h8101890508018506030083830001048382850481070001050683810484830481),
    .INIT_16(256'h0401018381850301000005830300030681040011060001068382010002848303),
    .INIT_17(256'h83010202010204890783818706810106030B8201860286030582810302830304),
    .INIT_18(256'h020001810200000D01010008020282008301830A008605810A88810100848285),
    .INIT_19(256'h0201018A01830106070702828600850201010204008582020500848200030001),
    .INIT_1A(256'h01818108000001060282850503820500028B8803050282828584040281838289),
    .INIT_1B(256'h070683818504828201848102838381058382030083030000000000010700810B),
    .INIT_1C(256'h8381820383840882008884828182008281860102830301850200048A85020302),
    .INIT_1D(256'h0681850703830287820183030007890382000387868185050703020704818100),
    .INIT_1E(256'h0302820404018500810604820284018205870200000100838106840387818389),
    .INIT_1F(256'h8501818182018801018400838300860701040005010001810404820503840983),
    .INIT_20(256'h84040685008483890087018285860284000400028A00878A0601840904018385),
    .INIT_21(256'h8783858582828106030301030002810382068309048105020682030700850001),
    .INIT_22(256'h048504818100818202028100878186880600810B828283868481818100838703),
    .INIT_23(256'h0386010182830682010088060181068303820003030402038402008202868486),
    .INIT_24(256'h8101820005008382028202870103018181020385888281010782010383840103),
    .INIT_25(256'h8286000183000282850B0A040506010881080106820600038184830183820084),
    .INIT_26(256'h0203008386040204048702018583830603028506038481008183038283840200),
    .INIT_27(256'h0206080003070908850404028502000481820300818383850188020482000101),
    .INIT_28(256'h0084830084010103080486050089830300810302010382018587810183830000),
    .INIT_29(256'h8302810287030005830501018301868281018402020082850101818682010202),
    .INIT_2A(256'h0A0702038104008B038686000084898884830101000700840003050202080402),
    .INIT_2B(256'h8500000801018601018203868202028481008403038201020201010183038103),
    .INIT_2C(256'h048583008600878A830181848181008381020A02860302010001830005818201),
    .INIT_2D(256'h8984838481810282818289030003040401870381008204010A0B810004040085),
    .INIT_2E(256'h8282818286028383810507038A05060102040000020001048202020289028383),
    .INIT_2F(256'h83018B0483850202810001008203020708038305010201830382850485878A8C),
    .INIT_30(256'h0003088284080501828481820205840286040103020081818383848783830483),
    .INIT_31(256'h810004048C828307840382010001818185010200050401018703828282020183),
    .INIT_32(256'h8383068701010206000483010402018483020081020300870202850083850800),
    .INIT_33(256'h0202858382018201868303820000010300840083828904868201818600838402),
    .INIT_34(256'h820182858300028485000103040603838302038285840186830000058E818400),
    .INIT_35(256'h8508028304830383010587020383818301068287038182068486030001018507),
    .INIT_36(256'h81030482050200870300018687840701010500068A8281060304870681848500),
    .INIT_37(256'h010284030301018B010181890787040686820082820100030283858183010483),
    .INIT_38(256'h8801068B0686098C070505048C0683088A8C8B8A088B819102878E900306858B),
    .INIT_39(256'h028B029186098C81060407048887820205068F0785000086888B8D09878F898C),
    .INIT_3A(256'h06908386000987068A858E88058E0C8D8481020B0888890A8787018904068404),
    .INIT_3B(256'h868A87850189018487898D06850785828C0500028A00890787898B88048D8500),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(18'h00000),
    .INIT_B(18'h00000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(9),
    .READ_WIDTH_B(9),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(18'h00000),
    .SRVAL_B(18'h00000),
    .WRITE_MODE_A("NO_CHANGE"),
    .WRITE_MODE_B("NO_CHANGE"),
    .WRITE_WIDTH_A(9),
    .WRITE_WIDTH_B(9)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM18.ram 
       (.ADDRARDADDR({addra,1'b0,1'b0,1'b0}),
        .ADDRBWRADDR({addrb,1'b0,1'b0,1'b0}),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clkb),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,dina}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0}),
        .DOADO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM18.ram_DOADO_UNCONNECTED [15:0]),
        .DOBDO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM18.ram_DOBDO_UNCONNECTED [15:8],DOBDO}),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM18.ram_DOPADOP_UNCONNECTED [1:0]),
        .DOPBDOP({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM18.ram_DOPBDOP_UNCONNECTED [1],\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM18.ram_n_35 }),
        .ENARDEN(ena_array),
        .ENBWREN(enb_array),
        .REGCEAREGCE(1'b0),
        .REGCEB(enb),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .WEA({wea,wea}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_top" *) 
module weight_mem_gen_20_blk_mem_gen_top
   (doutb,
    clka,
    clkb,
    enb,
    addra,
    addrb,
    dina,
    wea,
    ena);
  output [7:0]doutb;
  input clka;
  input clkb;
  input enb;
  input [13:0]addra;
  input [13:0]addrb;
  input [7:0]dina;
  input [0:0]wea;
  input ena;

  wire [13:0]addra;
  wire [13:0]addrb;
  wire clka;
  wire clkb;
  wire [7:0]dina;
  wire [7:0]doutb;
  wire ena;
  wire enb;
  wire [0:0]wea;

  weight_mem_gen_20_blk_mem_gen_generic_cstr \valid.cstr 
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .dina(dina),
        .doutb(doutb),
        .ena(ena),
        .enb(enb),
        .wea(wea));
endmodule

(* C_ADDRA_WIDTH = "14" *) (* C_ADDRB_WIDTH = "14" *) (* C_ALGORITHM = "1" *) 
(* C_AXI_ID_WIDTH = "4" *) (* C_AXI_SLAVE_TYPE = "0" *) (* C_AXI_TYPE = "1" *) 
(* C_BYTE_SIZE = "9" *) (* C_COMMON_CLK = "0" *) (* C_COUNT_18K_BRAM = "1" *) 
(* C_COUNT_36K_BRAM = "2" *) (* C_CTRL_ECC_ALGO = "NONE" *) (* C_DEFAULT_DATA = "0" *) 
(* C_DISABLE_WARN_BHV_COLL = "0" *) (* C_DISABLE_WARN_BHV_RANGE = "0" *) (* C_ELABORATION_DIR = "./" *) 
(* C_ENABLE_32BIT_ADDRESS = "0" *) (* C_EN_DEEPSLEEP_PIN = "0" *) (* C_EN_ECC_PIPE = "0" *) 
(* C_EN_RDADDRA_CHG = "0" *) (* C_EN_RDADDRB_CHG = "0" *) (* C_EN_SAFETY_CKT = "0" *) 
(* C_EN_SHUTDOWN_PIN = "0" *) (* C_EN_SLEEP_PIN = "0" *) (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     4.123218 mW" *) 
(* C_FAMILY = "artix7" *) (* C_HAS_AXI_ID = "0" *) (* C_HAS_ENA = "1" *) 
(* C_HAS_ENB = "1" *) (* C_HAS_INJECTERR = "0" *) (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
(* C_HAS_MEM_OUTPUT_REGS_B = "1" *) (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
(* C_HAS_REGCEA = "0" *) (* C_HAS_REGCEB = "0" *) (* C_HAS_RSTA = "0" *) 
(* C_HAS_RSTB = "0" *) (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
(* C_INITA_VAL = "0" *) (* C_INITB_VAL = "0" *) (* C_INIT_FILE = "weight_mem_gen_20.mem" *) 
(* C_INIT_FILE_NAME = "weight_mem_gen_20.mif" *) (* C_INTERFACE_TYPE = "0" *) (* C_LOAD_INIT_FILE = "1" *) 
(* C_MEM_TYPE = "1" *) (* C_MUX_PIPELINE_STAGES = "0" *) (* C_PRIM_TYPE = "1" *) 
(* C_READ_DEPTH_A = "10178" *) (* C_READ_DEPTH_B = "10178" *) (* C_READ_WIDTH_A = "8" *) 
(* C_READ_WIDTH_B = "8" *) (* C_RSTRAM_A = "0" *) (* C_RSTRAM_B = "0" *) 
(* C_RST_PRIORITY_A = "CE" *) (* C_RST_PRIORITY_B = "CE" *) (* C_SIM_COLLISION_CHECK = "ALL" *) 
(* C_USE_BRAM_BLOCK = "0" *) (* C_USE_BYTE_WEA = "0" *) (* C_USE_BYTE_WEB = "0" *) 
(* C_USE_DEFAULT_DATA = "0" *) (* C_USE_ECC = "0" *) (* C_USE_SOFTECC = "0" *) 
(* C_USE_URAM = "0" *) (* C_WEA_WIDTH = "1" *) (* C_WEB_WIDTH = "1" *) 
(* C_WRITE_DEPTH_A = "10178" *) (* C_WRITE_DEPTH_B = "10178" *) (* C_WRITE_MODE_A = "NO_CHANGE" *) 
(* C_WRITE_MODE_B = "WRITE_FIRST" *) (* C_WRITE_WIDTH_A = "8" *) (* C_WRITE_WIDTH_B = "8" *) 
(* C_XDEVICEFAMILY = "artix7" *) (* ORIG_REF_NAME = "blk_mem_gen_v8_4_1" *) (* downgradeipidentifiedwarnings = "yes" *) 
module weight_mem_gen_20_blk_mem_gen_v8_4_1
   (clka,
    rsta,
    ena,
    regcea,
    wea,
    addra,
    dina,
    douta,
    clkb,
    rstb,
    enb,
    regceb,
    web,
    addrb,
    dinb,
    doutb,
    injectsbiterr,
    injectdbiterr,
    eccpipece,
    sbiterr,
    dbiterr,
    rdaddrecc,
    sleep,
    deepsleep,
    shutdown,
    rsta_busy,
    rstb_busy,
    s_aclk,
    s_aresetn,
    s_axi_awid,
    s_axi_awaddr,
    s_axi_awlen,
    s_axi_awsize,
    s_axi_awburst,
    s_axi_awvalid,
    s_axi_awready,
    s_axi_wdata,
    s_axi_wstrb,
    s_axi_wlast,
    s_axi_wvalid,
    s_axi_wready,
    s_axi_bid,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_bready,
    s_axi_arid,
    s_axi_araddr,
    s_axi_arlen,
    s_axi_arsize,
    s_axi_arburst,
    s_axi_arvalid,
    s_axi_arready,
    s_axi_rid,
    s_axi_rdata,
    s_axi_rresp,
    s_axi_rlast,
    s_axi_rvalid,
    s_axi_rready,
    s_axi_injectsbiterr,
    s_axi_injectdbiterr,
    s_axi_sbiterr,
    s_axi_dbiterr,
    s_axi_rdaddrecc);
  input clka;
  input rsta;
  input ena;
  input regcea;
  input [0:0]wea;
  input [13:0]addra;
  input [7:0]dina;
  output [7:0]douta;
  input clkb;
  input rstb;
  input enb;
  input regceb;
  input [0:0]web;
  input [13:0]addrb;
  input [7:0]dinb;
  output [7:0]doutb;
  input injectsbiterr;
  input injectdbiterr;
  input eccpipece;
  output sbiterr;
  output dbiterr;
  output [13:0]rdaddrecc;
  input sleep;
  input deepsleep;
  input shutdown;
  output rsta_busy;
  output rstb_busy;
  input s_aclk;
  input s_aresetn;
  input [3:0]s_axi_awid;
  input [31:0]s_axi_awaddr;
  input [7:0]s_axi_awlen;
  input [2:0]s_axi_awsize;
  input [1:0]s_axi_awburst;
  input s_axi_awvalid;
  output s_axi_awready;
  input [7:0]s_axi_wdata;
  input [0:0]s_axi_wstrb;
  input s_axi_wlast;
  input s_axi_wvalid;
  output s_axi_wready;
  output [3:0]s_axi_bid;
  output [1:0]s_axi_bresp;
  output s_axi_bvalid;
  input s_axi_bready;
  input [3:0]s_axi_arid;
  input [31:0]s_axi_araddr;
  input [7:0]s_axi_arlen;
  input [2:0]s_axi_arsize;
  input [1:0]s_axi_arburst;
  input s_axi_arvalid;
  output s_axi_arready;
  output [3:0]s_axi_rid;
  output [7:0]s_axi_rdata;
  output [1:0]s_axi_rresp;
  output s_axi_rlast;
  output s_axi_rvalid;
  input s_axi_rready;
  input s_axi_injectsbiterr;
  input s_axi_injectdbiterr;
  output s_axi_sbiterr;
  output s_axi_dbiterr;
  output [13:0]s_axi_rdaddrecc;

  wire \<const0> ;
  wire [13:0]addra;
  wire [13:0]addrb;
  wire clka;
  wire clkb;
  wire [7:0]dina;
  wire [7:0]doutb;
  wire ena;
  wire enb;
  wire [0:0]wea;

  assign dbiterr = \<const0> ;
  assign douta[7] = \<const0> ;
  assign douta[6] = \<const0> ;
  assign douta[5] = \<const0> ;
  assign douta[4] = \<const0> ;
  assign douta[3] = \<const0> ;
  assign douta[2] = \<const0> ;
  assign douta[1] = \<const0> ;
  assign douta[0] = \<const0> ;
  assign rdaddrecc[13] = \<const0> ;
  assign rdaddrecc[12] = \<const0> ;
  assign rdaddrecc[11] = \<const0> ;
  assign rdaddrecc[10] = \<const0> ;
  assign rdaddrecc[9] = \<const0> ;
  assign rdaddrecc[8] = \<const0> ;
  assign rdaddrecc[7] = \<const0> ;
  assign rdaddrecc[6] = \<const0> ;
  assign rdaddrecc[5] = \<const0> ;
  assign rdaddrecc[4] = \<const0> ;
  assign rdaddrecc[3] = \<const0> ;
  assign rdaddrecc[2] = \<const0> ;
  assign rdaddrecc[1] = \<const0> ;
  assign rdaddrecc[0] = \<const0> ;
  assign rsta_busy = \<const0> ;
  assign rstb_busy = \<const0> ;
  assign s_axi_arready = \<const0> ;
  assign s_axi_awready = \<const0> ;
  assign s_axi_bid[3] = \<const0> ;
  assign s_axi_bid[2] = \<const0> ;
  assign s_axi_bid[1] = \<const0> ;
  assign s_axi_bid[0] = \<const0> ;
  assign s_axi_bresp[1] = \<const0> ;
  assign s_axi_bresp[0] = \<const0> ;
  assign s_axi_bvalid = \<const0> ;
  assign s_axi_dbiterr = \<const0> ;
  assign s_axi_rdaddrecc[13] = \<const0> ;
  assign s_axi_rdaddrecc[12] = \<const0> ;
  assign s_axi_rdaddrecc[11] = \<const0> ;
  assign s_axi_rdaddrecc[10] = \<const0> ;
  assign s_axi_rdaddrecc[9] = \<const0> ;
  assign s_axi_rdaddrecc[8] = \<const0> ;
  assign s_axi_rdaddrecc[7] = \<const0> ;
  assign s_axi_rdaddrecc[6] = \<const0> ;
  assign s_axi_rdaddrecc[5] = \<const0> ;
  assign s_axi_rdaddrecc[4] = \<const0> ;
  assign s_axi_rdaddrecc[3] = \<const0> ;
  assign s_axi_rdaddrecc[2] = \<const0> ;
  assign s_axi_rdaddrecc[1] = \<const0> ;
  assign s_axi_rdaddrecc[0] = \<const0> ;
  assign s_axi_rdata[7] = \<const0> ;
  assign s_axi_rdata[6] = \<const0> ;
  assign s_axi_rdata[5] = \<const0> ;
  assign s_axi_rdata[4] = \<const0> ;
  assign s_axi_rdata[3] = \<const0> ;
  assign s_axi_rdata[2] = \<const0> ;
  assign s_axi_rdata[1] = \<const0> ;
  assign s_axi_rdata[0] = \<const0> ;
  assign s_axi_rid[3] = \<const0> ;
  assign s_axi_rid[2] = \<const0> ;
  assign s_axi_rid[1] = \<const0> ;
  assign s_axi_rid[0] = \<const0> ;
  assign s_axi_rlast = \<const0> ;
  assign s_axi_rresp[1] = \<const0> ;
  assign s_axi_rresp[0] = \<const0> ;
  assign s_axi_rvalid = \<const0> ;
  assign s_axi_sbiterr = \<const0> ;
  assign s_axi_wready = \<const0> ;
  assign sbiterr = \<const0> ;
  GND GND
       (.G(\<const0> ));
  weight_mem_gen_20_blk_mem_gen_v8_4_1_synth inst_blk_mem_gen
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .dina(dina),
        .doutb(doutb),
        .ena(ena),
        .enb(enb),
        .wea(wea));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_v8_4_1_synth" *) 
module weight_mem_gen_20_blk_mem_gen_v8_4_1_synth
   (doutb,
    clka,
    clkb,
    enb,
    addra,
    addrb,
    dina,
    wea,
    ena);
  output [7:0]doutb;
  input clka;
  input clkb;
  input enb;
  input [13:0]addra;
  input [13:0]addrb;
  input [7:0]dina;
  input [0:0]wea;
  input ena;

  wire [13:0]addra;
  wire [13:0]addrb;
  wire clka;
  wire clkb;
  wire [7:0]dina;
  wire [7:0]doutb;
  wire ena;
  wire enb;
  wire [0:0]wea;

  weight_mem_gen_20_blk_mem_gen_top \gnbram.gnativebmg.native_blk_mem_gen 
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .dina(dina),
        .doutb(doutb),
        .ena(ena),
        .enb(enb),
        .wea(wea));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
