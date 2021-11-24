'''
 =====================================================================
 Project:       Accelerator-Rich Overlay Generator (AROG)
 Title:         ov_specs.py
 Description:   Specification file to guide the generation of HW/SW
	            components for accelerator-rich overlays.

 Date:          24.11.2021
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

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

    def author_k(self):
        self.author                             = 'Gianluca Bellocchi'    
        self.email                              = '<gianluca.bellocchi@unimore.it>'
        return self

    '''
        Accelerator #0
            >> Target name:         Traffic generator
            >> Connectionn type:    Logarithmic interconnect
            >> Protocol type:       Hardware processing engine (HWPE)
    '''

    def acc_0(self):
        self.target                             = 'traffic_gen'
        self.connection_type                    = 'lic'
        self.protocol_type                      = 'hwpe'
        return self

    '''
        Accelerator #1
            >> Target name:         Traffic generator
            >> Connectionn type:    Logarithmic interconnect
            >> Protocol type:       Hardware processing engine (HWPE)
    '''

    def acc_1(self):
        self.target                             = 'traffic_gen'
        self.connection_type                    = 'lic'
        self.protocol_type                      = 'hwpe'
        return self

    '''
        Accelerator #2
            >> Target name:         Traffic generator
            >> Connectionn type:    Logarithmic interconnect
            >> Protocol type:       Hardware processing engine (HWPE)
    '''

    def acc_2(self):
        self.target                             = 'traffic_gen'
        self.connection_type                    = 'lic'
        self.protocol_type                      = 'hwpe'
        return self

    # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

    # Additional parameters

    # def kernel_d(self):
    #     # Kernel interface
    #     self.is_ap_ctrl_hs                      = self.intf_kernel[0]
    #     self.is_mdc_dataflow                    = self.intf_kernel[1]

    # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

    def __init__(self):
        # user-defined
        self.author()
        self.accelerators()
        # derived
        # self.kernel_d()

    # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

