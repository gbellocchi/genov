'''
 =====================================================================
 Project:       PULP IP
 Title:         pulp_ip.py
 Description:   PULP IP

 Date:          25.1.2022
 ===================================================================== */

 Copyright (C) 2022 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''
#!/usr/bin/env python3

from python.collector import collector

class PulpIp(collector):
    def top(self):
        return self.get_template()