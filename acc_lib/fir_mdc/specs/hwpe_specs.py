########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

# HWPE attributes
class hwpe_specs:

    # User knobs

    def author_k(self):
        # Engineer(-s)
        self.author                             = 'Gianluca Bellocchi'    
        self.email                              = '<gianluca.bellocchi@unimore.it>'
        return self

    def kernel_k(self):
        # Generic
        self.hwpe_target                        = 'fir_mdc'
        self.design_type                        = 'hls'
        # Kernel design [ is_ap_ctrl_hs , is_mdc_dataflow ]
        self.intf_kernel                        = [ False , True ]
        return self

    def streaming_k(self):
        # HWPE streaming interfaces [ name , data-type , reg-dim , is_parallel , parallelism_factor]
        self.list_sink_stream                   = [ [ 'x_V' , 'int32_t' , 32 , False, 1 ] ]
        self.list_source_stream                 = [ [ 'y_V' , 'int32_t' , 32 , False, 1 ] ]
        return self

    def regfile_k(self):
        # HWPE standard regfiles
        self.std_reg_num                        = 4       
        # HWPE custom regfiles [ name , data-type , reg-dim , is_port ]
        self.custom_reg                         = [ [ 'coeff0_V' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff1_V' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff2_V' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff3_V' , 'uint32_t' , 32 , 1 ] ]
        self.custom_reg_num                     = len(self.custom_reg)
        return self

    def addressgen_k(self):
        # Address generation [ is_programmable ]
        self.addr_gen_in                        = [ [True] ]
        self.addr_gen_out                       = [ [True] ]
        return self

    # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

    # Additional parameters

    def env_d(self):
        # Environment
        self.dest_dir                           = 'output'
        return self

    def streaming_d(self):    
        self.n_sink                             = len(self.list_sink_stream)
        self.n_source                           = len(self.list_source_stream)
        self.sink_stream                        = [item[0] for item in self.list_sink_stream]
        self.source_stream                      = [item[0] for item in self.list_source_stream]
        self.sink_is_parallel                   = [item[3] for item in self.list_sink_stream]
        self.source_is_parallel                 = [item[3] for item in self.list_source_stream]
        self.sink_parallelism_factor            = [item[4] for item in self.list_sink_stream]
        self.source_parallelism_factor          = [item[4] for item in self.list_source_stream]
        return self

    # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

    def __init__(self):
        self.author_k()
        self.kernel_k()
        self.streaming_k()
        self.regfile_k()
        self.addressgen_k()
        self.env_d()
        self.streaming_d()

    # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

