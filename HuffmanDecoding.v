module Reciever ( DataInput , DataOutput , Clock , Reset ) ;

input DataInput ,Clock , Reset ;
output reg [2:0] DataOutput ;

parameter Trans1 = 4'b0000,
	  Trans2 = 4'b0001,
	  Trans3 = 4'b0010,
	  Trans4 = 4'b0011,
	  Trans5 = 4'b1111,
	  Idle = 4'b0100,
	  s0 = 4'b0101,
	  s1 = 4'b0110,
	  s2 = 4'b0111,
	  s3 = 4'b1000,
	  s4 = 4'b1001,
	  s5 = 4'b1010,
	  s6 = 4'b1011;
reg [3:0 ]State ;

always @(posedge Clock or posedge Reset) 
begin 

if (Reset )begin State = Idle   ; end
else 
begin 
case (State) 
Trans1: 
begin 
if (DataInput ==1'b1 ) begin State =s0 ; DataOutput = 3'b000;    end
else if (DataInput == 1'b0) begin State = s1 ; DataOutput = 3'b001;    end
end
Trans2:
begin 
if (DataInput ==1'b1 ) begin  State = Trans4;  end
else if (DataInput == 1'b0) begin  State = Trans3;  end
end
Trans3:
begin 
if (DataInput ==1'b1 ) begin  State =s2 ;  DataOutput = 3'b010;   end
else if (DataInput == 1'b0) begin State = Trans5;   end
end 
Trans4:
begin 
if (DataInput ==1'b1 ) begin  State =s4 ; DataOutput = 3'b100;    end
else if (DataInput == 1'b0) begin State =s3; DataOutput = 3'b011;    end
end
Trans5:
begin 
if (DataInput ==1'b1 ) begin  State =s6;  DataOutput = 3'b110;   end
else if (DataInput == 1'b0) begin  State =s5; DataOutput = 3'b101;   end
end
Idle:
begin 
if (DataInput ==1'b1 ) begin State =Trans1 ;    end
else if (DataInput == 1'b0) begin State =Trans2 ;   end
end
s0 :
begin 

State =Idle ;
end
s1 :
begin 
State =Idle ;
end
s2:
begin 
State =Idle ;
end
s3:
begin 
State =Idle ;
end
s4:
begin 
State =Idle ;
end
s5:
begin 
State =Idle ;
end
s6:
begin 

State =Idle ;
end


endcase 


end

end


endmodule

module Testbench ; 

reg  DataInput ,Clock , Reset ;
wire [2:0] DataOutput ;

integer Counter ;

initial 
begin 
Reset =1 ; 
#12
Clock =0 ;
Reset =0 ;

repeat(5)
begin
#12 
DataInput = $random ;

end 

end 
initial 
$monitor("Output Data is %b , Input Data is %b , Clock is %b" ,DataOutput , DataInput,Clock ); 

always 
begin 
#5 Clock = ~ Clock ; 
end

Reciever Reciever ( DataInput , DataOutput , Clock , Reset ) ;



endmodule 