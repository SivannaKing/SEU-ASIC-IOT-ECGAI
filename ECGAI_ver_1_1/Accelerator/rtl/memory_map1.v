module memory_map1 #(
    parameter ADDR_WIDTH=13,
    parameter DATA_WIDTH=8,
    parameter DATA_DEPTH=1024
)(    
    input             clk,
    input             rst_n,
    input             csen,   //片�?�信�?
	input			SPI_start,			
    //port A signal
    input      [ ADDR_WIDTH-1:0] addr_a,    //读地�?
    input      rdena,         //读信�?    
    output     reg [ DATA_WIDTH-1:0] data_a,

    //port B signal
    input      [ ADDR_WIDTH-1:0] addr_b,    //写地�?
    input      wrenb,         //写信�?    
    input      [ DATA_WIDTH-1:0] data_b
);
	
integer i;
(* ram_style = "block" *)reg [DATA_WIDTH-1:0]    register [DATA_DEPTH-1:0];  //定义�?个深度为16，位宽为8的存储器

always @(posedge clk or negedge rst_n) begin
        if (rst_n == 1'b0) begin             //初始�?
            for(i=0; i<DATA_DEPTH;i=i+1) begin
            register[i] <= 8'b0000_0000;
            end
        end
		else if(SPI_start == 1'b1) begin
			//readmem - Synthesis Unsupported Simulation ONLY
			$readmemb("E:\\Xilinx\\VivadoProject\\ECGLPDLA_ver1_0\\input_data\\bank0.txt",register);		
		end
        else if (wrenb == 1'b1 && csen == 1'b1 && SPI_start == 1'b0) begin     //写信号有�?
            register[addr_b] <= data_b;     //写入
    end
end

always @(posedge clk or negedge rst_n) begin
        if(rst_n == 1'b0) begin           //输出初始�?
            data_a <= 8'h0;
        end
        else if (rdena == 1'b1 && csen == 1'b1) begin    //读信号有�?
            data_a <= register[addr_a];     //读出
        end
        else begin
            data_a <= 0;
        end
end


endmodule
