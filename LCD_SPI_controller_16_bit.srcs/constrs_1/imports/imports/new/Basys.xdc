## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

# Clock signal
set_property PACKAGE_PIN W5 [get_ports i_Clk]							
	set_property IOSTANDARD LVCMOS33 [get_ports i_Clk]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports i_Clk]
 
 ##Pmod Header JC - SPI Control
##Sch name = JC1
set_property PACKAGE_PIN K17 [get_ports o_SPI_LCD_MOSI]
set_property IOSTANDARD LVCMOS33 [get_ports o_SPI_LCD_MOSI]
##Sch name = JC2
set_property PACKAGE_PIN M18 [get_ports o_SPI_LCD_Clk]
set_property IOSTANDARD LVCMOS33 [get_ports o_SPI_LCD_Clk]
##Sch name = JC3
set_property PACKAGE_PIN N17 [get_ports o_SPI_LCD_CS_n]
set_property IOSTANDARD LVCMOS33 [get_ports o_SPI_LCD_CS_n]
##Sch name = JC4
set_property PACKAGE_PIN P18 [get_ports i_SPI_LCD_MISO]
set_property IOSTANDARD LVCMOS33 [get_ports i_SPI_LCD_MISO]
##Sch name = JC7
set_property PACKAGE_PIN L17 [get_ports o_LCD_DC]					
	set_property IOSTANDARD LVCMOS33 [get_ports o_LCD_DC]
##Sch name = JC8
#set_property PACKAGE_PIN M19 [get_ports o_LCD_reset_n]					
	#set_property IOSTANDARD LVCMOS33 [get_ports o_LCD_reset_n]
##Sch name = JC9
set_property PACKAGE_PIN P17 [get_ports o_LCD_reset_n]					
	set_property IOSTANDARD LVCMOS33 [get_ports o_LCD_reset_n]
 
 
# Switches
set_property PACKAGE_PIN V17 [get_ports i_Rst_H]					
	set_property IOSTANDARD LVCMOS33 [get_ports i_Rst_H]
#set_property PACKAGE_PIN V16 [get_ports {sw[1]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[1]}]
#set_property PACKAGE_PIN W16 [get_ports {sw[2]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[2]}]
#set_property PACKAGE_PIN W17 [get_ports {sw[3]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[3]}]
#set_property PACKAGE_PIN W15 [get_ports {sw[4]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[4]}]
#set_property PACKAGE_PIN V15 [get_ports {sw[5]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[5]}]
#set_property PACKAGE_PIN W14 [get_ports {sw[6]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[6]}]
#set_property PACKAGE_PIN W13 [get_ports {sw[7]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[7]}]
#set_property PACKAGE_PIN V2 [get_ports {sw[8]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[8]}]
#set_property PACKAGE_PIN T3 [get_ports {sw[9]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[9]}]
#set_property PACKAGE_PIN T2 [get_ports {sw[10]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[10]}]
#set_property PACKAGE_PIN R3 [get_ports {sw[11]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[11]}]
#set_property PACKAGE_PIN W2 [get_ports {sw[12]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[12]}]
#set_property PACKAGE_PIN U1 [get_ports {sw[13]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[13]}]
#set_property PACKAGE_PIN T1 [get_ports {sw[14]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[14]}]
#set_property PACKAGE_PIN R2 [get_ports {sw[15]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[15]}]
	
set_property PACKAGE_PIN U16 [get_ports o_led]					
	set_property IOSTANDARD LVCMOS33 [get_ports o_led]
 
