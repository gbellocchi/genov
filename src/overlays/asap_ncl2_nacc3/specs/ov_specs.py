'''
 =====================================================================
 Project:       Accelerator-Rich Overlay Generator (AROG)
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

    '''
        ==========
        User knobs
        ==========
    '''

    '''
        Author information
    '''

    def author(self):
        self.author                             = 'Gianluca Bellocchi'    
        self.email                              = '<gianluca.bellocchi@unimore.it>'
        return self

    '''
        System
    '''

    def system(self):
        self.ov_config                          = 'asap_ncl2_nacc3'
        return self

    '''
        Cluster #0

        - 'core' ~ [ core_name, n_cores ]
        - 'tcdm' ~ [ n_tcdm_banks, tcdm_size ]
        - 'lic' ~ [ acc_name , wrapper_protocol ]
        - 'hci' ~ [ acc_name , wrapper_protocol ]
    '''

    def cluster_0(self):
        self.cl_offset                          = 0
        self.core                               = [ 'riscy', 2 ]
        self.tcdm                               = [ 32 , 128]
        self.lic                                = [ [ 'traffic_gen' , 'hwpe'],
                                                    [ 'traffic_gen' , 'hwpe'],
                                                    [ 'traffic_gen' , 'hwpe']]
        self.hci                                = [ ]
        return self

    def cluster_1(self):
        self.cl_offset                          = 0
        self.core                               = [ 'riscy', 2 ]
        self.tcdm                               = [ 32 , 128]
        self.lic                                = [ [ 'traffic_gen' , 'hwpe'],
                                                    [ 'traffic_gen' , 'hwpe'],
                                                    [ 'traffic_gen' , 'hwpe']]
        self.hci                                = [ ]
        return self