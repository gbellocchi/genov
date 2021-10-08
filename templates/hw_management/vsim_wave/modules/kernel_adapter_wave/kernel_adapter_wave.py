########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

# Packages
from templates.hw_management.vsim_wave.modules.kernel_adapter_wave.mdc_dataflow.mdc_dataflow import mdc_dataflow
from templates.hw_management.vsim_wave.modules.kernel_adapter_wave.xil_ap_ctrl_hs.xil_ap_ctrl_hs import xil_ap_ctrl_hs

# Kernel adapter wave
class kernel_adapter_wave:
    def __init__(self):
        self.m = ''
    
    def gen(self):
        self.get_template()
        return self.m

    def get_template(self):
        self.m = ''
        self.m += xil_ap_ctrl_hs().gen()
        self.m += mdc_dataflow().gen()
