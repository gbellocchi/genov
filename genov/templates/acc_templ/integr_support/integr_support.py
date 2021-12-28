########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

# Templates
from templates.acc_templ.integr_support.bender.top.bender import bender
from templates.acc_templ.integr_support.ips_list.top.ips_list import ips_list
from templates.acc_templ.integr_support.src_files.top.src_files import src_files

# Integration support
class integr_support:
    def __init__(self):
        print("\n[py] >>  Integration support ~ Retrieving components")
        self.path_common = ''

    def bender(self):
        print("\n[py] >>  Integration support ~ bender")
        return bender(
            temp_type = 'templates/acc_templ/integr_support/bender/',
            temp_top = 'bender.template_yml',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def src_files(self):
        print("\n[py] >>  HWPE standalone testbench ~ src_files")
        return src_files(
            temp_type = 'templates/acc_templ/integr_support/src_files/',
            temp_top = 'src_files.template_yml',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def ips_list(self):
        print("\n[py] >>  HWPE standalone testbench ~ ips_list")
        return ips_list(
            temp_type = 'templates/acc_templ/integr_support/ips_list/',
            temp_top = 'ips_list.template_yml',
            temp_modules = [],
            path_common = self.path_common
        ).top()



