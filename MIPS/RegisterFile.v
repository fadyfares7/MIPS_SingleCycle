
module register_file(
	read_data1,		// First data read out
	read_data2,		// second data read out
	read_register1,	        // First reg address
	read_register2,		// second reg address
	write_register,		// Write address
	write_data,		// write data in
	reg_write,              // 1-bit control signal
	clock);			// clock
	
	// Initiallization
	input[4:0]  read_register1, read_register2, write_register;   // address is 5 bit wide
	input[31:0] write_data;					      // data is 32 bit wide
	input 	    reg_write, clock;

	output[31:0] read_data1, read_data2;

	reg[31:0] read_data1, read_data2;
	reg[31:0] register[0:31];         // mips registers


	initial
	begin
		register[0]=0;  // reister0==0
	end

	//reading the required registers' values and assigning them to the outputs.
	always @( * )
	begin
		#1
		read_data1 <= register[read_register1];
		read_data2 <= register[read_register2];
	end
	
	//writing the write data to the required register.
	always @(posedge clock)				                         //writing process happens at the posedge of the next instruction.
	begin
		if(reg_write && write_register)                                 // register $zero value won't/can't be changed.
			#1 register[write_register] <= write_data;
	end


endmodule

