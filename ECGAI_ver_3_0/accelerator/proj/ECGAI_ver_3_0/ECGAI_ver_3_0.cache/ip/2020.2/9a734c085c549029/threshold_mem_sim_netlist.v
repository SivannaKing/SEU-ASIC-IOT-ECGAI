// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Mon Jun  5 19:21:39 2023
// Host        : wzxY9000X running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ threshold_mem_sim_netlist.v
// Design      : threshold_mem
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z035ffg676-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "threshold_mem,blk_mem_gen_v8_4_4,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_4,Vivado 2020.2" *) 
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
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [7:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [31:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [31:0]douta;

  wire [7:0]addra;
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
  wire [7:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [7:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "8" *) 
  (* C_ADDRB_WIDTH = "8" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "1" *) 
  (* C_COUNT_36K_BRAM = "0" *) 
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
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     3.53845 mW" *) 
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
  (* C_INIT_FILE = "threshold_mem.mem" *) 
  (* C_INIT_FILE_NAME = "threshold_mem.mif" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "1" *) 
  (* C_MEM_TYPE = "0" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "256" *) 
  (* C_READ_DEPTH_B = "256" *) 
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
  (* C_WRITE_DEPTH_A = "256" *) 
  (* C_WRITE_DEPTH_B = "256" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "32" *) 
  (* C_WRITE_WIDTH_B = "32" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_blk_mem_gen_v8_4_4 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
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
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[7:0]),
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
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[7:0]),
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 19760)
`pragma protect data_block
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
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
