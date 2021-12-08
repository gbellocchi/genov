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
        System
    '''

    def system_k(self):
        self.n_acc                              = 3
        return self

    '''
        Accelerator #0
            >> Target name:                 Traffic generator
            >> Protocol type:               Hardware processing engine (HWPE)
            >> Interconnection method:      Shared logarithmic interconnect
    '''

    def acc_0(self):
        self.target                             = 'traffic_gen'
        self.protocol_type                      = 'hwpe'
        self.connection_type                    = 'shared_lic'
        self.offset                             = 0
        return self

    '''
        Accelerator #1
            >> Target name:                 2D convolution
            >> Protocol type:               Hardware processing engine (HWPE)
            >> Interconnection method:      Shared logarithmic interconnect
    '''

    def acc_1(self):
        self.target                             = 'conv_mdc'
        self.protocol_type                      = 'hwpe'
        self.connection_type                    = 'shared_lic'
        self.offset                             = 1
        return self

    '''
        Accelerator #2
            >> Target name:                 Traffic generator
            >> Protocol type:               Hardware processing engine (HWPE)
            >> Interconnection method:      Shared logarithmic interconnect
    '''

    def acc_2(self):
        self.target                             = 'traffic_gen'
        self.protocol_type                      = 'hwpe'
        self.connection_type                    = 'shared_lic'
        self.offset                             = 2
        return self

    # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

    '''
        Additional parameters taht are derived from the user-defined ones. Do not modify this part.
    '''

    '''
        Derived accelerator targets list
    '''

    def targets_list(self):
        self.targets_list = []
        for attribute in dir(ov_specs):
            if "acc_" in attribute:
                method = getattr(self, attribute)
                self.targets_list.append(method)

    # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

    def __init__(self):
        # user-defined
        self.author_k()
        self.system_k()
        # self.acc_0()
        # self.acc_1()
        # self.acc_2()
        # derived
        self.targets_list()

    # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

