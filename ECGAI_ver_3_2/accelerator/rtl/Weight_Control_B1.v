`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/10 09:48:23
// Design Name: 
// Module Name: Weight_Control_B1
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


module Weight_Control_B1(
    input               clk,
    input               rst_n,
    output   reg [6:0]  w_00, w_10, w_20, w_30, w_40, w_50, w_60, w_70,
    output   reg        new_weight_val
);

wire                enable;
reg     [ 1:0]      addr;
wire    [27:0]      data_o;
reg     [ 1:0]      cnt;

//WeightBuffer_ROM_B1  #(.ADDR_WIDTH(2), .DATA_WIDTH(28),.DATA_DEPTH(2))  WeightBuffer_B1(  .clk(clk),  .enable(enable),  .addr(addr),  .data_o(data_o));
WeightBuffer_ROM_B1_IP WeightBuffer_B1(  .clka(clk),  .ena(enable),  .addra(addr),  .douta(data_o));


always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        {w_00, w_10, w_20, w_30, w_40, w_50, w_60, w_70} <= 56'b0;
    end
    else begin
    case(cnt)
        1:
            begin  
                w_00 <= data_o[27:21];
                w_10 <= data_o[20:14];
                w_20 <= data_o[13: 7];
                w_30 <= data_o[ 6: 0];            
            end 
        2:
            begin
                w_40 <= data_o[27:21];
                w_50 <= data_o[20:14];
                w_60 <= data_o[13: 7];
                w_70 <= data_o[ 6: 0];   
            end  
        default:;
    endcase  
    end
end

reg     new_weight_val_e1;
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt <= 2'b0;
        new_weight_val_e1 <= 0;
    end
    else if(cnt < 2) begin
        cnt <= cnt + 1;
    end
    else if(cnt == 2)begin
        cnt <= 2;
        new_weight_val_e1 <= 1; 
    end 
end

reg new_weight_val_e1_d1;
always@(posedge clk)begin
    new_weight_val_e1_d1 <= new_weight_val_e1;
end

assign new_weight_val_e1_e1 = new_weight_val_e1 && !new_weight_val_e1_d1;
always@(posedge clk)begin
    new_weight_val <= new_weight_val_e1_e1;
end

assign  enable = rst_n &&(cnt != 2);



always @(*)begin
    case(cnt)
    0:  addr <= 0;
    1:  addr <= 1;
    default: addr <= 0;
    endcase
end


endmodule
