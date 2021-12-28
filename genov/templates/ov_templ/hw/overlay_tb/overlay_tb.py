########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

# Templates
from templates.ov_templ.hw.overlay_tb.tb_ov.top.tb_ov import tb_ov

# Overlay - Hardware components for testbench
class overlay_tb:
    def __init__(self):
        print("\n[py] >> Overlay testbench ~ Retrieving hardware components")
        self.path_common = 'templates/ov_templ/hw/common/'

    def tb_ov(self):
        print("\n[py] >> HWPE standalone testbench ~ HW testbench")
        return tb_ov(
            temp_type = 'templates/ov_templ/hw/overlay_tb/tb_ov/',
            temp_top = 'tb_ov.template_sv',
            temp_modules = [],
            path_common = self.path_common
        ).top()