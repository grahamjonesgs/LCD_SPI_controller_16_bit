// Single-Port Block RAM No-Change Mode
// File: rams_sp_nc.v

module stack (clk, i_reset, i_read_flag, i_write_flag, i_write_value, o_stack_top_value, o_stack_error );

input clk;
input i_reset;
input i_read_flag;
input i_write_flag;
input [15:0] i_write_value;
output reg [15:0] o_stack_top_value;
output reg o_stack_error;

(* ram_style = "block" *) reg [15:0] RAM [1023:0];
reg [15:0] o_stacktop;
reg [15:0] r_SP;

initial
begin
    r_SP=15'h0;
    o_stack_error=1'b0;
end

always @(posedge clk)
begin
  if (i_reset)
  begin
    r_SP<=15'h0;
    o_stack_error<=1'b0;
  end //if (i_reset)
  else
  begin
    if (i_read_flag)
    begin
      if (r_SP==0)
       begin
        o_stack_error<=1;  
      end // if(r_SP==0)
      else
      begin
         r_SP<=r_SP-1; 
      end // else if if(r_SP==0)    
    end // if (i_read)
    if (i_write_flag)
    begin
      if (r_SP>1022)
      begin
         o_stack_error<=1; 
      end // if (r_SP>1022)
      else
      begin
          RAM[r_SP]<=i_write_value;
          r_SP<=r_SP+1;
      end // else if (r_SP>1022)
    end //if (i_write_flag)
  end // else if (i_reset)
end // always clock

always @(posedge clk)
begin
   o_stack_top_value<=RAM[r_SP-1];
end

endmodule