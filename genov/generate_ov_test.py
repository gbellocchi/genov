'''
 =====================================================================
 Project:      Accelerator-Rich Overlay Generator
 Title:        generate_ov_test.py
 Description:  Generation of accelerator-rich overlay test components.

 Date:         13.1.2022
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

import sys

'''
    Import custom functions
'''
from python.overlay.process_params import overlay_params_formatted
from python.overlay.process_params import print_ov_test_log
from python.overlay_test.generator import gen_ov_test_comps

'''
    Import emitter
'''
from python.overlay.emitter import EmitOv

'''
    Import design parameters
'''
from dev.ov_dev.specs.ov_specs import ov_specs

'''
    Import overlay test templates
'''
from templates.ov_templ.hw.test.test import Test

'''
    Read input arguments
'''
dir_out_ov = sys.argv[1]

'''
    Retrieve overlay design parameters
''' 
ov_specs = ov_specs

'''
    Format design parameters
'''
design_params = overlay_params_formatted(ov_specs)

'''
    Print overlay test log
''' 
print_ov_test_log(design_params)

'''
    Instantiate emitter item
'''
emitter = EmitOv(ov_specs, dir_out_ov)

'''
    Instantiate overlay template item
''' 
test = Test()

'''
    =====================================================================
    Component:      Overlay test (Hardware)

    Description:    Generation of test components, such as HW/SW testbench,
                    accelerator runtime calls, Modelsim waves, etc.
    ===================================================================== */
'''

'''
    Generate design components ~ Hardware testbench
    Basic standalone testbench that instantiates the DUT
    (generated accelerator), a RISC-V processor and some
    dummy memories to implement instruction, stack and data
    memories.
''' 
gen_ov_test_comps(
    test.OverlayTestbenchHw(),
    design_params,
    emitter,
    ['tb', 'overlay_tb', ['hw', 'sv']],
    emitter.ov_gen_test
)

'''
    =====================================================================
    Component:      Overlay test (Software)

    Description:    Generation of test components, such as HW/SW testbench,
                    accelerator runtime calls, Modelsim waves, etc.
    ===================================================================== */
'''

'''
    Generate design components ~ Archi
    Retrieve memory-mapped hardware accelerator registers.
''' 
# gen_comps(
#     hwpe_ov_tb_sw.archi_hwpe(),
#     ['sw', 'archi_hwpe', ['sw', 'archi']],
#     emitter.ov_gen_test_hwpe_lib
# )

'''
    Generate design components ~ Hardware abstraction layer (HAL)
    Retrieve Hardware Abstraction Layer with functions that permit 
    to create an interaction between the RISC-V processor and the 
    hardware accelerator.
''' 
# gen_comps(
#     hwpe_ov_tb_sw.hal_hwpe(),
#     ['sw', 'hal_hwpe', ['sw', 'hal']],
#     emitter.ov_gen_test_hwpe_lib
# )

'''
    Generate design components ~ Software testbench 
    Retrieve software testbench to assess HWPE functionality. This 
    is a pure baremetal test running on the riscv proxy core comprised 
    in the overlay system. This tb can be used as a starting point for 
    additional platform testing.
''' 
# gen_comps(
#     hwpe_ov_tb_sw.tb_hwpe(),
#     ['sw', 'tb_hwpe', ['sw', 'tb']],
#     emitter.ov_gen_test_sw
# )

'''
    =====================================================================
    Component:      Overlay test (Debug support)

    Description:    Generation of test components, such as HW/SW testbench,
                    accelerator runtime calls, Modelsim waves, etc.
    ===================================================================== */
'''

'''
    Generate design components ~ QuestaSim waves
''' 
gen_ov_test_comps(
    test.VsimWaveSoc(),
    design_params,
    emitter,
    ['integr_support', 'vsim_wave_soc', ['integr_support', 'vsim_wave']],
    emitter.ov_gen_test_waves
)

for cl_offset in range(design_params.n_clusters):

    '''
        Generate design components ~ QuestaSim waves
    ''' 
    gen_ov_test_comps(
        test.VsimWaveCluster(),
        design_params,
        emitter,
        ['integr_support', 'vsim_wave_cluster_' + str(cl_offset), ['integr_support', 'vsim_wave']],
        emitter.ov_gen_test_waves,
        cl_offset
    )