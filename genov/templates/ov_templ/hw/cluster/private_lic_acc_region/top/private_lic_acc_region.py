'''
 =====================================================================
 Project:       Overlay templates
 Title:         private_lic_acc_region.py
 Description:   The accelerator region is connected to the overlay 
                infrastructure by means of a private logarithmic 
                interconnect. This module also instantiates an 
                accelerator interface to the accelerator wrapper.

 Date:          29.12.2021
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

from collector import collector

class PrivateLicAccRegion(collector):
    def top(self):
        return self.get_template()