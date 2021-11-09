########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

# Packages
from templates.integr_support.bender.top.bender import bender
from templates.integr_support.vsim_wave.top.vsim_wave import vsim_wave

# Integration support
class integr_support:
    def __init__(self):
        print("\n>> Integration support ~ Retrieving components")
        self.path_common = ''

    def bender(self):
        print("\n>> Integration support ~ bender")
        return bender(
            temp_type = 'templates/integr_support/bender/',
            temp_top = 'bender.template_yml',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def vsim_wave(self):
        print("\n>> Integration support ~ QuestaSim waves")
        return bender(
            temp_type = 'templates/integr_support/vsim_wave/',
            temp_top = 'vsim_wave.template_wave_do',
            temp_modules = ['hwpe_ctrl.template_wave_do', 
                            'hwpe_engine.template_wave_do', 
                            'hwpe_fsm.template_wave_do',
                            'hwpe_streamer.template_wave_do',
                            'hwpe_top.template_wave_do',
                            'kernel_interface/mdc_dataflow.template_wave_do',
                            'kernel_interface/xil_ap_ctrl_hs.template_wave_do',
                            'kernel_interface/kernel_hls.template_wave_do',
                            'ov_acc_intf.template_wave_do'
            ],
            path_common = self.path_common
        ).top()



