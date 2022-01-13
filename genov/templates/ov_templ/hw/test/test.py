'''
 =====================================================================
 Project:       Overlay test class
 Title:         test.py
 Description:   The Overlay test class recalls all the the templates 
                compliant with the generation of an overlay test.

 Date:          29.12.2021
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

from templates.ov_templ.hw.test.overlay_tb_hw.top.overlay_tb_hw import OverlayTestbenchHw
# from templates.ov_templ.hw.test.overlay_tb_sw.top.overlay_tb_sw import OverlayTestbenchSw
# from templates.ov_templ.hw.test.vsim_wave.top.vsim_wave import VsimWave

class Test:
    def __init__(self):
        self.path_common = 'templates/ov_templ/hw/common/'

    def OverlayTestbenchHw(self):
        print("\n[py] >> Overlay ~ Hardware testbench")
        return OverlayTestbenchHw(
            temp_type = 'templates/ov_templ/hw/test/overlay_tb_hw/',
            temp_top = 'overlay_tb_hw.template_sv',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    # def OverlayTestbenchSw(self):
    #     print("\n[py] >> Overlay ~ Software testbench")
    #     return OverlayTestbenchHw(
    #         temp_type = 'templates/ov_templ/hw/test/overlay_tb_sw/',
    #         temp_top = 'overlay_tb_sw.template_sv',
    #         temp_modules = [],
    #         path_common = self.path_common
    #     ).top()
    
    # def VsimWave(self):
    #     print("\n[py] >> Overlay ~ QuestaSim waves")
    #     return VsimWave(
    #         temp_type = 'templates/ov_templ/hw/test/vsim_wave/',
    #         temp_top = 'vsim_wave.template_wave_do',
    #         temp_modules = ['hwpe_ctrl.template_wave_do', 
    #                         'hwpe_engine.template_wave_do', 
    #                         'hwpe_fsm.template_wave_do',
    #                         'hwpe_streamer.template_wave_do',
    #                         'hwpe_top.template_wave_do',
    #                         'kernel_interface/mdc_dataflow.template_wave_do',
    #                         'kernel_interface/xil_ap_ctrl_hs.template_wave_do',
    #                         'kernel_interface/kernel_hls.template_wave_do',
    #                         'cl_acc_intf.template_wave_do'
    #         ],
    #         path_common = self.path_common
    #     ).top()