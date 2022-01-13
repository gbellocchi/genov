'''
 =====================================================================
 Project:       L2 memory
 Title:         l2_mem.py
 Description:   L2 memory

 Date:          13.1.2022
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''
#!/usr/bin/env python3

from python.collector import collector

class L2Mem(collector):
    def top(self):
        return self.get_template()