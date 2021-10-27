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
        self.hwpe_target        = 'fir_mdc'
        self.design_type        = 'hls'

        # Kernel design [ is_ap_ctrl_hs , is_mdc_dataflow ]
        self.intf_kernel        = [ False , True ]

        # HWPE streaming interfaces [ name , data-type , reg-dim , is_parallel , parallelism_factor]
        self.list_sink_stream   = [ [ 'x_V' , 'int32_t' , 32 , False, 1 ] ]
        self.list_source_stream = [ [ 'y_V' , 'int32_t' , 32 , False, 1 ] ]
        self.n_sink             = len(self.list_sink_stream)
        self.n_source           = len(self.list_source_stream)

        # HWPE standard regfiles
        self.std_reg_num        = 4       

        # HWPE custom regfiles [ name , data-type , reg-dim , is_port ]
        self.custom_reg         = [ [ 'coeff0_V' , 'uint32_t' , 32 , 1 ] , 
                                    [ 'coeff1_V' , 'uint32_t' , 32 , 1 ] ,
                                    [ 'coeff2_V' , 'uint32_t' , 32 , 1 ] , 
                                    [ 'coeff3_V' , 'uint32_t' , 32 , 1 ] ]

        self.custom_reg_num     = len(self.custom_reg)

        # Address generation [ is_programmable ]
        self.addr_gen_in        = [ [True] ]
        self.addr_gen_out       = [ [True] ]

