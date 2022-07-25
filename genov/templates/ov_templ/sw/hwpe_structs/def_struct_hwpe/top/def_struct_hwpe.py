'''
 =====================================================================
 Project:       HWPE structs 
 Title:         def_struct_traffic_gen.py
 Description:   Definition of C structures for HWPE wrappers.

 Date:          15.7.2022
 ===================================================================== */

 Copyright (C) 2022 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

from python.collector import collector

class DefStructHwpe(collector):
    def top(self):
        return self.get_template()

    
