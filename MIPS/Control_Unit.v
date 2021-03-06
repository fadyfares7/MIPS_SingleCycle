
module Control_Unit(OPcode,RegDst,RegWrite,ALUSrc,AluOp,MemWrite,MemRead,MemToReg,
branch,jump, branch_not_equal,jump_link, enable_unsigned, load_upper_imediate,
half_byte,byte);

input [5:0]OPcode;

output RegDst;
output RegWrite;
output ALUSrc;
output [2:0]AluOp;
output MemWrite;
output MemRead;
output MemToReg;
output branch;
output branch_not_equal;
output jump;
output jump_link;
output enable_unsigned;
output load_upper_imediate;
output half_byte;
output byte;

wire [5:0]OPcode;

reg RegDst;
reg RegWrite;
reg ALUSrc;
reg [2:0]AluOp;
reg MemWrite;
reg MemRead;
reg MemToReg;
reg branch;
reg jump;
reg branch_not_equal;
reg enable_unsigned;
reg jump_link;
reg load_upper_imediate;
reg half_byte;
reg byte;

initial // initialize the control signals
	begin
 		RegDst=1'b0;
 		RegWrite=1'b0;
 		ALUSrc=1'b0;
 		AluOp=3'b000;
 		MemWrite=1'b0;
 		MemRead=1'b0;
 		MemToReg=1'b0;
 		branch=1'b0;
 		jump=1'b0;
 		branch_not_equal=1'b0;
 		enable_unsigned=1'b0;
 		jump_link=1'b0;
 		load_upper_imediate=1'b0;
 		half_byte=1'b0;
 		byte=1'b0;


	end


