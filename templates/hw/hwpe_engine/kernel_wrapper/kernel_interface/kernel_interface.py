########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

# Kernel interface
class kernel_interface:
    def __init__(self, hwpe_specs):
        self.author = hwpe_specs.author
        self.email = hwpe_specs.email
        self.common = ''

    def gen(self):
        self.intf_ap_ctrl()
        self.intf_dflow()
        return self.common

    def intf_ap_ctrl(self):
        with open('templates/hw/hwpe_engine/kernel_wrapper/kernel_interface/intf_ap_ctrl.template_sv', 'r') as f:
            self.common += f.read()
            self.common += '\n'
            f.close()

    def intf_dflow(self):
        with open('templates/hw/hwpe_engine/kernel_wrapper/kernel_interface/intf_dflow.template_sv', 'r') as f:
            self.common += f.read()
            self.common += '\n'
            f.close()




