/*
Name - SHUBHABRATA NATH
Topic - Synchronous Scanned D FF
Date - 18:07:2022
*/

module synchronous_scanned_d_ff_tb;

   reg d0,d1,sel,rst,clk;
   wire q;

   parameter Thold  = 5,
	     Tsetup = 5,
	     CYCLE  = 100;
  
   synchronous_scanned_d_ff dut(d0,d1,sel,rst,clk,q);

   always
   begin
   #(CYCLE/2) clk = 0;
   #(CYCLE/2) clk = 1;
   end
    
	task sync_reset;
	begin
	rst=1;
	d0=1;
	d1=1;
	sel={$random}%2;
	@(posedge clk);
	#(Thold);
	if(q!==0)
	begin
	$display("Reset is not working");
	$display("Error at time %t" , $time);
	$stop;
	end
	$display("Reset is perfect");
	{rst,d0,d1,sel}=4'bx;
	#(CYCLE-Thold-Tsetup);
	end
	endtask
	
    task load_d0;
	input data;
	begin
	rst=0;
	d0=data;
	d1=~data;
	sel=0;
	@(posedge clk);
	#(Thold);
	if(q!=data)
	begin
	$display("Execution failed");
	$display("Error at time %t" , $time);
	$stop;
	end
	$display("All_0 is well");
	{rst,d0,d1,sel}=4'bx;
	#(CYCLE-Thold-Tsetup);
	end
	endtask
	
	task load_d1;
	input data;
	begin
	rst=0;
	d0=~data;
	d1=data;
	sel=1;
	@(posedge clk);
	#(Thold);
	if(q!=data)
	begin
	$display("Execution failed");
	$display("Error at time %t" , $time);
	$stop;
	end
	$display("All_1 is well");
	{rst,d0,d1,sel}=4'bx;
	#(CYCLE-Thold-Tsetup);
	end
	endtask

   initial
      begin         
	 sync_reset;
	 load_d0(1'b1);
	 sync_reset;
	 load_d1(1'b1);
	 load_d0(1'b0);
	 load_d1(1'b0);
	 sync_reset;   
	 #100 $finish;
      end       
			
endmodule