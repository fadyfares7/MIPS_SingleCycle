//17 dec, 10;52pm
module PC(clk,In,Out);
input clk;
input[31:0] In;
output[31:0] Out;
reg[31:0] Out;

initial
begin
#0 Out<=0;
end

always @(posedge clk)
Out<=In;
endmodule
