'''
 =====================================================================
 Project:       LibHwpe class
 Title:         libhwpe.py
 Description:   The LibHwpe class recalls all the the templates 
                compliant with the generation of the software libraries
                for HWPE wrappers.

 Date:          29.12.2022
 ===================================================================== */

 Copyright (C) 2022 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

from templates.ov_templ.sw.libhwpe.host.hwpe_cl_lic.top.hwpe_cl_lic_host import HwpeClLicHost
from templates.ov_templ.sw.libhwpe.host.makefile.top.makefile_host import MakefileHost
from templates.ov_templ.sw.libhwpe.pulp.hwpe_cl_lic.top.hwpe_cl_lic_pulp import HwpeClLicPulp
from templates.ov_templ.sw.libhwpe.pulp.makefile.top.makefile_pulp import MakefilePulp
from templates.ov_templ.sw.libhwpe.inc.hwpe_cl_lic.top.hwpe_cl_lic_header import HwpeClLicHeader

class LibHwpe:
    def __init__(self):
        self.path_common = 'templates/ov_templ/sw/common/'

    def HwpeClLicHost(self, name):
        print("\n[py] >> Overlay Libs ~ %s (Host APIs)" % name.upper())
        return HwpeClLicHost(
            temp_type = 'templates/ov_templ/sw/libhwpe/host/hwpe_cl_lic/',
            temp_top = 'hwpe_cl_lic_host.template_c',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def MakefileHost(self, name):
        print("\n[py] >> Overlay Libs ~ %s (Host Makefile)" % name.upper())
        return MakefileHost(
            temp_type = 'templates/ov_templ/sw/libhwpe/host/makefile/',
            temp_top = 'makefile_host.template_mk',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def HwpeClLicPulp(self, name):
        print("\n[py] >> Overlay Libs ~ %s (PULP APIs)" % name.upper())
        return HwpeClLicPulp(
            temp_type = 'templates/ov_templ/sw/libhwpe/pulp/hwpe_cl_lic/',
            temp_top = 'hwpe_cl_lic_pulp.template_c',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def MakefilePulp(self, name):
        print("\n[py] >> Overlay Libs ~ %s (PULP Makefile)" % name.upper())
        return MakefilePulp(
            temp_type = 'templates/ov_templ/sw/libhwpe/pulp/makefile/',
            temp_top = 'makefile_pulp.template_mk',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def HwpeClLicHeader(self, name):
        print("\n[py] >> Overlay Libs ~ %s (Header)" % name.upper())
        return HwpeClLicHeader(
            temp_type = 'templates/ov_templ/sw/libhwpe/inc/hwpe_cl_lic/',
            temp_top = 'hwpe_cl_lic_header.template_c',
            temp_modules = [],
            path_common = self.path_common
        ).top()