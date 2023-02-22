// *****************************************************************************
// @Project Name : ECG_CPU 
// @Author       : Huangjunguang
// @Email        : huangjunguang@seu.edu.cn
// @File Name    : u_PE.v
// @Module Name  : u_PE
// @Created Time : 2020-05-21 12:46
//
// @Abstract     :             
//               
//
// Modification History
// ******************************************************************************
// Date				BY           Version         Change Description
// -------------------------------------------------------------------------
// 2020-05-21  	Huangjunguang      v1.0          initial version 
// 2020-06-03	Huangjunguang      v2.0			 change  the way to cut off
// 2020-06-08	Huangjunguang      v2.0			 change K to Calcycle
// ******************************************************************************


`timescale 1ns/1ns
`define byte_width 8
`define halfword_width 16

module u_PE(
	input         				            clk_cal, 
	input 					                rst_cal_n,
	input  		[`byte_width-1:0] 	        IWeight, IMap,
	input         				            ImapVld,IweightVld, INextPE_OMapVld,
	input  		[10:0] 			            Calcycle,//= K*K*IChannel 
	input		[`halfword_width-1:0]	    INextPE_OMap,	
	output 	    [`halfword_width-1:0] 	    OMap, 
	output 		[`byte_width-1:0] 	        ONextPE_Map,
	output        				            OMapVld, ONextPE_MapVld//ONextPE_WeightVld
    );

	        reg [`halfword_width-1:0]	    INextPE_OMap_R;
	        reg             		        IMapVld_R;
	
	        wire 		                    I_CalDataVld;	
	assign 		I_CalDataVld = ImapVld & IweightVld;

	        reg [10:0]                      MultiCount;
    	    wire[`halfword_width-1:0]       Multi,PEsum,data_B;
    	    wire[`halfword_width-1:0]       Sum_a;
	        wire[`halfword_width-1:0]       Sum_m;
	        reg [`halfword_width-1:0]       data_B_R;
	
	//IMap * IWeight
    	//TTopLevel6288b TTopLevel6288b(.A(IMap), .B(IWeight), .P(Sum_m));
	//call_adder call_adder_insid(.I_CalDataVld(I_CalDataVld),.data_A(Multi), .data_B(data_B), .Sum_adder(Sum_a));
	mult1 mult1(.a(IMap),.b(IWeight),.data_out(Sum_m));
	RCA_8bit RCA_8bit(.A(Multi),.B(data_B),.out(Sum_a));
    
    assign data_B = data_B_R;
	assign Multi = (I_CalDataVld == 1'b1)? Sum_m : 16'b0;
	assign PEsum = (I_CalDataVld == 1'b1)? Sum_a: 16'b0;

	reg [`byte_width-1:0] ONextPE_Map_R;
	wire      sendflag,send_sel;
	
	assign sendflag=(MultiCount == (Calcycle-1) || INextPE_OMapVld==1)?1'b1:0;
	assign send_sel=(MultiCount == (Calcycle-1))?1'b1:0;
	assign OMap = (send_sel == 1&& sendflag==1'b1)? PEsum : INextPE_OMap_R;

	assign OMapVld = sendflag;
	
	assign ONextPE_MapVld = (IMapVld_R)?1'b1:0;
	assign ONextPE_Map=(ONextPE_MapVld==1'b1)?ONextPE_Map_R:0;
	
	
	always@(negedge rst_cal_n or posedge clk_cal ) begin
		if(!rst_cal_n) begin
			IMapVld_R         <= 0;
			ONextPE_Map_R     <= 8'b0;
		end
		else begin	
		    if(I_CalDataVld)begin
               		   IMapVld_R      <= 1'b1;
			   ONextPE_Map_R  <= IMap;
		    end
		    else begin
				IMapVld_R     <= 0;
				ONextPE_Map_R <= 8'b0;
		    end 
        	end						  
	end 

	always@(negedge rst_cal_n or posedge clk_cal ) begin
		if(!rst_cal_n)begin
			INextPE_OMap_R <= 0;
		end
		else begin
			if(sendflag==1'b1)begin
				INextPE_OMap_R <= INextPE_OMap;
			end
			else begin
				INextPE_OMap_R <= 0;
			end
		end
	end
	
	always@(negedge rst_cal_n or posedge clk_cal )
	begin
		if(!rst_cal_n)begin
			MultiCount <= 0;
            		data_B_R<=0;
		end
		else begin
			if(I_CalDataVld)begin 	
				MultiCount <= MultiCount + 1;	
				data_B_R <= PEsum;								
				if(MultiCount == (Calcycle-1)) begin
					MultiCount <= 0;
					data_B_R <= 0;
				end							
			end 
			// else begin
				// MultiCount <= 0;
			// end 							

		end	
	end

 
endmodule
