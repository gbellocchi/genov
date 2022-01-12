'''
 =====================================================================
 Project:       Overlay top class
 Title:         top.py
 Description:   The overlay top class recalls all the the templates 
                compiant with the generation of an overlay system.

 Date:          29.12.2021
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

from templates.ov_templ.hw.top.bender.top.bender import bender

class Cluster:
    def __init__(self):
        print("\n[py] >> Cluster ~ Retrieving hardware components")
        self.path_common = 'templates/ov_templ/hw/common/'

    def ClPkg(self):
        print("\n[py] >> Cluster ~ Cluster package")
        return ClPkg(
            temp_type = 'templates/ov_templ/hw/cluster/cl_pkg/',
            temp_top = 'cl_pkg.template_sv',
            temp_modules = ['hwpe_lic.template_sv',
                            'hwpe_hci.template_sv'],
            path_common = self.path_common
        ).top()

    def LicAccRegion(self):
        print("\n[py] >> Cluster ~ LIC accelerator region")
        return LicAccRegion(
            temp_type = 'templates/ov_templ/hw/cluster/lic_acc_region/',
            temp_top = 'lic_acc_region.template_sv',
            temp_modules = ['acc_region.template_sv', 
                            'hwpe_intf.template_sv'],
            path_common = self.path_common
        ).top()

    def LicAccIntf(self):
        print("\n[py] >> Cluster ~ LIC accelerator interface")
        return LicAccIntf(
            temp_type = 'templates/ov_templ/hw/cluster/lic_acc_intf/',
            temp_top = 'lic_acc_intf.template_sv',
            temp_modules = ['hwpe_intf.template_sv'],
            path_common = self.path_common
        ).top()

    def Bender(self):
        print("\n[py] >> Cluster ~ Bender")
        return bender(
            temp_type = 'templates/ov_templ/hw/cluster/bender/',
            temp_top = 'bender.template_yml',
            temp_modules = [],
            path_common = self.path_common
        ).top()