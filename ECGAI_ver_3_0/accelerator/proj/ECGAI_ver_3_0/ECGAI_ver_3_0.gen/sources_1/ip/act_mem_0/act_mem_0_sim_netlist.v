// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Mon Jun  5 19:21:39 2023
// Host        : wzxY9000X running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top act_mem_0 -prefix
//               act_mem_0_ act_mem_0_sim_netlist.v
// Design      : act_mem_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z035ffg676-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "act_mem_0,blk_mem_gen_v8_4_4,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_4,Vivado 2020.2" *) 
(* NotValidForBitStream *)
module act_mem_0
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
  (* C_INIT_FILE = "act_mem_0.mem" *) 
  (* C_INIT_FILE_NAME = "act_mem_0.mif" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "1" *) 
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
  act_mem_0_blk_mem_gen_v8_4_4 U0
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 27600)
`pragma protect data_block
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
txuvp0O6CjSud12M
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
