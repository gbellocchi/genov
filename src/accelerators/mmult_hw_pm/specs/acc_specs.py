'''
 =====================================================================
 Project:       Matrix multiplication (AB)
 Version:       MMULT HW_PM
 Title:         acc_specs.py
 Description:   Specification file to guide the generation of HW/SW
	            components for hardware wrappers.

 Date:          12.11.2021
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

class acc_specs:

    def wrapper(self):
        self.is_third_party                     = False
        return self

    def author(self):
        self.author                             = 'Gianluca Bellocchi'    
        self.email                              = '<gianluca.bellocchi@unimore.it>'
        return self

    def kernel(self):
        self.target                             = 'mmult_hw_pm'
        self.design_type                        = 'hls'
        self.intf_kernel                        = [ True , False ]
        return self

    def streaming(self):
        self.list_sink_stream                   = [ [ 'in1' , 'int32_t' , 32 , True , 16],
                                                    [ 'in2' , 'int32_t' , 32 , True , 16] ]
        self.list_source_stream                 = [ [ 'out_r' , 'int32_t' , 32 , False , 1] ]
        return self

    def regfile(self):
        self.std_reg_num                        = 4       
        self.custom_reg                         = [ ]
        return self

    def addressgen(self):
        self.addr_gen_in                        = [ [True], [True] ]
        self.addr_gen_out                       = [ [True] ]
        return self