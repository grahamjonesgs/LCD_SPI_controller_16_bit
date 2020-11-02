// Single-Port Block RAM No-Change Mode
// File: rams_sp_nc.v

module rams_sp_nc (clk, read_en, addr, dout_opcode, dout_var1,dout_var2);

input clk; 
 
input read_en;
input [15:0] addr; 
output [15:0] dout_opcode;
output [15:0] dout_var1;
output [15:0] dout_var2;


(* ram_style = "block" *) reg [15:0] RAM [65535:0];
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
      dout_opcode <= RAM[addr];
      dout_var1 <= RAM[addr+1];
      dout_var2 <= RAM[addr+2];
  end
end
endmodule