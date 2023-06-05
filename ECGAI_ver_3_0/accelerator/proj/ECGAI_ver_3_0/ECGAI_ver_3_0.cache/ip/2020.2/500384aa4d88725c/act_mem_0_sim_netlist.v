// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Mon Jun  5 19:21:39 2023
// Host        : wzxY9000X running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ act_mem_0_sim_netlist.v
// Design      : act_mem_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z035ffg676-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "act_mem_0,blk_mem_gen_v8_4_4,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_4,Vivado 2020.2" *) 
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
0d090l0+bkrb8HkH+mueeUXjJNlpNA==
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
