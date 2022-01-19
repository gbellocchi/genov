'''
 =====================================================================
 Project:       PULP cluster OOC
 Title:         pulp_cluster_ooc.py
 Description:   Stub of PULP Cluster for out-of-context synthesis

 Date:          13.1.2022
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''
#!/usr/bin/env python3

from python.collector import collector

class PulpClusterOOC(collector):
    def top(self):
        return self.get_template()