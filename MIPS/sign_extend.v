//17 dec, 10:53 pm
module Sign_extend(In,Out,Control);
input[15:0] In;
input Control;
output[31:0] Out;
reg[31:0] Out;

always @ (In or Control)
begin 
if(Control)  
 Out<={16'b0,In};                        //if control=1 ==> unsigned 
					 //if control=0 ==> signed
else
 Out<={ {16{In[15]}}, In[15:0] };
 
end
endmodule

