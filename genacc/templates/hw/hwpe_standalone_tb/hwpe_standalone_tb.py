########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

# Templates
from templates.hw.hwpe_standalone_tb.tb_hwpe.top.tb_hwpe import tb_hwpe

# HWPE wrapper - Hardware components for standalone testbench
class hwpe_standalone_tb:
    def __init__(self):
        print("\n>> HWPE standalone testbench ~ Retrieving hardware components")
        self.path_common = 'templates/hw/common/'

    def tb_hwpe(self):
        print("\n>> HWPE standalone testbench ~ HW testbench")
        return tb_hwpe(
            temp_type = 'templates/hw/hwpe_standalone_tb/tb_hwpe/',
            temp_top = 'tb_hwpe.template_sv',
            temp_modules = ['hwpe.template_sv'],
            path_common = self.path_common
        ).top()