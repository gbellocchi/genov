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
        self.hwpe_target                = 'MAC'
        self.design_type                = 'manual'

        # HWPE streaming interfaces
        self.list_sink_stream           = [ 'a_i' , 'b_i' , 'c_i' ]
        self.list_source_stream         = [ 'd_o' ]
        self.n_sink                     = len(self.list_sink_stream)
        self.n_source                   = len(self.list_source_stream)

        # HWPE standard regfiles
        self.std_reg_num                = 5       

        # HWPE custom regfiles
        self.custom_reg_name            = [ 'naive_mul' , 'new_shift' ]
        self.custom_reg_dim             = [ 1 , 5 ]
        self.custom_reg_num             = len(self.custom_reg_name)
        self.custom_reg_isport          = [ 1 , 1 ]

        # FSM
        self.fsm_trans_size             = [ ['len', 'a_i'] , ['len', 'b_i'] , ['len', 'c_i'] , ['len', 'd_o'] ]


