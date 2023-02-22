
`timescale 1 ns / 1 ps

	module axi_lite_v1_0_S00_AXI #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line

		// Width of S_AXI data bus
		parameter integer C_S_AXI_DATA_WIDTH	= 32,
		// Width of S_AXI address bus
		parameter integer C_S_AXI_ADDR_WIDTH	= 5
	)
	(
		// Users to add ports here

		input  [7:0]			FC_OMap1,
		input  [3:0]			nn_layer_cnt,
		input					FC_OVld,
		output	reg				SPI_start,
		input  wire [7:0]           weight_data_O0,
		input  wire [7:0]           weight_data_O1,
		input  wire [13:0]          wt_I_addr_sf,
		input  wire [8:0]		wr_addr_sf,
		input  wire [7:0]       IOB_Data_O0_sf,
		input  wire [7:0]       IOB_Data_O1_sf,
		input  wire   [13:0]     wt_C0_addr_sf,
		input  wire   [13:0]     wt_C1_addr_sf,
		input  wire   [8:0]      rd_addr_sf,
		input  wire             SPI_start_temp,
        input  [7:0] sf_addr_reg0,
        input  [7:0] sf_addr_reg1,
        input  [7:0] sf_addr_reg2,
        input  [7:0] sf_addr_reg3,
        input  [7:0] sf_addr_reg4,
        
        input  [7:0] sf_reg0,
        input  [7:0] sf_reg1,
        input  [7:0] sf_reg2,
        input  [7:0] sf_reg3,
        input  [7:0] sf_reg4,
        
                input  [7:0] sf_maddr_reg0,
        input  [7:0] sf_maddr_reg1,
        input  [7:0] sf_maddr_reg2,
        input  [7:0] sf_maddr_reg3,
        input  [7:0] sf_maddr_reg4,
        
        input  [7:0] sf_mreg0,
        input  [7:0] sf_mreg1,
        input  [7:0] sf_mreg2,
        input  [7:0] sf_mreg3,
        input  [7:0] sf_mreg4,
        
        input enable_rise_reg,
        input enable_rise,
        input wait_tran,
        input final_flag,
        input tran_start,
        
        
		// User ports ends
		
		// Do not modify the ports beyond this line

		// Global Clock Signal
		input wire  S_AXI_ACLK,
		// Global Reset Signal. This Signal is Active LOW
		input wire  S_AXI_ARESETN,
		// Write address (issued by master, acceped by Slave)
		input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_AWADDR,
		// Write channel Protection type. This signal indicates the
    		// privilege and security level of the transaction, and whether
    		// the transaction is a data access or an instruction access.
		input wire [2 : 0] S_AXI_AWPROT,
		// Write address valid. This signal indicates that the master signaling
    		// valid write address and control information.
		input wire  S_AXI_AWVALID,
		// Write address ready. This signal indicates that the slave is ready
    		// to accept an address and associated control signals.
		output wire  S_AXI_AWREADY,
		// Write data (issued by master, acceped by Slave) 
		input wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_WDATA,
		// Write strobes. This signal indicates which byte lanes hold
    		// valid data. There is one write strobe bit for each eight
    		// bits of the write data bus.    
		input wire [(C_S_AXI_DATA_WIDTH/8)-1 : 0] S_AXI_WSTRB,
		// Write valid. This signal indicates that valid write
    		// data and strobes are available.
		input wire  S_AXI_WVALID,
		// Write ready. This signal indicates that the slave
    		// can accept the write data.
		output wire  S_AXI_WREADY,
		// Write response. This signal indicates the status
    		// of the write transaction.
		output wire [1 : 0] S_AXI_BRESP,
		// Write response valid. This signal indicates that the channel
    		// is signaling a valid write response.
		output wire  S_AXI_BVALID,
		// Response ready. This signal indicates that the master
    		// can accept a write response.
		input wire  S_AXI_BREADY,
		// Read address (issued by master, acceped by Slave)
		input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_ARADDR,
		// Protection type. This signal indicates the privilege
    		// and security level of the transaction, and whether the
    		// transaction is a data access or an instruction access.
		input wire [2 : 0] S_AXI_ARPROT,
		// Read address valid. This signal indicates that the channel
    		// is signaling valid read address and control information.
		input wire  S_AXI_ARVALID,
		// Read address ready. This signal indicates that the slave is
    		// ready to accept an address and associated control signals.
		output wire  S_AXI_ARREADY,
		// Read data (issued by slave)
		output wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_RDATA,
		// Read response. This signal indicates the status of the
    		// read transfer.
		output wire [1 : 0] S_AXI_RRESP,
		// Read valid. This signal indicates that the channel is
    		// signaling the required read data.
		output wire  S_AXI_RVALID,
		// Read ready. This signal indicates that the master can
    		// accept the read data and response information.
		input wire  S_AXI_RREADY,
		//output reg [31:0] a ,//t use
		//output reg [31:0] a1 //t use
		output wire [7:0] read1,
		output wire [7:0] read2,	
		input wire  [31:0] SF_FC_REG1,
		input wire  [31:0] SF_FC_REG2,
		input wire  [31:0] SF_FC_REG3,
		input wire  [31:0] SF_FC_REG4,
        input wire  [7:0] SF_FC_REG5,        
        output wire Enable_trans,
        input wire  Busy,
        output reg [7:0] w_weight
		
		
	);

	// AXI4LITE signals
	reg [C_S_AXI_ADDR_WIDTH-1 : 0] 	axi_awaddr;
	reg  	axi_awready;
	reg  	axi_wready;
	reg [1 : 0] 	axi_bresp;
	reg  	axi_bvalid;
	reg [C_S_AXI_ADDR_WIDTH-1 : 0] 	axi_araddr;
	reg  	axi_arready;
	reg [C_S_AXI_DATA_WIDTH-1 : 0] 	axi_rdata;
	reg [1 : 0] 	axi_rresp;
	reg  	axi_rvalid;

	// Example-specific design signals
	// local parameter for addressing 32 bit / 64 bit C_S_AXI_DATA_WIDTH
	// ADDR_LSB is used for addressing 32/64 bit registers/memories
	// ADDR_LSB = 2 for 32 bits (n downto 2)
	// ADDR_LSB = 3 for 64 bits (n downto 3)
	localparam integer ADDR_LSB = (C_S_AXI_DATA_WIDTH/32) + 1;
	localparam integer OPT_MEM_ADDR_BITS = 2;
	//----------------------------------------------
	//-- Signals for user logic register space example
	//------------------------------------------------
	//-- Number of Slave Registers 6
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg0;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg1;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg2;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg3;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg4;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg5;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg6;
	wire	 slv_reg_rden;
	wire	 slv_reg_wren;
	reg [C_S_AXI_DATA_WIDTH-1:0]	 reg_data_out;
	integer	 byte_index;
	reg	 aw_en;

	// I/O Connections assignments

	assign S_AXI_AWREADY	= axi_awready;
	assign S_AXI_WREADY	= axi_wready;
	assign S_AXI_BRESP	= axi_bresp;
	assign S_AXI_BVALID	= axi_bvalid;
	assign S_AXI_ARREADY	= axi_arready;
	assign S_AXI_RDATA	= axi_rdata;
	//assign a = axi_rdata;  //testbench use
	assign S_AXI_RRESP	= axi_rresp;
	assign S_AXI_RVALID	= axi_rvalid;
	// Implement axi_awready generation
	// axi_awready is asserted for one S_AXI_ACLK clock cycle when both
	// S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_awready is
	// de-asserted when reset is low.

/////////////////////////////////////test use//////////////////////////////////////////////////

reg spi_s;

reg [15:0]spi_cnt;
 ///////////////////////////////////////////////////////////////////////////////////   




	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_awready <= 1'b0;
	      aw_en <= 1'b1;
	    end 
	  else
	    begin    
	      if (~axi_awready && S_AXI_AWVALID && S_AXI_WVALID && aw_en)
	        begin
	          // slave is ready to accept write address when 
	          // there is a valid write address and write data
	          // on the write address and data bus. This design 
	          // expects no outstanding transactions. 
	          axi_awready <= 1'b1;
	          aw_en <= 1'b0;
	        end
	        else if (S_AXI_BREADY && axi_bvalid)
	            begin
	              aw_en <= 1'b1;
	              axi_awready <= 1'b1;    //sf ago =0
	            end
	      else           
	        begin
	          axi_awready <= 1'b1;    //sf ago =0
	        end
	    end 
	end       

	// Implement axi_awaddr latching
	// This process is used to latch the address when both 
	// S_AXI_AWVALID and S_AXI_WVALID are valid. 

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_awaddr <= 0;
	    end 
	  else
	    begin    
	      if (~axi_awready && S_AXI_AWVALID && S_AXI_WVALID && aw_en)
	        begin
	          // Write Address latching 
	          axi_awaddr <= S_AXI_AWADDR;
	        end
	    end 
	end       

	// Implement axi_wready generation
	// axi_wready is asserted for one S_AXI_ACLK clock cycle when both
	// S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_wready is 
	// de-asserted when reset is low. 

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_wready <= 1'b0;
	    end 
	  else
	    begin    
	      if (~axi_wready && S_AXI_WVALID && S_AXI_AWVALID && aw_en )
	        begin
	          // slave is ready to accept write data when 
	          // there is a valid write address and write data
	          // on the write address and data bus. This design 
	          // expects no outstanding transactions. 
	          axi_wready <= 1'b1;
	        end
	      else
	        begin
	          axi_wready <= 1'b1;     //sf ago =0    
	        end
	    end 
	end       

	// Implement memory mapped register select and write logic generation
	// The write data is accepted and written to memory mapped registers when
	// axi_awready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted. Write strobes are used to
	// select byte enables of slave registers while writing.
	// These registers are cleared when reset (active low) is applied.
	// Slave register write enable is asserted when valid address and data are available
	// and the slave is ready to accept the write address and write data.
	assign slv_reg_wren = axi_wready && S_AXI_WVALID && axi_awready && S_AXI_AWVALID;
    reg busy1;
	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      slv_reg0 <= 32'd0;
	      busy1 <= 0;
	      // slv_reg1 <= 0;
	      // slv_reg2 <= 0;
	      // slv_reg3 <= 0;
	      // slv_reg4 <= 0;
	      // slv_reg5 <= 0;
	    end 
	  else begin
	    if (slv_reg_wren)
	      begin
	        busy1 <= 1;
	        case ( axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] )
	          3'h0:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 0
	                slv_reg0[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          // 3'h1:
	            // for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              // if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 1
	                // slv_reg1[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              // end  
	          // 3'h2:
	            // for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              // if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 2
	                // slv_reg2[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              // end  
	          // 3'h3:
	            // for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              // if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 3
	                // slv_reg3[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              // end  
	          // 3'h4:
	            // for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              // if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 4
	                // slv_reg4[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              // end  
	          // 3'h5:
	            // for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              // if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 5
	                // slv_reg5[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              // end  
	          default : begin
	                      slv_reg0 <= slv_reg0;
	                      // slv_reg1 <= slv_reg1;
	                      // slv_reg2 <= slv_reg2;
	                      // slv_reg3 <= slv_reg3;
	                      // slv_reg4 <= slv_reg4;
	                      // slv_reg5 <= slv_reg5;
	                    end
	        endcase
	      end
	      else begin
	         if(enable_rise_reg)
	           slv_reg0 <= {29'd0,2'b0,1'b1};
	         else if(enable_rise)
	           slv_reg0 <= {29'd0,3'b111}; 	
	        else if(tran_start)
                slv_reg0 <= {28'd0,3'd4,1'b1};      
	          end
	  end
	end    

	// Implement write response logic generation
	// The write response and response valid signals are asserted by the slave 
	// when axi_wready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted.  
	// This marks the acceptance of address and indicates the status of 
	// write transaction.

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_bvalid  <= 0;
	      axi_bresp   <= 2'b0;
	    end 
	  else
	    begin    
	      if (axi_awready && S_AXI_AWVALID && ~axi_bvalid && axi_wready && S_AXI_WVALID)
	        begin
	          // indicates a valid write response is available
	          axi_bvalid <= 1'b1;
	          axi_bresp  <= 2'b0; // 'OKAY' response 
	        end                   // work error responses in future
	      else
	        begin
	          if (S_AXI_BREADY && axi_bvalid) 
	            //check if bready is asserted while bvalid is high) 
	            //(there is a possibility that bready is always asserted high)   
	            begin
	              axi_bvalid <= 1'b0; 
	            end  
	        end
	    end
	end   

	// Implement axi_arready generation
	// axi_arready is asserted for one S_AXI_ACLK clock cycle when
	// S_AXI_ARVALID is asserted. axi_awready is 
	// de-asserted when reset (active low) is asserted. 
	// The read address is also latched when S_AXI_ARVALID is 
	// asserted. axi_araddr is reset to zero on reset assertion.

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_arready <= 1'b0;
	      axi_araddr  <= 32'b0;
	    end 
	  else
	    begin    
	      if (~axi_arready && S_AXI_ARVALID)
	        begin
	          // indicates that the slave has acceped the valid read address
	          axi_arready <= 1'b1;
	          // Read address latching
	          axi_araddr  <= S_AXI_ARADDR;
	        end
	      else
	        begin
	          axi_arready <= 1'b0;
	        end
	    end 
	end       

	// Implement axi_arvalid generation
	// axi_rvalid is asserted for one S_AXI_ACLK clock cycle when both 
	// S_AXI_ARVALID and axi_arready are asserted. The slave registers 
	// data are available on the axi_rdata bus at this instance. The 
	// assertion of axi_rvalid marks the validity of read data on the 
	// bus and axi_rresp indicates the status of read transaction.axi_rvalid 
	// is deasserted on reset (active low). axi_rresp and axi_rdata are 
	// cleared to zero on reset (active low).  
	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_rvalid <= 0;
	      axi_rresp  <= 0;
	    end 
	  else
	    begin    
	      if (axi_arready && S_AXI_ARVALID && ~axi_rvalid)
	        begin
	          // Valid read data is available at the read data bus
	          axi_rvalid <= 1'b1;
	          axi_rresp  <= 2'b0; // 'OKAY' response
	        end   
	      else if (axi_rvalid && S_AXI_RREADY)
	        begin
	          // Read data is accepted by the master
	          axi_rvalid <= 1'b0;
	        end                
	    end
	end    

	// Implement memory mapped register select and read logic generation
	// Slave register read enable is asserted when valid address is available
	// and the slave is ready to accept the read address.
	assign slv_reg_rden = axi_arready & S_AXI_ARVALID & ~axi_rvalid;
	always @(*)
	begin
	      // Address decoding for reading registers
	      case ( axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] )
	        3'h0   : reg_data_out <= slv_reg0;
	        3'h1   : reg_data_out <= slv_reg1;
	        3'h2   : reg_data_out <= slv_reg2;
	        3'h3   : reg_data_out <= slv_reg3;
	        3'h4   : reg_data_out <= slv_reg4;
	        3'h5   : reg_data_out <= slv_reg5;
			3'h6   : reg_data_out <= slv_reg6;
	        default : reg_data_out <= 0;
	      endcase
	end

	// Output register or memory read data
	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_rdata  <= 0;
	    end 
	  else
	    begin    
	      // When there is a valid read address (S_AXI_ARVALID) with 
	      // acceptance of read address by the slave (axi_arready), 
	      // output the read dada 
	      if (slv_reg_rden)
	        begin
	          axi_rdata <= reg_data_out;     // register read data
	        end   
	    end
	end    

	// Add user logic here
	
	assign Enable_trans = slv_reg0[1];
	always @(posedge S_AXI_ACLK)begin
		if(S_AXI_ARESETN == 1'b0)begin 
			SPI_start <= 1'b0;
			//Enable_trans <= 0;
			w_weight <= 0;
			end
		else begin
			SPI_start <= slv_reg0[0];
			//Enable_trans <= slv_reg0[1];       
			w_weight <= slv_reg0[31:24];
			end
			end

	wire [4:0] ecg_finish;
	assign ecg_finish = {nn_layer_cnt,FC_OVld};
	
	//*********************************************************************************
	 reg [17:0] acc_cnt;
       always @(posedge S_AXI_ACLK)begin
        if(S_AXI_ARESETN == 1'b0) begin
            acc_cnt <= 18'b0;
        end
        else if(SPI_start)begin
            acc_cnt <= acc_cnt+1;//ecg_finish;
        end
        end
    //*********************************************************************************
	always @(posedge S_AXI_ACLK)
		if(S_AXI_ARESETN == 1'b0) begin
			slv_reg6 <= 32'b0;
			slv_reg5 <= 0;
			slv_reg4 <= 0;
			slv_reg3 <= 0;
			slv_reg2 <= 0;
			slv_reg1 <= 0;
		end
		else begin
			slv_reg6 <= 0;//{10'd0,acc_cnt,nn_layer_cnt};//ecg_finish  without acc count && layer count
			slv_reg5 <= {24'd0,SF_FC_REG5};//{sf_reg0,sf_reg1,sf_reg2,sf_reg3};    //weight view0
			slv_reg4 <= SF_FC_REG4;//{sf_addr_reg0,sf_addr_reg1,sf_addr_reg2,sf_addr_reg3};   //map view
			slv_reg3 <= SF_FC_REG3;    //weight view1
			slv_reg2 <= SF_FC_REG2;    //
			slv_reg1 <= SF_FC_REG1; 
		end
	
	reg [2:0] reg_cnt;
	(* DONT_TOUCH = 1|1 *) reg [1:0] byte_cnt;
	reg [3:0] wait_7clk;
	always @(posedge S_AXI_ACLK)
		if(S_AXI_ARESETN == 1'b0) begin
			//slv_reg1 <= 32'b0;
			//slv_reg2 <= 32'b0;
			//slv_reg3 <= 32'b0;
			//slv_reg4 <= 32'b0;
			//slv_reg5 <= 32'b0;
			reg_cnt  <= 3'b0;
			byte_cnt <= 2'b0;
			wait_7clk<= 3'b0;
		end
		else begin
			if (ecg_finish == 5'b10011)begin
				case ( reg_cnt )
				  3'h0:
					  if ( byte_cnt <= 2'b11 ) begin
						//slv_reg1[(byte_cnt*8) +: 8] <= FC_OMap1;
						byte_cnt <= byte_cnt + 1'b1;
						if(byte_cnt == 2'b11)
							reg_cnt <= reg_cnt + 1'b1;
					  end  
				  3'h1:
					  if ( byte_cnt <= 2'b11 ) begin
						//slv_reg2[(byte_cnt*8) +: 8] <= FC_OMap1;
						byte_cnt <= byte_cnt + 1'b1;
						if(byte_cnt == 2'b11)
							reg_cnt <= reg_cnt + 1'b1;
					  end  
				  3'h2:
					  if ( byte_cnt <= 2'b11 ) begin
						//slv_reg3[(byte_cnt*8) +: 8] <= FC_OMap1;
						byte_cnt <= byte_cnt + 1'b1;
						if(byte_cnt == 2'b11)
							reg_cnt <= reg_cnt + 1'b1;
					  end  
				  3'h3:
					  if ( byte_cnt <= 2'b11 ) begin
						//slv_reg4[(byte_cnt*8) +: 8] <= FC_OMap1;
						byte_cnt <= byte_cnt + 1'b1;
						if(byte_cnt == 2'b11)
							reg_cnt <= reg_cnt + 1'b1;
					  end  
				  3'h4:begin
						//slv_reg5[7:0] <= FC_OMap1;
						reg_cnt <= reg_cnt + 1'b1;
					   end  
				  3'h5:begin
						wait_7clk <= wait_7clk + 1'b1;
						if(wait_7clk == 4'd6)begin
							reg_cnt <= 0;
							wait_7clk <= 0;
							byte_cnt <=0;
						end
				  end 					   
				  default : begin
							   //slv_reg0 <= slv_reg0;
							  //slv_reg1 <= slv_reg1;
							  //slv_reg2 <= slv_reg2;
							  //slv_reg3 <= slv_reg3;
							  //slv_reg4 <= slv_reg4;
							 // slv_reg5 <= slv_reg5;
							end
				endcase
			end
			else begin
							  //slv_reg1 <= slv_reg1;
							  //slv_reg2 <= slv_reg2;
							  //slv_reg3 <= slv_reg3;
							  //slv_reg4 <= slv_reg4;
							 // slv_reg5 <= slv_reg5;
			end
		end
	// User logic ends


always@(posedge S_AXI_ACLK or negedge S_AXI_ARESETN )begin
    if(!S_AXI_ARESETN)
        spi_s<=0;
    else if(SPI_start)
        spi_s<=1;
    end
always@(posedge S_AXI_ACLK or negedge S_AXI_ARESETN )begin
    if(!S_AXI_ARESETN)
        spi_cnt<=0;
    else if(spi_cnt==16'd511)
        spi_cnt<=0;
    else if(SPI_start)
        spi_cnt<=spi_cnt+1;
    end
//******************************************************************************************************
// blk_mem_gen_10 weight_memory10 (.clka(S_AXI_ACLK),    .ena(1'b0),    .wea(0),    .addra(0),    .dina(8'b0    ),    .clkb(S_AXI_ACLK),    .enb(spi_s),    .addrb(spi_cnt),    .doutb(read1)    );
// blk_mem_gen_9 weight_memory9 (.clka(S_AXI_ACLK),    .ena(1'b0),    .wea(0),    .addra(0),    .dina(8'b0    ),    .clkb(S_AXI_ACLK),    .enb(spi_s),    .addrb(wt_I_addr_sf),    .doutb(read2)    );
 //*****************************************************************************************************

	endmodule
