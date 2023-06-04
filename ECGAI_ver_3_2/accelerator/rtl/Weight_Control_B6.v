`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/08 15:43:36
// Design Name: 
// Module Name: Weight_Control_B6
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Weight_Control_B6(
    input                clk,
    input                rst_n,
    output   reg [6:0]   w_0, w_1, w_2, w_3, w_4, w_5, w_6, w_7, w_8, w_9, w_10, w_11, w_12, w_13, w_14, w_15,
                         w_16, w_17, w_18, w_19, w_20, w_21, w_22, w_23, w_24, w_25, w_26, w_27, w_28, w_29, w_30, w_31,
                         w_32, w_33, w_34, w_35, w_36, w_37, w_38, w_39, w_40, w_41, w_42, w_43, w_44, w_45, 
                         w_46, w_47, w_48, w_49, w_50, w_51, w_52, w_53, w_54, w_55, w_56, w_57, w_58, w_59, w_60, 
                         w_61, w_62, w_63,
    output   reg [4:0]   new_weight_val, //每一个对应一个输出�?�道的存储权重标�?
    output   reg         Weight_Trans_Done
    );

wire                enable;
reg     [ 6:0]      addr;
wire    [27:0]      data_o;
reg     [ 4:0]      cnt;
reg                 enable0 ;
//80,也就是每�?个地�?存着4个weight�?64*5*7=80*28
//WeightBuffer_ROM_B6  #(.ADDR_WIDTH(7), .DATA_WIDTH(28),.DATA_DEPTH(80))  WeightBuffer_B6( .clk(clk),  .enable(enable),  .addr(addr),  .data_o(data_o));
WeightBuffer_ROM_B6_IP WeightBuffer_B6 ( 
  .clka(clk),    // input wire clka
  .ena(enable),      // input wire ena
  .addra(addr),  // input wire [6 : 0] addra
  .douta(data_o)  // output wire [27 : 0] douta
);
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        w_0 <= 0;
        w_1 <= 0; 
        w_2 <= 0; 
        w_3 <= 0; 
        w_4 <= 0; 
        w_5 <= 0; 
        w_6 <= 0; 
        w_7 <= 0; 
        w_8 <= 0; 
        w_9 <= 0; 
        w_10 <= 0; 
        w_11 <= 0; 
        w_12 <= 0; 
        w_13 <= 0; 
        w_14 <= 0; 
        w_15 <= 0; 
        w_16 <= 0; 
        w_17 <= 0; 
        w_18 <= 0; 
        w_19 <= 0; 
        w_20 <= 0; 
        w_21 <= 0; 
        w_22 <= 0; 
        w_23 <= 0; 
        w_24 <= 0; 
        w_25 <= 0; 
        w_26 <= 0; 
        w_27 <= 0; 
        w_28 <= 0; 
        w_29 <= 0; 
        w_30 <= 0; 
        w_31 <= 0; 
        w_32 <= 0; 
        w_33 <= 0; 
        w_34 <= 0; 
        w_35 <= 0; 
        w_36 <= 0; 
        w_37 <= 0; 
        w_38 <= 0; 
        w_39 <= 0; 
        w_40 <= 0; 
        w_41 <= 0; 
        w_42 <= 0; 
        w_43 <= 0; 
        w_44 <= 0; 
        w_45 <= 0; 
        w_46 <= 0; 
        w_47 <= 0; 
        w_48 <= 0; 
        w_49 <= 0; 
        w_50 <= 0; 
        w_51 <= 0; 
        w_52 <= 0; 
        w_53 <= 0; 
        w_54 <= 0; 
        w_55 <= 0; 
        w_56 <= 0; 
        w_57 <= 0; 
        w_58 <= 0; 
        w_59 <= 0; 
        w_60 <= 0; 
        w_61 <= 0; 
        w_62 <= 0; 
        w_63 <= 0; 

    end
    else begin
    case(cnt)
        1:
            begin  
                w_0 <= data_o[27:21];
                w_1 <= data_o[20:14];
                w_2 <= data_o[13: 7];
                w_3 <= data_o[ 6: 0];            
            end 
        2:
            begin
                w_4 <= data_o[27:21];
                w_5 <= data_o[20:14];
                w_6 <= data_o[13: 7];
                w_7 <= data_o[ 6: 0];   
            end
         3:
            begin
                w_8  <= data_o[27:21];
                w_9  <= data_o[20:14];
                w_10 <= data_o[13: 7];
                w_11 <= data_o[ 6: 0];
            end  
          4:
            begin
                w_12  <= data_o[27:21];
                w_13  <= data_o[20:14];
                w_14  <= data_o[13: 7];
                w_15  <= data_o[ 6: 0];
            end
          5:
            begin  
                w_16 <= data_o[27:21];
                w_17 <= data_o[20:14];
                w_18 <= data_o[13: 7];
                w_19 <= data_o[ 6: 0];            
            end 
          6:
            begin  
                w_20 <= data_o[27:21];
                w_21 <= data_o[20:14];
                w_22 <= data_o[13: 7];
                w_23 <= data_o[ 6: 0];            
            end
          7:
            begin  
                w_24 <= data_o[27:21];
                w_25 <= data_o[20:14];
                w_26 <= data_o[13: 7];
                w_27 <= data_o[ 6: 0];            
            end
          8:
            begin  
                w_28 <= data_o[27:21];
                w_29 <= data_o[20:14];
                w_30 <= data_o[13: 7];
                w_31 <= data_o[ 6: 0];            
            end
           9:
            begin  
                w_32 <= data_o[27:21];
                w_33 <= data_o[20:14];
                w_34 <= data_o[13: 7];
                w_35 <= data_o[ 6: 0];            
            end
           10:
            begin  
                w_36 <= data_o[27:21];
                w_37 <= data_o[20:14];
                w_38 <= data_o[13: 7];
                w_39 <= data_o[ 6: 0];            
            end     
           11:
            begin  
                w_40 <= data_o[27:21];
                w_41 <= data_o[20:14];
                w_42 <= data_o[13: 7];
                w_43 <= data_o[ 6: 0];            
            end
           12:
            begin  
                w_44 <= data_o[27:21];
                w_45 <= data_o[20:14];
                w_46 <= data_o[13: 7];
                w_47 <= data_o[ 6: 0];            
            end
           13:
            begin  
                w_48 <= data_o[27:21];
                w_49 <= data_o[20:14];
                w_50 <= data_o[13: 7];
                w_51 <= data_o[ 6: 0];            
            end
           14:
            begin  
                w_52 <= data_o[27:21];
                w_53 <= data_o[20:14];
                w_54 <= data_o[13: 7];
                w_55 <= data_o[ 6: 0];            
            end
           15:
            begin  
                w_56 <= data_o[27:21];
                w_57 <= data_o[20:14];
                w_58 <= data_o[13: 7];
                w_59 <= data_o[ 6: 0];            
            end
            16:
             begin  
                w_60 <= data_o[27:21];
                w_61 <= data_o[20:14];
                w_62 <= data_o[13: 7];
                w_63 <= data_o[ 6: 0];            
            end                                  
        default:;
    endcase  
    end
end

always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        addr <= 0;
    end
    else begin
        if(!enable0)
            addr <= addr + 1;
        else
            addr <= 0;        
    end
end

always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt <= 0;
    end
    else if(!enable0)begin
        if(cnt == 16)begin
            cnt <= 1;
        end 
        else begin
            cnt <= cnt + 1;
        end
    end
    else begin
        cnt <= 0;
    end
end



always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        enable0 <= 0;
    end
    else begin
        if(addr == 79)begin
            enable0 <= 1;
        end
    end    

end
assign enable = rst_n ^ enable0;

//*******************************************给PE的输出信�?*****************************
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        new_weight_val <= 0;
    end
    else begin
        if(cnt == 16)begin
            new_weight_val <= {new_weight_val[3:0], 1'b1};
        end
    end
end


always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        Weight_Trans_Done <= 0;
    end
    else if(cnt == 16 && addr ==80)
        Weight_Trans_Done <= 1;
end   
endmodule
