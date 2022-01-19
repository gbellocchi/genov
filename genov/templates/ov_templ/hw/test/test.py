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
from templates.ov_templ.hw.test.vsim_wave_cluster.top.vsim_wave_cluster import VsimWaveCluster
from templates.ov_templ.hw.test.vsim_wave_soc.top.vsim_wave_soc import VsimWaveSoc

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
    
    def VsimWaveCluster(self):
        print("\n[py] >> Overlay ~ QuestaSim waves (Cluster)")
        return VsimWaveCluster(
            temp_type = 'templates/ov_templ/hw/test/vsim_wave_cluster/',
            temp_top = 'vsim_wave_cluster.template_wave_do',
            temp_modules = ['hwpe/hwpe_ctrl.template_wave_do', 
                            'hwpe/hwpe_engine.template_wave_do', 
                            'hwpe/hwpe_fsm.template_wave_do',
                            'hwpe/hwpe_streamer.template_wave_do',
                            'hwpe/hwpe_top.template_wave_do',
                            'hwpe/kernel_interface/mdc_dataflow.template_wave_do',
                            'hwpe/kernel_interface/xil_ap_ctrl_hs.template_wave_do',
                            'hwpe/kernel_interface/kernel_hls.template_wave_do',
                            'hwpe.template_wave_do',
                            'cl_acc_intf.template_wave_do',
                            'cluster.template_wave_do',
                            'riscv_core.template_wave_do'
            ],
            path_common = self.path_common
        ).top()

    def VsimWaveSoc(self):
        print("\n[py] >> Overlay ~ QuestaSim waves (SoC)")
        return VsimWaveSoc(
            temp_type = 'templates/ov_templ/hw/test/vsim_wave_soc/',
            temp_top = 'vsim_wave_soc.template_wave_do',
            temp_modules = ['soc.template_wave_do'
            ],
            path_common = self.path_common
        ).top()