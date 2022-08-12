// *****************************************************************************
// @Project Name : ECG_CPU 
// @Author       : Huangjunguang
// @Email        : andy_ic@foxmail.com
// @File Name    : Mcu_ECG.v
// @Module Name  : Mcu_ECG
// @Created Time : 2020-03-19 09:54
//
// @Abstract     : This module is master contrl unit of ECG ,achieving various 
//               ways of data reuse by controlling data transmission and computing.
//               
//
// Modification History
// ******************************************************************************
// Date           BY           Version         Change Description
// -------------------------------------------------------------------------
// 2020-03-19   Huangjunguang    v1.0a           initial version 
// 2020-05-18	Huangjunguang	 v2.0b			change the state
// 2020-06-03	Huangjunguang     v2.0		change nn_layers_num_reg to 7
// ******************************************************************************

`timescale 1ns / 1ns
`define DDR_DW			64
`define DDR_AW			32


module SPU_ECG(
    input						clk_cal,
    input						rst_cal_n,

	//from SPI  (new)
	input						SPI_start, 
	input						SPI_done,
	
    //from MemCtrl             
	input						ft_lyr_param_done, 
    input						ft_wt_done,
    input						ft_ecg_done,
    input						memct_init_cmplt, //new
	//input		[7:0]			Nt_num,  
	input           			lyr_cal_done,
	
    //to MemCtrl 
    output reg	[7:0]           mc_cs, //current state 
    output reg	[7:0]           mc_ns, //next state 
    output reg	[5:0]           or_cs,
    output reg	[5:0]           or_ns,
	

    //output reg	[7:0]           ft_Nt_cnt,
    output reg	[3:0]           nn_layer_cnt,     
	
	output reg	[11:0]          ecg_len,
    
    output reg	[`DDR_AW-1:0]   nn_ecg_saddr,
    output reg	[`DDR_AW-1:0]   nn_wt_saddr,
	output reg	[`DDR_AW-1:0]   nn_lyr_param_saddr
	
    //from   calculating unit
    // input						pe_cal_done_sync
	
    //to    calculating unit
    //output reg					pe_cal_start,   
    //output reg					pe_wt_rst,
    //output reg					pe_ft_lyr_param_done
);

//********************************************************************
//Master control state declarations 
//********************************************************************
    localparam [7:0] IDLE     = 8'd0; // idle state
	localparam [7:0] FT_ADDR  = 8'd1; // wait until memctrl get the address
    localparam [7:0] ECG_UD   = 8'd2; // wait until the ECG is updated
	localparam [7:0] FT_ECG   = 8'd3; // read ECG
    localparam [7:0] FT_PARA  = 8'd4; // read each layer specific parameter
    localparam [7:0] CONV_CAL = 8'd5; // conv cal
    localparam [7:0] LY_DONE  = 8'd6; // end of layer calculation
    localparam [7:0] INF_DONE = 8'd7; // end of a inferrence

//******************************************************************************
// OR dataflow control state declarations 
//*******************************  ***********************************************
    localparam [5:0] OR_IDLE   = 6'd0;
    localparam [5:0] OR_FT_WT  = 6'd1;
    localparam [5:0] OR_CAL    = 6'd2;
    localparam [5:0] OR_DONE   = 6'd3;