always @ (OPcode )
   begin
     if (OPcode==6'b000000)//r-type
		begin
 			RegDst=1'b1;
 			RegWrite=1'b1;
 			ALUSrc=1'b0;
 			AluOp=3'b010;
 			MemWrite=1'b0;
 			MemRead=1'b0;
			MemToReg=1'b0;
 			branch=1'b0;
 			jump=1'b0;
 			branch_not_equal=1'b0;
 			enable_unsigned=1'b0;
 			jump_link=1'b0;
			load_upper_imediate=1'b0;
			half_byte=1'b0;
			byte=1'b0;
		end

//I-type&j=type
    else 
	begin
	     case (OPcode)
		//i=type
		6'b001000://addi
		  begin
 			RegDst=1'b0;
			RegWrite=1'b1;
 			ALUSrc=1'b1;
 			AluOp=3'b000;
 		 	MemWrite=1'b0;
 			MemRead=1'b0;
 			MemToReg=1'b0;
 			branch=1'b0;
		 	jump=1'b0;
			branch_not_equal=1'b0;
 			enable_unsigned=1'b0;
 			jump_link=1'b0;
			load_upper_imediate=1'b0;
			half_byte=1'b0;
			byte=1'b0;
		end


		6'b001010://slti
		  begin
 			RegDst=1'b0;
			RegWrite=1'b1;
 			ALUSrc=1'b1;
 		  	AluOp=3'b101;
 			MemWrite=1'b0;
 			MemRead=1'b0;
 			MemToReg=1'b0;
 			branch=1'b0;
			jump=1'b0;
			branch_not_equal=1'b0;
 			enable_unsigned=1'b0;
 			jump_link=1'b0;
			load_upper_imediate=1'b0;
			half_byte=1'b0;
			byte=1'b0;
		   end


		6'b001001://sltui
		   begin
 			RegDst=1'b0;
			RegWrite=1'b1;
 			ALUSrc=1'b1;
 		   	AluOp=3'b101;
 			MemWrite=1'b0;
 			MemRead=1'b0;
 			MemToReg=1'b0;
 			branch=1'b0;
			jump=1'b0;
			branch_not_equal=1'b0;
 			enable_unsigned=1'b1;
 			jump_link=1'b0;
			load_upper_imediate=1'b0;
			half_byte=1'b0;
			byte=1'b0;
		    end

		6'b000100://beq
		    begin
 			RegDst=1'bx;
 			RegWrite=1'b0;
 			ALUSrc=1'b0;
 			AluOp=3'b001;
 			MemWrite=1'b0;
 			MemRead=1'b0;
 			MemToReg=1'bx;
 			branch=1'b1;
 			jump=1'b0;
			branch_not_equal=1'b0;
 			enable_unsigned=1'b0;
 			jump_link=1'b0;
			load_upper_imediate=1'b0;
			half_byte=1'b0;
			byte=1'b0;

		    end


		6'b000101://bne
		    begin
 			RegDst=1'bx;
			RegWrite=1'b0;
 			ALUSrc=1'b0;
 			AluOp=3'b001;
 			MemWrite=1'b0;
 			MemRead=1'b0;
 			MemToReg=1'bx;
 			branch=1'b0;
 			jump=1'b0;
			branch_not_equal=1'b1;
 			enable_unsigned=1'b0;
 			jump_link=1'b0;
			load_upper_imediate=1'b0;
			half_byte=1'b0;
			byte=1'b0;
		    end


		6'b001100://andi
		    begin
			RegDst=1'b0;
			RegWrite=1'b1;
 			ALUSrc=1'b1;
 			AluOp=3'b011;
 			MemWrite=1'b0;
 			MemRead=1'b0;
 			MemToReg=1'b0;
 			branch=1'b0;
			jump=1'b0;
			branch_not_equal=1'b0;
 			enable_unsigned=1'b1;
 			jump_link=1'b0;
			load_upper_imediate=1'b0;
			half_byte=1'b0;
			byte=1'b0;
		    end


		6'b001101://ori
		    begin
			RegDst=1'b0;
			RegWrite=1'b1;
 			ALUSrc=1'b1;
 			AluOp=3'b100;
 			MemWrite=1'b0;
 			MemRead=1'b0;
 			MemToReg=1'b0;
 			branch=1'b0;
			jump=1'b0;
			branch_not_equal=1'b0;
 			enable_unsigned=1'b1;
 			jump_link=1'b0;
			load_upper_imediate=1'b0;
			half_byte=1'b0;
			byte=1'b0;
		    end


		6'b100011://lw
		    begin
 			RegDst=1'b0;
			RegWrite=1'b1;
 			ALUSrc=1'b1;
 			AluOp=3'b000;
 			MemWrite=1'b0;
 			MemRead=1'b1;
 			MemToReg=1'b1;
 			branch=1'b0;
 			jump=1'b0;
			branch_not_equal=1'b0;
 			enable_unsigned=1'b0;
 			jump_link=1'b0;
			load_upper_imediate=1'b0;
			half_byte=1'b0;
			byte=1'b0;
		    end


		6'b100001://lh
		    begin
 			RegDst=1'b0;
			RegWrite=1'b1;
 			ALUSrc=1'b1;
 			AluOp=3'b000;
 			MemWrite=1'b0;
 			MemRead=1'b1;
 			MemToReg=1'b1;
 			branch=1'b0;
 			jump=1'b0;
			branch_not_equal=1'b0;
 			enable_unsigned=1'b0;
 			jump_link=1'b0;
			load_upper_imediate=1'b0;
			half_byte=1'b1;
			byte=1'b0;
		    end


		6'b100000://lb
		    begin
 			RegDst=1'b0;
			RegWrite=1'b1;
 			ALUSrc=1'b1;
 			AluOp=3'b000;
 			MemWrite=1'b0;
 			MemRead=1'b1;
 			MemToReg=1'b1;
 			branch=1'b0;
 			jump=1'b0;
			branch_not_equal=1'b0;
 			enable_unsigned=1'b0;
 			jump_link=1'b0;
			load_upper_imediate=1'b0;
			half_byte=1'b0;
			byte=1'b1;
		    end

		6'b100101://lhu
		    begin
 			RegDst=1'b0;
			RegWrite=1'b1;
 			ALUSrc=1'b1;
 			AluOp=3'b000;
 			MemWrite=1'b0;
 			MemRead=1'b1;
 			MemToReg=1'b1;
 			branch=1'b0;
 			jump=1'b0;
			branch_not_equal=1'b0;
 			enable_unsigned=1'b1;
 			jump_link=1'b0;
			load_upper_imediate=1'b0;
			half_byte=1'b1;
			byte=1'b0;
		    end


		6'b100100://lbu
		    begin
 			RegDst=1'b0;
			RegWrite=1'b1;
 			ALUSrc=1'b1;
 			AluOp=3'b000;
 			MemWrite=1'b0;
 			MemRead=1'b1;
 			MemToReg=1'b1;
 			branch=1'b0;
 			jump=1'b0;
			branch_not_equal=1'b0;
 			enable_unsigned=1'b1;
 			jump_link=1'b0;
			load_upper_imediate=1'b0;
			half_byte=1'b0;
			byte=1'b1;
		    end

		6'b101011://sw
		    begin
 			RegDst=1'bx;
 			RegWrite=1'b0;
 			ALUSrc=1'b1;
 			AluOp=3'b000;
 			MemWrite=1'b1;
 			MemRead=1'b0;
 			MemToReg=1'bx;
 			branch=1'b0;
 			jump=1'b0;
			branch_not_equal=1'b0;
 			enable_unsigned=1'b0;
 			jump_link=1'b0;
			load_upper_imediate=1'b0;
			half_byte=1'b0;
			byte=1'b0;
		    end


		6'b101001://sh
		    begin
 			RegDst=1'bx;
 			RegWrite=1'b0;
 			ALUSrc=1'b1;
 			AluOp=3'b000;
 			MemWrite=1'b1;
 			MemRead=1'b0;
 			MemToReg=1'bx;
 			branch=1'b0;
 			jump=1'b0;
			branch_not_equal=1'b0;
 			enable_unsigned=1'b0;
 			jump_link=1'b0;
			load_upper_imediate=1'b0;
			half_byte=1'b1;
			byte=1'b0;
		    end


		6'b101000://sb
		    begin
 			RegDst=1'bx;
 			RegWrite=1'b0;
 			ALUSrc=1'b1;
 			AluOp=3'b000;
 			MemWrite=1'b1;
 			MemRead=1'b0;
 			MemToReg=1'bx;
 			branch=1'b0;
 			jump=1'b0;
			branch_not_equal=1'b0;
 			enable_unsigned=1'b0;
 			jump_link=1'b0;
			load_upper_imediate=1'b0;
			half_byte=1'b0;
			byte=1'b1;
		    end


		6'b001111://lui
		    begin
 			RegDst=1'b0;
 			RegWrite=1'b1;
 			ALUSrc=1'bx;
 			AluOp=3'bxxx;
 			MemWrite=1'b0;
 			MemRead=1'b0;
 			MemToReg=1'bx;
 			branch=1'bx;
 			jump=1'b0;
			branch_not_equal=1'b0;
 			enable_unsigned=1'b0;
 			jump_link=1'b0;
			load_upper_imediate=1'b1;
			half_byte=1'b0;
			byte=1'b0;
		    end


		//j-type
		6'b000011://jal
		    begin
 			RegDst=1'bx;
 			RegWrite=1'b1;
 			ALUSrc=1'bx;
 			AluOp=3'bxxx;
 			MemWrite=1'b1;
 			MemRead=1'b0;
 			MemToReg=1'bx;
 			branch=1'bx;
 			jump=1'b1;
			branch_not_equal=1'b0;
 			enable_unsigned=1'b0;
 			jump_link=1'b1;
			load_upper_imediate=1'b0;
			half_byte=1'b0;
			byte=1'b0;
		    end


		6'b000010://jump
		    begin
 			RegDst=1'bx;
 			RegWrite=1'b0;
 			ALUSrc=1'bx;
 			AluOp=3'bxxx;
 			MemWrite=1'b0;
 			MemRead=1'b0;
 			MemToReg=1'bx;
 			branch=1'bx;
 			jump=1'b1;
			branch_not_equal=1'b0;
 			enable_unsigned=1'b0;
 			jump_link=1'b0;
			load_upper_imediate=1'b0;
			half_byte=1'b0;
			byte=1'b0;
		    end


		default: 
		   begin
			RegDst=1'b0;
 			RegWrite=1'b0;
 			ALUSrc=1'b0;
 			AluOp=3'b000;
 			MemWrite=1'b0;
 			MemRead=1'b0;
			MemToReg=1'b0;
 			branch=1'b0;
 			jump=1'b0;
 			branch_not_equal=1'b0;
 			enable_unsigned=1'b0;
 			jump_link=1'b0;
			load_upper_imediate=1'b0;
			half_byte=1'b0;
			byte=1'b0;
		    end

	   endcase

	end

     end

endmodule

