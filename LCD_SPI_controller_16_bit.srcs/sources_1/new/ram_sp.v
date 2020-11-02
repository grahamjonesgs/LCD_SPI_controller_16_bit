// Single-Port Block RAM No-Change Mode
// File: rams_sp_nc.v

module rams_sp_nc (clk, read_en, read_addr, dout_opcode, dout_var1,dout_var2, write_en, write_addr, write_value);

input clk; 
 
input read_en;
input [11:0] read_addr; 
output [15:0] dout_opcode;
output [15:0] dout_var1;
output [15:0] dout_var2;
input [11:0] write_addr;
input [15:0] write_value;
input write_en;

(* ram_style = "block" *) reg [15:0] RAM [4095:0];
reg [15:0] dout_opcode;
reg [15:0] dout_var1;
reg [15:0] dout_var2;


initial
begin
    $readmemh("lcd_data.mem",RAM);
end

always @(posedge clk)
begin
  if (read_en)
  begin
      dout_opcode <= RAM[read_addr];
      dout_var1 <= RAM[read_addr+1];
      dout_var2 <= RAM[read_addr+2];
  end
  if (write_en)
  begin
      RAM[write_addr] <= write_value;
  end
end
endmodule