'''
 =====================================================================
 Project:       Cluster package
 Title:         pulp_cluster_cfg_pkg.py
 Description:   Packages compliant with hardware accelerator parameters.

 Date:          29.12.2021
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''
#!/usr/bin/env python3

from python.collector import collector

class PulpClusterCfgPkg(collector):
    def top(self):
        return self.get_template()