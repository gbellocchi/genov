'''
 =====================================================================
 Project:       SoC structures
 Title:         def_struct_perf_eval.py
 Description:   Definition of default structures for performance profiling.

 Date:          15.7.2022
 ===================================================================== */

 Copyright (C) 2022 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

from python.collector import collector

class DefStructPerfEval(collector):
    def top(self):
        return self.get_template()

    
