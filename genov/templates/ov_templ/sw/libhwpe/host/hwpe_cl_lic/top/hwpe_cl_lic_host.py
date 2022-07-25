'''
 =====================================================================
 Project:       LibHWPE 
 Title:         hwpe_cl_lic_host.py
 Description:   Software APIs for host.

 Date:          13.7.2022
 ===================================================================== */

 Copyright (C) 2022 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

from python.collector import collector

class HwpeClLicHost(collector):
    def top(self):
        return self.get_template()

    
