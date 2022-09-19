'''
 =====================================================================
 Project:       Accelerator-Rich Overlay Generator (AROG)
 Title:         ov_specs.py
 Description:   Specification file to guide the generation of HW/SW
	            components for accelerator-rich overlays.

 ===================================================================== */

 Copyright (C) 2022 University of Modena and Reggio Emilia.

 Author: Alessandro Capotondi, University of Modena and Reggio Emilia.

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
        # Insert Your Name (optional)
        self.author                             = 'Alessandro Capotondi'
        # Insert Your Email (optional)
        self.email                              = 'a.capotondi@unimore.it'
        return self

    '''
        System
    '''

    def system(self):
        # Insert the Overaly Name (same of the folder)
        self.ov_config                          = 'example1'
        # Insert the Overaly Target
        # (xilzu9eg (for zcu102), xilzu7ev (for zcu104),
        #  xilzu3eg (for ultra96), k26 (for kv260))
        self.target_soc                         = 'xilzu9eg'
        return self

    '''
        Cluster #0

        - 'core' ~ [ core_name, n_cores ]
        - 'tcdm' ~ [ n_tcdm_banks, tcdm_size ]
        - 'lic' ~ [ acc_name , wrapper_protocol ]
        - 'hci' ~ [ acc_name , wrapper_protocol ]
    '''

    def cluster_0(self):
        # Cluster ID (same of the contructor...)
        self.cl_offset                          = 0
        # Core definition (['type'], NumberOfCores)
        # type = {riscy | ibex}
        # NumeberOfCores = must be log2 and not greater than 16
        self.core                               = [ 'riscy', 8 ]
        # Memory declaration (NumberOfBanks, TotalSizeInKB)
        # NumberOfBanks = must be log2 and not greater than 64
        # TotalSizeInKB = must be lower than 2MB
        self.tcdm                               = [ 16 , 128]
        # Internal Interconnection list of couples ([['HW_IP_Name'], ['Interface']])
        # HW_IP_Name = same of src/accelerators
        # Interface/Protocol = 
        self.lic                                = [ [ 'traffic_gen' , 'hwpe'],
                                                    [ 'traffic_gen' , 'hwpe'],
                                                    [ 'traffic_gen' , 'hwpe'],
                                                    [ 'traffic_gen' , 'hwpe']
                                                  ]
        self.hci                                = [ ]
        return self