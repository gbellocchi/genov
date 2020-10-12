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
        self.hwpe_target                = 'rayMarching'
        self.design_type                = 'hls'

        # HWPE streaming interfaces
        self.list_sink_stream           = [ 'port0' , 'port011' , 'port1' , 'port2' ]
        self.list_source_stream         = [ 'port012' ]
        self.n_sink                     = len(self.list_sink_stream)
        self.n_source                   = len(self.list_source_stream)

        # HWPE standard regfiles
        self.std_reg_num                = 5       

        # HWPE custom regfiles
        self.custom_reg_name            = [ 'n_particles' ,  'map_height' , 'map_width' , 'orig_x' , 'orig_y' , 'angleMin' , 'angleIncrement' , 'map_resolution' , 'maxRange' ]
        self.custom_reg_dim             = [ 32 , 32 , 32 , 32 , 32 , 32 , 32 , 32 , 32  ]
        self.custom_reg_num             = len(self.custom_reg_name)
        self.custom_reg_isport          = [ 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 ]

        # FSM
        self.fsm_trans_size             = [ ['len', 'port0'] , ['len', 'port011'] , ['len', 'port1'] , ['len', 'port2'] , ['len', 'port3'] ]


