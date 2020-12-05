`define M ACC[0]
module mult4X4 (Clk, St, Multiplier, Multiplicand, Done, Result); 
//putput can be seen in the the last clock cyle only of a given input because the last iteration gives the product
input Clk,St; //declaring the two input parameters clock and reset
input [3:0] Multiplier, Multiplicand;//declaring 2 4 bit Multiplicand and multiplier
output Done; 
output [7:0] Result;//as result is 2*bit size of the operands,so we declare 8-bit numbers
 //state is a 3 bit number as for a 3 bit number we have maximum of 4 add and 4 shift operations,total=8 so I take it as 2^3=8
reg [3:0] State; //add/shift 
reg [8:0] ACC; //accumulator 
//we declare everything to 0 in the begining called "initialization phase
initial 
begin 
    State =0;
    ACC = 0;
end 
//state is the counter variable that handles the count of the cycles
//we designed the system to trigger at every positive edge of the clock signal
//we change the state in every if/else statement as it represents a cycle
//number of cycles is equal to number of bits in the multiplicand 
//(<=) Execution of nonblocking assignments can be viewed as a two-step process:
//1. Evaluate the RHS of nonblocking statements at the beginning of the time step.
//2. Update the LHS of nonblocking statements at the end of the time step. 
always@(posedge Clk)//posedge tells positive edge of the clock
begin 
   case (State)//herer we use switch statement analogy in verilog called case to start our process
   0://initialization phase 
		begin //Starting multiplication process
			if(St == 1'b1)
			begin 
				ACC[8:4] <= 5'b00000; 
				ACC[3:0] <= Multiplier;//basically adding multimplier to the A part of the acc register
				State <= 1; 
			end
        end 
    1,3,5,7://at every alternate cycel I do the work of checking the last bit and decideing wheter I must add or not 
	//I either add and shift  or just shift depending on the last bit of the accumulator register 
        begin //Checking for last bit of the acculumator register
			if( `M == 1'b1) //Last bit ls 1,we proceed to do A=A+M
                begin 
				    ACC[8:4] <= {1'b0, ACC[7:4]} + Multiplicand;// Add and move to next state(A=A+M)
				    State<= State + 1; // change count with addition and just shifting
                end 
            else
                begin
                State <= State + 1;//Change state without a
                end
        end
    2,4,6,8 ://here in the even cycles we do the job of shifting the number from the previous cycle's output
	//in this algo,the shift is a mandatory step and happens regardless of the addition operation 
        begin
            ACC <= {1'b0, ACC[8:1]};//Shift right by one bit by replacing the moved bit with 0,we dont see sign extension here
            State <= State + 1;//increment the count variable after a cycle
        end
    9://after the 8th step we encounter 9th step which tells if the multiplication is over of not
        begin//once the steps are done,we re-initialize the values of the state and accumator to make it ready for next input,as first set happens before loop
            State <= 0;
            ACC <= 0;
        end 
    endcase
end 
   assign Done = (State == 9)?1'b1:1'b0 ;//checking if the state is 9,mif yes we replace the done variable with 1(true
   assign Result = (State == 9) ? ACC [7:0] : 8 'b00000000;//if state is 9,we store the result that is retured to the testbench for output
   //if the state is 9,we store the value of the accumulator in the result,else put 0 in it to show that the multiplication was with 0
endmodule
