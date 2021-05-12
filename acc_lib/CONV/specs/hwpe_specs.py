########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

# HWPE attributes
class hwpe_specs:
    def __init__(self):

        # Engineer(-s)
        self.author             = 'Gianluca Bellocchi'
        self.email              = '<gianluca.bellocchi@unimore.it>'

        # Environment
        self.dest_dir           = 'output'

        # Generic
        self.hwpe_target        = 'CONV'
        self.design_type        = 'hls'

        # Kernel design [ is_ap_ctrl , is_dflow ]
        self.intf_kernel        = [ False , True ]

        # HWPE streaming interfaces [ name , data-type , reg-dim ]
        self.list_sink_stream   = [ [ 'x1_V' , 'int32_t' , 32 ] , [ 'x2_V' , 'int32_t' , 32 ] ]
        self.list_source_stream = [ [ 'y_V' , 'int32_t' , 32 ] ]
        self.n_sink             = len(self.list_sink_stream)
        self.n_source           = len(self.list_source_stream)

        # HWPE standard regfiles
        self.std_reg_num        = 5       

        # HWPE custom regfiles [ name , data-type , reg-dim , isport ]
        self.custom_reg         = [ [ 'k11_V'  , 'int32_t' , 32 , 1 ] ,
                                    [ 'k21_V'  , 'int32_t' , 32 , 1 ] ,
                                    [ 'k12_V'  , 'int32_t' , 32 , 1 ] ,
                                    [ 'k22_V'  , 'int32_t' , 32 , 1 ] ,
                                    [ 'x1_p_V' , 'int32_t' , 32 , 1 ] ,
                                    [ 'x2_p_V' , 'int32_t' , 32 , 1 ] ]
                                    
        self.custom_reg_num     = len(self.custom_reg)

        # Address generation [ is_hardwired , is_programmed ]
        self.addr_gen           = [ False , True ]

