# Sequential_Multiplier
This is a simple Verilog code that mimics the working of  a sequential multiplier algorithm and is used to to multiply numbers from testbench values,update to the latest version of iverilog to run this code



To run this code 

1)install icarus verilog (latest version) from thier website

2)save this in C:\iverilog\bin 

3)open command prompt and naviagte to the folder where the code is stored enter the lines

>iverilog -o seq_mul seqmul.v seqmul_tb.v

>vvp seq_mul

>gtkwave mult4X4.vcd(or the dump file created)

if you get error saying iverilog is not recognised,please add bin folder path of the user variable in the control panel

comments in the main file is more than adequate for understanding the code and its functioning
