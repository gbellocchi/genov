'''
 =====================================================================
 Project:       Cluster package
 Title:         cl_pkg.py
 Description:   Packages compliant with hardware accelerator parameters.

 Date:          29.12.2021
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''
#!/usr/bin/env python3

from collector import collector

class ClPkg(collector):
    def top(self):
        return self.get_template()