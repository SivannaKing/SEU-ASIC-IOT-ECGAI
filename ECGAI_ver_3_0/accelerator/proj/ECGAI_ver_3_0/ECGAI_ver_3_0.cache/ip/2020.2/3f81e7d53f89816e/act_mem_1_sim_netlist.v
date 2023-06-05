// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Mon Jun  5 19:21:39 2023
// Host        : wzxY9000X running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ act_mem_1_sim_netlist.v
// Design      : act_mem_1
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z035ffg676-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "act_mem_1,blk_mem_gen_v8_4_4,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_4,Vivado 2020.2" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (clka,
    ena,
    wea,
    addra,
    dina,
    douta);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [9:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [31:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [31:0]douta;

  wire [9:0]addra;
  wire clka;
  wire [31:0]dina;
  wire [31:0]douta;
  wire ena;
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
  wire [31:0]NLW_U0_doutb_UNCONNECTED;
  wire [9:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [9:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "10" *) 
  (* C_ADDRB_WIDTH = "10" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "1" *) 
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
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     2.95215 mW" *) 
  (* C_FAMILY = "zynq" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "1" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
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
  (* C_INIT_FILE = "act_mem_1.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "0" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "1024" *) 
  (* C_READ_DEPTH_B = "1024" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "32" *) 
  (* C_READ_WIDTH_B = "32" *) 
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
  (* C_WRITE_DEPTH_A = "1024" *) 
  (* C_WRITE_DEPTH_B = "1024" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "32" *) 
  (* C_WRITE_WIDTH_B = "32" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_blk_mem_gen_v8_4_4 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_U0_doutb_UNCONNECTED[31:0]),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[9:0]),
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
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[9:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[31:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
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
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2020.2"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
QGLtnqZzRetDH6gCWT4Js6wuLlZfrNx/VJp3sfR2NF+cxypO5AxN0oDKLJJtmdrtE/ueNDg+Qf7Z
TqBNRojORA==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
B6Ger3hRvfjHkaJ+W8639Kl3TzC9TogLuklOXEiMNdc4Im+DjEUzxb3DKlzu0VW3zxZqjJ3+wsW/
LnRmPCESi5Y9eRJaLFXg79EMfoj4X+nTdHAP6yCfltBADKegZ12gpnB/8ey5yn2KA74LUtPC7jna
iyjqSfsWLGnz6UdXzwk=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
BX+DxgMPRyZbYojCUR9Sk8Lq+3ZigBz4yMFHQkmurfdfDzyTPJCE827eGiPyTenK1QPVhEtf9g06
0BFXq/0COPuU1BWJwdkz1c4dE6/exDwhvEh+hPx3vRY6z8fDEf6aGVIXrHDvrmddehe7yMSIpo+k
aXHR06EEdfHCFY4TggYwhcJVXjkE+ApsVuyfmEfPmYjo8hCWyQyBsUWIOY03q1+MvUjjsmTwgs9g
fh5MY9ToaLfoJxPKdCpsqrBX4LJ+VDGFlAqIcqHTE2jCmPiToZAFXB7fzf1wDjFCBlJyFVDBGi0i
m+CouLSb7X1mvVhdDZgNrZDJMV688Bu3o54vew==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
DaIU/Ddc8USbZ2mURzujJDWDH1JbHl5tFVOOQ2aVaUPIA71yyE38OXVLEtF8rNmujYH30nEeQ+FV
LVJ16aaHw+iiuaqorTM3K5KLohVlN+WlcEtSXHuPNHjw8ddqtzpaX7pH1zqZH+YmfCL5oaNLqDH4
rkBnUl0/Gm/hzSwKjYhXGQFYQ+gGP99OjXakzrAqZzp/Iq4gt+Z5902/JV9thd/isHQImJ0QyK8M
EKM579iPAfXGes2mbiNYHcvDmSPYmW1zlhOE++N1EKeea7j/msnKeyhlC+hGE4Xfn4TVvqgQexCT
rp/wS/MosY6WH1aKFQlFH2hEppA7KXUaQlvG+w==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
XmWoAt4X8hrCJ5yTyug4ajJW5UhfkLNibzjihWzZ4Cr9hQSvWZoTc8rjGsLPbz6Le+/9iI5KxecS
eR0wiAO+G2IkwhZgVBeZdKoFnlnTVAyLjk9wMAFXNyJZM6b1NDbfXlPcUsC6JePvPlwwdWknkSsC
r3KvgkWAS+O3xvRmaNw=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Hw3Y+rShKrXiUViyNU1/O2qv6TgheLHBnFMj1i9MUGrHYqh9pLfLYUgWR7S2vj4jv4S+Ks0BpP4p
dKEqVAFmTCfQNEUHaVcFPkOHgig6L4mhLY6HUUKJoRgiQepgLi/W3V+ZZPQSQFkB3CU4MsJzhXvR
yLcpDriZy8cnAHD87Zi5DrNGBzj3kigJeM0du6lCQbxtF5aEdoaNP+YTnIFtcqYhoYnswQlYt0sV
HKgFA8VzqzL5WYnpH7+1IKmFkJBHkyqHCa9wPK0qCKnxkuDj70YzPVqQ+cocdKU+/gNdpCOdZlci
F2HTxrgfrXndJru3TiDqu4UavqAe0MNuFp3t0w==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
XPVggoWL6aXz+MpODTOZhEUQDa0vfEnUDaYeEHXm2vGyqKJujN2c/FFAFBeBYdJATLsIsQ+BqoPc
pBbcFYXDBfOtFIW2dH6Y1OoD65KyJ/hAq8coa21kFgq4hFat5vzZ2iIfkCpTUr4vDZO7Xne8cZO9
WsHffoTCt5rS59wWm2b8I5R8Eh2TUbQg3RCyrcnD66cvcEnlXe1CNMQ4/loVJpA4IBinBf820Wjc
vw2fZbGI0jXC+ACSHOviH63Xwmn+aRV5Ppkup7IYoon/ieKapRQeASu3TTY37xSBXiInSdtMTzJ6
+4GfO4eSHVriCk/sWbuTBzfRzoSShrnHjzz5LA==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2020_08", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
L78XuiswVcgO2gtebzL7SA9BC/jJGAM0v6S9pzmyqL+QYzRneiYeGyDmsW33jEVVSTuNjTXkBLY7
yTOKQruatwe4V0OLi6174saSAmPgerSV1GyLP7KhmusLV/N61avC9TPam+tekhKeE0tds4EnJ3et
4JdLh+SE4Z4pcuqCjB5MFneIYKKWDx7siU6oesAQtoSJOesfMchX63MhOjOHFP/ch+1gHv3T45hg
IGF7V7TrdREVE4f9631tlVJ1o2Dypsmo/76Itz5WCGlTMjAnWXN8IXxKN+PZ3dyt1wjrZm2P/td+
xiGszFnSLrRvw/HferwtSmRx8q0fiHZ88roGTw==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
kDX5kq2QEe25429T6vQqBCFvV1McKTJRYfK99ymVNK2GGvGLXSzgwJHwB2fj9rM0wme3zYYY0vQR
x+9F4L7KLlOVY6qY3LB59uDzyXBI3mMZaS905HXHJkdZHWtQWpfHhl27LqL+8FSluaD6F+KFfYOV
CwIOVuCIp/XjxFXpNBik7YiPt4kHOlDA97IXNLnYUn/g1csGqeNWce4UTne50ggWvLYGbTFGmTjT
N67TpUiGRVRCSv8Tax72GWFIMFZk3Tlp68ZUSQEybZMWX1U9XdMdtxfvNGhf8mi5jQJ2SupSzKu4
T/+53IN9T8aLePAiGBKKG1ZBj4y1ZyYA7XYvjw==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 27952)
`pragma protect data_block
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
Tilp6p5QkjZyRTKVsqVSEDEiejR6ww==
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
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
    reg GRESTORE_int;

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
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

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

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
