module weight_memory6 #(
    parameter ADDR_WIDTH=11,
    parameter DATA_WIDTH=8,
    parameter DATA_DEPTH=2048
)	(    
    input             clk,
    input             rst_n,
    input             csen,   //片�?�信�?
	
	input	[3:0]	  layer2weight_cnt,		
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
        else if (wrenb == 1'b1 && csen == 1'b1) begin     //写信号有�?
            //register[addr_b] <= data_b;     //写入
			case(layer2weight_cnt)
				//readmem - Synthesis Unsupported Simulation ONLY
				4'h1:$readmemb("E:\\Xilinx\\VivadoProject\\ECGLPDLA_ver1_0\\wt_ver1_0\\layer1\\layer1_bank5.txt",register);
				4'h2:$readmemb("E:\\Xilinx\\VivadoProject\\ECGLPDLA_ver1_0\\wt_ver1_0\\layer2\\layer2_bank5.txt",register);
				4'h3:$readmemb("E:\\Xilinx\\VivadoProject\\ECGLPDLA_ver1_0\\wt_ver1_0\\layer3\\layer3_bank5.txt",register);
				4'h4:$readmemb("E:\\Xilinx\\VivadoProject\\ECGLPDLA_ver1_0\\wt_ver1_0\\layer4\\layer4_bank5.txt",register);
				4'h5:$readmemb("E:\\Xilinx\\VivadoProject\\ECGLPDLA_ver1_0\\wt_ver1_0\\layer5\\layer5_bank5.txt",register);
				4'h6:$readmemb("E:\\Xilinx\\VivadoProject\\ECGLPDLA_ver1_0\\wt_ver1_0\\layer6\\layer6_bank5.txt",register);
				4'h7:$readmemb("E:\\Xilinx\\VivadoProject\\ECGLPDLA_ver1_0\\wt_ver1_0\\gap.txt",register);
				4'h8:$readmemb("E:\\Xilinx\\VivadoProject\\ECGLPDLA_ver1_0\\wt_ver1_0\\layer8\\layer8_bank5.txt",register);
				default:$readmemb("E:\\Xilinx\\VivadoProject\\ECGLPDLA_ver1_0\\wt_ver1_0\\layer1\\layer1_bank5.txt",register);
			endcase
			
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
