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
        self.hwpe_target        = 'MMUL_PARALLEL'
        self.design_type        = 'hls'

        # Kernel design [ is_ap_ctrl , is_dflow ]
        self.intf_kernel        = [ False , True ]

        # HWPE streaming interfaces [ name , data-type , reg-dim , is_parallel , parallelism_factor]
        self.list_sink_stream   = [ [ 'in1' , 'int32_t' , 32 , True , 16 ] , [ 'in2' , 'int32_t' , 32 , True , 16 ] ]
        self.list_source_stream = [ [ 'out_r' , 'int32_t' , 32 , False, 1] ]
        self.n_sink             = len(self.list_sink_stream)
        self.n_source           = len(self.list_source_stream)

        # HWPE standard regfiles
        self.std_reg_num        = 5       

        # HWPE custom regfiles [ name , data-type , reg-dim , isport ]
        self.custom_reg         = [ ]
        self.custom_reg_num     = len(self.custom_reg)

        # Address generation [ is_hardwired , is_programmed ]
        self.addr_gen           = [ False , True ]

