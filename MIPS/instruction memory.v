module instructionMem(address,data_out);
input [31:0] address;
output[31:0] data_out;
reg [7:0] InstructionMemory [0:1023]; // memory wide is 1 Byte and 1024 depth means 1kB memory

assign #2 data_out[31:24] = InstructionMemory[address]; // put the most 8bits from the memory in the most 8bits of data_out
assign #2 data_out[23:16] = InstructionMemory[address+1]; // +1 means the next 8bits address
assign #2 data_out[15:8] = InstructionMemory[address+2];
assign #2 data_out[7:0] = InstructionMemory[address+3];

initial begin
$readmemb("memory.list",InstructionMemory); // reading from the memory.list file in binary
end
endmodule
