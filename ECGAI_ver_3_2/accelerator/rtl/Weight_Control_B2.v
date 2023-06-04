`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/28 10:18:57
// Design Name: 
// Module Name: Weight_Control_B2
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


module Weight_Control_B2(
    input                clk,
    input                rst_n,
    output   reg [6:0]   w_0, w_1, w_2, w_3, w_4, w_5, w_6, w_7,
    output   reg [15:0]  new_weight_val, //每一个对应一个输出�?�道的存储权重标�?
    output   reg         Weight_Trans_Done
);
wire                enable;
reg     [ 4:0]      addr;
wire    [27:0]      data_o;
reg     [ 4:0]      cnt;
reg                 enable0 ;
//28,也就是每�?个地�?存着4个weight�?16*8*7=32*28
//WeightBuffer_ROM_B2  #(.ADDR_WIDTH(5), .DATA_WIDTH(28),.DATA_DEPTH(32))  WeightBuffer_B2( .clk(clk),  .enable(enable),  .addr(addr),  .data_o(data_o) );
WeightBuffer_ROM_B2_IP WeightBuffer_B2 (
  .clka(clk),    // input wire clka
  .ena(enable),      // input wire ena
  .addra(addr),  // input wire [4 : 0] addra
  .douta(data_o)  // output wire [27 : 0] douta
);

always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        {w_0, w_1, w_2, w_3, w_4, w_5, w_6, w_7} <= 56'b0;
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
        cnt <= 2'b0;
    end
    else if(!enable0)begin
        if(cnt == 2)begin
            cnt <= 1;
        end 
        else begin
            cnt <= cnt + 1;
        end
    end
    else begin
        cnt <= 2'b0;
    end
end



always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        enable0 <= 0;
    end
    else begin
        if(addr == 31)begin
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
        if(cnt == 2)begin
            new_weight_val <= {new_weight_val[14:0], 1'b1};
        end
    end
end


always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        Weight_Trans_Done <= 0;
    end
    else if(cnt == 2 && addr ==0)
        Weight_Trans_Done <= 1;
end




endmodule
