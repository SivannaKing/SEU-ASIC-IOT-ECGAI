// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.1 (win64) Build 2188600 Wed Apr  4 18:40:38 MDT 2018
// Date        : Mon Nov 29 14:50:12 2021
// Host        : DESKTOP-5DABIT8 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/FPGA/e203_ecg/e203_ecg/project_2/project_2.srcs/sources_1/ip/weight_mem_gen_00/weight_mem_gen_00_sim_netlist.v
// Design      : weight_mem_gen_00
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a200tfbg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "weight_mem_gen_00,blk_mem_gen_v8_4_1,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_1,Vivado 2018.1" *) 
(* NotValidForBitStream *)
module weight_mem_gen_00
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
  (* C_INIT_FILE = "weight_mem_gen_00.mem" *) 
  (* C_INIT_FILE_NAME = "weight_mem_gen_00.mif" *) 
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
  weight_mem_gen_00_blk_mem_gen_v8_4_1 U0
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
module weight_mem_gen_00_bindec
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
module weight_mem_gen_00_bindec_0
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
module weight_mem_gen_00_blk_mem_gen_generic_cstr
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

  weight_mem_gen_00_bindec \bindec_a.bindec_inst_a 
       (.addra(addra[13:11]),
        .ena(ena),
        .ena_array(ena_array));
  weight_mem_gen_00_bindec_0 \bindec_b.bindec_inst_b 
       (.addrb(addrb[13:11]),
        .enb(enb),
        .enb_array(enb_array));
  weight_mem_gen_00_blk_mem_gen_mux__parameterized0 \has_mux_b.B 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ({\ramloop[1].ram.r_n_0 ,\ramloop[1].ram.r_n_1 ,\ramloop[1].ram.r_n_2 ,\ramloop[1].ram.r_n_3 ,\ramloop[1].ram.r_n_4 ,\ramloop[1].ram.r_n_5 ,\ramloop[1].ram.r_n_6 ,\ramloop[1].ram.r_n_7 }),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 (ram_doutb),
        .DOBDO({\ramloop[2].ram.r_n_0 ,\ramloop[2].ram.r_n_1 ,\ramloop[2].ram.r_n_2 ,\ramloop[2].ram.r_n_3 ,\ramloop[2].ram.r_n_4 ,\ramloop[2].ram.r_n_5 ,\ramloop[2].ram.r_n_6 ,\ramloop[2].ram.r_n_7 }),
        .addrb(addrb[13:11]),
        .clkb(clkb),
        .doutb(doutb),
        .enb(enb));
  weight_mem_gen_00_blk_mem_gen_prim_width \ramloop[0].ram.r 
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .dina(dina),
        .\doutb[7] (ram_doutb),
        .ena(ena),
        .enb(enb),
        .wea(wea));
  weight_mem_gen_00_blk_mem_gen_prim_width__parameterized0 \ramloop[1].ram.r 
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .dina(dina),
        .\doutb[7] ({\ramloop[1].ram.r_n_0 ,\ramloop[1].ram.r_n_1 ,\ramloop[1].ram.r_n_2 ,\ramloop[1].ram.r_n_3 ,\ramloop[1].ram.r_n_4 ,\ramloop[1].ram.r_n_5 ,\ramloop[1].ram.r_n_6 ,\ramloop[1].ram.r_n_7 }),
        .ena(ena),
        .enb(enb),
        .wea(wea));
  weight_mem_gen_00_blk_mem_gen_prim_width__parameterized1 \ramloop[2].ram.r 
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
module weight_mem_gen_00_blk_mem_gen_mux__parameterized0
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
module weight_mem_gen_00_blk_mem_gen_prim_width
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

  weight_mem_gen_00_blk_mem_gen_prim_wrapper_init \prim_init.ram 
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
module weight_mem_gen_00_blk_mem_gen_prim_width__parameterized0
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

  weight_mem_gen_00_blk_mem_gen_prim_wrapper_init__parameterized0 \prim_init.ram 
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
module weight_mem_gen_00_blk_mem_gen_prim_width__parameterized1
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

  weight_mem_gen_00_blk_mem_gen_prim_wrapper_init__parameterized1 \prim_init.ram 
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
module weight_mem_gen_00_blk_mem_gen_prim_wrapper_init
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
    .INIT_00(256'h0581830484000481820383810504840281000202088283830581848781818203),
    .INIT_01(256'h0182060083848481010604020401830585820401820381038786858686868286),
    .INIT_02(256'h0085850206030385000481008585840606810485818581898890888281810283),
    .INIT_03(256'h040400828283048481820201848603828982848981898E8E0406010486848302),
    .INIT_04(256'h8203810285838282870303018306070581820482878701010081840283008483),
    .INIT_05(256'h0000820186840200008205048202048301860402030484858200048100030081),
    .INIT_06(256'h0001058801810485830404838204020584850200838203060201040382028306),
    .INIT_07(256'h0182018382810100818282828181820201048284850201830001020201008682),
    .INIT_08(256'h8102030500010084018402848501010281848300010484000403848204038403),
    .INIT_09(256'h0083010584828403838304000082040282828282050384830084878183050781),
    .INIT_0A(256'h8101008501828183050000018302828103018385028289010401040182020282),
    .INIT_0B(256'h8302810284818182850083850306038481878605038181898787000403008684),
    .INIT_0C(256'h8184878382040003010303008183840201010182010002028404060381830084),
    .INIT_0D(256'h8304000400810500820301038183878282868881838685848387848400850502),
    .INIT_0E(256'h0084810202848182020083028381008484828203840104818402040185850101),
    .INIT_0F(256'h8682848381818184830481010183810102818401010084850081040282840002),
    .INIT_10(256'h0207040002828787818503010105858302020083030001000184828388818183),
    .INIT_11(256'h0404018386840385818301830083030105830483000181818405840384870104),
    .INIT_12(256'h0583040300060406040001878384038105838602000482020481010185838384),
    .INIT_13(256'h8503038200038482008582040287878202020283030103820185870403880002),
    .INIT_14(256'h8100830482828302010281850001020303818381018383810003018203008102),
    .INIT_15(256'h82048A0081040084820282020301008401028384030382810183028282830101),
    .INIT_16(256'h0302830003010105828200028102830081850082838100040204840000810000),
    .INIT_17(256'h0002838281018300018281828303818482858784868200000184000302818600),
    .INIT_18(256'h8283820000028285810002028300020281020381020000868105040082810281),
    .INIT_19(256'h8101048581028301010082840202000103858104820003820303820505848185),
    .INIT_1A(256'h8381010182010281858102838304000681810300848282020382038200010381),
    .INIT_1B(256'h0001000281858202020581840182018484820506030001818481010001828300),
    .INIT_1C(256'h0100820283018102018288820004050281810001030482000183010004008181),
    .INIT_1D(256'h8403020200820202018484848481830303030300010083840203818400050405),
    .INIT_1E(256'h0002838181810005048284848101040382858282030105020381038201848886),
    .INIT_1F(256'h8103040000020183818102028101048203028786858484828401070185848481),
    .INIT_20(256'h8382058201040401818300008483840003838300820003820708838A02020401),
    .INIT_21(256'h0301888486820281888883830501818581848300020201028202028501858185),
    .INIT_22(256'h8300818181860000818682850102838885848602008200868381028383828484),
    .INIT_23(256'h828205050382878A848200030100888105070287858484020283010100828185),
    .INIT_24(256'h8103010201868582018482858482818281008383868503838682818282818181),
    .INIT_25(256'h8484018505000102010201848200838283820085010182040082000083890100),
    .INIT_26(256'h0100848386858281818484828403008103018402010304000100000001008581),
    .INIT_27(256'h8181810301008100028383000301838683000000838101010708850383048785),
    .INIT_28(256'h8201820282028284848484018383090804060902050202028284848583868484),
    .INIT_29(256'h8300028186840084828202818685838700810502810101848102870103858185),
    .INIT_2A(256'h0300030002840202008784830003028185000300820281810184000201818683),
    .INIT_2B(256'h8301810503040703828484010181030283018202030100830183020100820104),
    .INIT_2C(256'h8181838181810183028183840004810281858283820002008381810081850182),
    .INIT_2D(256'h0404810083000382010001040181030302018303838186840002018384828101),
    .INIT_2E(256'h0300010200020003028283858783810183030203000603028188010208098182),
    .INIT_2F(256'h8183868283828384838504040002008283818285838301030281820301818783),
    .INIT_30(256'h8381818381838200000101820202010082830100008100038381828301840101),
    .INIT_31(256'h8281830204020181838381000000838101820281020282820383020181018100),
    .INIT_32(256'h8200000181818300000282838183008401008283848300028383838482008383),
    .INIT_33(256'h8301028383008284818181828102000200810281028101008383000101020101),
    .INIT_34(256'h0183828182838102028383020081828201018181830083828201840100828182),
    .INIT_35(256'h8483010002010000038181838381028201838184018300818300028101008101),
    .INIT_36(256'h0002838282018283000282010182820002810181810283830184818301018483),
    .INIT_37(256'h0182828203810302838286810104030086878701810501878900060485018281),
    .INIT_38(256'h8786058104888600060482050282810404070484838283060501028483048284),
    .INIT_39(256'h0585018187008103008288838400050104818503818405048284008389830185),
    .INIT_3A(256'h018601850703028185038485818285840200828103848281030081838B828202),
    .INIT_3B(256'h018300008986010303058686840301000382858482028A0204848F0405058881),
    .INIT_3C(256'h8285828284840403858582000706828987820401040584850506830482018100),
    .INIT_3D(256'h0382888182858403010305848483070403040300018502050083838781848584),
    .INIT_3E(256'h8100810002018200010082010101028482810082838382018381838483028301),
    .INIT_3F(256'h0284020200828381818381828200028202820183830201830383818384020282),
    .INIT_40(256'h0102818181008183008401838300008383008281010000818281848183810102),
    .INIT_41(256'h8183828100818200010081020182018381838283838182810082000200828101),
    .INIT_42(256'h8101828202828100008181848483810083848281820101818183848203028101),
    .INIT_43(256'h0181010202020283850081830081018282828201000201000183020283010184),
    .INIT_44(256'h0182018183838582830200810000818283020001820281828384010081008183),
    .INIT_45(256'h8183008283810083010083038301828681008200818685838204020182848583),
    .INIT_46(256'h8401038301828301020100810681820202010202830201028181828384008200),
    .INIT_47(256'h0503838100060381850102008503038202010282008182810082000202018184),
    .INIT_48(256'h8400838604818482018300008283018301838100000202028101868484038101),
    .INIT_49(256'h0201820082820000818181868303020283828183000400030183828583818285),
    .INIT_4A(256'h8184850002818384818103810202858482838102018382858101810606810283),
    .INIT_4B(256'h0103840084838484818382830001820181040301040001028582868281028204),
    .INIT_4C(256'h0102818183830085018384028984888684038282008384848484838384818181),
    .INIT_4D(256'h0202010185810108038383818281818184858685858700000406020706000500),
    .INIT_4E(256'h8100810081010706060307028181010104810301038282840000010183000083),
    .INIT_4F(256'h0100818200848382010184858201048182840183020100828183050301810004),
    .INIT_50(256'h0102820301810281020102010404010001020301820201000200810404828203),
    .INIT_51(256'h0281060404000503010182000082010482828300018184840101820200810303),
    .INIT_52(256'h0381030100018481008281018304848200008586820182840302810281820181),
    .INIT_53(256'h0081848101000381010202010083018200830082830081000303848485010401),
    .INIT_54(256'h8181860000820304008182810082010381008284838201030101010183000104),
    .INIT_55(256'h8502830200018102030081878687000000040004838381810100840201038381),
    .INIT_56(256'h8181820300000101810002010183848383818483830381840000818100828200),
    .INIT_57(256'h0101028103008182010181038102070501008303810381860703020103038300),
    .INIT_58(256'h0301010000018402838401828281828200830105048101848400020081810082),
    .INIT_59(256'h0200040504048283828181038181000300000184008202010002048100000101),
    .INIT_5A(256'h0182008181010302820181038483020203820201008300818400828103038200),
    .INIT_5B(256'h0381008203018181830181030003010182010503040282840303028201840301),
    .INIT_5C(256'h8583838200048200830001818201020181020581038182820281010081050205),
    .INIT_5D(256'h8502010201008581810301810301810082020002060382000102040200838185),
    .INIT_5E(256'h0A82858281810082820104848382818302028582000402848501838684818181),
    .INIT_5F(256'h0103000281820203008187818382810201818583818282020001820181000502),
    .INIT_60(256'h0181820202828200028102020085008204868584030481810184838384828101),
    .INIT_61(256'h8687868183838502020281018283020381818283008282048102848382820303),
    .INIT_62(256'h8104018303008402820182040200008181810401018101030504028502010687),
    .INIT_63(256'h03028203820101028183820502050A8405040083008101008104080783008485),
    .INIT_64(256'h8282010101008282000200010182010283020002818300030583830003020101),
    .INIT_65(256'h0081810281020482840003008104040581000305810384868503040383818282),
    .INIT_66(256'h0000028101030081008303020004010000828189858104090381048103828181),
    .INIT_67(256'h8302028301000082010201828104000102048687828386820100030083040783),
    .INIT_68(256'h0001018201030182040283850301000182828101818383858400010284838281),
    .INIT_69(256'h8383860282038382018383868401820181858302038104050382010084000003),
    .INIT_6A(256'h8483858383818504000403050803010403070083040505018103040385018183),
    .INIT_6B(256'h0807050300878682828181838401050004030002020082008385828583848184),
    .INIT_6C(256'h0781020002830203020404020283000182818883000403010002010204830004),
    .INIT_6D(256'h8583848184858181010105018185828A83828202010002010281040502810003),
    .INIT_6E(256'h8685838682840183818100820081830084828385828282828502028104818185),
    .INIT_6F(256'h0204018382828584858383828583838582000081828104838202010203020403),
    .INIT_70(256'h8384878383838284838104060402008384818100828306040400010302820000),
    .INIT_71(256'h8282810082038202828482828100848705050103040000018101000184010284),
    .INIT_72(256'h0402040005828285020103010103818301828103000402018382868184028101),
    .INIT_73(256'h8B87868B8D038100008285828185840800000501010001018101030282810302),
    .INIT_74(256'h0283000004030284830302000281828385848186000083818403810084028102),
    .INIT_75(256'h8288830383828281860704060000010505040203828581818585830102010001),
    .INIT_76(256'h03000382810389888484838A8882810284850102038185818181050284848483),
    .INIT_77(256'h0200008183818102838688008101820407010183838102050003070503040303),
    .INIT_78(256'h8181010100020302020200828183000101000002868400818181010301820103),
    .INIT_79(256'h0303050481818185868300858381050403020002040100048201048282818101),
    .INIT_7A(256'h8283020002018100048185010301050507060103078282850400840306810082),
    .INIT_7B(256'h0286868584000281010200020101020285890106090083830101838481838583),
    .INIT_7C(256'h8305058383810005828302020081000383818403810103028282038300830002),
    .INIT_7D(256'h8104820001020200010382830081838181828281818300838381000300020187),
    .INIT_7E(256'h0103858200818401818101810203008102828100838185020302820101008281),
    .INIT_7F(256'h0704020805080402008400818101008382010003050300010183858482038203),
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
module weight_mem_gen_00_blk_mem_gen_prim_wrapper_init__parameterized0
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
    .INIT_00(256'h8201810105058383810100028282820082000101000282820306828204038405),
    .INIT_01(256'h0082848102840183050081040083838101030202020301828200828183820300),
    .INIT_02(256'h0282820182818101000001810081050084010100820182810182850000810101),
    .INIT_03(256'h8200888685848401850083020283828381828181848300018301028381820202),
    .INIT_04(256'h0001810302018103810181000103010502840100810083860203048103818203),
    .INIT_05(256'h0384000000858184828381820303848102828883828201810202040704010381),
    .INIT_06(256'h0183058301038204810301820002020200028182000281020101828183020382),
    .INIT_07(256'h0304000101030101828281028383040283000081018102810381028103028281),
    .INIT_08(256'h8401828383028182000084830181038182848182820182000300018301018301),
    .INIT_09(256'h8386008602070705060102030181810181020182000202058182828481028281),
    .INIT_0A(256'h0001038281840181810082010001010181010182030104810304810200008187),
    .INIT_0B(256'h0282830283820400818302820281828500840202810481818181818281018300),
    .INIT_0C(256'h8281030003010103818200020103810300818182050406030686838581860282),
    .INIT_0D(256'h8282008586818202000303050003038204000003030001018286828300010281),
    .INIT_0E(256'h0181008105010302810807020701850102838201050102090304000001828786),
    .INIT_0F(256'h0281008300828284010083000084838109838285810401050502850102010383),
    .INIT_10(256'h8786838184820485828281810003020402028303020101030382810381008381),
    .INIT_11(256'h8202060383818202000081828101820002020100030005028203020002020183),
    .INIT_12(256'h0381030001018183810084818285858581858285860285858282008585848201),
    .INIT_13(256'h0805038184028302830205000083810203820102010305810303030200000203),
    .INIT_14(256'h8383008281820204040303838281828300828402810002010083010284838405),
    .INIT_15(256'h0202048282810183050182018185050104828202038183858184868681810000),
    .INIT_16(256'h0402040102820202838202010302008183018101820102838181010100048104),
    .INIT_17(256'h0301040201010500828181820203000102020183828201828202828201810282),
    .INIT_18(256'h0283008200810404028485840183040005010485848187838282830000820300),
    .INIT_19(256'h8205810304000101820183000402040200820405020303810301820082008401),
    .INIT_1A(256'h0504050204020081030003000101838200028482828101878400848500038181),
    .INIT_1B(256'h8684818400028102848288878484820106040503010301820481030103010906),
    .INIT_1C(256'h0483040708828281018182850085810086838202820381010201038100848301),
    .INIT_1D(256'h8589828300810403010303048284818981828181018308050302018600848382),
    .INIT_1E(256'h0B0C0D8304058400008787838201838402848382018585008603848383848482),
    .INIT_1F(256'h8207010402848786018585038482810003040083878682848403000100040401),
    .INIT_20(256'h8182878201040187858604020486018183050102880605820383008584830482),
    .INIT_21(256'h8201048501830082048483048283858583888601020702040183018281860501),
    .INIT_22(256'h8584838287000001870182810206010081038105850201818284810105818103),
    .INIT_23(256'h0382038301028203818186860301810203000185838482818805818481040484),
    .INIT_24(256'h0004818187818181010100048203000502040283040281018100828681040007),
    .INIT_25(256'h0082828104020003040085830003820200048100868306010404028483858482),
    .INIT_26(256'h8801810781048401838300838104048201820182820304038181818482000504),
    .INIT_27(256'h8386860082030200820400048187898281838100050082818703838602020181),
    .INIT_28(256'h8383010084040304838283000204838384810203018684868786038202010504),
    .INIT_29(256'h05008103028201838682878C8C83018283818100018203030102820085878182),
    .INIT_2A(256'h8481820082848886870505040182838684000002038687850306030086830704),
    .INIT_2B(256'h8182838586858303848885040502840201858186838281858683020405010084),
    .INIT_2C(256'h848684858382868204820103838685828786820302058A898900010100868882),
    .INIT_2D(256'h8588888581010202010308050101020481810086858A8B888381858284878787),
    .INIT_2E(256'h0004028187030381010482020081008200818483820384810506838303848282),
    .INIT_2F(256'h8301828103010383028101000182018283048482008182818382838102820482),
    .INIT_30(256'h0483030402830083058482810283840082030002810401020100810202838303),
    .INIT_31(256'h8203008584818282010103008203820101000407020100838103030406858582),
    .INIT_32(256'h0009060504838303040103038383820382060403018582820501030100858403),
    .INIT_33(256'h0182010383028181008282018481020383850581038183830083000581018381),
    .INIT_34(256'h8100048202820100840001000485828587828300838988830304020105008181),
    .INIT_35(256'h0000020201010385818200830105818684818401828203020487838684830082),
    .INIT_36(256'h0004050201028281818101040203020101008482050082020303048284828586),
    .INIT_37(256'h0209828800868382810382008589858205820081038100850204820400030181),
    .INIT_38(256'h8282010201818403838205810386018200018285860581830003000105020603),
    .INIT_39(256'h0004018182880584018204058186848186028381830303008481010284820303),
    .INIT_3A(256'h0402020582810106818384818182838102020203000405018100840403828300),
    .INIT_3B(256'h8204008404018582828281818384850202038101848207848105858282030503),
    .INIT_3C(256'h0203048205010004010484018403030702830101018584008305820207020001),
    .INIT_3D(256'h0287850101838181018584820404010086828183030407830183820181000006),
    .INIT_3E(256'h0201018202840082838100020003020002058406018100818601848400018282),
    .INIT_3F(256'h0204818402008185000101848101850282818200048103000581840005030581),
    .INIT_40(256'h8502000400828385818301038301010203818400818402838583028202028104),
    .INIT_41(256'h0301880083000100838406018205820083018100888581030302858102838301),
    .INIT_42(256'h8181858302848483008402830081058484838382828201860100028583850000),
    .INIT_43(256'h0088040481000300878683000304848200830100848101020101010284810184),
    .INIT_44(256'h8584828306050182840102050402010482048500838201838583828483818483),
    .INIT_45(256'h8201850002000504020581050082008100840100838383848883848184828203),
    .INIT_46(256'h8184000201000200848185848282010202810101068702820381810281000203),
    .INIT_47(256'h0282010287008483820281858300020000000285818104810600848804830403),
    .INIT_48(256'h0905060403008183028383838100820386040403048986880101030183028483),
    .INIT_49(256'h8202838201810182840284010082030683000086028301008303840085030201),
    .INIT_4A(256'h0488818802020204030100810207008103830183010301040583830384000003),
    .INIT_4B(256'h8203010005838183028382828587838302838181000004048283820004010282),
    .INIT_4C(256'h89878484018100040081820583810303058B87870382838602010282818A8888),
    .INIT_4D(256'h0000868681040182018202820305040282030381008501080602010384030484),
    .INIT_4E(256'h8303000583010104028286858385020001040282838482810483000301830184),
    .INIT_4F(256'h0405820200008203030081020600830101018202010081838300020204048383),
    .INIT_50(256'h8200820404820184868502820283030083848101028103028100018301030003),
    .INIT_51(256'h0907060305818100850202838487828487010001020083028183870105028381),
    .INIT_52(256'h8600028104060300828384020381008184838501030081038101810082028481),
    .INIT_53(256'h03000282818286008382848402818586020502008685090C0B82868382008181),
    .INIT_54(256'h0005818101840001028483878200030201010183030102020083838484848483),
    .INIT_55(256'h0200000402038282830200030400038204828487008183040103810283040200),
    .INIT_56(256'h0384838100038400838281018102868101820000830083010583858186828682),
    .INIT_57(256'h0203050203040281888182008403820185000481008184820184890104838104),
    .INIT_58(256'h0181010288028184830302840000868B01818384830204040581028483848385),
    .INIT_59(256'h0400048187848381810005010284820002008501830202078103058402828208),
    .INIT_5A(256'h0482820381058100878503028105880003880500008103820401860301810184),
    .INIT_5B(256'h0102038201050384028384000185038183030600010085040383820405828200),
    .INIT_5C(256'h8382850003818202020305828283008389860100828784020185810202040183),
    .INIT_5D(256'h8501840101840806080302048286840083040000000081008282828783860304),
    .INIT_5E(256'h01838B8488820185038103000283020282000000828203840188018283050209),
    .INIT_5F(256'h8282818202838482838484838600028283828800000481028681050183038384),
    .INIT_60(256'h0183830003038402850104048185868586840004048483818384008384848303),
    .INIT_61(256'h850285828881008386868A008103850084858586008689020584030402040506),
    .INIT_62(256'h0003848302810204840081048181018506010885010201000282820083828102),
    .INIT_63(256'h0181828485840302820283010501000782080181870304008285848102818300),
    .INIT_64(256'h0183028184020184810282820405820005840202038382008481848384020007),
    .INIT_65(256'h0281888282010081838381058286008483818101830203038187858300868201),
    .INIT_66(256'h0082038688888581018102040001818184010483828300018382000081820302),
    .INIT_67(256'h0103828284008105050383868501840182820201820281008401820100810303),
    .INIT_68(256'h0284068182008386818101828401838304040382040400068205840605000401),
    .INIT_69(256'h050103828283898A848587868200840682058101010203018103818700860084),
    .INIT_6A(256'h8303820002008100038381828384848283858687818183828284868386038302),
    .INIT_6B(256'h0302018100008183838281010007080400008100040384828384828584820083),
    .INIT_6C(256'h8202810100050481828583810084020181838300048181810004000481010702),
    .INIT_6D(256'h8401020281868382030284030200830081820301028382828383018105000282),
    .INIT_6E(256'h8484838502010101020283858102818204838501848403030382868601018304),
    .INIT_6F(256'h8201850304820384010102838302810281038284018584008586860003820082),
    .INIT_70(256'h8204868401820083020400828186828101020382038301020403050382050081),
    .INIT_71(256'h0004048183000281038305020104810183810003020386810504040402818203),
    .INIT_72(256'h0002028203038300858381840082818100818102818200830283010103820081),
    .INIT_73(256'h8583848100000381810303008382020182838181020404020183018300070201),
    .INIT_74(256'h8186818301028281000102050584840383820285858581010283820183830486),
    .INIT_75(256'h0183818385820407050100030101030484030600018402000182828284810281),
    .INIT_76(256'h03048182850300858400818702838B0182828300030203060101848483868681),
    .INIT_77(256'h8184818482848101818305030281828483840101020282018282818102810002),
    .INIT_78(256'h8402840503818600018781010087828384030400000382018585850084000100),
    .INIT_79(256'h8105820104810582810081868488810481828103850086060002028184000102),
    .INIT_7A(256'h0086020000030182818607060681868589018782000105000784030285040586),
    .INIT_7B(256'h81050A8481810403010201018284840281810001038200018101820400020482),
    .INIT_7C(256'h8285018304820502848100840782820181860281018300040083820481858282),
    .INIT_7D(256'h8284828884008400010501820001008102010182830108070A87888483848482),
    .INIT_7E(256'h0003838281000282858105018604048682020481020381000302048282048287),
    .INIT_7F(256'h8404030000860503080503848682810003010501018483810402828101018303),
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
module weight_mem_gen_00_blk_mem_gen_prim_wrapper_init__parameterized1
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
    .INIT_00(256'h0001040084008186888701010282830182848301008401818303010105000400),
    .INIT_01(256'h0500038388840481858184850382810204068103840202838101000103848383),
    .INIT_02(256'h0286820001860005038584810005038403038805810204870287848683818389),
    .INIT_03(256'h8300028189028683858389820383048102010482880384848784828102050402),
    .INIT_04(256'h8200008500010083050685038201828502858286838285818288888184038500),
    .INIT_05(256'h8283828301870602820500868581870481820086058702010182858603000304),
    .INIT_06(256'h000782818581028604838683838889878184880086038302030202868B038683),
    .INIT_07(256'h0203818385058784010182860187038205878684030003010585018200010084),
    .INIT_08(256'h0002850781878102828381018502020001040383860384850100828102860001),
    .INIT_09(256'h04870401838101070100818382018800008300010281048A0001008308010185),
    .INIT_0A(256'h8281000285020200010184048603048281048205000087860006040189818485),
    .INIT_0B(256'h0282018401818700828704020684068382020583098300810482020981888102),
    .INIT_0C(256'h0382030486040681810182060302868703060103858183810383038185888105),
    .INIT_0D(256'h0484840000010881810101810805010204020309008185810183000287030083),
    .INIT_0E(256'h0204010105838784830201848400868585828281868184070281820101048302),
    .INIT_0F(256'h0081090487828601030281840484010100828382850202030382810388028100),
    .INIT_10(256'h8582030001048282098102820581028181038201028102040101000382048300),
    .INIT_11(256'h0486018901070302020203818100858484080381020502028282010000008708),
    .INIT_12(256'h0400820204810081030085000183850102820003020182000381060384810083),
    .INIT_13(256'h0200020084008683020D080205030202898482838181000A8183020482010001),
    .INIT_14(256'h8101840104848281008604058382860201020901878283810381018602030383),
    .INIT_15(256'h8507020506008181890004000386810300810202038382820881040207038383),
    .INIT_16(256'h8205848705010481008584030C02820282010005030104830406028400010100),
    .INIT_17(256'h080001098306828383828206048203018181038385878306050C0582820F8602),
    .INIT_18(256'h0083028105000083000101060303040103850181810481048387028603000483),
    .INIT_19(256'h0200840202000585000105008401810505090482000D82008100848304820403),
    .INIT_1A(256'h82818308028303810481038303818802008884840A8402810902820B820A8286),
    .INIT_1B(256'h810684848287830607088385830C85010002818903010381010084820C020002),
    .INIT_1C(256'h0003040003058205828500020484028204030306010301840104008101000383),
    .INIT_1D(256'h0405840202858385810082018101830381878583828200018106860006820184),
    .INIT_1E(256'h8781828401040600858300028100830002818781008802840208818785868701),
    .INIT_1F(256'h8200048283038501008505828283020103058604048602810583820781008387),
    .INIT_20(256'h8781020104818486828800008385020283020400030200050102858182860286),
    .INIT_21(256'h8182000386030304030501000701028807828502820181888282058381020100),
    .INIT_22(256'h03878781850100028403838783048C0205018283828400890101828100018202),
    .INIT_23(256'h000381040281888A058185030481868603010581818402028886020501838703),
    .INIT_24(256'h0282828782810305840084030182078182860403008303050003868605828301),
    .INIT_25(256'h0481050285000081838600860201810088018101010603818804848601018182),
    .INIT_26(256'h8985868187810300838800048103820202030002050185848301860582028986),
    .INIT_27(256'h0482828303840206848983030081010181058583010185850001038405060003),
    .INIT_28(256'h0182830584050009010501810100828485008304830284860003830582838581),
    .INIT_29(256'h0306030282090401030385000681820581830287010401008303868887820400),
    .INIT_2A(256'h0085048283850400050581028282828101020001030181880583878901868203),
    .INIT_2B(256'h0586048204868304000503828289840281028286008489020201008682008489),
    .INIT_2C(256'h0502000104810002028385828104028303818282830406888103820381870501),
    .INIT_2D(256'h0085848281888804850302840086000182040382020088848283048183850502),
    .INIT_2E(256'h0488000184018384028400818183048584008200028903860382010200820281),
    .INIT_2F(256'h0003048405858784810082000085848686850803828205010385018305820000),
    .INIT_30(256'h0183020000810181838300020281828207840382818106038500818700818C82),
    .INIT_31(256'h0283018200828584848406820283010205028400038401040281828184830301),
    .INIT_32(256'h8200010281840481050104010182000183020284000085008781040105828384),
    .INIT_33(256'h8100078482000203810482000304840303040102810682860001840501030287),
    .INIT_34(256'h8100070404838106048204028184870500000402080186828300000302008102),
    .INIT_35(256'h0484070002000281020402840281040403030407028302828100810203838281),
    .INIT_36(256'h0282820186828583818505020783848588000103050385858783060183818281),
    .INIT_37(256'h0381098382820006030304058304008685000001018302820184030407820103),
    .INIT_38(256'h8586058884088404008102008A04828202060786830008840788020386050489),
    .INIT_39(256'h84030707070A05878A01040682010102038D068D048405898884848786058708),
    .INIT_3A(256'h8B0703010507038F87078C03840481078A078589068988050885880185878489),
    .INIT_3B(256'h82088B8D028607080587068B81848107840188048782038A078A87038A070700),
    .INIT_3C(256'h02898E05828A81818584068602850A81878884098C0985070105078809839308),
    .INIT_3D(256'h81078F898C8883840504018887090483020004888D8588838906848306828581),
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
module weight_mem_gen_00_blk_mem_gen_top
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

  weight_mem_gen_00_blk_mem_gen_generic_cstr \valid.cstr 
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
(* C_INITA_VAL = "0" *) (* C_INITB_VAL = "0" *) (* C_INIT_FILE = "weight_mem_gen_00.mem" *) 
(* C_INIT_FILE_NAME = "weight_mem_gen_00.mif" *) (* C_INTERFACE_TYPE = "0" *) (* C_LOAD_INIT_FILE = "1" *) 
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
module weight_mem_gen_00_blk_mem_gen_v8_4_1
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
  weight_mem_gen_00_blk_mem_gen_v8_4_1_synth inst_blk_mem_gen
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
module weight_mem_gen_00_blk_mem_gen_v8_4_1_synth
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

  weight_mem_gen_00_blk_mem_gen_top \gnbram.gnativebmg.native_blk_mem_gen 
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
