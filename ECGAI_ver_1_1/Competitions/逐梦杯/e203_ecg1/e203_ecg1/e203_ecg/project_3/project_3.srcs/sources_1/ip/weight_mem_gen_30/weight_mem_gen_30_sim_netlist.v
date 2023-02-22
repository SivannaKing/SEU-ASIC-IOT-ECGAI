// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.1 (win64) Build 2188600 Wed Apr  4 18:40:38 MDT 2018
// Date        : Mon Nov 29 14:58:52 2021
// Host        : DESKTOP-5DABIT8 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/FPGA/e203_ecg/e203_ecg/project_2/project_2.srcs/sources_1/ip/weight_mem_gen_30/weight_mem_gen_30_sim_netlist.v
// Design      : weight_mem_gen_30
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a200tfbg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "weight_mem_gen_30,blk_mem_gen_v8_4_1,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_1,Vivado 2018.1" *) 
(* NotValidForBitStream *)
module weight_mem_gen_30
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
  (* C_INIT_FILE = "weight_mem_gen_30.mem" *) 
  (* C_INIT_FILE_NAME = "weight_mem_gen_30.mif" *) 
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
  weight_mem_gen_30_blk_mem_gen_v8_4_1 U0
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
module weight_mem_gen_30_bindec
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
module weight_mem_gen_30_bindec_0
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
module weight_mem_gen_30_blk_mem_gen_generic_cstr
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

  weight_mem_gen_30_bindec \bindec_a.bindec_inst_a 
       (.addra(addra[13:11]),
        .ena(ena),
        .ena_array(ena_array));
  weight_mem_gen_30_bindec_0 \bindec_b.bindec_inst_b 
       (.addrb(addrb[13:11]),
        .enb(enb),
        .enb_array(enb_array));
  weight_mem_gen_30_blk_mem_gen_mux__parameterized0 \has_mux_b.B 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ({\ramloop[1].ram.r_n_0 ,\ramloop[1].ram.r_n_1 ,\ramloop[1].ram.r_n_2 ,\ramloop[1].ram.r_n_3 ,\ramloop[1].ram.r_n_4 ,\ramloop[1].ram.r_n_5 ,\ramloop[1].ram.r_n_6 ,\ramloop[1].ram.r_n_7 }),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 (ram_doutb),
        .DOBDO({\ramloop[2].ram.r_n_0 ,\ramloop[2].ram.r_n_1 ,\ramloop[2].ram.r_n_2 ,\ramloop[2].ram.r_n_3 ,\ramloop[2].ram.r_n_4 ,\ramloop[2].ram.r_n_5 ,\ramloop[2].ram.r_n_6 ,\ramloop[2].ram.r_n_7 }),
        .addrb(addrb[13:11]),
        .clkb(clkb),
        .doutb(doutb),
        .enb(enb));
  weight_mem_gen_30_blk_mem_gen_prim_width \ramloop[0].ram.r 
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .dina(dina),
        .\doutb[7] (ram_doutb),
        .ena(ena),
        .enb(enb),
        .wea(wea));
  weight_mem_gen_30_blk_mem_gen_prim_width__parameterized0 \ramloop[1].ram.r 
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .dina(dina),
        .\doutb[7] ({\ramloop[1].ram.r_n_0 ,\ramloop[1].ram.r_n_1 ,\ramloop[1].ram.r_n_2 ,\ramloop[1].ram.r_n_3 ,\ramloop[1].ram.r_n_4 ,\ramloop[1].ram.r_n_5 ,\ramloop[1].ram.r_n_6 ,\ramloop[1].ram.r_n_7 }),
        .ena(ena),
        .enb(enb),
        .wea(wea));
  weight_mem_gen_30_blk_mem_gen_prim_width__parameterized1 \ramloop[2].ram.r 
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
module weight_mem_gen_30_blk_mem_gen_mux__parameterized0
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
module weight_mem_gen_30_blk_mem_gen_prim_width
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

  weight_mem_gen_30_blk_mem_gen_prim_wrapper_init \prim_init.ram 
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
module weight_mem_gen_30_blk_mem_gen_prim_width__parameterized0
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

  weight_mem_gen_30_blk_mem_gen_prim_wrapper_init__parameterized0 \prim_init.ram 
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
module weight_mem_gen_30_blk_mem_gen_prim_width__parameterized1
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

  weight_mem_gen_30_blk_mem_gen_prim_wrapper_init__parameterized1 \prim_init.ram 
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
module weight_mem_gen_30_blk_mem_gen_prim_wrapper_init
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
    .INIT_00(256'h00050081860182030082818186000082810082050483080803060402888B8B85),
    .INIT_01(256'h0306048482050689878202068386008200820006008100038282010682830604),
    .INIT_02(256'h8382838689000382038200028304038181838300050484878403078385058281),
    .INIT_03(256'h0384828186850184060703008684010601050104840104008383810404848286),
    .INIT_04(256'h8B86820005020287000203050082838482050506818602048581818204030584),
    .INIT_05(256'h0300068182868383878787840605030386000906820285048485038103058384),
    .INIT_06(256'h8185010304018603030384010404010382060383810104010003058486840102),
    .INIT_07(256'h0203028104838585028582810281000303010203038383020084810001028202),
    .INIT_08(256'h0384818203020002000281828382008300820002820184048181010000008402),
    .INIT_09(256'h8501040600030285840182828402010083810381838200058183820181810001),
    .INIT_0A(256'h0184818585810100020101878184830200008685820405840501018384828100),
    .INIT_0B(256'h8303838481860402810301810303830300020281820004840604038403018202),
    .INIT_0C(256'h8101058284830385000000820306840302020302810102818681840283810581),
    .INIT_0D(256'h02020781838586830501828184818883040301858100868A0583000284858100),
    .INIT_0E(256'h8400818302040001018582018103830182828184810502000481840289048281),
    .INIT_0F(256'h8104830382848481010282828281008202000581040203818382030305820001),
    .INIT_10(256'h8386838383838303828383008283040484818A82008200818482028401850282),
    .INIT_11(256'h0303858481028203020002040302028284840400010283848285030204820281),
    .INIT_12(256'h8201820102000505818282830281000105038184028583020081048284830002),
    .INIT_13(256'h0205028281828581810203028286858202038300848300020481000401840084),
    .INIT_14(256'h8200010386848581000202868504028281840282828101038A84850401810303),
    .INIT_15(256'h028B8E0101038284028601010102058287838384828701810000010404028185),
    .INIT_16(256'h0281008203858788008101048483828200020386820182818181008482028481),
    .INIT_17(256'h0387828389818303810081820000020381838687848100868800838182908382),
    .INIT_18(256'h8381810002838885040004810302058281830002028300868202028401040402),
    .INIT_19(256'h8C82000001018100000200828203050083020202038202018A85028285008286),
    .INIT_1A(256'h0702018386830400810383820205848686838282838383820102838503838200),
    .INIT_1B(256'h8684008281838484818204868485010505818686000003030701018702020200),
    .INIT_1C(256'h0085868606070706830184000101018101820104028302840000000202868184),
    .INIT_1D(256'h0503010182848382010005050185868486020586828304008182008686828402),
    .INIT_1E(256'h0081868502030000028183810282828586868400060283870606060105010081),
    .INIT_1F(256'h8101030103038484850003030382890083008181848281008384838685850002),
    .INIT_20(256'h0100058300818182030382858201010003850001810482068203820603848384),
    .INIT_21(256'h0185818481828482838682008501878586838284818385020404030686848283),
    .INIT_22(256'h0200040381020003010381838285840087028588818584868582000004030582),
    .INIT_23(256'h8182048582028281050604818104038102008387030104010702010303018101),
    .INIT_24(256'h83008486820603008A0084878283028784818100008287850000898B85818587),
    .INIT_25(256'h0003020104060001010201048281010001850305848981858585898989890283),
    .INIT_26(256'h0100878786888283838285858301820184838182888603028486010104030503),
    .INIT_27(256'h8901858883848589818405000504038302838786858583850382848684838586),
    .INIT_28(256'h8583870085828601828386820000838101008202008182838301848585828400),
    .INIT_29(256'h8283828182008200008282020082030301840203810101040502020000820084),
    .INIT_2A(256'h8405058301820402020503810202050283060405038103818101820204008102),
    .INIT_2B(256'h8100020186028201810000048382060684870282838401030000008581018201),
    .INIT_2C(256'h8401020001860002018300818381848101018283850405818404040403048185),
    .INIT_2D(256'h8384820504010001878201010203008487020206000101008100000082830383),
    .INIT_2E(256'h0200000102820003048103818706048183898181848788000300010001020000),
    .INIT_2F(256'h8181818100818284838182848681048101810001038203848203028200858101),
    .INIT_30(256'h8302040202008282020184830102828284018302020483810103828185028200),
    .INIT_31(256'h8183878582838700818289840085838401810186860501840281830083020481),
    .INIT_32(256'h8185018100028900818186008181810001030301048100810201010401860400),
    .INIT_33(256'h810103810103810083020202038101010205068102000184848204898A078281),
    .INIT_34(256'h8101020183018201858201828285818303028686050000878481830200818382),
    .INIT_35(256'h8302818181020105020200028100038483020201000403018485828302830004),
    .INIT_36(256'h8200060186030281000481018100010107058401008202008102810300038181),
    .INIT_37(256'h8383818100010100818182848182000281820503018101018282030182840183),
    .INIT_38(256'h8201818283848300820003020586840184860004020381810002008585820203),
    .INIT_39(256'h8303028183060083008583038101010001028204818300810001850083040502),
    .INIT_3A(256'h0102020401840200810182000482848201848381818582010484010201038784),
    .INIT_3B(256'h0282858484830102010181008283830188878586818583030484848401820203),
    .INIT_3C(256'h0303838300020285818101828588838102830200030083818203810504830304),
    .INIT_3D(256'h8403820181018182010101810002838487868587858103000100028282010202),
    .INIT_3E(256'h8502010081810202810201038503038383010281858300828484818400008202),
    .INIT_3F(256'h8300028301068585860002840004820000838181850386810201820182000100),
    .INIT_40(256'h0604850203040102820003858506028185028200858282820081008204038300),
    .INIT_41(256'h0004018302060082048282010000018203828281028183828101838684018381),
    .INIT_42(256'h0000028484038382028101818303810182838100820203818204010282010281),
    .INIT_43(256'h8305010000038685848182828202820382010001818203820100028804810282),
    .INIT_44(256'h8384050181010581850003008604848282838381860482818181010483010404),
    .INIT_45(256'h8300828183020182010002840083028301838384828385028301830082028384),
    .INIT_46(256'h8282810083000002038201038181810381018103818202810201020084848384),
    .INIT_47(256'h0203838181838303010100830202028283818201000000820182818181008200),
    .INIT_48(256'h8400848200010282008182000083830000028181010383828102000201818181),
    .INIT_49(256'h0201028100028100828181838404000300000101038482818382028283828200),
    .INIT_4A(256'h8300818383818400828200820003038100818400018485820101010281000283),
    .INIT_4B(256'h0082008281018201848483820100820201810181828384018100818101008303),
    .INIT_4C(256'h830104018301018284830182838305008A030400000083020503838101040482),
    .INIT_4D(256'h8883840405060201810284880305010201810304070900850502848381020001),
    .INIT_4E(256'h8182010402810082828400848486000383818301820182848205038400020081),
    .INIT_4F(256'h0382008305048184030383850281840787830203020082060286868103000681),
    .INIT_50(256'h8201830282010201008104048281818183020181030381810082030082818584),
    .INIT_51(256'h8483020302050600838402070100850281818181820383838683860282010181),
    .INIT_52(256'h84810181838104028483868502000086028100020300000B8181828583010203),
    .INIT_53(256'h0300010301018100010282028483018185050A08840381010003810703848682),
    .INIT_54(256'h8683838282838686010304030204838381008200020200810384848183820704),
    .INIT_55(256'h8181858586810002018300038482010204060081010001030282810102030281),
    .INIT_56(256'h0382010101008101030282008281028202018182030081000003010282810381),
    .INIT_57(256'h0486000006028383818181020005020401020100018283840404060004010301),
    .INIT_58(256'h8102018282850503000205838382010281018202028102030303868483840100),
    .INIT_59(256'h0181818182838184000082818103010181820400008181848581018100030003),
    .INIT_5A(256'h0382038303820202810004050303818184018482038381820001050302058281),
    .INIT_5B(256'h8482828302000381008482820102818182000183810081858481850182840183),
    .INIT_5C(256'h0500810582010001018381820000810100030481828683820183830201840282),
    .INIT_5D(256'h0400018201018281830282828282838182830282820202820202038100810500),
    .INIT_5E(256'h0382830283038185050304040182010202010184858384010284008203010603),
    .INIT_5F(256'h0204000401010301020301028202000103810202000282818101818200030486),
    .INIT_60(256'h8483010202008587850303038181840181818882810184818104058183000201),
    .INIT_61(256'h0502828687898105068102040485818103030384010305048204080784818300),
    .INIT_62(256'h8403010100028683840302000081020304838300038200040185030705868802),
    .INIT_63(256'h858283858101020684878A8A8202008307038101028383810706060487858486),
    .INIT_64(256'h0382040000000001838182030300000102010383818405040201848181018285),
    .INIT_65(256'h0203818181048301848304838782828281000202038200828201018103818481),
    .INIT_66(256'h8282000187820202018685810381080185828208018181868500018183848402),
    .INIT_67(256'h0485868282028203010201030100820385858307050301000303888582818281),
    .INIT_68(256'h0105058283010208860002070400010483030102818301818103830186828301),
    .INIT_69(256'h828302040001010303018A828202838382040501838282018100830183018A85),
    .INIT_6A(256'h0001838482008603030204010081028100000182040302818302840300028481),
    .INIT_6B(256'h8388818302828685838783828101810202828100028102818284858500020300),
    .INIT_6C(256'h0100030381050002008385010082810083848101848101040500008284810284),
    .INIT_6D(256'h01000004048182810100830281000A0205820382018101818400000381030181),
    .INIT_6E(256'h0203828483038182820101818284838385848581848100820384850102830002),
    .INIT_6F(256'h8201008284838200008204830100820084008382830202848381000000820281),
    .INIT_70(256'h8182018404030000020005000501000305010285010702810402038301820082),
    .INIT_71(256'h0204020101820001000100010283810003038884860181828201030600060003),
    .INIT_72(256'h8481000000848185818301828303818301000081820201000181030201010002),
    .INIT_73(256'h8586878283008201020182830103020081020202000102820102830002820481),
    .INIT_74(256'h0101828183820103030201040384000403818201040402048200810201018183),
    .INIT_75(256'h8385840106818384828584818383828483818401828182868685858886020001),
    .INIT_76(256'h0002820102028383858184828300008302030204028481838685000181810081),
    .INIT_77(256'h0000000202818400878782868607820681008282030282858683858602020005),
    .INIT_78(256'h8302020201008182000201028200828100000081018281848300000181048202),
    .INIT_79(256'h0284818484018202018102048482820102810182818301000304008301820181),
    .INIT_7A(256'h0100040305020281010082028303838300828883010003828681018182058205),
    .INIT_7B(256'h0204008382010301020200830204020303040384030200810202050606830182),
    .INIT_7C(256'h0385810001000282028100038201810282020283840381010284000202030201),
    .INIT_7D(256'h0800010001010181810003010081810182868482828283008182838102020604),
    .INIT_7E(256'h0002018202818487848582840703020301000103018901000382840681838302),
    .INIT_7F(256'h0181028701038381038181050803840001010186820104050084820381810082),
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
module weight_mem_gen_30_blk_mem_gen_prim_wrapper_init__parameterized0
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
    .INIT_00(256'h8201828102038581040400848485830203040182868100050583888201050481),
    .INIT_01(256'h82818183830002048A86020703050481828500810300008B8302040587868884),
    .INIT_02(256'h0001000100838102008183010205000000028181040202830485010102000102),
    .INIT_03(256'h0201018182008502050102010081020702828102028585038182030103030182),
    .INIT_04(256'h0201018484000204030281040481030602050300868586890283830402830182),
    .INIT_05(256'h84820181838284000101840100008282018203810581838384818C8A83820203),
    .INIT_06(256'h9002048401860401028386840301028200000401838387010181830003828386),
    .INIT_07(256'h050286830683010100008A8C008782850100040300828302838382850181830A),
    .INIT_08(256'h0001810300040086848286858E89878488878287868484000104040403020302),
    .INIT_09(256'h8D888B8885008400008503000382818382018187878686830000818302030404),
    .INIT_0A(256'h8401840000838303028400848102828381810282810285828181898589868788),
    .INIT_0B(256'h0181018383820102848381860086848802040383020001008283020402820083),
    .INIT_0C(256'h0000030202010200810302050301068381020001060201030386838182810282),
    .INIT_0D(256'h8387000085028300030181040200030082818381848589898789860300010202),
    .INIT_0E(256'h0202040183020100028102030305020405010200830102830183828182878486),
    .INIT_0F(256'h0383818381830181048182028100010082030000818281060481848682848203),
    .INIT_10(256'h8183840383008401040282010202020000818102038102018105050682828200),
    .INIT_11(256'h0003050304018200000188858582848184810000020100818282830281830204),
    .INIT_12(256'h8302040282038105818200038200040102010403030002010200050282830181),
    .INIT_13(256'h850282818A828381818200830281010205010786020186020102050481000000),
    .INIT_14(256'h0501810281810203010204000000008281010382858284868283000101020102),
    .INIT_15(256'h8600010300050504888B88868702830002858103038181020401810506060B06),
    .INIT_16(256'h0203838181018181000085878881830481000102810300850100008102850084),
    .INIT_17(256'h0301050503030387030387828D8489898C028100010081810303040283810100),
    .INIT_18(256'h0001028301018105818400818101018201810202818305838300830102020002),
    .INIT_19(256'h83830181008202020104818382820000010606070A0382820381868183848484),
    .INIT_1A(256'h0681848301810300820083008201000181010506040601000401000681848301),
    .INIT_1B(256'h8302010201820083030087848189810405020202020483810184008284830203),
    .INIT_1C(256'h8281018403838500000282838483830003818303840083828184008102028382),
    .INIT_1D(256'h0085840302840181010282820082828184850184818481030382828481010184),
    .INIT_1E(256'h0003000002000081820203028301848401848200848283038101830101810100),
    .INIT_1F(256'h8203008100810282000283838384838303840000850182850200010183828381),
    .INIT_20(256'h0283838284018284818103018382840100828403820202008483038201848181),
    .INIT_21(256'h8202030301830100048484838381820184038201838403030381030101818283),
    .INIT_22(256'h0086818581868602010203040182008581040501848382878281810182000001),
    .INIT_23(256'h0401838100040303810485848583038185848A83858405068203000701050400),
    .INIT_24(256'h8300848685008381010184830105000005088185010500058481858783830403),
    .INIT_25(256'h0205010181030481818284008583038502050201048181820503010103888600),
    .INIT_26(256'h8101810303060183008403028482030104040382018185818585898684038104),
    .INIT_27(256'h8686828281810282840101008685828484820003010101878786888383028581),
    .INIT_28(256'h8583840002018182858783038182010204050100830185858884048204048106),
    .INIT_29(256'h0081828102828288818584818182050281068486878501828482830086018286),
    .INIT_2A(256'h0082028204838983820202048182040086018481008486000203000184870202),
    .INIT_2B(256'h0301030005028102848688010302828581878386010303010101810082838484),
    .INIT_2C(256'h0183868403070303018285830102010483020204828283818103820101030100),
    .INIT_2D(256'h8682820005818183018102020104008204030101858584820182860084830201),
    .INIT_2E(256'h0383810406820181818400820200008403018207050306838186840304850102),
    .INIT_2F(256'h0300850502820281838487828200818486820181828183008203040502030005),
    .INIT_30(256'h8382878384018501810184820281030702048281810202818288070406828500),
    .INIT_31(256'h0187810601040502870281040104848286050582020383040085880102840382),
    .INIT_32(256'h0303028184828285010302838100830306058105838402838381810081848501),
    .INIT_33(256'h8304000203830003850001848181818687810483048500810701810201000002),
    .INIT_34(256'h008107030283810303818386840305018106050408850A010082848384820303),
    .INIT_35(256'h8404850303068181018384010185038383048883058286848282060100040281),
    .INIT_36(256'h0002850002020085018500028204830682078402048102860403030300018101),
    .INIT_37(256'h0086810581048282008282818303810201810682810083000086000184810005),
    .INIT_38(256'h0284828301048200838481038482810201010381010584820184818384010184),
    .INIT_39(256'h0401820103840100818684000400048484010581018601840682040482010000),
    .INIT_3A(256'h0400028583040005810100038281048201030188858601830501020402020400),
    .INIT_3B(256'h0301830004010404038107820100020201028501040283868687848402838283),
    .INIT_3C(256'h00830001030200810381040402028385840100040400848183008A0002830183),
    .INIT_3D(256'h1004860281868381828283848200000304028303048201028381818183018103),
    .INIT_3E(256'h0502818487878681820101020082820300838500010282020004830304048482),
    .INIT_3F(256'h0200048283838283030405010104840302058284848103000182818383020004),
    .INIT_40(256'h8600028401008484858581008301838200840283838281838485008304848283),
    .INIT_41(256'h8201820202848402818283028301818202008401000483010284818381018482),
    .INIT_42(256'h8103830102828300830281018203000003000303038383000182810285828184),
    .INIT_43(256'h0084048383810300820202008404000081810082848483018100818485858203),
    .INIT_44(256'h8182010201830000000183038301830083000103030381028184028281010001),
    .INIT_45(256'h0281018482008183008284008403838384820384828284810082818383020184),
    .INIT_46(256'h8301020305020482020184038384828585860083830004040002818684020282),
    .INIT_47(256'h8183818981000681038481038102008602058408050007060600840103048482),
    .INIT_48(256'h0082028386008586880083870085848385038302858583898681880000828100),
    .INIT_49(256'h868400818387868A878687828281848482838484038401008583868286868784),
    .INIT_4A(256'h8C01818282848488868B038381848A01858181828586048101868A8602040187),
    .INIT_4B(256'h028284858186018102008304850286010183028285040004030100838100848A),
    .INIT_4C(256'h0282010003018500828485868582828300028602820302820004838281818303),
    .INIT_4D(256'h8884028302848603848384848481008281820383890305040101020303010303),
    .INIT_4E(256'h8382858183850084010003028285028282040584000304058600010081858686),
    .INIT_4F(256'h8986018584048203848284030001020203858681818100828303810583020505),
    .INIT_50(256'h0001828602020083868601008181008403020186028182050081830082868387),
    .INIT_51(256'h8482000601828601810001020184828101838301838181848304028785830500),
    .INIT_52(256'h8182828182020201840100038583060104008400040101038101840084040006),
    .INIT_53(256'h0200810185850081828103830181850184810281038104020285858102070000),
    .INIT_54(256'h0284838786880001840281058782018482828302818183028381820000000285),
    .INIT_55(256'h0507030000008104830102818306818384810385878384028201020606060104),
    .INIT_56(256'h8204010381010206060600818584858305020005030082038305010282820405),
    .INIT_57(256'h0105058503078683820401838185010100868281000381008484008785888485),
    .INIT_58(256'h8382840201018201838302038203030005018183840103828486028203008282),
    .INIT_59(256'h8589858986830382050182020182000000038103010283050386838282848584),
    .INIT_5A(256'h0382020182838302820204820181830202000182840284830081020282828283),
    .INIT_5B(256'h8784810301040181030503018481830202840405068300068301040002830081),
    .INIT_5C(256'h8303840701840389878602848481020202828600020103000006040103020289),
    .INIT_5D(256'h0101018485820085810181878283050006050102820481830185018583868501),
    .INIT_5E(256'h8583810181850102848482828482830585820102830102838384820284828402),
    .INIT_5F(256'h0202028201028305820182000203030202818307090705020381868681848384),
    .INIT_60(256'h8283858303010100818302830602018481818404020384820284810202820005),
    .INIT_61(256'h8501000081000084858103010201840001028400050402018686050101018481),
    .INIT_62(256'h8385848104028202820082020100840084030485000383838385008203840382),
    .INIT_63(256'h8282830081810281008181008382858200000482018685870002050204028286),
    .INIT_64(256'h0106828989008502040002888588818382038305810402018283020402030303),
    .INIT_65(256'h8181820282020101838301858303030484848400840182840006050483018401),
    .INIT_66(256'h8383830201010181810100010182008483028303848383038302810381828285),
    .INIT_67(256'h8283818886848283030201820200020404888589030005008301060400018100),
    .INIT_68(256'h8585880000828202008100848303858483020084818603030085008386858285),
    .INIT_69(256'h0382048185820084028202810407038301010004080101018183820082050000),
    .INIT_6A(256'h0383840684018401830181018303828681830387030002830106020387000082),
    .INIT_6B(256'h8382008181018383040181010507040505000305000107090082820002868489),
    .INIT_6C(256'h0383820001828282868186008205820281018181018103810201020283000500),
    .INIT_6D(256'h8388000103030486020009010085820203038108008500020200020300848201),
    .INIT_6E(256'h8183820603038301868304040582868183848602040582820288870085030784),
    .INIT_6F(256'h87868A0382848205050305020300818186878107028186810184828381818201),
    .INIT_70(256'h0401018483820203820300828481820101020282838303840003040405008481),
    .INIT_71(256'h0303030001828302828381830181018103018302030505020882828181018103),
    .INIT_72(256'h0284008484810101000302810402008581028301840300850183818282810181),
    .INIT_73(256'h8686818181048104010202020305030383868481060507028303060201008482),
    .INIT_74(256'h0282810204000383840388860084848301010284018303038102028101838683),
    .INIT_75(256'h8286828601018500820002048584840286020683840283038203008485018203),
    .INIT_76(256'h0081010105000102880003078202868882830381820383860483020002858784),
    .INIT_77(256'h8500040087868482000101040085828705020383018201088684840382888887),
    .INIT_78(256'h0400008303038786888482000201010201830104810201820382030683838185),
    .INIT_79(256'h8583040102820381810203810383018104038101838282010281070204040083),
    .INIT_7A(256'h0202828201020185828403000383818784858B82848103010488878403818181),
    .INIT_7B(256'h0600030581068102050009050182820282818381018405820184018284830602),
    .INIT_7C(256'h0200020202028584008682060384860088010084810101000706820101810281),
    .INIT_7D(256'h8600010001008183848301008104020201010282028100010482020282810286),
    .INIT_7E(256'h0100848505038201008381018584000200040104020782038281830385890382),
    .INIT_7F(256'h01850384818281038103030203810300010401008385868182040100810A0A02),
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
module weight_mem_gen_30_blk_mem_gen_prim_wrapper_init__parameterized1
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
    .INIT_00(256'h0002008682010002028784030002828286828302028400018186810005030486),
    .INIT_01(256'h8383850502040105048282060281820505078202848303008203828685850500),
    .INIT_02(256'h038582008482030282838100028207020A0A81040009038103818800010A0182),
    .INIT_03(256'h8881010400038402008884870482820684030086030A00000502018201000800),
    .INIT_04(256'h8682810100010706040783820101820101838781000A01030482008200008202),
    .INIT_05(256'h00838285810081018508858B810A810103010183810304040383810081830001),
    .INIT_06(256'h0303000703038501058784818309820102010182010182048702870201038884),
    .INIT_07(256'h86020088040D8200830700860100080104838403818205038384820081030508),
    .INIT_08(256'h8103070687850100810401870300840086828500010485010382838502028303),
    .INIT_09(256'h078300068482020401820081820200030C870301860201840900010203868305),
    .INIT_0A(256'h8B82020683020200010A088203030503810381018A0401028101818182848400),
    .INIT_0B(256'h0081028585050305098503018103020407020300068802040285030582830000),
    .INIT_0C(256'h8101030382000600010583038503000204058182848386038288030482810183),
    .INIT_0D(256'h08830203810004000B8100020788018101000707830081048785040285010184),
    .INIT_0E(256'h010284028C058202010482828202848301860105828205820281028784010003),
    .INIT_0F(256'h0309030106058103090285038302820184890283018381830406038303000208),
    .INIT_10(256'h8101830000010185030601810082040306868306038602040282058109040200),
    .INIT_11(256'h0504880801010082040784018281000183010604810685848185038307810081),
    .INIT_12(256'h0607838383000106048500058484000701008182058205820203020503088301),
    .INIT_13(256'h010A010781820300860003048303858581840200058182838601028300000282),
    .INIT_14(256'h04850007048600030685838104010484820B8187020588820481810185828101),
    .INIT_15(256'h0303020284088183008A01820983840187068101010200810204828183000105),
    .INIT_16(256'h0605038204018186818381020482818181020706860005060307848289058205),
    .INIT_17(256'h0184008285038101018205818184810187850002028483060103068281008500),
    .INIT_18(256'h8681848101820400838202058301040884830282828107060601870181028300),
    .INIT_19(256'h0582810002008105848700010286860101810A00040084810402848202038282),
    .INIT_1A(256'h8400060487820508858301038387820705818682038588068102848982000182),
    .INIT_1B(256'h848A840681830103838207840103828105020400048100828185850481820802),
    .INIT_1C(256'h8681008281878104078188008201850304038682830103000382040003820203),
    .INIT_1D(256'h8301008682038181020304870582838705040005828107830683848202018185),
    .INIT_1E(256'h0401818681078182008284818403810503028281010004030184048283830104),
    .INIT_1F(256'h0500008681000005050202058281038208818301000182828388098302818302),
    .INIT_20(256'h0200000602010500810400010B04030404820488000181020102028481810302),
    .INIT_21(256'h0202040384040503098487830305820281830784050184000183028201050101),
    .INIT_22(256'h820081020D060002030104868382040281020481058283058581048581810007),
    .INIT_23(256'h8281018209840181008209850107000404000181048107820083840506820282),
    .INIT_24(256'h830482810106000201058302850609858A020303830401050282038582028606),
    .INIT_25(256'h00830987050201030082818301820802060401008105830181018A0107010183),
    .INIT_26(256'h00088284820909868A8284020201810500810300008201028282820109820181),
    .INIT_27(256'h0201028505000B04020300050107000383028705060181860102050301058182),
    .INIT_28(256'h8500040300038107008484020001868383038181080481810681098306810003),
    .INIT_29(256'h8203050102018100858189050781040283818103830400818109818384020883),
    .INIT_2A(256'h8486020103868100818185820384820003060B82070384070300810104840A02),
    .INIT_2B(256'h8386828106840083838104008705810200028283030003848501820481038404),
    .INIT_2C(256'h0003810006848783010084040300018904040301878302080104080100840800),
    .INIT_2D(256'h0482810285010100820187030302018184838502010081070184050900818284),
    .INIT_2E(256'h0382010302020081040304818100050B82840102060302008482010105848282),
    .INIT_2F(256'h8801850005820582848103018202850304870003810481018104850201018885),
    .INIT_30(256'h0000020683840481828401058104030100850004058682088401040483008781),
    .INIT_31(256'h0502010288018A00008302000286860686030105048700820201818281000205),
    .INIT_32(256'h8703040181038487028201028485838281010405820386868202820602810003),
    .INIT_33(256'h85838188868384010007050102880285010001070381018B0685848583810302),
    .INIT_34(256'h0188048188860383830303828402888481018907838400068102028184810000),
    .INIT_35(256'h8404010201880500000286090084048681850001018600818302050300848483),
    .INIT_36(256'h8101030100028885010486020084828203018400878284020086828902858101),
    .INIT_37(256'h028389040581048A828201860000048189020405820186840385810089890100),
    .INIT_38(256'h8C03848A8B828C9108850606028B070800888109080A8D8901848C8E05010607),
    .INIT_39(256'h8E85038483058889058A8B028C0A878789068B068A048E84028A8A02058A8282),
    .INIT_3A(256'h05858A85060684058688038101060B8808898409048F07078603088403878883),
    .INIT_3B(256'h07858B0586828884060104048A84888586048986818605818B85820587888700),
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
module weight_mem_gen_30_blk_mem_gen_top
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

  weight_mem_gen_30_blk_mem_gen_generic_cstr \valid.cstr 
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
(* C_INITA_VAL = "0" *) (* C_INITB_VAL = "0" *) (* C_INIT_FILE = "weight_mem_gen_30.mem" *) 
(* C_INIT_FILE_NAME = "weight_mem_gen_30.mif" *) (* C_INTERFACE_TYPE = "0" *) (* C_LOAD_INIT_FILE = "1" *) 
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
module weight_mem_gen_30_blk_mem_gen_v8_4_1
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
  weight_mem_gen_30_blk_mem_gen_v8_4_1_synth inst_blk_mem_gen
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
module weight_mem_gen_30_blk_mem_gen_v8_4_1_synth
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

  weight_mem_gen_30_blk_mem_gen_top \gnbram.gnativebmg.native_blk_mem_gen 
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
