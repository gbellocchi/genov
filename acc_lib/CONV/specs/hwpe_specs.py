########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

# HWPE attributes
class hwpe_specs:
    def __init__(self):

        # Engineer(-s)
        self.author                     = 'Gianluca Bellocchi'
        self.email                      = '<gianluca.bellocchi@unimore.it>'

        # Environment
        self.dest_dir                   = 'output'

        # Generic
        self.hwpe_target                = 'CONV'
        self.design_type                = 'hls'

        # HWPE streaming interfaces
        self.list_sink_stream           = [ 'instream' , 'kernel' ]
        self.list_source_stream         = [ 'outstream' ]
        self.n_sink                     = len(self.list_sink_stream)
        self.n_source                   = len(self.list_source_stream)

        # HWPE standard regfiles
        self.std_reg_num                = 5       

        # HWPE custom regfiles
        self.custom_reg_name            = [ 'len_kernel' ]
        self.custom_reg_dim             = [ 32 ]
        self.custom_reg_num             = len(self.custom_reg_name)
        self.custom_reg_isport          = [ 0 ]

        # FSM
        self.fsm_trans_size             = [ ['len', 'instream'] , ['len_kernel', 'kernel'] , ['len', 'outstream'] ]


