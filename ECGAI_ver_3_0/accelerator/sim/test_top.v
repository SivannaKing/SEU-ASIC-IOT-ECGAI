`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/01 20:46:06
// Design Name: 
// Module Name: test_top
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


module test_top(

    );
    
    parameter clk_period = 5;
        
    reg clk, rst_n;
    reg start;
    
    wire done;
    wire [4:0] classout;
        
        // ================ generate clk =================//
        
        initial begin
            clk = 1'b0;
            forever begin
                #2.5 clk = ~clk;
            end
        end
        
        //================== generate rst_n ==============//
        
        initial begin
            rst_n = 1'b1;
            #(clk_period/2) rst_n = 1'b0;
            #(clk_period/2) rst_n = 1'b1;
        end
    
        //================== DUT =======================//
        
        initial begin
            start = 1'b0;
            #(clk_period+clk_period/2) start = 1'b1;
        end
        
        ecg_bnn_top u_ecg_bnn_top(
            .clk(clk),
            .rst_n(rst_n),
            .ecg_rd_done(start),
            .done(done),
            .classout(classout)
        );
        
        
endmodule
