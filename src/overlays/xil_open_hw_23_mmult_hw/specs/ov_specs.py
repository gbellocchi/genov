'''
 =====================================================================
 Project:       GenOv
 Title:         ov_specs.py
 Description:   Specification file to guide the generation of HW/SW
	            components for accelerator-rich overlays.

 Date:          17.2.2022
 ===================================================================== */

 Copyright (C) 2022 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

class ov_specs:

    def author(self):
        self.author                             = 'Gianluca Bellocchi'    
        self.email                              = '<gianluca.bellocchi@unimore.it>'
        return self

    def system(self):
        self.ov_config                          = 'xil_open_hw_23_mmult_hw'
        self.target_soc                         = 'zcu102'
        return self

    def cluster_0(self):
        self.cl_offset                          = 0
        self.core                               = [ 'riscy', 2 ]
        self.tcdm                               = [ 16 , 128*1024]
        self.lic                                = [ ['mmult_hw' , 'hwpe']]
        self.hci                                = [ ]
        return self