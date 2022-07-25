'''
 =====================================================================
 Project:       HWPE structs
 Title:         hwpe_structs.py
 Description:   Definition of C structures for HWPE wrappers.

 Date:          15.7.2022
 ===================================================================== */

 Copyright (C) 2022 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

from templates.ov_templ.sw.hwpe_structs.def_struct_common.top.def_struct_common import DefStructCommon
from templates.ov_templ.sw.hwpe_structs.def_struct_hwpe.top.def_struct_hwpe import DefStructHwpe

class HwpeStructs:
    def __init__(self):
        self.path_common = 'templates/ov_templ/sw/common/'

    def DefStructCommon(self):
        print("\n[py] >> HWPE structs ~ Common")
        return DefStructCommon(
            temp_type = 'templates/ov_templ/sw/hwpe_structs/def_struct_common/',
            temp_top = 'def_struct_common.template_c',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def DefStructHwpe(self, name):
        print("\n[py] >> HWPE structs ~ %s" % name)
        return DefStructHwpe(
            temp_type = 'templates/ov_templ/sw/hwpe_structs/def_struct_hwpe/',
            temp_top = 'def_struct_hwpe.template_c',
            temp_modules = [],
            path_common = self.path_common
        ).top()