/*
Name - SHUBHABRATA NATH
Topic - Synchronous Scanned D FF
Date - 18:07:2022
*/

module synchronous_scanned_d_ff(input d_in_0,d_in_1,sel,rst,clk,output reg d_out);

reg d;

always@(d_in_0,d_in_1,sel)
begin
d = (!sel ? d_in_0 : d_in_1);
end

always@(posedge clk)
begin
if(rst)d_out <= 1'b0;
else d_out <= d;
end

endmodule