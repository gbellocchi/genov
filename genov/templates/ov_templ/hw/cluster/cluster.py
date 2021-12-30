'''
 =====================================================================
 Project:       Cluster class
 Title:         cluster.py
 Description:   The Cluster class recalls all the the templates 
                compiant with the generation of an overlay cluster tailored 
                to an use in the aim of accelerator-rich architectures and
                supporting different accelerator interconnection strategies.

 Date:          29.12.2021
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

from templates.ov_templ.hw.cluster.cl_pkg.top.cl_pkg import ClPkg
from templates.ov_templ.hw.cluster.shared_lic_acc_region.top.shared_lic_acc_region import SharedLicAccRegion
from templates.ov_templ.hw.cluster.private_lic_acc_region.top.private_lic_acc_region import PrivateLicAccRegion
from templates.ov_templ.hw.cluster.acc_intf.top.acc_intf import AccIntf

class Cluster:
    def __init__(self):
        print("\n[py] >> Overlay ~ Retrieving hardware components")
        self.path_common = 'templates/ov_templ/hw/common/'

    def ClPkg(self):
        print("\n[py] >> Overlay ~ Cluster package")
        return ClPkg(
            temp_type = 'templates/ov_templ/hw/cluster/cl_pkg/',
            temp_top = 'cl_pkg.template_sv',
            temp_modules = ['hwpe.template_sv'],
            path_common = self.path_common
        ).top()

    def SharedLicAccRegion(self):
        print("\n[py] >> Overlay ~ Shared LIC accelerator region")
        return SharedLicAccRegion(
            temp_type = 'templates/ov_templ/hw/cluster/shared_lic_acc_region/',
            temp_top = 'shared_lic_acc_region.template_sv',
            temp_modules = ['acc_region.template_sv', 
                            'hwpe_intf.template_sv'],
            path_common = self.path_common
        ).top()

    def PrivateLicAccRegion(self):
        print("\n[py] >> Overlay ~ Private LIC accelerator region")
        return SharedLicAccRegion(
            temp_type = 'templates/ov_templ/hw/cluster/private_lic_acc_region/',
            temp_top = 'private_lic_acc_region.template_sv',
            temp_modules = ['acc_region.template_sv', 
                            'hwpe_intf.template_sv'
            ],
            path_common = self.path_common
        ).top()

    def AccIntf(self):
        print("\n[py] >> Overlay ~ Accelerator interface")
        return AccIntf(
            temp_type = 'templates/ov_templ/hw/cluster/acc_intf/',
            temp_top = 'acc_intf.template_sv',
            temp_modules = ['hwpe_intf.template_sv'],
            path_common = self.path_common
        ).top()