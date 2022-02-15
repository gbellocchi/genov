'''
 =====================================================================
 Project:       Integration support
 Title:         integr_support.py
 Description:   Components aimed at simplifying the integration of 
                accelerator wrappers at system-level.

 Date:          29.12.2021
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

from templates.acc_templ.integr_support.bender.top.bender import bender
from templates.acc_templ.integr_support.ips_list.top.ips_list import ips_list
from templates.acc_templ.integr_support.src_files.top.src_files import src_files

class integr_support:
    def __init__(self):
        self.path_common = ''

    def bender(self):
        print("\n[py] >> Integration support ~ bender")
        return bender(
            temp_type = 'templates/acc_templ/integr_support/bender/',
            temp_top = 'bender.template_yml',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def src_files(self):
        print("\n[py] >> Integration support ~ src_files")
        return src_files(
            temp_type = 'templates/acc_templ/integr_support/src_files/',
            temp_top = 'src_files.template_yml',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def ips_list(self):
        print("\n[py] >> Integration support ~ ips_list")
        return ips_list(
            temp_type = 'templates/acc_templ/integr_support/ips_list/',
            temp_top = 'ips_list.template_yml',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def vsim_wave(self):
        print("\n[py] >> Integration support ~ vsim_wave")
        return ips_list(
            temp_type = 'templates/acc_templ/integr_support/vsim_wave/',
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



