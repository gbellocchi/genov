'''
 =====================================================================
 Project:       Overlay testbench
 Title:         overlay_tb_hw.py
 Description:   Hardware testbench for accelerator-rich overlay.

 Date:          29.12.2021
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

from python.collector import collector

class OverlayTestbenchHw(collector):
    def top(self):
        return self.get_template()

    
