'''
 =====================================================================
 Project:       Cluster class
 Title:         cluster.py
 Description:   The Cluster class recalls all the the templates 
                compliant with the generation of an overlay cluster tailored 
                to an use in the aim of accelerator-rich architectures and
                supporting different accelerator interconnection strategies.

 Date:          29.12.2021
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

from templates.ov_templ.hw.cluster.bender.top.bender import Bender
from templates.ov_templ.hw.cluster.cl_pkg.top.cl_pkg import ClPkg
from templates.ov_templ.hw.cluster.dmac_wrap_ooc.top.dmac_wrap_ooc import DmacWrapOOC
from templates.ov_templ.hw.cluster.lic_acc_region.top.lic_acc_region import LicAccRegion
from templates.ov_templ.hw.cluster.lic_acc_intf.top.lic_acc_intf import LicAccIntf
from templates.ov_templ.hw.cluster.pulp_cluster_ooc.top.pulp_cluster_ooc import PulpClusterOOC

class Cluster:
    def __init__(self):
        self.path_common = 'templates/ov_templ/hw/common/'

    def Bender(self):
        print("\n[py] >> Cluster ~ Bender")
        return Bender(
            temp_type = 'templates/ov_templ/hw/cluster/bender/',
            temp_top = 'bender.template_yml',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def ClPkg(self):
        print("\n[py] >> Cluster ~ Cluster package")
        return ClPkg(
            temp_type = 'templates/ov_templ/hw/cluster/cl_pkg/',
            temp_top = 'cl_pkg.template_sv',
            temp_modules = ['hwpe_lic.template_sv',
                            'hwpe_hci.template_sv'],
            path_common = self.path_common
        ).top()

    def DmacWrapOOC(self):
        print("\n[py] >> Cluster ~ DMA wrapper OOC")
        return DmacWrapOOC(
            temp_type = 'templates/ov_templ/hw/cluster/dmac_wrap_ooc/',
            temp_top = 'dmac_wrap_ooc.template_sv',
            temp_modules = [],
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

    def PulpClusterOOC(self):
        print("\n[py] >> Cluster ~ PULP cluster OOC")
        return PulpClusterOOC(
            temp_type = 'templates/ov_templ/hw/cluster/pulp_cluster_ooc/',
            temp_top = 'pulp_cluster_ooc.template_sv',
            temp_modules = [],
            path_common = self.path_common
        ).top()