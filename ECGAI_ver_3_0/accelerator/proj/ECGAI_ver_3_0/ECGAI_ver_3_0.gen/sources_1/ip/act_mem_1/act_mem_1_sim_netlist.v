// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Mon Jun  5 19:21:40 2023
// Host        : wzxY9000X running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               e:/Repository/SEU-ASIC-IOT-ECGAI/ECGAI_ver_3_0/accelerator/proj/ECGAI_ver_3_0/ECGAI_ver_3_0.gen/sources_1/ip/act_mem_1/act_mem_1_sim_netlist.v
// Design      : act_mem_1
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z035ffg676-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "act_mem_1,blk_mem_gen_v8_4_4,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_4,Vivado 2020.2" *) 
(* NotValidForBitStream *)
module act_mem_1
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
  act_mem_1_blk_mem_gen_v8_4_4 U0
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 27888)
`pragma protect data_block
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
p8QKXZu0dLOSIGpO4dxf
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
