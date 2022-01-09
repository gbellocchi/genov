'''
 =====================================================================
 Project:       LIC accelerator interface
 Title:         lic_acc_intf.py
 Description:   The LIC accelerator interface is positioned in between an 
                accelerator region and the top module of an accelerator 
                wrapper. The goal of the IP is to decompose the crossbar
                TCDM master interface (from the overlay cluster) into
                the single signals of the TCDM communication protocol.

 Date:          29.12.2021
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

from python.collector import collector

class LicAccIntf(collector):
    def top(self):
        return self.get_template()