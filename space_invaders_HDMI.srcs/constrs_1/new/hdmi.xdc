##--- TMDS clock (par diferencial)---
set_property -dict { PACKAGE_PIN H16 IOSTANDARD TMDS_33 } [get_ports {hdmi_out_clk_p}]
set_property -dict { PACKAGE_PIN H17 IOSTANDARD TMDS_33 } [get_ports {hdmi_out_clk_n}]

##--- TMDS data lanes 0,1,2 (pares diferenciais)---
set_property -dict { PACKAGE_PIN D19 IOSTANDARD TMDS_33 } [get_ports {hdmi_out_data_p[0]}]
set_property -dict { PACKAGE_PIN D20 IOSTANDARD TMDS_33 } [get_ports {hdmi_out_data_n[0]}]
set_property -dict { PACKAGE_PIN C20 IOSTANDARD TMDS_33 } [get_ports {hdmi_out_data_p[1]}]
set_property -dict { PACKAGE_PIN B20 IOSTANDARD TMDS_33 } [get_ports {hdmi_out_data_n[1]}]
set_property -dict { PACKAGE_PIN B19 IOSTANDARD TMDS_33 } [get_ports {hdmi_out_data_p[2]}]
set_property -dict { PACKAGE_PIN A20 IOSTANDARD TMDS_33 } [get_ports {hdmi_out_data_n[2]}]