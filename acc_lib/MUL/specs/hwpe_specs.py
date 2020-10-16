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
        self.hwpe_target        = 'MUL'
        self.design_type        = 'hls'

        # HWPE streaming interfaces [ name , data-type , reg-dim ]
        self.list_sink_stream   = [ [ 'x1_V' , 'int32_t' , 32 ] , [ 'x2_V' , 'int32_t' , 32 ] ]
        self.list_source_stream = [ [ 'y_V' , 'int32_t' , 32 ] ]
        self.n_sink             = len(self.list_sink_stream)
        self.n_source           = len(self.list_source_stream)

        # HWPE standard regfiles
        self.std_reg_num        = 5       

        # HWPE custom regfiles [ name , data-type , reg-dim , isport ]
        self.custom_reg         = [ ]
        self.custom_reg_num     = len(self.custom_reg)

        # FSM
        self.fsm_trans_size     = [ ['len', 'x1_V'] , ['len', 'x2_V'] , ['len', 'y_V'] ]

        # RISC-V firmware stimuli 
        self.input_stimuli      = [ 'stim_x1' , 'stim_x2' ]
        self.output_result      = [ 'res_y' ]
        # self.custom_reg_values  = []

