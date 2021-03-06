// zero extenders and sign extenders for 8 bit and 16 bit
// the data memory here can handle the halfword and byte loading/storing internally

module Data_memory (address, data_in, mem_read, mem_write, half_word_mode, byte_mode, unsigned_mode, data_out, clk);

input [31:0] address;
input [31:0] data_in;
input mem_read;
input mem_write;
input half_word_mode;
input byte_mode;
input unsigned_mode;
input clk;

output [31:0] data_out;

reg [7:0] DataMemory[0:1023]; // DataMemory of 1Byte wide and 1024 byte depth which is 1KB memory
reg [31:0] data_out;

always @(posedge clk)
begin
 if (mem_write & !mem_read) // Check wether we are writing the memory
	begin
		#2
		if (!half_word_mode & !byte_mode) // check wether we are writing a 32_bit word or otherwise 
			begin   
                              //writing in the memory

				DataMemory[address] = data_in[31:24];  
				DataMemory[address + 1] = data_in[23:16];
				DataMemory[address + 2] = data_in[15:8];
				DataMemory[address + 3] = data_in[7:0];
			end
		
		else if (half_word_mode & !byte_mode) // check wether we are writing a 16_bit halfword or otherwise
			begin
				/* the next lines of code will put the two bytes in the rightmost
  				   half of data_in into two consecutive bytes in the byte-addressed
                                   memory */
				
				DataMemory[address] = data_in[15:8];
				DataMemory[address+1] = data_in[7:0];
			end
		
		else if (!half_word_mode & byte_mode) // check wether we are writing an 8_bit byte or otherwise
			begin
				/* the next lines of code will put the rightmost byte in data_in in the
				   memory place referred to by address */
				
				DataMemory[address] = data_in[7:0];
			end
		else // this is a forbidden case scenario //

			begin
	           
			end
 	end
end







always @ (mem_write or mem_read or half_word_mode or byte_mode or unsigned_mode or address or data_in)
begin


if (!mem_write & mem_read) // checks wether we are reading the memory
	begin
		#2
		if (!half_word_mode & !byte_mode) // check wether we are reading a word
			begin
				/* the next lines of code will read the contents of
				   four consecutive bytes in memory starting from the location
				   address into the 32_bit data_out port */
			
				data_out[31:24] = DataMemory[address];
				data_out[23:16] = DataMemory[address + 1];
				data_out[15:8] = DataMemory[address + 2];
				data_out[7:0] = DataMemory[address + 3];
			end
		
		else if (half_word_mode & !byte_mode) // check wether we are reading halfword
			begin
				if (!unsigned_mode)
					begin
						/* the next chunk of code will take a halfword from the
						    memory and sign extends them into 32_bit width and put them
						    in the rightmost half of data_out */
				
						data_out = {{16{DataMemory[address+1][7]}}, {DataMemory[address], DataMemory[address + 1]}};
					end					
                                else 
					begin
						data_out = {16'b0, {DataMemory[address], DataMemory[address + 1]}}; 
			 		end
		 	end
		
		else if (!half_word_mode & byte_mode) // check wether we are reading a byte
			begin 
                                if (!unsigned_mode)
					begin
						/* the next lines of code will take a halfword from the
						    memory and sign extends them into 32_bit width and put them
						    in the rightmost half of data_out */
				
						data_out = {{24{DataMemory[address][7]}}, DataMemory[address]};

							
					end					
                                else 
					begin
					        data_out = {24'b0, DataMemory[address]}; 
			 		end
			end

		else // this is a forbiddn scenario //
			begin 
						
			end
		
	end
end
endmodule
