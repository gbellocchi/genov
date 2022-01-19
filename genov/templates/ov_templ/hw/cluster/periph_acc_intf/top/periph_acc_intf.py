'''
 =====================================================================
 Project:       Peripheral accelerator interface
 Title:         periph_acc_intf.py
 Description:   The peripheral accelerator interface routes the slave 
                peripheral signals toward the slave port of HWPE-based
                accelerator wrappers.

 Date:          19.1.2022
 ===================================================================== */

 Copyright (C) 2022 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

from python.collector import collector

class PeriphAccIntf(collector):
    def top(self):
        return self.get_template()