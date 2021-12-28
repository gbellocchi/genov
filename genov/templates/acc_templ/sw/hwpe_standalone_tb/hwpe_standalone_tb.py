########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

# Templates
from templates.acc_templ.sw.hwpe_standalone_tb.archi_hwpe.top.archi_hwpe import archi_hwpe
from templates.acc_templ.sw.hwpe_standalone_tb.hal_hwpe.top.hal_hwpe import hal_hwpe
from templates.acc_templ.sw.hwpe_standalone_tb.tb_hwpe.top.tb_hwpe import tb_hwpe

# HWPE wrapper - Software components for standalone testbench
class hwpe_standalone_tb:
    def __init__(self):
        print("\n[py] >>  HWPE standalone testbench ~ Retrieving software components")
        self.path_common = 'templates/acc_templ/sw/common/'

    def archi_hwpe(self):
        print("\n[py] >>  HWPE standalone testbench ~ archi")
        return archi_hwpe(
            temp_type = 'templates/acc_templ/sw/hwpe_standalone_tb/archi_hwpe/',
            temp_top = 'archi_hwpe.template_c',
            temp_modules = ['addressgen_archi.template_c', 
                            'custom_archi.template_c'  , 
                            'tcdm_archi.template_c', 
                            'basic_archi.template_c', 
                            'standard_archi.template_c', 
                            'uloop_archi.template_c'],
            path_common = self.path_common
        ).top()

    def hal_hwpe(self):
        print("\n[py] >>  HWPE standalone testbench ~ hal")
        return hal_hwpe(
            temp_type = 'templates/acc_templ/sw/hwpe_standalone_tb/hal_hwpe/',
            temp_top = 'hal_hwpe.template_c',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def tb_hwpe(self):
        print("\n[py] >>  HWPE standalone testbench ~ SW testbench")
        return tb_hwpe(
            temp_type = 'templates/acc_templ/sw/hwpe_standalone_tb/tb_hwpe/',
            temp_top = 'tb_hwpe.template_c',
            temp_modules = ['hwpe/hwpe_addressgen_decl.template_c',
                            'hwpe/hwpe_exec.template_c',
                            'hwpe/hwpe_fsm_decl.template_c',
                            'hwpe/hwpe_progr.template_c',
                            'test/test_params.template_c',
                            'test/test_stims.template_c',
                            'test/test_check.template_c'],
            path_common = self.path_common
        ).top()


