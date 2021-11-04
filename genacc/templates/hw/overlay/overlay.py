########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

# Packages - Overlay
from templates.hw.overlay.ov_acc_pkg.top.ov_acc_pkg import ov_acc_pkg
from templates.hw.overlay.ov_acc_intf.top.ov_acc_intf import ov_acc_intf

# Overlay
class overlay:
    def __init__(self):
        print("\n>> Overlay ~ Retrieving hardware components")
        self.path_common = 'templates/hw/common/'

    def acc_pkg(self):
        print("\n>> Overlay accelerator package")
        return ov_acc_pkg(
            temp_type = 'templates/hw/overlay/ov_acc_pkg/',
            temp_top = 'ov_acc_pkg.template_sv',
            temp_modules = ['hwpe.template_sv'],
            path_common = self.path_common
        ).top()

    def acc_intf(self):
        print("\n>> Overlay accelerator interface")
        return ov_acc_intf(
            temp_type = 'templates/hw/overlay/ov_acc_intf/',
            temp_top = 'ov_acc_intf.template_sv',
            temp_modules = ['cl_log_interco.template_sv'],
            path_common = self.path_common
        ).top()