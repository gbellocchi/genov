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
        self.target                             = 'fir_128_mdc'
        self.design_type                        = 'hls'
        # Kernel design [ is_ap_ctrl_hs , is_mdc_dataflow ]
        self.intf_kernel                        = [ False , True ]
        return self

    def streaming_k(self):
        # HWPE streaming interfaces [ name , data-type , reg-dim , is_parallel , parallelism_factor]
        self.list_sink_stream                   = [ [ 'din_strm_V' , 'int32_t' , 32 , False, 1 ] ]
        self.list_source_stream                 = [ [ 'dout_strm_V' , 'int32_t' , 32 , False, 1 ] ]
        return self

    def regfile_k(self):
        # HWPE standard regfiles
        self.std_reg_num                        = 4       
        # HWPE custom regfiles [ name , data-type , reg-dim , is_port ]
        self.custom_reg                         = [ [ 'coeff_0' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff_1' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_2' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff_3' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff_4' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_5' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_6' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff_7' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_8' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_9' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff_10' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_11' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_12' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff_13' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_14' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_15' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff_16' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_17' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_18' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff_19' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_20' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_21' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff_22' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_23' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_24' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff_25' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_26' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_27' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff_28' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_29' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_30' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_31' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff_32' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_33' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_34' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff_35' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_36' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_37' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff_38' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_39' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_40' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_41' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff_42' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_43' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_44' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff_45' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_46' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_47' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff_48' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_49' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_50' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_51' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff_52' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_53' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_54' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff_55' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_56' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_57' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff_58' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_59' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_60' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_61' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff_62' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_63' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_64' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff_65' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_66' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_67' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff_68' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_69' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_70' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_71' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff_72' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_73' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_74' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff_75' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_76' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_77' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff_78' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_79' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_80' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_81' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff_82' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_83' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_84' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff_85' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_86' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_87' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff_88' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_89' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_90' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_91' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff_92' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_93' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_94' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff_95' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_96' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_97' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff_98' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_99' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_100' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_101' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff_102' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_103' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_104' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff_105' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_106' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_107' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff_108' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_109' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_110' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_111' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff_112' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_113' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_114' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff_115' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_116' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_117' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff_118' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_119' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_120' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_121' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff_122' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_123' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_124' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'coeff_125' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_126' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'coeff_127' , 'uint32_t' , 32 , 1 ] ]
        return self

    def addressgen_k(self):
        # Address generation [ is_programmable ]
        self.addr_gen_in                        = [ [True] ]
        self.addr_gen_out                       = [ [True] ]
        return self

    # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

    # Additional parameters

    def kernel_d(self):
        # Kernel interface
        self.is_ap_ctrl_hs                      = self.intf_kernel[0]
        self.is_mdc_dataflow                    = self.intf_kernel[1]

    def streaming_d(self):    
        self.n_sink                             = len(self.list_sink_stream)
        self.n_source                           = len(self.list_source_stream)
        self.stream_in                          = [item[0] for item in self.list_sink_stream]
        self.stream_out                         = [item[0] for item in self.list_source_stream]
        self.stream_in_dtype                    = [item[1] for item in self.list_sink_stream]
        self.stream_out_dtype                   = [item[1] for item in self.list_source_stream]
        self.is_parallel_in                     = [item[3] for item in self.list_sink_stream]
        self.is_parallel_out                    = [item[3] for item in self.list_source_stream]
        self.in_parallelism_factor              = [item[4] for item in self.list_sink_stream]
        self.out_parallelism_factor             = [item[4] for item in self.list_source_stream]
        return self

    def regfile_d(self):    
        # HWPE custom regfiles
        self.custom_reg_name                    = [item[0] for item in self.custom_reg]
        self.custom_reg_dtype                   = [item[1] for item in self.custom_reg]
        self.custom_reg_dim                     = [item[2] for item in self.custom_reg]
        self.custom_reg_isport                  = [item[3] for item in self.custom_reg]
        self.custom_reg_num                     = len(self.custom_reg)
        return self

    def addressgen_d(self):
        # Address generation
        self.addr_gen_in_isprogr                = [item[0] for item in self.addr_gen_in]
        self.addr_gen_out_isprogr               = [item[0] for item in self.addr_gen_out]
        return self

    # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

    def __init__(self):
        # user-defined
        self.author_k()
        self.kernel_k()
        self.streaming_k()
        self.regfile_k()
        self.addressgen_k()
        # derived
        self.kernel_d()
        self.streaming_d()
        self.regfile_d()
        self.addressgen_d()

    # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

