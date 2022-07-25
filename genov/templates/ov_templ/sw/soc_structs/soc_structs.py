'''
 =====================================================================
 Project:       SoC structs
 Title:         soc_structs.py
 Description:   Definition of C structures for SoC.

 Date:          15.7.2022
 ===================================================================== */

 Copyright (C) 2022 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

from templates.ov_templ.sw.soc_structs.def_struct_perf_eval.top.def_struct_perf_eval import DefStructPerfEval

class SocStructs:
    def __init__(self):
        self.path_common = 'templates/ov_templ/sw/common/'

    def DefStructPerfEval(self):
        print("\n[py] >> SoC structs ~ Performance profiling")
        return DefStructPerfEval(
            temp_type = 'templates/ov_templ/sw/soc_structs/def_struct_perf_eval/',
            temp_top = 'def_struct_perf_eval.template_c',
            temp_modules = [],
            path_common = self.path_common
        ).top()