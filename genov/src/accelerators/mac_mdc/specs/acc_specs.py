'''
 =====================================================================
 Project:       MAC mdc
 Title:         acc_specs.py
 Description:   Specification file to guide the generation of HW/SW
	            components for hardware wrappers.

 Date:          25.1.2022
 ===================================================================== */

 Copyright (C) 2022 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

class acc_specs:

    def author(self):
        self.author                             = 'Gianluca Bellocchi'    
        self.email                              = '<gianluca.bellocchi@unimore.it>'
        return self

    def kernel(self):
        self.target                             = 'mac_mdc'
        self.design_type                        = 'hdl'
        self.intf_kernel                        = [ False, True ]
        return self

    def streaming(self):
        self.list_sink_stream                   = [ [ 'a' , 'int32_t' , 32 , False, 1 ] , [ 'b' , 'int32_t' , 32 , False, 1 ] , [ 'c' , 'int32_t' , 32 , False, 1 ] ]
        self.list_source_stream                 = [ [ 'd' , 'int32_t' , 32 , False, 1 ] ]
        return self

    def regfile(self):
        self.std_reg_num                        = 4       
        self.custom_reg                         = [ [ 'reg_simple_mul' , 'int'     , 1  , 1 ] ,
                                                    [ 'reg_shift'      , 'int8_t'  , 8  , 1 ] ,
                                                    [ 'reg_len'        , 'int16_t' , 16 , 1 ] ]
        return self

    def addressgen(self):
        self.addr_gen_in                        = [ [True] , [True] , [True] ]
        self.addr_gen_out                       = [ [True] ]
        return self