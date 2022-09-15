// *************************************************************************
// @Project Name : ECG_CPU 
// @Author       : Huangjunguang
// @Email        : huangjunguang@seu.edu.cn
// @File Name    : PEarray16_8.v
// @Module Name  : PEarray16_8
// @Created Time : 2020-05-21 12:46
//
// @Abstract     : This module is sum of PEs              
//               
// Modification History
// *************************************************************************
// Date			BY           	Version		Change Description
// -------------------------------------------------------------------------
// 2020-05-21  	Huangjunguang   v1.0        initial version 
// 2021-09-10	wzx				v2.1		add eng annotations
// *************************************************************************
`timescale 1ns / 1ns
`define byte_width 8
`define halfword_width 16

module PEarray16_8 (
    input                            clk_cal,
    input                            rst_cal_n,
    // Signals with cfg
    input      [                5:0] or_cs,
    input      [                3:0] nn_layer_cnt,
    input                            rd_done,
    input      [               10:0] Calcycle,      // = K*IChannel
    input      [               10:0] pass_cycle,    // = R+C+K-1-2
    // Signals with Input_Regfile
    input      [    `byte_width-1:0] IMap1,
    input      [    `byte_width-1:0] IMap2,
    input      [    `byte_width-1:0] IMap3,
    input      [    `byte_width-1:0] IMap4,
    input      [    `byte_width-1:0] IMap5,
    input      [    `byte_width-1:0] IMap6,
    input      [    `byte_width-1:0] IMap7,
    input      [    `byte_width-1:0] IMap8,
    input      [    `byte_width-1:0] IMap9,
    input      [    `byte_width-1:0] IMap10,
    input      [    `byte_width-1:0] IMap11,
    input      [    `byte_width-1:0] IMap12,
    input      [    `byte_width-1:0] IMap13,
    input      [    `byte_width-1:0] IMap14,
    input      [    `byte_width-1:0] IMap15,
    input      [    `byte_width-1:0] IMap16,
    input                            ImapVld,
    // Signals with Weight buffer
    input      [    `byte_width-1:0] IWeight1,
    input      [    `byte_width-1:0] IWeight2,
    input      [    `byte_width-1:0] IWeight3,
    input      [    `byte_width-1:0] IWeight4,
    input      [    `byte_width-1:0] IWeight5,
    input      [    `byte_width-1:0] IWeight6,
    input      [    `byte_width-1:0] IWeight7,
    input      [    `byte_width-1:0] IWeight8,
    input                            IweightVld1,
    input                            IweightVld2,
    input                            IweightVld3,
    input                            IweightVld4,
    input                            IweightVld5,
    input                            IweightVld6,
    input                            IweightVld7,
    input                            IweightVld8,
    // Signals with Output Regfile
    output     [`halfword_width-1:0] PE_OMap1,
    output     [`halfword_width-1:0] PE_OMap2,
    output     [`halfword_width-1:0] PE_OMap3,
    output     [`halfword_width-1:0] PE_OMap4,
    output     [`halfword_width-1:0] PE_OMap5,
    output     [`halfword_width-1:0] PE_OMap6,
    output     [`halfword_width-1:0] PE_OMap7,
    output     [`halfword_width-1:0] PE_OMap8,
    output                           PE_OMapVld1,
    output                           PE_OMapVld2,
    output                           PE_OMapVld3,
    output                           PE_OMapVld4,
    output                           PE_OMapVld5,
    output                           PE_OMapVld6,
    output                           PE_OMapVld7,
    output                           PE_OMapVld8,
    output reg                       PE_end,
    //FC lyr
    output reg [    `byte_width-1:0] FC_OMap1,
    output reg [    `byte_width-1:0] FC_OMap2,
    output reg [    `byte_width-1:0] FC_OMap3,
    output reg [    `byte_width-1:0] FC_OMap4,
    output reg [    `byte_width-1:0] FC_OMap5,
    output reg [    `byte_width-1:0] FC_OMap6,
    output reg [    `byte_width-1:0] FC_OMap7,
    output reg [    `byte_width-1:0] FC_OMap8,
    output reg                       FC_OVld
);


    // ONextPE_Map
    wire 	[`byte_width-1:0] 	R1C1_ONextPE_Map, R1C2_ONextPE_Map, 
	R1C3_ONextPE_Map, R1C4_ONextPE_Map, R1C5_ONextPE_Map, 
	R1C6_ONextPE_Map, R1C7_ONextPE_Map, R1C8_ONextPE_Map, 
	R1C9_ONextPE_Map, R1C10_ONextPE_Map, R1C11_ONextPE_Map, 
	R1C12_ONextPE_Map, R1C13_ONextPE_Map, R1C14_ONextPE_Map, 
	R1C15_ONextPE_Map, R1C16_ONextPE_Map;
    wire						R1C1_ONextPE_MapVld, R1C2_ONextPE_MapVld, 
	R1C3_ONextPE_MapVld, R1C4_ONextPE_MapVld, R1C5_ONextPE_MapVld, 
	R1C6_ONextPE_MapVld, R1C7_ONextPE_MapVld, R1C8_ONextPE_MapVld, 
	R1C9_ONextPE_MapVld, R1C10_ONextPE_MapVld, R1C11_ONextPE_MapVld, 
	R1C12_ONextPE_MapVld, R1C13_ONextPE_MapVld, R1C14_ONextPE_MapVld, 
	R1C15_ONextPE_MapVld, R1C16_ONextPE_MapVld;
    wire	[`byte_width-1:0]	R2C1_ONextPE_Map, R2C2_ONextPE_Map, 
	R2C3_ONextPE_Map, R2C4_ONextPE_Map, R2C5_ONextPE_Map, 
	R2C6_ONextPE_Map, R2C7_ONextPE_Map, R2C8_ONextPE_Map, 
	R2C9_ONextPE_Map, R2C10_ONextPE_Map, R2C11_ONextPE_Map, 
	R2C12_ONextPE_Map, R2C13_ONextPE_Map, R2C14_ONextPE_Map, 
	R2C15_ONextPE_Map, R2C16_ONextPE_Map;
    wire						R2C1_ONextPE_MapVld, R2C2_ONextPE_MapVld, 
	R2C3_ONextPE_MapVld, R2C4_ONextPE_MapVld, R2C5_ONextPE_MapVld, 
	R2C6_ONextPE_MapVld, R2C7_ONextPE_MapVld, R2C8_ONextPE_MapVld, 
	R2C9_ONextPE_MapVld, R2C10_ONextPE_MapVld, R2C11_ONextPE_MapVld, 
	R2C12_ONextPE_MapVld, R2C13_ONextPE_MapVld, R2C14_ONextPE_MapVld, 
	R2C15_ONextPE_MapVld, R2C16_ONextPE_MapVld;
    wire	[`byte_width-1:0]	R3C1_ONextPE_Map, R3C2_ONextPE_Map, 
	R3C3_ONextPE_Map, R3C4_ONextPE_Map, R3C5_ONextPE_Map, 
	R3C6_ONextPE_Map, R3C7_ONextPE_Map, R3C8_ONextPE_Map, 
	R3C9_ONextPE_Map, R3C10_ONextPE_Map, R3C11_ONextPE_Map, 
	R3C12_ONextPE_Map, R3C13_ONextPE_Map, R3C14_ONextPE_Map, 
	R3C15_ONextPE_Map, R3C16_ONextPE_Map;
    wire						R3C1_ONextPE_MapVld, R3C2_ONextPE_MapVld, 
	R3C3_ONextPE_MapVld, R3C4_ONextPE_MapVld, R3C5_ONextPE_MapVld, 
	R3C6_ONextPE_MapVld, R3C7_ONextPE_MapVld, R3C8_ONextPE_MapVld, 
	R3C9_ONextPE_MapVld, R3C10_ONextPE_MapVld, R3C11_ONextPE_MapVld, 
	R3C12_ONextPE_MapVld, R3C13_ONextPE_MapVld, R3C14_ONextPE_MapVld, 
	R3C15_ONextPE_MapVld, R3C16_ONextPE_MapVld;
    wire 	[`byte_width-1:0]	R4C1_ONextPE_Map, R4C2_ONextPE_Map, 
	R4C3_ONextPE_Map, R4C4_ONextPE_Map, R4C5_ONextPE_Map, 
	R4C6_ONextPE_Map, R4C7_ONextPE_Map, R4C8_ONextPE_Map, 
	R4C9_ONextPE_Map, R4C10_ONextPE_Map, R4C11_ONextPE_Map, 
	R4C12_ONextPE_Map, R4C13_ONextPE_Map, R4C14_ONextPE_Map, 
	R4C15_ONextPE_Map, R4C16_ONextPE_Map;
    wire						R4C1_ONextPE_MapVld, R4C2_ONextPE_MapVld, 
	R4C3_ONextPE_MapVld, R4C4_ONextPE_MapVld, R4C5_ONextPE_MapVld, 
	R4C6_ONextPE_MapVld, R4C7_ONextPE_MapVld, R4C8_ONextPE_MapVld, 
	R4C9_ONextPE_MapVld, R4C10_ONextPE_MapVld, R4C11_ONextPE_MapVld, 
	R4C12_ONextPE_MapVld, R4C13_ONextPE_MapVld, R4C14_ONextPE_MapVld, 
	R4C15_ONextPE_MapVld, R4C16_ONextPE_MapVld;
    wire	[`byte_width-1:0]	R5C1_ONextPE_Map, R5C2_ONextPE_Map, 
	R5C3_ONextPE_Map, R5C4_ONextPE_Map, R5C5_ONextPE_Map, 
	R5C6_ONextPE_Map, R5C7_ONextPE_Map, R5C8_ONextPE_Map, 
	R5C9_ONextPE_Map, R5C10_ONextPE_Map, R5C11_ONextPE_Map, 
	R5C12_ONextPE_Map, R5C13_ONextPE_Map, R5C14_ONextPE_Map, 
	R5C15_ONextPE_Map, R5C16_ONextPE_Map;
    wire						R5C1_ONextPE_MapVld, R5C2_ONextPE_MapVld, 
	R5C3_ONextPE_MapVld, R5C4_ONextPE_MapVld, R5C5_ONextPE_MapVld, 
	R5C6_ONextPE_MapVld, R5C7_ONextPE_MapVld, R5C8_ONextPE_MapVld, 					
	R5C9_ONextPE_MapVld, R5C10_ONextPE_MapVld, R5C11_ONextPE_MapVld, 
	R5C12_ONextPE_MapVld, R5C13_ONextPE_MapVld, R5C14_ONextPE_MapVld, 
	R5C15_ONextPE_MapVld, R5C16_ONextPE_MapVld;
    wire	[`byte_width-1:0]	R6C1_ONextPE_Map, R6C2_ONextPE_Map, 
	R6C3_ONextPE_Map, R6C4_ONextPE_Map, R6C5_ONextPE_Map, 
	R6C6_ONextPE_Map, R6C7_ONextPE_Map, R6C8_ONextPE_Map,
	R6C9_ONextPE_Map, R6C10_ONextPE_Map, R6C11_ONextPE_Map, 
	R6C12_ONextPE_Map, R6C13_ONextPE_Map, R6C14_ONextPE_Map, 
	R6C15_ONextPE_Map, R6C16_ONextPE_Map;
    wire						R6C1_ONextPE_MapVld, R6C2_ONextPE_MapVld, 
	R6C3_ONextPE_MapVld, R6C4_ONextPE_MapVld, R6C5_ONextPE_MapVld, 
	R6C6_ONextPE_MapVld, R6C7_ONextPE_MapVld, R6C8_ONextPE_MapVld,						
	R6C9_ONextPE_MapVld, R6C10_ONextPE_MapVld, R6C11_ONextPE_MapVld, 
	R6C12_ONextPE_MapVld, R6C13_ONextPE_MapVld, R6C14_ONextPE_MapVld, 
	R6C15_ONextPE_MapVld, R6C16_ONextPE_MapVld;
    wire	[`byte_width-1:0]	R7C1_ONextPE_Map, R7C2_ONextPE_Map, 
	R7C3_ONextPE_Map, R7C4_ONextPE_Map, R7C5_ONextPE_Map, 
	R7C6_ONextPE_Map, R7C7_ONextPE_Map, R7C8_ONextPE_Map,
	R7C9_ONextPE_Map, R7C10_ONextPE_Map, R7C11_ONextPE_Map, 
	R7C12_ONextPE_Map, R7C13_ONextPE_Map, R7C14_ONextPE_Map, 
	R7C15_ONextPE_Map, R7C16_ONextPE_Map;
    wire						R7C1_ONextPE_MapVld, R7C2_ONextPE_MapVld,
	R7C3_ONextPE_MapVld, R7C4_ONextPE_MapVld, R7C5_ONextPE_MapVld, 
	R7C6_ONextPE_MapVld, R7C7_ONextPE_MapVld, R7C8_ONextPE_MapVld,						
	R7C9_ONextPE_MapVld, R7C10_ONextPE_MapVld, R7C11_ONextPE_MapVld, 
	R7C12_ONextPE_MapVld, R7C13_ONextPE_MapVld, R7C14_ONextPE_MapVld, 
	R7C15_ONextPE_MapVld, R7C16_ONextPE_MapVld;
    wire	[`byte_width-1:0]	R8C1_ONextPE_Map, R8C2_ONextPE_Map, 
	R8C3_ONextPE_Map, R8C4_ONextPE_Map, R8C5_ONextPE_Map,
	R8C6_ONextPE_Map, R8C7_ONextPE_Map, R8C8_ONextPE_Map,
	R8C9_ONextPE_Map, R8C10_ONextPE_Map, R8C11_ONextPE_Map, 
	R8C12_ONextPE_Map, R8C13_ONextPE_Map, R8C14_ONextPE_Map, 
	R8C15_ONextPE_Map, R8C16_ONextPE_Map;
    wire						R8C1_ONextPE_MapVld, R8C2_ONextPE_MapVld,
	R8C3_ONextPE_MapVld, R8C4_ONextPE_MapVld, R8C5_ONextPE_MapVld,
	R8C6_ONextPE_MapVld, R8C7_ONextPE_MapVld, R8C8_ONextPE_MapVld,						
	R8C9_ONextPE_MapVld, R8C10_ONextPE_MapVld, R8C11_ONextPE_MapVld,
	R8C12_ONextPE_MapVld, R8C13_ONextPE_MapVld, R8C14_ONextPE_MapVld,
	R8C15_ONextPE_MapVld, R8C16_ONextPE_MapVld;


    // INextPE_OMap
    wire	[`halfword_width-1:0]	R1C1_INextPE_OMap, R1C2_INextPE_OMap,
	R1C3_INextPE_OMap, R1C4_INextPE_OMap, R1C5_INextPE_OMap, 
	R1C6_INextPE_OMap, R1C7_INextPE_OMap, R1C8_INextPE_OMap, 
	R1C9_INextPE_OMap, R1C10_INextPE_OMap, R1C11_INextPE_OMap, 
	R1C12_INextPE_OMap, R1C13_INextPE_OMap, R1C14_INextPE_OMap, 
	R1C15_INextPE_OMap, R1C16_INextPE_OMap;
    wire							R1C1_INextPE_OMapVld, R1C2_INextPE_OMapVld, 
	R1C3_INextPE_OMapVld, R1C4_INextPE_OMapVld, R1C5_INextPE_OMapVld, 
	R1C6_INextPE_OMapVld, R1C7_INextPE_OMapVld, R1C8_INextPE_OMapVld,						
	R1C9_INextPE_OMapVld, R1C10_INextPE_OMapVld, R1C11_INextPE_OMapVld, 
	R1C12_INextPE_OMapVld, R1C13_INextPE_OMapVld, R1C14_INextPE_OMapVld, 
	R1C15_INextPE_OMapVld, R1C16_INextPE_OMapVld;
    wire	[`halfword_width-1:0]	R2C1_INextPE_OMap, R2C2_INextPE_OMap, 
    R2C3_INextPE_OMap, R2C4_INextPE_OMap, R2C5_INextPE_OMap, 
    R2C6_INextPE_OMap, R2C7_INextPE_OMap, R2C8_INextPE_OMap,
	R2C9_INextPE_OMap, R2C10_INextPE_OMap, R2C11_INextPE_OMap, 
    R2C12_INextPE_OMap, R2C13_INextPE_OMap, R2C14_INextPE_OMap, 
    R2C15_INextPE_OMap, R2C16_INextPE_OMap;
    wire					        R2C1_INextPE_OMapVld, R2C2_INextPE_OMapVld, 
    R2C3_INextPE_OMapVld, R2C4_INextPE_OMapVld, R2C5_INextPE_OMapVld, 
    R2C6_INextPE_OMapVld, R2C7_INextPE_OMapVld, R2C8_INextPE_OMapVld,						
	R2C9_INextPE_OMapVld, R2C10_INextPE_OMapVld, R2C11_INextPE_OMapVld, 
    R2C12_INextPE_OMapVld, R2C13_INextPE_OMapVld, R2C14_INextPE_OMapVld, 
    R2C15_INextPE_OMapVld, R2C16_INextPE_OMapVld;
    wire	[`halfword_width-1:0]	R3C1_INextPE_OMap, R3C2_INextPE_OMap, 
    R3C3_INextPE_OMap, R3C4_INextPE_OMap, R3C5_INextPE_OMap, 
    R3C6_INextPE_OMap, R3C7_INextPE_OMap, R3C8_INextPE_OMap,
	R3C9_INextPE_OMap, R3C10_INextPE_OMap, R3C11_INextPE_OMap, 
    R3C12_INextPE_OMap, R3C13_INextPE_OMap, R3C14_INextPE_OMap, 
    R3C15_INextPE_OMap, R3C16_INextPE_OMap;
    wire					        R3C1_INextPE_OMapVld, R3C2_INextPE_OMapVld, 
    R3C3_INextPE_OMapVld, R3C4_INextPE_OMapVld, R3C5_INextPE_OMapVld, 
    R3C6_INextPE_OMapVld, R3C7_INextPE_OMapVld, R3C8_INextPE_OMapVld,						
	R3C9_INextPE_OMapVld, R3C10_INextPE_OMapVld, R3C11_INextPE_OMapVld, 
    R3C12_INextPE_OMapVld, R3C13_INextPE_OMapVld, R3C14_INextPE_OMapVld, 
    R3C15_INextPE_OMapVld, R3C16_INextPE_OMapVld;
    wire	[`halfword_width-1:0]	R4C1_INextPE_OMap, R4C2_INextPE_OMap, 
    R4C3_INextPE_OMap, R4C4_INextPE_OMap, R4C5_INextPE_OMap, 
    R4C6_INextPE_OMap, R4C7_INextPE_OMap, R4C8_INextPE_OMap,
	R4C9_INextPE_OMap, R4C10_INextPE_OMap, R4C11_INextPE_OMap, 
    R4C12_INextPE_OMap, R4C13_INextPE_OMap, R4C14_INextPE_OMap, 
    R4C15_INextPE_OMap, R4C16_INextPE_OMap;
    wire 					        R4C1_INextPE_OMapVld, R4C2_INextPE_OMapVld, 
    R4C3_INextPE_OMapVld, R4C4_INextPE_OMapVld, R4C5_INextPE_OMapVld, 
    R4C6_INextPE_OMapVld, R4C7_INextPE_OMapVld, R4C8_INextPE_OMapVld,						
	R4C9_INextPE_OMapVld, R4C10_INextPE_OMapVld, R4C11_INextPE_OMapVld, 
    R4C12_INextPE_OMapVld, R4C13_INextPE_OMapVld, R4C14_INextPE_OMapVld, 
    R4C15_INextPE_OMapVld, R4C16_INextPE_OMapVld;
    wire	[`halfword_width-1:0]	R5C1_INextPE_OMap, R5C2_INextPE_OMap, 
    R5C3_INextPE_OMap, R5C4_INextPE_OMap, R5C5_INextPE_OMap, 
    R5C6_INextPE_OMap, R5C7_INextPE_OMap, R5C8_INextPE_OMap,
	R5C9_INextPE_OMap, R5C10_INextPE_OMap, R5C11_INextPE_OMap, 
    R5C12_INextPE_OMap, R5C13_INextPE_OMap, R5C14_INextPE_OMap, 
    R5C15_INextPE_OMap, R5C16_INextPE_OMap;
    wire 	    			    	R5C1_INextPE_OMapVld, R5C2_INextPE_OMapVld, 
    R5C3_INextPE_OMapVld, R5C4_INextPE_OMapVld, R5C5_INextPE_OMapVld, 
    R5C6_INextPE_OMapVld, R5C7_INextPE_OMapVld, R5C8_INextPE_OMapVld,						
	R5C9_INextPE_OMapVld, R5C10_INextPE_OMapVld, R5C11_INextPE_OMapVld, 
    R5C12_INextPE_OMapVld, R5C13_INextPE_OMapVld, R5C14_INextPE_OMapVld, 
    R5C15_INextPE_OMapVld, R5C16_INextPE_OMapVld;
    wire	[`halfword_width-1:0]	R6C1_INextPE_OMap, R6C2_INextPE_OMap, 
    R6C3_INextPE_OMap, R6C4_INextPE_OMap, R6C5_INextPE_OMap, 
    R6C6_INextPE_OMap, R6C7_INextPE_OMap, R6C8_INextPE_OMap,
	R6C9_INextPE_OMap, R6C10_INextPE_OMap, R6C11_INextPE_OMap, 
    R6C12_INextPE_OMap, R6C13_INextPE_OMap, R6C14_INextPE_OMap, 
    R6C15_INextPE_OMap, R6C16_INextPE_OMap;
    wire	        				R6C1_INextPE_OMapVld, R6C2_INextPE_OMapVld, 
    R6C3_INextPE_OMapVld, R6C4_INextPE_OMapVld, R6C5_INextPE_OMapVld, 
    R6C6_INextPE_OMapVld, R6C7_INextPE_OMapVld, R6C8_INextPE_OMapVld,						
	R6C9_INextPE_OMapVld, R6C10_INextPE_OMapVld, R6C11_INextPE_OMapVld, 
    R6C12_INextPE_OMapVld, R6C13_INextPE_OMapVld, R6C14_INextPE_OMapVld, 
    R6C15_INextPE_OMapVld, R6C16_INextPE_OMapVld;
    wire	[`halfword_width-1:0]	R7C1_INextPE_OMap, R7C2_INextPE_OMap, 
    R7C3_INextPE_OMap, R7C4_INextPE_OMap, R7C5_INextPE_OMap, 
    R7C6_INextPE_OMap, R7C7_INextPE_OMap, R7C8_INextPE_OMap,
	R7C9_INextPE_OMap, R7C10_INextPE_OMap, R7C11_INextPE_OMap, 
    R7C12_INextPE_OMap, R7C13_INextPE_OMap, R7C14_INextPE_OMap, 
    R7C15_INextPE_OMap, R7C16_INextPE_OMap;
    wire	        				R7C1_INextPE_OMapVld, R7C2_INextPE_OMapVld, 
    R7C3_INextPE_OMapVld, R7C4_INextPE_OMapVld, R7C5_INextPE_OMapVld, 
    R7C6_INextPE_OMapVld, R7C7_INextPE_OMapVld, R7C8_INextPE_OMapVld,						
	R7C9_INextPE_OMapVld, R7C10_INextPE_OMapVld, R7C11_INextPE_OMapVld, 
    R7C12_INextPE_OMapVld, R7C13_INextPE_OMapVld, R7C14_INextPE_OMapVld, 
    R7C15_INextPE_OMapVld, R7C16_INextPE_OMapVld;
    wire	[`halfword_width-1:0]	R8C1_INextPE_OMap, R8C2_INextPE_OMap, 
    R8C3_INextPE_OMap, R8C4_INextPE_OMap, R8C5_INextPE_OMap, 
    R8C6_INextPE_OMap, R8C7_INextPE_OMap, R8C8_INextPE_OMap,
	R8C9_INextPE_OMap, R8C10_INextPE_OMap, R8C11_INextPE_OMap, 
    R8C12_INextPE_OMap, R8C13_INextPE_OMap, R8C14_INextPE_OMap, 
    R8C15_INextPE_OMap, R8C16_INextPE_OMap;
    wire					        R8C1_INextPE_OMapVld, R8C2_INextPE_OMapVld, 
    R8C3_INextPE_OMapVld, R8C4_INextPE_OMapVld, R8C5_INextPE_OMapVld, 
    R8C6_INextPE_OMapVld, R8C7_INextPE_OMapVld, R8C8_INextPE_OMapVld, 
    R8C9_INextPE_OMapVld, R8C10_INextPE_OMapVld, R8C11_INextPE_OMapVld, 
    R8C12_INextPE_OMapVld, R8C13_INextPE_OMapVld, R8C14_INextPE_OMapVld, 
    R8C15_INextPE_OMapVld, R8C16_INextPE_OMapVld;


    // *********************************************************************
    // ImapVld
    // *********************************************************************
    reg ImapVld1, ImapVld2, ImapVld3, ImapVld4;
    reg ImapVld5, ImapVld6, ImapVld7, ImapVld8;
    reg ImapVld9, ImapVld10, ImapVld11, ImapVld12;
    reg ImapVld13, ImapVld14, ImapVld15, ImapVld16;

    always @(*) begin
        if (!rst_cal_n) begin
            ImapVld1  = 0;
            ImapVld2  = 0;
            ImapVld3  = 0;
            ImapVld4  = 0;
            ImapVld5  = 0;
            ImapVld6  = 0;
            ImapVld7  = 0;
            ImapVld8  = 0;
            ImapVld9  = 0;
            ImapVld10 = 0;
            ImapVld11 = 0;
            ImapVld12 = 0;
            ImapVld13 = 0;
            ImapVld14 = 0;
            ImapVld15 = 0;
            ImapVld16 = 0;
        end else if (nn_layer_cnt == 4'd8) begin  // 8th layer
            ImapVld1  = ImapVld;
            ImapVld2  = 0;
            ImapVld3  = 0;
            ImapVld4  = 0;
            ImapVld5  = 0;
            ImapVld6  = 0;
            ImapVld7  = 0;
            ImapVld8  = 0;
            ImapVld9  = 0;
            ImapVld10 = 0;
            ImapVld11 = 0;
            ImapVld12 = 0;
            ImapVld13 = 0;
            ImapVld14 = 0;
            ImapVld15 = 0;
            ImapVld16 = 0;
        end else begin  // 1-7th layers
            ImapVld1  = ImapVld;
            ImapVld2  = ImapVld;
            ImapVld3  = ImapVld;
            ImapVld4  = ImapVld;
            ImapVld5  = ImapVld;
            ImapVld6  = ImapVld;
            ImapVld7  = ImapVld;
            ImapVld8  = ImapVld;
            ImapVld9  = ImapVld;
            ImapVld10 = ImapVld;
            ImapVld11 = ImapVld;
            ImapVld12 = ImapVld;
            ImapVld13 = ImapVld;
            ImapVld14 = ImapVld;
            ImapVld15 = ImapVld;
            ImapVld16 = ImapVld;
        end
    end


    // *********************************************************************
    // FC layer8 output 3 stage one-hot FSM
    // *********************************************************************
    localparam [7:0] IDLE = 8'd0;  // idle state
    localparam [7:0] S1 = 8'd1;  // FC_OData1
    localparam [7:0] S2 = 8'd2;  // FC_OData2
    localparam [7:0] S3 = 8'd3;  // FC_OData3
    localparam [7:0] S4 = 8'd4;  // FC_OData4
    localparam [7:0] S5 = 8'd5;  // FC_OData5
    localparam [7:0] S6 = 8'd6;  // FC_OData6
    localparam [7:0] S7 = 8'd7;  // FC_OData7		
    localparam [7:0] S8 = 8'd8;  // FC_OData8

    reg [8:0] fc_cs;  // current state
    reg [8:0] fc_ns;  // nest state
    reg fc_flag, fc_flag_temp;

    always @(posedge clk_cal or negedge rst_cal_n)
        if (!rst_cal_n) fc_cs <= 9'b1;
        else fc_cs <= fc_ns;

    always @(posedge clk_cal or negedge rst_cal_n) begin
        if (!rst_cal_n) begin
            fc_flag <= 1'b0;
            fc_flag_temp <= 1'b0;
        end else begin
            fc_flag_temp <= PE_OMapVld1;
            if (!fc_flag_temp && PE_OMapVld1) fc_flag <= 1'b1;  // PE_OMapVld1 0->1
            else fc_flag <= 1'b0;
        end
    end

    always @(*) begin
        fc_ns = 9'b0;  // reset ns
        case (1'b1)
            fc_cs[IDLE]: begin
                if (fc_flag && nn_layer_cnt == 4'd8 && or_cs == 6'd4) fc_ns[S1] = 1'b1;
                else fc_ns[IDLE] = 1'b1;
            end
            fc_cs[S1]: fc_ns[S2] = 1'b1;
            fc_cs[S2]: fc_ns[S3] = 1'b1;
            fc_cs[S3]: fc_ns[S4] = 1'b1;
            fc_cs[S4]: fc_ns[S5] = 1'b1;
            fc_cs[S5]: fc_ns[S6] = 1'b1;
            fc_cs[S6]: fc_ns[S7] = 1'b1;
            fc_cs[S7]: fc_ns[S8] = 1'b1;
            fc_cs[S8]: fc_ns[IDLE] = 1'b1;
        endcase
    end


    // *********************************************************************
    // 7th & 8th layer output
    // *********************************************************************
    reg     [7:0] last_buf    [15:0];
    reg     [3:0] last_addr;
    reg     [3:0] last_addr_p;

    integer       i;

    always @(posedge clk_cal or negedge rst_cal_n) begin
        if (!rst_cal_n) begin
            last_addr <= 0;
            for (i = 0; i < 16; i = i + 1) last_buf[i] <= 8'b0;
        end else begin
            if (or_cs != 6'd4)  // OR dataflow FSM: NOT 0100 OR_CAL
                last_addr <= 4'b0;
            else if (nn_layer_cnt == 4'd7) begin
                if (PE_OMapVld1) begin
                    last_buf[last_addr] <= PE_OMap1[4] ? 
                    {PE_OMap1[15], PE_OMap1[11:5]+1'b1} :  // round up
                    {PE_OMap1[15], PE_OMap1[11:5]};
                    last_addr <= last_addr + 1;
                    if (last_addr == 4'd15) last_addr <= 0;
                end
            end 
            // 8th layer need to find biggest result NOT cut off
            else if (nn_layer_cnt == 4'd8 && PE_OMapVld1) begin
                case (last_addr)
                    4'b0000: begin
                        last_buf[last_addr] <= PE_OMap1[15:8];  
                        last_addr <= last_addr + 1;
                    end
                    4'b0001: begin
                        last_buf[last_addr] <= PE_OMap2[15:8];
                        last_addr <= last_addr + 1;
                    end
                    4'b0010: begin
                        last_buf[last_addr] <= PE_OMap3[15:8];
                        last_addr <= last_addr + 1;
                    end
                    4'b0011: begin
                        last_buf[last_addr] <= PE_OMap4[15:8];
                        last_addr <= last_addr + 1;
                    end
                    4'b0100: begin
                        last_buf[last_addr] <= PE_OMap5[15:8];
                        last_addr <= last_addr + 1;
                    end
                    4'b0101: begin
                        last_buf[last_addr] <= PE_OMap6[15:8];
                        last_addr <= last_addr + 1;
                    end
                    4'b0110: begin
                        last_buf[last_addr] <= PE_OMap7[15:8];
                        last_addr <= last_addr + 1;
                    end
                    4'b0111: begin
                        last_buf[last_addr] <= PE_OMap8[15:8];
                        last_addr <= last_addr + 1;
                    end
                    default: begin
                        last_addr <= last_addr + 1;
                    end
                endcase
                if (last_addr == 4'd15) last_addr <= 0;
            end  // if (nn_layer_cnt == 4'd8 && PE_OMapVld1)
            else last_addr <= 0;  // other layers
        end
    end

    always @(posedge clk_cal) last_addr_p <= last_addr;

    always @(*) begin
        if (!rst_cal_n) begin
            FC_OVld  = 'b0;
            FC_OMap1 = 'b0;
            FC_OMap2 = 'b0;
            FC_OMap3 = 'b0;
            FC_OMap4 = 'b0;
            FC_OMap5 = 'b0;
            FC_OMap6 = 'b0;
            FC_OMap7 = 'b0;
            FC_OMap8 = 'b0;
        end else begin
            if (nn_layer_cnt == 4'd7) begin
                if (last_addr_p == 4'd7) begin  // output last_buf twice
                    FC_OVld  = 1'b1;
                    FC_OMap1 = last_buf[0];
                    FC_OMap2 = last_buf[1];
                    FC_OMap3 = last_buf[2];
                    FC_OMap4 = last_buf[3];
                    FC_OMap5 = last_buf[4];
                    FC_OMap6 = last_buf[5];
                    FC_OMap7 = last_buf[6];
                    FC_OMap8 = last_buf[7];
                end else if (last_addr_p == 4'd15) begin
                    FC_OVld  = 1'b1;
                    FC_OMap1 = last_buf[8];
                    FC_OMap2 = last_buf[9];
                    FC_OMap3 = last_buf[10];
                    FC_OMap4 = last_buf[11];
                    FC_OMap5 = last_buf[12];
                    FC_OMap6 = last_buf[13];
                    FC_OMap7 = last_buf[14];
                    FC_OMap8 = last_buf[15];
                end else begin
                    FC_OVld  = 'b0;
                    FC_OMap1 = 'b0;
                    FC_OMap2 = 'b0;
                    FC_OMap3 = 'b0;
                    FC_OMap4 = 'b0;
                    FC_OMap5 = 'b0;
                    FC_OMap6 = 'b0;
                    FC_OMap7 = 'b0;
                    FC_OMap8 = 'b0;
                end
            end else begin  // nn_layer_cnt != 4'd7 output one by one
                case (1'b1)
                    fc_cs[S1]: begin
                        FC_OVld  = 1'b1;
                        FC_OMap1 = last_buf[0];
                        FC_OMap2 = 0;
                        FC_OMap3 = 0;
                        FC_OMap4 = 0;
                        FC_OMap5 = 0;
                        FC_OMap6 = 0;
                        FC_OMap7 = 0;
                        FC_OMap8 = 0;
                    end
                    fc_cs[S2]: begin
                        FC_OVld  = 1'b1;
                        FC_OMap1 = last_buf[1];
                        FC_OMap2 = 0;
                        FC_OMap3 = 0;
                        FC_OMap4 = 0;
                        FC_OMap5 = 0;
                        FC_OMap6 = 0;
                        FC_OMap7 = 0;
                        FC_OMap8 = 0;
                    end
                    fc_cs[S3]: begin
                        FC_OVld  = 1'b1;
                        FC_OMap1 = last_buf[2];
                        FC_OMap2 = 0;
                        FC_OMap3 = 0;
                        FC_OMap4 = 0;
                        FC_OMap5 = 0;
                        FC_OMap6 = 0;
                        FC_OMap7 = 0;
                        FC_OMap8 = 0;
                    end
                    fc_cs[S4]: begin
                        FC_OVld  = 1'b1;
                        FC_OMap1 = last_buf[3];
                        FC_OMap2 = 0;
                        FC_OMap3 = 0;
                        FC_OMap4 = 0;
                        FC_OMap5 = 0;
                        FC_OMap6 = 0;
                        FC_OMap7 = 0;
                        FC_OMap8 = 0;
                    end
                    fc_cs[S5]: begin
                        FC_OVld  = 1'b1;
                        FC_OMap1 = last_buf[4];
                        FC_OMap2 = 0;
                        FC_OMap3 = 0;
                        FC_OMap4 = 0;
                        FC_OMap5 = 0;
                        FC_OMap6 = 0;
                        FC_OMap7 = 0;
                        FC_OMap8 = 0;
                    end
                    fc_cs[S6]: begin
                        FC_OVld  = 1'b1;
                        FC_OMap1 = last_buf[5];
                        FC_OMap2 = 0;
                        FC_OMap3 = 0;
                        FC_OMap4 = 0;
                        FC_OMap5 = 0;
                        FC_OMap6 = 0;
                        FC_OMap7 = 0;
                        FC_OMap8 = 0;
                    end
                    fc_cs[S7]: begin
                        FC_OVld  = 1'b1;
                        FC_OMap1 = last_buf[6];
                        FC_OMap2 = 0;
                        FC_OMap3 = 0;
                        FC_OMap4 = 0;
                        FC_OMap5 = 0;
                        FC_OMap6 = 0;
                        FC_OMap7 = 0;
                        FC_OMap8 = 0;
                    end
                    fc_cs[S8]: begin
                        FC_OVld  = 1'b1;
                        FC_OMap1 = last_buf[7];
                        FC_OMap2 = 0;
                        FC_OMap3 = 0;
                        FC_OMap4 = 0;
                        FC_OMap5 = 0;
                        FC_OMap6 = 0;
                        FC_OMap7 = 0;
                        FC_OMap8 = 0;
                    end
                    default: begin
                        FC_OVld  = 1'b0;
                        FC_OMap1 = 0;
                        FC_OMap2 = 0;
                        FC_OMap3 = 0;
                        FC_OMap4 = 0;
                        FC_OMap5 = 0;
                        FC_OMap6 = 0;
                        FC_OMap7 = 0;
                        FC_OMap8 = 0;
                    end
                endcase
            end
        end
    end

    // *********************************************************************
    // PE_end	
    // *********************************************************************
    // FIXME pass_cnt vs Ocnt
    reg  [10:0] pass_cnt;  // pass cycle cnt
    reg         passcnt_flag;
    reg  [ 5:0] Ocnt;
    wire        Oflag;

    parameter R = 16;
    parameter C = 8;

    always @(posedge clk_cal or negedge rst_cal_n) begin
        if (!rst_cal_n) begin
            pass_cnt <= 0;
            passcnt_flag <= 0;
        end else begin
            if (ImapVld && IweightVld1) begin  // first PE pass
                passcnt_flag <= 1'b1;
            end
            if (passcnt_flag) begin
                pass_cnt <= pass_cnt + 1'b1;
                if (pass_cnt == (pass_cycle - 1)) begin
                    passcnt_flag <= 0;
                    pass_cnt <= 0;
                end
            end else pass_cnt <= 0;
        end
    end

    assign Oflag = (nn_layer_cnt <= 4'd6) ?  // 1-6th layers
    ((PE_OMapVld1 || PE_OMapVld8) && (Calcycle > 16)) : 0;  // FIXME Why 1 or 8?

    always @(posedge clk_cal or negedge rst_cal_n) begin
        if (!rst_cal_n) Ocnt <= 0;
        else begin
            if (Oflag) begin
                Ocnt <= Ocnt + 1'b1;
                if (Ocnt == ((R + C - 1) - 1)) Ocnt <= 0;  // output cycle
            end
        end
    end

    always @(posedge clk_cal or negedge rst_cal_n) begin
        if (!rst_cal_n) PE_end <= 1'b1;  //1'b1 first
        else begin
            if (pass_cnt == (pass_cycle - 1) || Ocnt == ((R + C - 1) - 1)) PE_end <= 1'b1;
            else if (rd_done == 1 || Oflag) PE_end <= 1'b0;
        end
    end


    // *********************************************************************
    // R16CX last_INextPE_OMapVld transmit result to the upper PE
    // *********************************************************************	
    reg [4:0] Rcnt;
    reg       last_INextPE_OMapVld1;
    reg       last_INextPE_OMapVld2;
    reg       last_INextPE_OMapVld3;
    reg       last_INextPE_OMapVld4;
    reg       last_INextPE_OMapVld5;
    reg       last_INextPE_OMapVld6;
    reg       last_INextPE_OMapVld7;
    reg       last_INextPE_OMapVld8;

    always @(posedge clk_cal or negedge rst_cal_n) begin
        if (!rst_cal_n) begin
            Rcnt <= 0;
            last_INextPE_OMapVld1 <= 1'b0;
        end else begin
            if (PE_OMapVld1) begin
                Rcnt <= Rcnt + 1'b1;  // 1C output
                if (Rcnt == (R - 1)) last_INextPE_OMapVld1 <= 1'b0;
                else last_INextPE_OMapVld1 <= 1'b1;  // R = 0~14
            end else begin
                Rcnt <= 0;
                last_INextPE_OMapVld1 <= 1'b0;
            end
        end
    end

    always @(posedge clk_cal or negedge rst_cal_n) begin
        if (!rst_cal_n) begin
            last_INextPE_OMapVld2 <= 0;
            last_INextPE_OMapVld3 <= 0;
            last_INextPE_OMapVld4 <= 0;
            last_INextPE_OMapVld5 <= 0;
            last_INextPE_OMapVld6 <= 0;
            last_INextPE_OMapVld7 <= 0;
            last_INextPE_OMapVld8 <= 0;
        end else begin  // column output in turn
            last_INextPE_OMapVld2 <= last_INextPE_OMapVld1;
            last_INextPE_OMapVld3 <= last_INextPE_OMapVld2;
            last_INextPE_OMapVld4 <= last_INextPE_OMapVld3;
            last_INextPE_OMapVld5 <= last_INextPE_OMapVld4;
            last_INextPE_OMapVld6 <= last_INextPE_OMapVld5;
            last_INextPE_OMapVld7 <= last_INextPE_OMapVld6;
            last_INextPE_OMapVld8 <= last_INextPE_OMapVld7;
        end
    end


    // *********************************************************************
    // PE array R16C8 :: R<->C change 128 PEs
    // *********************************************************************    
    u_PE PE_R1C1 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (IMap1),
        .ImapVld   (ImapVld1),
        .IWeight   (IWeight1),
        .IweightVld(IweightVld1),

        .ONextPE_Map    (R1C1_ONextPE_Map),
        .ONextPE_MapVld (R1C1_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R1C2_INextPE_OMap),
        .INextPE_OMapVld(R1C2_INextPE_OMapVld),  //OMap from C+1
        .OMap           (PE_OMap1),
        .OMapVld        (PE_OMapVld1)            //OMap 
    );

    u_PE PE_R1C2 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (IMap2),
        .ImapVld   (ImapVld2),
        .IWeight   (IWeight1),
        .IweightVld(IweightVld1),

        .ONextPE_Map    (R1C2_ONextPE_Map),
        .ONextPE_MapVld (R1C2_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R1C3_INextPE_OMap),
        .INextPE_OMapVld(R1C3_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R1C2_INextPE_OMap),
        .OMapVld        (R1C2_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R1C3 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (IMap3),
        .ImapVld   (ImapVld3),
        .IWeight   (IWeight1),
        .IweightVld(IweightVld1),

        .ONextPE_Map    (R1C3_ONextPE_Map),
        .ONextPE_MapVld (R1C3_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R1C4_INextPE_OMap),
        .INextPE_OMapVld(R1C4_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R1C3_INextPE_OMap),
        .OMapVld        (R1C3_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R1C4 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (IMap4),
        .ImapVld   (ImapVld4),
        .IWeight   (IWeight1),
        .IweightVld(IweightVld1),

        .ONextPE_Map    (R1C4_ONextPE_Map),
        .ONextPE_MapVld (R1C4_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R1C5_INextPE_OMap),
        .INextPE_OMapVld(R1C5_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R1C4_INextPE_OMap),
        .OMapVld        (R1C4_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R1C5 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (IMap5),
        .ImapVld   (ImapVld5),
        .IWeight   (IWeight1),
        .IweightVld(IweightVld1),

        .ONextPE_Map    (R1C5_ONextPE_Map),
        .ONextPE_MapVld (R1C5_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R1C6_INextPE_OMap),
        .INextPE_OMapVld(R1C6_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R1C5_INextPE_OMap),
        .OMapVld        (R1C5_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R1C6 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (IMap6),
        .ImapVld   (ImapVld6),
        .IWeight   (IWeight1),
        .IweightVld(IweightVld1),

        .ONextPE_Map    (R1C6_ONextPE_Map),
        .ONextPE_MapVld (R1C6_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R1C7_INextPE_OMap),
        .INextPE_OMapVld(R1C7_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R1C6_INextPE_OMap),
        .OMapVld        (R1C6_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R1C7 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (IMap7),
        .ImapVld   (ImapVld7),
        .IWeight   (IWeight1),
        .IweightVld(IweightVld1),

        .ONextPE_Map    (R1C7_ONextPE_Map),
        .ONextPE_MapVld (R1C7_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R1C8_INextPE_OMap),
        .INextPE_OMapVld(R1C8_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R1C7_INextPE_OMap),
        .OMapVld        (R1C7_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R1C8 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (IMap8),
        .ImapVld   (ImapVld8),
        .IWeight   (IWeight1),
        .IweightVld(IweightVld1),

        .ONextPE_Map    (R1C8_ONextPE_Map),
        .ONextPE_MapVld (R1C8_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R1C9_INextPE_OMap),
        .INextPE_OMapVld(R1C9_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R1C8_INextPE_OMap),
        .OMapVld        (R1C8_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R1C9 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (IMap9),
        .ImapVld   (ImapVld9),
        .IWeight   (IWeight1),
        .IweightVld(IweightVld1),

        .ONextPE_Map    (R1C9_ONextPE_Map),
        .ONextPE_MapVld (R1C9_ONextPE_MapVld),    //IMap
        .INextPE_OMap   (R1C10_INextPE_OMap),
        .INextPE_OMapVld(R1C10_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R1C9_INextPE_OMap),
        .OMapVld        (R1C9_INextPE_OMapVld)    //OMap 
    );

    u_PE PE_R1C10 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (IMap10),
        .ImapVld   (ImapVld10),
        .IWeight   (IWeight1),
        .IweightVld(IweightVld1),

        .ONextPE_Map    (R1C10_ONextPE_Map),
        .ONextPE_MapVld (R1C10_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R1C11_INextPE_OMap),
        .INextPE_OMapVld(R1C11_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R1C10_INextPE_OMap),
        .OMapVld        (R1C10_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R1C11 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (IMap11),
        .ImapVld   (ImapVld11),
        .IWeight   (IWeight1),
        .IweightVld(IweightVld1),

        .ONextPE_Map    (R1C11_ONextPE_Map),
        .ONextPE_MapVld (R1C11_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R1C12_INextPE_OMap),
        .INextPE_OMapVld(R1C12_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R1C11_INextPE_OMap),
        .OMapVld        (R1C11_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R1C12 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (IMap12),
        .ImapVld   (ImapVld12),
        .IWeight   (IWeight1),
        .IweightVld(IweightVld1),

        .ONextPE_Map    (R1C12_ONextPE_Map),
        .ONextPE_MapVld (R1C12_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R1C13_INextPE_OMap),
        .INextPE_OMapVld(R1C13_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R1C12_INextPE_OMap),
        .OMapVld        (R1C12_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R1C13 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (IMap13),
        .ImapVld   (ImapVld13),
        .IWeight   (IWeight1),
        .IweightVld(IweightVld1),

        .ONextPE_Map    (R1C13_ONextPE_Map),
        .ONextPE_MapVld (R1C13_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R1C14_INextPE_OMap),
        .INextPE_OMapVld(R1C14_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R1C13_INextPE_OMap),
        .OMapVld        (R1C13_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R1C14 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (IMap14),
        .ImapVld   (ImapVld14),
        .IWeight   (IWeight1),
        .IweightVld(IweightVld1),

        .ONextPE_Map    (R1C14_ONextPE_Map),
        .ONextPE_MapVld (R1C14_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R1C15_INextPE_OMap),
        .INextPE_OMapVld(R1C15_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R1C14_INextPE_OMap),
        .OMapVld        (R1C14_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R1C15 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (IMap15),
        .ImapVld   (ImapVld15),
        .IWeight   (IWeight1),
        .IweightVld(IweightVld1),

        .ONextPE_Map    (R1C15_ONextPE_Map),
        .ONextPE_MapVld (R1C15_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R1C16_INextPE_OMap),
        .INextPE_OMapVld(R1C16_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R1C15_INextPE_OMap),
        .OMapVld        (R1C15_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R1C16 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (IMap16),
        .ImapVld   (ImapVld16),
        .IWeight   (IWeight1),
        .IweightVld(IweightVld1),

        .ONextPE_Map    (R1C16_ONextPE_Map),
        .ONextPE_MapVld (R1C16_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (16'b0),
        .INextPE_OMapVld(last_INextPE_OMapVld1),  //OMap from C+1
        .OMap           (R1C16_INextPE_OMap),
        .OMapVld        (R1C16_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R2C1 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R1C1_ONextPE_Map),
        .ImapVld   (R1C1_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight2),
        .IweightVld(IweightVld2),

        .ONextPE_Map    (R2C1_ONextPE_Map),
        .ONextPE_MapVld (R2C1_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R2C2_INextPE_OMap),
        .INextPE_OMapVld(R2C2_INextPE_OMapVld),  //OMap from C+1
        .OMap           (PE_OMap2),
        .OMapVld        (PE_OMapVld2)            //OMap 
    );

    u_PE PE_R2C2 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R1C2_ONextPE_Map),
        .ImapVld   (R1C2_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight2),
        .IweightVld(IweightVld2),

        .ONextPE_Map    (R2C2_ONextPE_Map),
        .ONextPE_MapVld (R2C2_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R2C3_INextPE_OMap),
        .INextPE_OMapVld(R2C3_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R2C2_INextPE_OMap),
        .OMapVld        (R2C2_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R2C3 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R1C3_ONextPE_Map),
        .ImapVld   (R1C3_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight2),
        .IweightVld(IweightVld2),

        .ONextPE_Map    (R2C3_ONextPE_Map),
        .ONextPE_MapVld (R2C3_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R2C4_INextPE_OMap),
        .INextPE_OMapVld(R2C4_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R2C3_INextPE_OMap),
        .OMapVld        (R2C3_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R2C4 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R1C4_ONextPE_Map),
        .ImapVld   (R1C4_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight2),
        .IweightVld(IweightVld2),

        .ONextPE_Map    (R2C4_ONextPE_Map),
        .ONextPE_MapVld (R2C4_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R2C5_INextPE_OMap),
        .INextPE_OMapVld(R2C5_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R2C4_INextPE_OMap),
        .OMapVld        (R2C4_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R2C5 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R1C5_ONextPE_Map),
        .ImapVld   (R1C5_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight2),
        .IweightVld(IweightVld2),

        .ONextPE_Map    (R2C5_ONextPE_Map),
        .ONextPE_MapVld (R2C5_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R2C6_INextPE_OMap),
        .INextPE_OMapVld(R2C6_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R2C5_INextPE_OMap),
        .OMapVld        (R2C5_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R2C6 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R1C6_ONextPE_Map),
        .ImapVld   (R1C6_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight2),
        .IweightVld(IweightVld2),

        .ONextPE_Map    (R2C6_ONextPE_Map),
        .ONextPE_MapVld (R2C6_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R2C7_INextPE_OMap),
        .INextPE_OMapVld(R2C7_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R2C6_INextPE_OMap),
        .OMapVld        (R2C6_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R2C7 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R1C7_ONextPE_Map),
        .ImapVld   (R1C7_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight2),
        .IweightVld(IweightVld2),

        .ONextPE_Map    (R2C7_ONextPE_Map),
        .ONextPE_MapVld (R2C7_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R2C8_INextPE_OMap),
        .INextPE_OMapVld(R2C8_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R2C7_INextPE_OMap),
        .OMapVld        (R2C7_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R2C8 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R1C8_ONextPE_Map),
        .ImapVld   (R1C8_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight2),
        .IweightVld(IweightVld2),

        .ONextPE_Map    (R2C8_ONextPE_Map),
        .ONextPE_MapVld (R2C8_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R2C9_INextPE_OMap),
        .INextPE_OMapVld(R2C9_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R2C8_INextPE_OMap),
        .OMapVld        (R2C8_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R2C9 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R1C9_ONextPE_Map),
        .ImapVld   (R1C9_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight2),
        .IweightVld(IweightVld2),

        .ONextPE_Map    (R2C9_ONextPE_Map),
        .ONextPE_MapVld (R2C9_ONextPE_MapVld),    //IMap
        .INextPE_OMap   (R2C10_INextPE_OMap),
        .INextPE_OMapVld(R2C10_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R2C9_INextPE_OMap),
        .OMapVld        (R2C9_INextPE_OMapVld)    //OMap 
    );

    u_PE PE_R2C10 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R1C10_ONextPE_Map),
        .ImapVld   (R1C10_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight2),
        .IweightVld(IweightVld2),

        .ONextPE_Map    (R2C10_ONextPE_Map),
        .ONextPE_MapVld (R2C10_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R2C11_INextPE_OMap),
        .INextPE_OMapVld(R2C11_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R2C10_INextPE_OMap),
        .OMapVld        (R2C10_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R2C11 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R1C11_ONextPE_Map),
        .ImapVld   (R1C11_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight2),
        .IweightVld(IweightVld2),

        .ONextPE_Map    (R2C11_ONextPE_Map),
        .ONextPE_MapVld (R2C11_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R2C12_INextPE_OMap),
        .INextPE_OMapVld(R2C12_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R2C11_INextPE_OMap),
        .OMapVld        (R2C11_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R2C12 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R1C12_ONextPE_Map),
        .ImapVld   (R1C12_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight2),
        .IweightVld(IweightVld2),

        .ONextPE_Map    (R2C12_ONextPE_Map),
        .ONextPE_MapVld (R2C12_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R2C13_INextPE_OMap),
        .INextPE_OMapVld(R2C13_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R2C12_INextPE_OMap),
        .OMapVld        (R2C12_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R2C13 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R1C13_ONextPE_Map),
        .ImapVld   (R1C13_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight2),
        .IweightVld(IweightVld2),

        .ONextPE_Map    (R2C13_ONextPE_Map),
        .ONextPE_MapVld (R2C13_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R2C14_INextPE_OMap),
        .INextPE_OMapVld(R2C14_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R2C13_INextPE_OMap),
        .OMapVld        (R2C13_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R2C14 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R1C14_ONextPE_Map),
        .ImapVld   (R1C14_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight2),
        .IweightVld(IweightVld2),

        .ONextPE_Map    (R2C14_ONextPE_Map),
        .ONextPE_MapVld (R2C14_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R2C15_INextPE_OMap),
        .INextPE_OMapVld(R2C15_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R2C14_INextPE_OMap),
        .OMapVld        (R2C14_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R2C15 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R1C15_ONextPE_Map),
        .ImapVld   (R1C15_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight2),
        .IweightVld(IweightVld2),

        .ONextPE_Map    (R2C15_ONextPE_Map),
        .ONextPE_MapVld (R2C15_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R2C16_INextPE_OMap),
        .INextPE_OMapVld(R2C16_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R2C15_INextPE_OMap),
        .OMapVld        (R2C15_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R2C16 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R1C16_ONextPE_Map),
        .ImapVld   (R1C16_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight2),
        .IweightVld(IweightVld2),

        .ONextPE_Map    (R2C16_ONextPE_Map),
        .ONextPE_MapVld (R2C16_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (16'b0),
        .INextPE_OMapVld(last_INextPE_OMapVld2),  //OMap from C+1
        .OMap           (R2C16_INextPE_OMap),
        .OMapVld        (R2C16_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R3C1 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R2C1_ONextPE_Map),
        .ImapVld   (R2C1_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight3),
        .IweightVld(IweightVld3),

        .ONextPE_Map    (R3C1_ONextPE_Map),
        .ONextPE_MapVld (R3C1_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R3C2_INextPE_OMap),
        .INextPE_OMapVld(R3C2_INextPE_OMapVld),  //OMap from C+1
        .OMap           (PE_OMap3),
        .OMapVld        (PE_OMapVld3)            //OMap 
    );

    u_PE PE_R3C2 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R2C2_ONextPE_Map),
        .ImapVld   (R2C2_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight3),
        .IweightVld(IweightVld3),

        .ONextPE_Map    (R3C2_ONextPE_Map),
        .ONextPE_MapVld (R3C2_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R3C3_INextPE_OMap),
        .INextPE_OMapVld(R3C3_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R3C2_INextPE_OMap),
        .OMapVld        (R3C2_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R3C3 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R2C3_ONextPE_Map),
        .ImapVld   (R2C3_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight3),
        .IweightVld(IweightVld3),

        .ONextPE_Map    (R3C3_ONextPE_Map),
        .ONextPE_MapVld (R3C3_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R3C4_INextPE_OMap),
        .INextPE_OMapVld(R3C4_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R3C3_INextPE_OMap),
        .OMapVld        (R3C3_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R3C4 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R2C4_ONextPE_Map),
        .ImapVld   (R2C4_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight3),
        .IweightVld(IweightVld3),

        .ONextPE_Map    (R3C4_ONextPE_Map),
        .ONextPE_MapVld (R3C4_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R3C5_INextPE_OMap),
        .INextPE_OMapVld(R3C5_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R3C4_INextPE_OMap),
        .OMapVld        (R3C4_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R3C5 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R2C5_ONextPE_Map),
        .ImapVld   (R2C5_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight3),
        .IweightVld(IweightVld3),

        .ONextPE_Map    (R3C5_ONextPE_Map),
        .ONextPE_MapVld (R3C5_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R3C6_INextPE_OMap),
        .INextPE_OMapVld(R3C6_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R3C5_INextPE_OMap),
        .OMapVld        (R3C5_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R3C6 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R2C6_ONextPE_Map),
        .ImapVld   (R2C6_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight3),
        .IweightVld(IweightVld3),

        .ONextPE_Map    (R3C6_ONextPE_Map),
        .ONextPE_MapVld (R3C6_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R3C7_INextPE_OMap),
        .INextPE_OMapVld(R3C7_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R3C6_INextPE_OMap),
        .OMapVld        (R3C6_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R3C7 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R2C7_ONextPE_Map),
        .ImapVld   (R2C7_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight3),
        .IweightVld(IweightVld3),

        .ONextPE_Map    (R3C7_ONextPE_Map),
        .ONextPE_MapVld (R3C7_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R3C8_INextPE_OMap),
        .INextPE_OMapVld(R3C8_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R3C7_INextPE_OMap),
        .OMapVld        (R3C7_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R3C8 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R2C8_ONextPE_Map),
        .ImapVld   (R2C8_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight3),
        .IweightVld(IweightVld3),

        .ONextPE_Map    (R3C8_ONextPE_Map),
        .ONextPE_MapVld (R3C8_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R3C9_INextPE_OMap),
        .INextPE_OMapVld(R3C9_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R3C8_INextPE_OMap),
        .OMapVld        (R3C8_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R3C9 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R2C9_ONextPE_Map),
        .ImapVld   (R2C9_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight3),
        .IweightVld(IweightVld3),

        .ONextPE_Map    (R3C9_ONextPE_Map),
        .ONextPE_MapVld (R3C9_ONextPE_MapVld),    //IMap
        .INextPE_OMap   (R3C10_INextPE_OMap),
        .INextPE_OMapVld(R3C10_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R3C9_INextPE_OMap),
        .OMapVld        (R3C9_INextPE_OMapVld)    //OMap 
    );

    u_PE PE_R3C10 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R2C10_ONextPE_Map),
        .ImapVld   (R2C10_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight3),
        .IweightVld(IweightVld3),

        .ONextPE_Map    (R3C10_ONextPE_Map),
        .ONextPE_MapVld (R3C10_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R3C11_INextPE_OMap),
        .INextPE_OMapVld(R3C11_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R3C10_INextPE_OMap),
        .OMapVld        (R3C10_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R3C11 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R2C11_ONextPE_Map),
        .ImapVld   (R2C11_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight3),
        .IweightVld(IweightVld3),

        .ONextPE_Map    (R3C11_ONextPE_Map),
        .ONextPE_MapVld (R3C11_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R3C12_INextPE_OMap),
        .INextPE_OMapVld(R3C12_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R3C11_INextPE_OMap),
        .OMapVld        (R3C11_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R3C12 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R2C12_ONextPE_Map),
        .ImapVld   (R2C12_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight3),
        .IweightVld(IweightVld3),

        .ONextPE_Map    (R3C12_ONextPE_Map),
        .ONextPE_MapVld (R3C12_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R3C13_INextPE_OMap),
        .INextPE_OMapVld(R3C13_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R3C12_INextPE_OMap),
        .OMapVld        (R3C12_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R3C13 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R2C13_ONextPE_Map),
        .ImapVld   (R2C13_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight3),
        .IweightVld(IweightVld3),

        .ONextPE_Map    (R3C13_ONextPE_Map),
        .ONextPE_MapVld (R3C13_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R3C14_INextPE_OMap),
        .INextPE_OMapVld(R3C14_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R3C13_INextPE_OMap),
        .OMapVld        (R3C13_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R3C14 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R2C14_ONextPE_Map),
        .ImapVld   (R2C14_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight3),
        .IweightVld(IweightVld3),

        .ONextPE_Map    (R3C14_ONextPE_Map),
        .ONextPE_MapVld (R3C14_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R3C15_INextPE_OMap),
        .INextPE_OMapVld(R3C15_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R3C14_INextPE_OMap),
        .OMapVld        (R3C14_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R3C15 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R2C15_ONextPE_Map),
        .ImapVld   (R2C15_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight3),
        .IweightVld(IweightVld3),

        .ONextPE_Map    (R3C15_ONextPE_Map),
        .ONextPE_MapVld (R3C15_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R3C16_INextPE_OMap),
        .INextPE_OMapVld(R3C16_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R3C15_INextPE_OMap),
        .OMapVld        (R3C15_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R3C16 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R2C16_ONextPE_Map),
        .ImapVld   (R2C16_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight3),
        .IweightVld(IweightVld3),

        .ONextPE_Map    (R3C16_ONextPE_Map),
        .ONextPE_MapVld (R3C16_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (16'b0),
        .INextPE_OMapVld(last_INextPE_OMapVld3),  //OMap from C+1
        .OMap           (R3C16_INextPE_OMap),
        .OMapVld        (R3C16_INextPE_OMapVld)   //OMap 
    );


    u_PE PE_R4C1 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R3C1_ONextPE_Map),
        .ImapVld   (R3C1_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight4),
        .IweightVld(IweightVld4),

        .ONextPE_Map    (R4C1_ONextPE_Map),
        .ONextPE_MapVld (R4C1_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R4C2_INextPE_OMap),
        .INextPE_OMapVld(R4C2_INextPE_OMapVld),  //OMap from C+1
        .OMap           (PE_OMap4),
        .OMapVld        (PE_OMapVld4)            //OMap 
    );

    u_PE PE_R4C2 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R3C2_ONextPE_Map),
        .ImapVld   (R3C2_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight4),
        .IweightVld(IweightVld4),

        .ONextPE_Map    (R4C2_ONextPE_Map),
        .ONextPE_MapVld (R4C2_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R4C3_INextPE_OMap),
        .INextPE_OMapVld(R4C3_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R4C2_INextPE_OMap),
        .OMapVld        (R4C2_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R4C3 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R3C3_ONextPE_Map),
        .ImapVld   (R3C3_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight4),
        .IweightVld(IweightVld4),

        .ONextPE_Map    (R4C3_ONextPE_Map),
        .ONextPE_MapVld (R4C3_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R4C4_INextPE_OMap),
        .INextPE_OMapVld(R4C4_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R4C3_INextPE_OMap),
        .OMapVld        (R4C3_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R4C4 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R3C4_ONextPE_Map),
        .ImapVld   (R3C4_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight4),
        .IweightVld(IweightVld4),

        .ONextPE_Map    (R4C4_ONextPE_Map),
        .ONextPE_MapVld (R4C4_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R4C5_INextPE_OMap),
        .INextPE_OMapVld(R4C5_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R4C4_INextPE_OMap),
        .OMapVld        (R4C4_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R4C5 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R3C5_ONextPE_Map),
        .ImapVld   (R3C5_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight4),
        .IweightVld(IweightVld4),

        .ONextPE_Map    (R4C5_ONextPE_Map),
        .ONextPE_MapVld (R4C5_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R4C6_INextPE_OMap),
        .INextPE_OMapVld(R4C6_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R4C5_INextPE_OMap),
        .OMapVld        (R4C5_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R4C6 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R3C6_ONextPE_Map),
        .ImapVld   (R3C6_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight4),
        .IweightVld(IweightVld4),

        .ONextPE_Map    (R4C6_ONextPE_Map),
        .ONextPE_MapVld (R4C6_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R4C7_INextPE_OMap),
        .INextPE_OMapVld(R4C7_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R4C6_INextPE_OMap),
        .OMapVld        (R4C6_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R4C7 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R3C7_ONextPE_Map),
        .ImapVld   (R3C7_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight4),
        .IweightVld(IweightVld4),

        .ONextPE_Map    (R4C7_ONextPE_Map),
        .ONextPE_MapVld (R4C7_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R4C8_INextPE_OMap),
        .INextPE_OMapVld(R4C8_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R4C7_INextPE_OMap),
        .OMapVld        (R4C7_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R4C8 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R3C8_ONextPE_Map),
        .ImapVld   (R3C8_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight4),
        .IweightVld(IweightVld4),

        .ONextPE_Map    (R4C8_ONextPE_Map),
        .ONextPE_MapVld (R4C8_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R4C9_INextPE_OMap),
        .INextPE_OMapVld(R4C9_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R4C8_INextPE_OMap),
        .OMapVld        (R4C8_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R4C9 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R3C9_ONextPE_Map),
        .ImapVld   (R3C9_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight4),
        .IweightVld(IweightVld4),

        .ONextPE_Map    (R4C9_ONextPE_Map),
        .ONextPE_MapVld (R4C9_ONextPE_MapVld),    //IMap
        .INextPE_OMap   (R4C10_INextPE_OMap),
        .INextPE_OMapVld(R4C10_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R4C9_INextPE_OMap),
        .OMapVld        (R4C9_INextPE_OMapVld)    //OMap 
    );

    u_PE PE_R4C10 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R3C10_ONextPE_Map),
        .ImapVld   (R3C10_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight4),
        .IweightVld(IweightVld4),

        .ONextPE_Map    (R4C10_ONextPE_Map),
        .ONextPE_MapVld (R4C10_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R4C11_INextPE_OMap),
        .INextPE_OMapVld(R4C11_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R4C10_INextPE_OMap),
        .OMapVld        (R4C10_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R4C11 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R3C11_ONextPE_Map),
        .ImapVld   (R3C11_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight4),
        .IweightVld(IweightVld4),

        .ONextPE_Map    (R4C11_ONextPE_Map),
        .ONextPE_MapVld (R4C11_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R4C12_INextPE_OMap),
        .INextPE_OMapVld(R4C12_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R4C11_INextPE_OMap),
        .OMapVld        (R4C11_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R4C12 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R3C12_ONextPE_Map),
        .ImapVld   (R3C12_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight4),
        .IweightVld(IweightVld4),

        .ONextPE_Map    (R4C12_ONextPE_Map),
        .ONextPE_MapVld (R4C12_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R4C13_INextPE_OMap),
        .INextPE_OMapVld(R4C13_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R4C12_INextPE_OMap),
        .OMapVld        (R4C12_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R4C13 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R3C13_ONextPE_Map),
        .ImapVld   (R3C13_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight4),
        .IweightVld(IweightVld4),

        .ONextPE_Map    (R4C13_ONextPE_Map),
        .ONextPE_MapVld (R4C13_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R4C14_INextPE_OMap),
        .INextPE_OMapVld(R4C14_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R4C13_INextPE_OMap),
        .OMapVld        (R4C13_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R4C14 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R3C14_ONextPE_Map),
        .ImapVld   (R3C14_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight4),
        .IweightVld(IweightVld4),

        .ONextPE_Map    (R4C14_ONextPE_Map),
        .ONextPE_MapVld (R4C14_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R4C15_INextPE_OMap),
        .INextPE_OMapVld(R4C15_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R4C14_INextPE_OMap),
        .OMapVld        (R4C14_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R4C15 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R3C15_ONextPE_Map),
        .ImapVld   (R3C15_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight4),
        .IweightVld(IweightVld4),

        .ONextPE_Map    (R4C15_ONextPE_Map),
        .ONextPE_MapVld (R4C15_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R4C16_INextPE_OMap),
        .INextPE_OMapVld(R4C16_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R4C15_INextPE_OMap),
        .OMapVld        (R4C15_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R4C16 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R3C16_ONextPE_Map),
        .ImapVld   (R3C16_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight4),
        .IweightVld(IweightVld4),

        .ONextPE_Map    (R4C16_ONextPE_Map),
        .ONextPE_MapVld (R4C16_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (16'b0),
        .INextPE_OMapVld(last_INextPE_OMapVld4),  //OMap from C+1
        .OMap           (R4C16_INextPE_OMap),
        .OMapVld        (R4C16_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R5C1 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R4C1_ONextPE_Map),
        .ImapVld   (R4C1_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight5),
        .IweightVld(IweightVld5),

        .ONextPE_Map    (R5C1_ONextPE_Map),
        .ONextPE_MapVld (R5C1_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R5C2_INextPE_OMap),
        .INextPE_OMapVld(R5C2_INextPE_OMapVld),  //OMap from C+1
        .OMap           (PE_OMap5),
        .OMapVld        (PE_OMapVld5)            //OMap 
    );

    u_PE PE_R5C2 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R4C2_ONextPE_Map),
        .ImapVld   (R4C2_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight5),
        .IweightVld(IweightVld5),

        .ONextPE_Map    (R5C2_ONextPE_Map),
        .ONextPE_MapVld (R5C2_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R5C3_INextPE_OMap),
        .INextPE_OMapVld(R5C3_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R5C2_INextPE_OMap),
        .OMapVld        (R5C2_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R5C3 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R4C3_ONextPE_Map),
        .ImapVld   (R4C3_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight5),
        .IweightVld(IweightVld5),

        .ONextPE_Map    (R5C3_ONextPE_Map),
        .ONextPE_MapVld (R5C3_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R5C4_INextPE_OMap),
        .INextPE_OMapVld(R5C4_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R5C3_INextPE_OMap),
        .OMapVld        (R5C3_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R5C4 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R4C4_ONextPE_Map),
        .ImapVld   (R4C4_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight5),
        .IweightVld(IweightVld5),

        .ONextPE_Map    (R5C4_ONextPE_Map),
        .ONextPE_MapVld (R5C4_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R5C5_INextPE_OMap),
        .INextPE_OMapVld(R5C5_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R5C4_INextPE_OMap),
        .OMapVld        (R5C4_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R5C5 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R4C5_ONextPE_Map),
        .ImapVld   (R4C5_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight5),
        .IweightVld(IweightVld5),

        .ONextPE_Map    (R5C5_ONextPE_Map),
        .ONextPE_MapVld (R5C5_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R5C6_INextPE_OMap),
        .INextPE_OMapVld(R5C6_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R5C5_INextPE_OMap),
        .OMapVld        (R5C5_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R5C6 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R4C6_ONextPE_Map),
        .ImapVld   (R4C6_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight5),
        .IweightVld(IweightVld5),

        .ONextPE_Map    (R5C6_ONextPE_Map),
        .ONextPE_MapVld (R5C6_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R5C7_INextPE_OMap),
        .INextPE_OMapVld(R5C7_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R5C6_INextPE_OMap),
        .OMapVld        (R5C6_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R5C7 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R4C7_ONextPE_Map),
        .ImapVld   (R4C7_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight5),
        .IweightVld(IweightVld5),

        .ONextPE_Map    (R5C7_ONextPE_Map),
        .ONextPE_MapVld (R5C7_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R5C8_INextPE_OMap),
        .INextPE_OMapVld(R5C8_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R5C7_INextPE_OMap),
        .OMapVld        (R5C7_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R5C8 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R4C8_ONextPE_Map),
        .ImapVld   (R4C8_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight5),
        .IweightVld(IweightVld5),

        .ONextPE_Map    (R5C8_ONextPE_Map),
        .ONextPE_MapVld (R5C8_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R5C9_INextPE_OMap),
        .INextPE_OMapVld(R5C9_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R5C8_INextPE_OMap),
        .OMapVld        (R5C8_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R5C9 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R4C9_ONextPE_Map),
        .ImapVld   (R4C9_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight5),
        .IweightVld(IweightVld5),

        .ONextPE_Map    (R5C9_ONextPE_Map),
        .ONextPE_MapVld (R5C9_ONextPE_MapVld),    //IMap
        .INextPE_OMap   (R5C10_INextPE_OMap),
        .INextPE_OMapVld(R5C10_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R5C9_INextPE_OMap),
        .OMapVld        (R5C9_INextPE_OMapVld)    //OMap 
    );

    u_PE PE_R5C10 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R4C10_ONextPE_Map),
        .ImapVld   (R4C10_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight5),
        .IweightVld(IweightVld5),

        .ONextPE_Map    (R5C10_ONextPE_Map),
        .ONextPE_MapVld (R5C10_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R5C11_INextPE_OMap),
        .INextPE_OMapVld(R5C11_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R5C10_INextPE_OMap),
        .OMapVld        (R5C10_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R5C11 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R4C11_ONextPE_Map),
        .ImapVld   (R4C11_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight5),
        .IweightVld(IweightVld5),

        .ONextPE_Map    (R5C11_ONextPE_Map),
        .ONextPE_MapVld (R5C11_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R5C12_INextPE_OMap),
        .INextPE_OMapVld(R5C12_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R5C11_INextPE_OMap),
        .OMapVld        (R5C11_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R5C12 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R4C12_ONextPE_Map),
        .ImapVld   (R4C12_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight5),
        .IweightVld(IweightVld5),

        .ONextPE_Map    (R5C12_ONextPE_Map),
        .ONextPE_MapVld (R5C12_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R5C13_INextPE_OMap),
        .INextPE_OMapVld(R5C13_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R5C12_INextPE_OMap),
        .OMapVld        (R5C12_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R5C13 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R4C13_ONextPE_Map),
        .ImapVld   (R4C13_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight5),
        .IweightVld(IweightVld5),

        .ONextPE_Map    (R5C13_ONextPE_Map),
        .ONextPE_MapVld (R5C13_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R5C14_INextPE_OMap),
        .INextPE_OMapVld(R5C14_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R5C13_INextPE_OMap),
        .OMapVld        (R5C13_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R5C14 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R4C14_ONextPE_Map),
        .ImapVld   (R4C14_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight5),
        .IweightVld(IweightVld5),

        .ONextPE_Map    (R5C14_ONextPE_Map),
        .ONextPE_MapVld (R5C14_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R5C15_INextPE_OMap),
        .INextPE_OMapVld(R5C15_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R5C14_INextPE_OMap),
        .OMapVld        (R5C14_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R5C15 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R4C15_ONextPE_Map),
        .ImapVld   (R4C15_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight5),
        .IweightVld(IweightVld5),

        .ONextPE_Map    (R5C15_ONextPE_Map),
        .ONextPE_MapVld (R5C15_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R5C16_INextPE_OMap),
        .INextPE_OMapVld(R5C16_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R5C15_INextPE_OMap),
        .OMapVld        (R5C15_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R5C16 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R4C16_ONextPE_Map),
        .ImapVld   (R4C16_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight5),
        .IweightVld(IweightVld5),

        .ONextPE_Map    (R5C16_ONextPE_Map),
        .ONextPE_MapVld (R5C16_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (16'b0),
        .INextPE_OMapVld(last_INextPE_OMapVld5),  //OMap from C+1
        .OMap           (R5C16_INextPE_OMap),
        .OMapVld        (R5C16_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R6C1 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R5C1_ONextPE_Map),
        .ImapVld   (R5C1_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight6),
        .IweightVld(IweightVld6),

        .ONextPE_Map    (R6C1_ONextPE_Map),
        .ONextPE_MapVld (R6C1_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R6C2_INextPE_OMap),
        .INextPE_OMapVld(R6C2_INextPE_OMapVld),  //OMap from C+1
        .OMap           (PE_OMap6),
        .OMapVld        (PE_OMapVld6)            //OMap 
    );

    u_PE PE_R6C2 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R5C2_ONextPE_Map),
        .ImapVld   (R5C2_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight6),
        .IweightVld(IweightVld6),

        .ONextPE_Map    (R6C2_ONextPE_Map),
        .ONextPE_MapVld (R6C2_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R6C3_INextPE_OMap),
        .INextPE_OMapVld(R6C3_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R6C2_INextPE_OMap),
        .OMapVld        (R6C2_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R6C3 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R5C3_ONextPE_Map),
        .ImapVld   (R5C3_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight6),
        .IweightVld(IweightVld6),

        .ONextPE_Map    (R6C3_ONextPE_Map),
        .ONextPE_MapVld (R6C3_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R6C4_INextPE_OMap),
        .INextPE_OMapVld(R6C4_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R6C3_INextPE_OMap),
        .OMapVld        (R6C3_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R6C4 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R5C4_ONextPE_Map),
        .ImapVld   (R5C4_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight6),
        .IweightVld(IweightVld6),

        .ONextPE_Map    (R6C4_ONextPE_Map),
        .ONextPE_MapVld (R6C4_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R6C5_INextPE_OMap),
        .INextPE_OMapVld(R6C5_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R6C4_INextPE_OMap),
        .OMapVld        (R6C4_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R6C5 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R5C5_ONextPE_Map),
        .ImapVld   (R5C5_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight6),
        .IweightVld(IweightVld6),

        .ONextPE_Map    (R6C5_ONextPE_Map),
        .ONextPE_MapVld (R6C5_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R6C6_INextPE_OMap),
        .INextPE_OMapVld(R6C6_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R6C5_INextPE_OMap),
        .OMapVld        (R6C5_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R6C6 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R5C6_ONextPE_Map),
        .ImapVld   (R5C6_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight6),
        .IweightVld(IweightVld6),

        .ONextPE_Map    (R6C6_ONextPE_Map),
        .ONextPE_MapVld (R6C6_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R6C7_INextPE_OMap),
        .INextPE_OMapVld(R6C7_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R6C6_INextPE_OMap),
        .OMapVld        (R6C6_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R6C7 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R5C7_ONextPE_Map),
        .ImapVld   (R5C7_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight6),
        .IweightVld(IweightVld6),

        .ONextPE_Map    (R6C7_ONextPE_Map),
        .ONextPE_MapVld (R6C7_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R6C8_INextPE_OMap),
        .INextPE_OMapVld(R6C8_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R6C7_INextPE_OMap),
        .OMapVld        (R6C7_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R6C8 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R5C8_ONextPE_Map),
        .ImapVld   (R5C8_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight6),
        .IweightVld(IweightVld6),

        .ONextPE_Map    (R6C8_ONextPE_Map),
        .ONextPE_MapVld (R6C8_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R6C9_INextPE_OMap),
        .INextPE_OMapVld(R6C9_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R6C8_INextPE_OMap),
        .OMapVld        (R6C8_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R6C9 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R5C9_ONextPE_Map),
        .ImapVld   (R5C9_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight6),
        .IweightVld(IweightVld6),

        .ONextPE_Map    (R6C9_ONextPE_Map),
        .ONextPE_MapVld (R6C9_ONextPE_MapVld),    //IMap
        .INextPE_OMap   (R6C10_INextPE_OMap),
        .INextPE_OMapVld(R6C10_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R6C9_INextPE_OMap),
        .OMapVld        (R6C9_INextPE_OMapVld)    //OMap 
    );

    u_PE PE_R6C10 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R5C10_ONextPE_Map),
        .ImapVld   (R5C10_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight6),
        .IweightVld(IweightVld6),

        .ONextPE_Map    (R6C10_ONextPE_Map),
        .ONextPE_MapVld (R6C10_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R6C11_INextPE_OMap),
        .INextPE_OMapVld(R6C11_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R6C10_INextPE_OMap),
        .OMapVld        (R6C10_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R6C11 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R5C11_ONextPE_Map),
        .ImapVld   (R5C11_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight6),
        .IweightVld(IweightVld6),

        .ONextPE_Map    (R6C11_ONextPE_Map),
        .ONextPE_MapVld (R6C11_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R6C12_INextPE_OMap),
        .INextPE_OMapVld(R6C12_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R6C11_INextPE_OMap),
        .OMapVld        (R6C11_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R6C12 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R5C12_ONextPE_Map),
        .ImapVld   (R5C12_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight6),
        .IweightVld(IweightVld6),

        .ONextPE_Map    (R6C12_ONextPE_Map),
        .ONextPE_MapVld (R6C12_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R6C13_INextPE_OMap),
        .INextPE_OMapVld(R6C13_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R6C12_INextPE_OMap),
        .OMapVld        (R6C12_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R6C13 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R5C13_ONextPE_Map),
        .ImapVld   (R5C13_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight6),
        .IweightVld(IweightVld6),

        .ONextPE_Map    (R6C13_ONextPE_Map),
        .ONextPE_MapVld (R6C13_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R6C14_INextPE_OMap),
        .INextPE_OMapVld(R6C14_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R6C13_INextPE_OMap),
        .OMapVld        (R6C13_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R6C14 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R5C14_ONextPE_Map),
        .ImapVld   (R5C14_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight6),
        .IweightVld(IweightVld6),

        .ONextPE_Map    (R6C14_ONextPE_Map),
        .ONextPE_MapVld (R6C14_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R6C15_INextPE_OMap),
        .INextPE_OMapVld(R6C15_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R6C14_INextPE_OMap),
        .OMapVld        (R6C14_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R6C15 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R5C15_ONextPE_Map),
        .ImapVld   (R5C15_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight6),
        .IweightVld(IweightVld6),

        .ONextPE_Map    (R6C15_ONextPE_Map),
        .ONextPE_MapVld (R6C15_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R6C16_INextPE_OMap),
        .INextPE_OMapVld(R6C16_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R6C15_INextPE_OMap),
        .OMapVld        (R6C15_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R6C16 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R5C16_ONextPE_Map),
        .ImapVld   (R5C16_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight6),
        .IweightVld(IweightVld6),

        .ONextPE_Map    (R6C16_ONextPE_Map),
        .ONextPE_MapVld (R6C16_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (16'b0),
        .INextPE_OMapVld(last_INextPE_OMapVld6),  //OMap from C+1
        .OMap           (R6C16_INextPE_OMap),
        .OMapVld        (R6C16_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R7C1 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R6C1_ONextPE_Map),
        .ImapVld   (R6C1_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight7),
        .IweightVld(IweightVld7),

        .ONextPE_Map    (R7C1_ONextPE_Map),
        .ONextPE_MapVld (R7C1_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R7C2_INextPE_OMap),
        .INextPE_OMapVld(R7C2_INextPE_OMapVld),  //OMap from C+1
        .OMap           (PE_OMap7),
        .OMapVld        (PE_OMapVld7)            //OMap 
    );

    u_PE PE_R7C2 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R6C2_ONextPE_Map),
        .ImapVld   (R6C2_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight7),
        .IweightVld(IweightVld7),

        .ONextPE_Map    (R7C2_ONextPE_Map),
        .ONextPE_MapVld (R7C2_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R7C3_INextPE_OMap),
        .INextPE_OMapVld(R7C3_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R7C2_INextPE_OMap),
        .OMapVld        (R7C2_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R7C3 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R6C3_ONextPE_Map),
        .ImapVld   (R6C3_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight7),
        .IweightVld(IweightVld7),

        .ONextPE_Map    (R7C3_ONextPE_Map),
        .ONextPE_MapVld (R7C3_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R7C4_INextPE_OMap),
        .INextPE_OMapVld(R7C4_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R7C3_INextPE_OMap),
        .OMapVld        (R7C3_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R7C4 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R6C4_ONextPE_Map),
        .ImapVld   (R6C4_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight7),
        .IweightVld(IweightVld7),

        .ONextPE_Map    (R7C4_ONextPE_Map),
        .ONextPE_MapVld (R7C4_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R7C5_INextPE_OMap),
        .INextPE_OMapVld(R7C5_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R7C4_INextPE_OMap),
        .OMapVld        (R7C4_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R7C5 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R6C5_ONextPE_Map),
        .ImapVld   (R6C5_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight7),
        .IweightVld(IweightVld7),

        .ONextPE_Map    (R7C5_ONextPE_Map),
        .ONextPE_MapVld (R7C5_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R7C6_INextPE_OMap),
        .INextPE_OMapVld(R7C6_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R7C5_INextPE_OMap),
        .OMapVld        (R7C5_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R7C6 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R6C6_ONextPE_Map),
        .ImapVld   (R6C6_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight7),
        .IweightVld(IweightVld7),

        .ONextPE_Map    (R7C6_ONextPE_Map),
        .ONextPE_MapVld (R7C6_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R7C7_INextPE_OMap),
        .INextPE_OMapVld(R7C7_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R7C6_INextPE_OMap),
        .OMapVld        (R7C6_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R7C7 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R6C7_ONextPE_Map),
        .ImapVld   (R6C7_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight7),
        .IweightVld(IweightVld7),

        .ONextPE_Map    (R7C7_ONextPE_Map),
        .ONextPE_MapVld (R7C7_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R7C8_INextPE_OMap),
        .INextPE_OMapVld(R7C8_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R7C7_INextPE_OMap),
        .OMapVld        (R7C7_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R7C8 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R6C8_ONextPE_Map),
        .ImapVld   (R6C8_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight7),
        .IweightVld(IweightVld7),

        .ONextPE_Map    (R7C8_ONextPE_Map),
        .ONextPE_MapVld (R7C8_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R7C9_INextPE_OMap),
        .INextPE_OMapVld(R7C9_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R7C8_INextPE_OMap),
        .OMapVld        (R7C8_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R7C9 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R6C9_ONextPE_Map),
        .ImapVld   (R6C9_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight7),
        .IweightVld(IweightVld7),

        .ONextPE_Map    (R7C9_ONextPE_Map),
        .ONextPE_MapVld (R7C9_ONextPE_MapVld),    //IMap
        .INextPE_OMap   (R7C10_INextPE_OMap),
        .INextPE_OMapVld(R7C10_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R7C9_INextPE_OMap),
        .OMapVld        (R7C9_INextPE_OMapVld)    //OMap 
    );

    u_PE PE_R7C10 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R6C10_ONextPE_Map),
        .ImapVld   (R6C10_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight7),
        .IweightVld(IweightVld7),

        .ONextPE_Map    (R7C10_ONextPE_Map),
        .ONextPE_MapVld (R7C10_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R7C11_INextPE_OMap),
        .INextPE_OMapVld(R7C11_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R7C10_INextPE_OMap),
        .OMapVld        (R7C10_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R7C11 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R6C11_ONextPE_Map),
        .ImapVld   (R6C11_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight7),
        .IweightVld(IweightVld7),

        .ONextPE_Map    (R7C11_ONextPE_Map),
        .ONextPE_MapVld (R7C11_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R7C12_INextPE_OMap),
        .INextPE_OMapVld(R7C12_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R7C11_INextPE_OMap),
        .OMapVld        (R7C11_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R7C12 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R6C12_ONextPE_Map),
        .ImapVld   (R6C12_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight7),
        .IweightVld(IweightVld7),

        .ONextPE_Map    (R7C12_ONextPE_Map),
        .ONextPE_MapVld (R7C12_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R7C13_INextPE_OMap),
        .INextPE_OMapVld(R7C13_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R7C12_INextPE_OMap),
        .OMapVld        (R7C12_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R7C13 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R6C13_ONextPE_Map),
        .ImapVld   (R6C13_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight7),
        .IweightVld(IweightVld7),

        .ONextPE_Map    (R7C13_ONextPE_Map),
        .ONextPE_MapVld (R7C13_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R7C14_INextPE_OMap),
        .INextPE_OMapVld(R7C14_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R7C13_INextPE_OMap),
        .OMapVld        (R7C13_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R7C14 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R6C14_ONextPE_Map),
        .ImapVld   (R6C14_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight7),
        .IweightVld(IweightVld7),

        .ONextPE_Map    (R7C14_ONextPE_Map),
        .ONextPE_MapVld (R7C14_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R7C15_INextPE_OMap),
        .INextPE_OMapVld(R7C15_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R7C14_INextPE_OMap),
        .OMapVld        (R7C14_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R7C15 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R6C15_ONextPE_Map),
        .ImapVld   (R6C15_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight7),
        .IweightVld(IweightVld7),

        .ONextPE_Map    (R7C15_ONextPE_Map),
        .ONextPE_MapVld (R7C15_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R7C16_INextPE_OMap),
        .INextPE_OMapVld(R7C16_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R7C15_INextPE_OMap),
        .OMapVld        (R7C15_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R7C16 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R6C16_ONextPE_Map),
        .ImapVld   (R6C16_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight7),
        .IweightVld(IweightVld7),

        .ONextPE_Map    (R7C16_ONextPE_Map),
        .ONextPE_MapVld (R7C16_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (16'b0),
        .INextPE_OMapVld(last_INextPE_OMapVld7),  //OMap from C+1
        .OMap           (R7C16_INextPE_OMap),
        .OMapVld        (R7C16_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R8C1 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R7C1_ONextPE_Map),
        .ImapVld   (R7C1_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight8),
        .IweightVld(IweightVld8),

        .ONextPE_Map    (R8C1_ONextPE_Map),
        .ONextPE_MapVld (R8C1_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R8C2_INextPE_OMap),
        .INextPE_OMapVld(R8C2_INextPE_OMapVld),  //OMap from C+1
        .OMap           (PE_OMap8),
        .OMapVld        (PE_OMapVld8)            //OMap 
    );

    u_PE PE_R8C2 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R7C2_ONextPE_Map),
        .ImapVld   (R7C2_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight8),
        .IweightVld(IweightVld8),

        .ONextPE_Map    (R8C2_ONextPE_Map),
        .ONextPE_MapVld (R8C2_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R8C3_INextPE_OMap),
        .INextPE_OMapVld(R8C3_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R8C2_INextPE_OMap),
        .OMapVld        (R8C2_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R8C3 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R7C3_ONextPE_Map),
        .ImapVld   (R7C3_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight8),
        .IweightVld(IweightVld8),

        .ONextPE_Map    (R8C3_ONextPE_Map),
        .ONextPE_MapVld (R8C3_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R8C4_INextPE_OMap),
        .INextPE_OMapVld(R8C4_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R8C3_INextPE_OMap),
        .OMapVld        (R8C3_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R8C4 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R7C4_ONextPE_Map),
        .ImapVld   (R7C4_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight8),
        .IweightVld(IweightVld8),

        .ONextPE_Map    (R8C4_ONextPE_Map),
        .ONextPE_MapVld (R8C4_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R8C5_INextPE_OMap),
        .INextPE_OMapVld(R8C5_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R8C4_INextPE_OMap),
        .OMapVld        (R8C4_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R8C5 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R7C5_ONextPE_Map),
        .ImapVld   (R7C5_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight8),
        .IweightVld(IweightVld8),

        .ONextPE_Map    (R8C5_ONextPE_Map),
        .ONextPE_MapVld (R8C5_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R8C6_INextPE_OMap),
        .INextPE_OMapVld(R8C6_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R8C5_INextPE_OMap),
        .OMapVld        (R8C5_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R8C6 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R7C6_ONextPE_Map),
        .ImapVld   (R7C6_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight8),
        .IweightVld(IweightVld8),

        .ONextPE_Map    (R8C6_ONextPE_Map),
        .ONextPE_MapVld (R8C6_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R8C7_INextPE_OMap),
        .INextPE_OMapVld(R8C7_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R8C6_INextPE_OMap),
        .OMapVld        (R8C6_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R8C7 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R7C7_ONextPE_Map),
        .ImapVld   (R7C7_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight8),
        .IweightVld(IweightVld8),

        .ONextPE_Map    (R8C7_ONextPE_Map),
        .ONextPE_MapVld (R8C7_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R8C8_INextPE_OMap),
        .INextPE_OMapVld(R8C8_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R8C7_INextPE_OMap),
        .OMapVld        (R8C7_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R8C8 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R7C8_ONextPE_Map),
        .ImapVld   (R7C8_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight8),
        .IweightVld(IweightVld8),

        .ONextPE_Map    (R8C8_ONextPE_Map),
        .ONextPE_MapVld (R8C8_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R8C9_INextPE_OMap),
        .INextPE_OMapVld(R8C9_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R8C8_INextPE_OMap),
        .OMapVld        (R8C8_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R8C9 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R7C9_ONextPE_Map),
        .ImapVld   (R7C9_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight8),
        .IweightVld(IweightVld8),

        .ONextPE_Map    (R8C9_ONextPE_Map),
        .ONextPE_MapVld (R8C9_ONextPE_MapVld),    //IMap
        .INextPE_OMap   (R8C10_INextPE_OMap),
        .INextPE_OMapVld(R8C10_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R8C9_INextPE_OMap),
        .OMapVld        (R8C9_INextPE_OMapVld)    //OMap 
    );

    u_PE PE_R8C10 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R7C10_ONextPE_Map),
        .ImapVld   (R7C10_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight8),
        .IweightVld(IweightVld8),

        .ONextPE_Map    (R8C10_ONextPE_Map),
        .ONextPE_MapVld (R8C10_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R8C11_INextPE_OMap),
        .INextPE_OMapVld(R8C11_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R8C10_INextPE_OMap),
        .OMapVld        (R8C10_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R8C11 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R7C11_ONextPE_Map),
        .ImapVld   (R7C11_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight8),
        .IweightVld(IweightVld8),

        .ONextPE_Map    (R8C11_ONextPE_Map),
        .ONextPE_MapVld (R8C11_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R8C12_INextPE_OMap),
        .INextPE_OMapVld(R8C12_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R8C11_INextPE_OMap),
        .OMapVld        (R8C11_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R8C12 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R7C12_ONextPE_Map),
        .ImapVld   (R7C12_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight8),
        .IweightVld(IweightVld8),

        .ONextPE_Map    (R8C12_ONextPE_Map),
        .ONextPE_MapVld (R8C12_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R8C13_INextPE_OMap),
        .INextPE_OMapVld(R8C13_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R8C12_INextPE_OMap),
        .OMapVld        (R8C12_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R8C13 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R7C13_ONextPE_Map),
        .ImapVld   (R7C13_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight8),
        .IweightVld(IweightVld8),

        .ONextPE_Map    (R8C13_ONextPE_Map),
        .ONextPE_MapVld (R8C13_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R8C14_INextPE_OMap),
        .INextPE_OMapVld(R8C14_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R8C13_INextPE_OMap),
        .OMapVld        (R8C13_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R8C14 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R7C14_ONextPE_Map),
        .ImapVld   (R7C14_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight8),
        .IweightVld(IweightVld8),

        .ONextPE_Map    (R8C14_ONextPE_Map),
        .ONextPE_MapVld (R8C14_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R8C15_INextPE_OMap),
        .INextPE_OMapVld(R8C15_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R8C14_INextPE_OMap),
        .OMapVld        (R8C14_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R8C15 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R7C15_ONextPE_Map),
        .ImapVld   (R7C15_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight8),
        .IweightVld(IweightVld8),

        .ONextPE_Map    (R8C15_ONextPE_Map),
        .ONextPE_MapVld (R8C15_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (R8C16_INextPE_OMap),
        .INextPE_OMapVld(R8C16_INextPE_OMapVld),  //OMap from C+1
        .OMap           (R8C15_INextPE_OMap),
        .OMapVld        (R8C15_INextPE_OMapVld)   //OMap 
    );

    u_PE PE_R8C16 (
        .clk_cal   (clk_cal),
        .rst_cal_n (rst_cal_n),
        .Calcycle  (Calcycle),
        .IMap      (R7C16_ONextPE_Map),
        .ImapVld   (R7C16_ONextPE_MapVld),  //IMap from R-1									
        .IWeight   (IWeight8),
        .IweightVld(IweightVld8),

        .ONextPE_Map    (R8C16_ONextPE_Map),
        .ONextPE_MapVld (R8C16_ONextPE_MapVld),   //IMap
        .INextPE_OMap   (16'b0),
        .INextPE_OMapVld(last_INextPE_OMapVld8),  //OMap from C+1
        .OMap           (R8C16_INextPE_OMap),
        .OMapVld        (R8C16_INextPE_OMapVld)   //OMap 
    );



endmodule

