module tb_mult4X4;
    reg Clk,St; 
    reg [3:0] Multiplier; 
    reg [3:0] Multiplicand; 
    wire [7:0] Result; 
    wire Done;
 
    mult4X4 SEQMULFUNC (Clk,St,Multiplier,Multiplicand,Done,Result);
 
    initial begin 
        $dumpfile ("mult4X4.vcd"); 
        $dumpvars; 
    end
    initial
        Clk = 0;

    always 
         #10 Clk =~Clk; 
    initial begin 
        St = 1; 
        Multiplicand= 4'b0000; 
        Multiplier= 4'b0001;
 
        #200
		St = 1; 
		Multiplicand= 4'b1110; 
		Multiplier= 4'b1100; 

		#200 
		St = 1; 
		Multiplicand= 4'b1001; 
		Multiplier= 4'b0110; 

		#200 
		St = 1; 
		Multiplicand= 4'b1111; 
		Multiplier= 4'b1111; 

		#200 
		$finish; 
    end 
endmodule