########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

# Templates
from templates.acc_templ.hw.hwpe_standalone_tb.tb_hwpe.top.tb_hwpe import tb_hwpe

# HWPE wrapper - Hardware components for standalone testbench
class hwpe_standalone_tb:
    def __init__(self):
        self.path_common = 'templates/acc_templ/hw/common/'

    def tb_hwpe(self):
        print("\n[py] >>  HWPE standalone testbench ~ HW testbench")
        return tb_hwpe(
            temp_type = 'templates/acc_templ/hw/hwpe_standalone_tb/tb_hwpe/',
            temp_top = 'tb_hwpe.template_sv',
            temp_modules = ['hwpe.template_sv'],
            path_common = self.path_common
        ).top()