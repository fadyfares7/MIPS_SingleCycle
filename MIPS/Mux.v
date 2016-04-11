
//17 dec, 10:57
module Mux(In1,In2,Control,Out);
input[31:0] In1,In2;
input Control;

output[31:0] Out;

reg[31:0] Out;

always @(Control or In1 or In2)
begin
if(Control)
Out <= In2;

else
Out <= In1;
end

endmodule



module Mux_5bit(In1,In2,Control,Out);
input[4:0] In1,In2;
input Control;

output[4:0] Out;

reg[4:0] Out;

always @(Control or In1 or In2)
begin
if(Control)
Out <= In2;

else
Out <= In1;
end

endmodule