//******************************************************************************
// FC dataflow control state declarations 
//******************************************************************************
    // localparam [5:0] FC_IDLE   = 6'd0;
    // localparam [5:0] FC_FT_IFM = 6'd1;
    // localparam [5:0] FC_FT_WT  = 6'd2;
    // localparam [5:0] FC_TX_OFM = 6'd3;
    // localparam [5:0] FC_CAL    = 6'd4;
    // localparam [5:0] FC_DONE   = 6'd5;

	reg						ft_all_addr_done;
    wire					nn_processing_done;    
    wire					layer_processing_done; // pulse 
    wire [7:0]				nn_layer_cnt_nxt;

    wire [7:0]  			ft_Nt_cnt_nxt;
    
	
    reg  [`DDR_AW-1:0]		nn_wt_saddr_reg;   
    reg  [`DDR_AW-1:0]		nn_ecg_saddr_reg;	
    reg  [`DDR_AW-1:0]		nn_lyr_param_saddr_reg;
    reg  [7:0]				nn_layers_num_reg;
    reg  [3:0]				nn_layers_num; 
 
	reg	 [11:0]				ecg_len_reg;
//*******************************************************************
// Master control state machine reset address       
//******************************************************************
	
	
	always @(posedge clk_cal or negedge rst_cal_n)
		if(!rst_cal_n) begin
			//output reset
			nn_wt_saddr         	<= `DDR_AW'b0;  
			nn_ecg_saddr        	<= `DDR_AW'b0;
			nn_lyr_param_saddr  	<= `DDR_AW'b0;
			nn_layers_num       	<= 4'd0;
			ecg_len					<= 12'd0;
			ft_all_addr_done		<= 1'b0;
			
			//reg reset
			nn_wt_saddr_reg         <= `DDR_AW'b11111111;  //3 address needs to modify
			nn_ecg_saddr_reg        <= `DDR_AW'b11111111;
			nn_lyr_param_saddr_reg  <= `DDR_AW'b0;
			nn_layers_num_reg       <= 4'd9;
			ecg_len_reg				<= 12'd3600;
		end
		else begin
			if(memct_init_cmplt && mc_cs[FT_ADDR]) begin
				nn_wt_saddr         <= nn_wt_saddr_reg;
				nn_ecg_saddr        <= nn_ecg_saddr_reg;
				nn_lyr_param_saddr  <= nn_lyr_param_saddr_reg;	
				nn_layers_num 		<= nn_layers_num_reg;
				ecg_len				<= ecg_len_reg;
				ft_all_addr_done	<= 1'b1;
			end
		end
	
	
	
//*******************************************************************
// Master control state machine control signals        
//******************************************************************


    // count the number of layers that having been computed 
    always @(posedge clk_cal or negedge rst_cal_n)
        if(!rst_cal_n) 
            nn_layer_cnt <= 4'b0;
        else
            if(mc_cs[INF_DONE] | mc_cs[IDLE]) //mc_cs[ECG_UD]?
                nn_layer_cnt <= 4'b0001;
            else if (layer_processing_done)
                nn_layer_cnt <= nn_layer_cnt_nxt;

    assign nn_layer_cnt_nxt = nn_layer_cnt < nn_layers_num ? nn_layer_cnt + 1'b1 : 1'b0;
    assign nn_processing_done = (nn_layer_cnt == nn_layers_num) ? 1'b1 : 1'b0; 
    
    assign layer_processing_done = or_cs[OR_CAL]&&or_ns[OR_DONE];
    
    
    
    
//**********************************************************************
// Master control state machine 
//**********************************************************************

    always @(posedge clk_cal or negedge rst_cal_n) 
        if(!rst_cal_n)
            mc_cs <= 8'b1;
        else 
            mc_cs <= mc_ns;

    always @(*) begin
        mc_ns = 8'b0;
        case(1'b1)
            mc_cs[IDLE]     : begin
                if(memct_init_cmplt)
                    mc_ns[FT_ADDR] = 1'b1;
                else
                    mc_ns[IDLE]   = 1'b1;
            end
            mc_cs[FT_ADDR]  : begin
                if(ft_all_addr_done && SPI_start)
                    mc_ns[ECG_UD] = 1'b1;
                else
                    mc_ns[FT_ADDR]  = 1'b1;
            end
            mc_cs[ECG_UD]   : begin 
                if(SPI_done)
					mc_ns[FT_ECG] = 1'b1;
                else 
					mc_ns[ECG_UD] = 1'b1;
            end
            mc_cs[FT_ECG]   : begin
                if(ft_ecg_done)
                    mc_ns[FT_PARA] = 1'b1;
                else
                    mc_ns[FT_ECG] = 1'b1;
            end
            mc_cs[FT_PARA]  : begin
                if(ft_lyr_param_done)
                    mc_ns[CONV_CAL] =1'b1;
                else
                    mc_ns[FT_PARA] = 1'b1;
            end
			mc_cs[CONV_CAL] : begin
                if(layer_processing_done)
                    mc_ns[LY_DONE] =1'b1;
                else
                    mc_ns[CONV_CAL] = 1'b1;
            end
            mc_cs[LY_DONE]  : begin
                if(nn_processing_done)
                    mc_ns[INF_DONE] = 1'b1;
                else
                    mc_ns[FT_PARA] = 1'b1;
            end
            mc_cs[INF_DONE] : begin
                    mc_ns[IDLE] =1'b1;
            end
        endcase
    
    end

     

//******************************************************************************
// Master control state machine output 
//******************************************************************************
/*    always @(posedge clk_cal or negedge rst_cal_n) begin 
        if(!rst_cal_n)
            npu_busy <= 1'b0;
        else if(|mc_ns[6:2])        
            npu_busy <= 1'b1;
        else
            npu_busy <= 1'b0;        
    end

 //作用？
    // to calculating unit
    always @(posedge clk_cal or negedge rst_cal_n)
        if(!rst_cal_n)
            pe_ft_lyr_param_done <= 1'b0;
        else if(mc_ns[FT_PARA] && (mc_cs[FT_ECG]|mc_cs[LY_DONE]))
            pe_ft_lyr_param_done <= 1'b0;
        else if(mc_cs[FT_PARA] && mc_ns[CONV_CAL])
            pe_ft_lyr_param_done <= 1'b1;
 
			
//******************************************************************************
//  dataflow  control signals 
//******************************************************************************
    

// 在mem_ctrl中用于计算从外部ram取weight的次数，在mem_ctrl中仅与mc_cs[OR_FT_WT]
    always @(posedge clk_cal or negedge rst_cal_n)
        if (!rst_cal_n)
            ft_Nt_cnt <= 8'b0;
        else if (or_ns[OR_FT_WT]&&or_cs[OR_IDLE])
            ft_Nt_cnt <= 8'b0;
        else begin
            case(1'b1) 
                !or_cs[OR_IDLE] :
                    if (or_cs[OR_FT_WT]&&or_ns[OR_CAL])
                        ft_Nt_cnt <= ft_Nt_cnt_nxt;
                default         : ft_Nt_cnt <= 8'b0;
            endcase 
        end 
    assign ft_Nt_cnt_nxt = ft_Nt_cnt==Nt_num-1'b1 ? 8'b0 : ft_Nt_cnt+1'b1;

*/



//******************************************************************************
// OR dataflow state machine 
//******************************************************************************

    always @(posedge clk_cal or negedge rst_cal_n)
        if(!rst_cal_n)
            or_cs <= 6'b1;
        else  
            or_cs <= or_ns;

    always @(*) begin
        or_ns = 6'b0;
        case (1'b1)
            or_cs[OR_IDLE]    : begin
                if(mc_cs[CONV_CAL])
                    or_ns[OR_FT_WT]  = 1'b1;
                else 
                    or_ns[OR_IDLE]    = 1'b1;
            end 
            or_cs[OR_FT_WT]   : begin
                if(ft_wt_done)
                    or_ns[OR_CAL]     = 1'b1;
                else
                    or_ns[OR_FT_WT]   = 1'b1;
            end 
            or_cs[OR_CAL]     : begin
				if(lyr_cal_done)
					or_ns[OR_DONE]    = 1'b1;
                else 
                    or_ns[OR_CAL]     = 1'b1;
            end 
            or_cs[OR_DONE]    : begin
                or_ns[IDLE]           = 1'b1;
            end 
        endcase 
    end  

//******************************************************************************
// dataflow FSM output signals  
//******************************************************************************
    
    //to calculating unit 
    // always @(posedge clk_cal or negedge rst_cal_n)
        // if(!rst_cal_n)
            // pe_cal_start <= 1'b0;
        // else if((or_ns[OR_FT_WT]|or_ns[OR_OF])&&or_cs[OR_CAL])
            // pe_cal_start <= 1'b0;
        // else if(or_cs[OR_FT_WT]&&or_ns[OR_CAL])
            // pe_cal_start <= 1'b1;

/*
    always @(posedge clk_cal or negedge rst_cal_n)
        if(!rst_cal_n)
            pe_wt_rst <= 1'b0;
        else if(or_cs[OR_FT_WT]&&or_ns[OR_CAL])
           pe_wt_rst <= 1'b0;
        else if(or_cs[OR_IDLE]&&or_ns[OR_FT_WT])
           pe_wt_rst <= 1'b1; 
*/


endmodule
