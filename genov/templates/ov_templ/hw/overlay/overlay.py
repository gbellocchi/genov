########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

# Templates
from templates.ov_templ.hw.overlay.ov_cl_pkg.top.ov_cl_pkg import ov_cl_pkg
from templates.ov_templ.hw.overlay.ov_acc_intf.top.ov_acc_intf import ov_acc_intf

# Overlay
class overlay:
    def __init__(self):
        print("\n[py] >> Overlay ~ Retrieving hardware components")
        self.path_common = 'templates/ov_templ/hw/common/'

    def cl_pkg(self):
        print("\n[py] >> Overlay cluster package")
        return ov_cl_pkg(
            temp_type = 'templates/ov_templ/hw/overlay/ov_cl_pkg/',
            temp_top = 'ov_cl_pkg.template_sv',
            temp_modules = ['hwpe.template_sv'],
            path_common = self.path_common
        ).top()

    def acc_intf(self):
        print("\n[py] >> Overlay accelerator interface")
        return ov_acc_intf(
            temp_type = 'templates/ov_templ/hw/overlay/ov_acc_intf/',
            temp_top = 'ov_acc_intf.template_sv',
            temp_modules = ['cl_log_interco.template_sv'],
            path_common = self.path_common
        ).top()