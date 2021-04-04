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
 
 #seven-segment LED display
set_property PACKAGE_PIN V7 [get_ports {o_LED_cathode[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_LED_cathode[7]}]
set_property PACKAGE_PIN W7 [get_ports {o_LED_cathode[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_LED_cathode[6]}]
set_property PACKAGE_PIN W6 [get_ports {o_LED_cathode[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_LED_cathode[5]}]
set_property PACKAGE_PIN U8 [get_ports {o_LED_cathode[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_LED_cathode[4]}]
set_property PACKAGE_PIN V8 [get_ports {o_LED_cathode[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_LED_cathode[3]}]
set_property PACKAGE_PIN U5 [get_ports {o_LED_cathode[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_LED_cathode[2]}]
set_property PACKAGE_PIN V5 [get_ports {o_LED_cathode[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_LED_cathode[1]}]
set_property PACKAGE_PIN U7 [get_ports {o_LED_cathode[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_LED_cathode[0]}]
set_property PACKAGE_PIN U2 [get_ports {o_Anode_Activate[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_Anode_Activate[0]}]
set_property PACKAGE_PIN U4 [get_ports {o_Anode_Activate[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_Anode_Activate[1]}]
set_property PACKAGE_PIN V4 [get_ports {o_Anode_Activate[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_Anode_Activate[2]}]
set_property PACKAGE_PIN W4 [get_ports {o_Anode_Activate[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_Anode_Activate[3]}]

set_property PACKAGE_PIN U18 [get_ports i_Rst_H]
set_property IOSTANDARD LVCMOS33 [get_ports i_Rst_H]


	
#set_property PACKAGE_PIN U16 [get_ports o_led]					
#set_property IOSTANDARD LVCMOS33 [get_ports o_led]
#set_property PACKAGE_PIN E19 [get_ports o_led_2]
#set_property IOSTANDARD LVCMOS33 [get_ports o_led_2]	
	
# LEDs
set_property PACKAGE_PIN U16 [get_ports {o_led[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {o_led[0]}]
set_property PACKAGE_PIN E19 [get_ports {o_led[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {o_led[1]}]
set_property PACKAGE_PIN U19 [get_ports {o_led[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {o_led[2]}]
set_property PACKAGE_PIN V19 [get_ports {o_led[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {o_led[3]}]
set_property PACKAGE_PIN W18 [get_ports {o_led[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {o_led[4]}]
set_property PACKAGE_PIN U15 [get_ports {o_led[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {o_led[5]}]
set_property PACKAGE_PIN U14 [get_ports {o_led[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {o_led[6]}]
set_property PACKAGE_PIN V14 [get_ports {o_led[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {o_led[7]}]
set_property PACKAGE_PIN V13 [get_ports {o_led[8]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {o_led[8]}]
set_property PACKAGE_PIN V3 [get_ports {o_led[9]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {o_led[9]}]
set_property PACKAGE_PIN W3 [get_ports {o_led[10]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {o_led[10]}]
set_property PACKAGE_PIN U3 [get_ports {o_led[11]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {o_led[11]}]
set_property PACKAGE_PIN P3 [get_ports {o_led[12]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {o_led[12]}]
set_property PACKAGE_PIN N3 [get_ports {o_led[13]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {o_led[13]}]
set_property PACKAGE_PIN P1 [get_ports {o_led[14]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {o_led[14]}]
set_property PACKAGE_PIN L1 [get_ports {o_led[15]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {o_led[15]}]	
	
	
	
set_property PACKAGE_PIN B18 [get_ports i_uart_rx]
set_property IOSTANDARD LVCMOS33 [get_ports i_uart_rx]

set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]
 
