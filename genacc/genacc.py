
########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

from classes import genacc, emitter

# HW packages
from templates.hw.hwpe_wrapper.hwpe_wrapper import hwpe_wrapper
from templates.hw.overlay.overlay import overlay

# Integration support packages
from templates.integr_support.integr_support import integr_support

# SW packages
from templates.sw.hwpe_wrapper_tb.hwpe_wrapper_tb import hwpe_wrapper_tb

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

'''
    Generator
    =========

    Instantiate generator item
'''
genacc = genacc()

'''
    Emitter
    =======

    Instantiate export item
'''
emitter = emitter()

'''
    Output environment
    ==================

    Create output environment
'''
emitter.create_out_hw_env()
emitter.create_out_sw_env()
emitter.create_out_ov_integr_env()

'''
    Static
    ======

    Export static components
'''
emitter.out_hw_static() 
emitter.out_sw_static()

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

'''
    Hardware wrapper
    ================

    Instantiate HWPE wrapper item
'''
hwpe_wrapper = hwpe_wrapper()

'''
    Generate design components ~ Top wrapper
'''
template = hwpe_wrapper.top_wrapper()
out_target = genacc.gen(template)
filename = emitter.get_file_name(['hwpe', 'top_wrapper', ['hw', 'rtl']])
emitter.out_gen(out_target, filename, emitter.out_hw_hwpe_engine)

'''
    Generate design components ~ Top
'''
template = hwpe_wrapper.top()
out_target = genacc.gen(template)
filename = emitter.get_file_name(['hwpe', 'top', ['hw', 'rtl']])
emitter.out_gen(out_target, filename, emitter.out_hw_hwpe_engine)

'''
    Generate design components ~ Engine
'''
template = hwpe_wrapper.engine()
out_target = genacc.gen(template)
filename = emitter.get_file_name(['hwpe', 'engine', ['hw', 'rtl']])
emitter.out_gen(out_target, filename, emitter.out_hw_hwpe_engine)

'''
    Generate design components ~ Kernel adapter
'''
template = hwpe_wrapper.kernel_adapter()
out_target = genacc.gen(template)
filename = emitter.get_file_name(['hwpe', 'kernel_adapter', ['hw', 'rtl']])
emitter.out_gen(out_target, filename, emitter.out_hw_hwpe_engine)

'''
    Generate design components ~ Streamer
'''
template = hwpe_wrapper.streamer()
out_target = genacc.gen(template)
filename = emitter.get_file_name(['hwpe', 'streamer', ['hw', 'rtl']])
emitter.out_gen(out_target, filename, emitter.out_hw_hwpe_engine)

'''
    Generate design components ~ Controller
'''
template = hwpe_wrapper.ctrl()
out_target = genacc.gen(template)
filename = emitter.get_file_name(['hwpe', 'ctrl', ['hw', 'rtl']])
emitter.out_gen(out_target, filename, emitter.out_hw_hwpe_engine)

'''
    Generate design components ~ FSM
'''
template = hwpe_wrapper.fsm()
out_target = genacc.gen(template)
filename = emitter.get_file_name(['hwpe', 'fsm', ['hw', 'rtl']])
emitter.out_gen(out_target, filename, emitter.out_hw_hwpe_engine)

'''
    Generate design components ~ Package
'''
template = hwpe_wrapper.package()
out_target = genacc.gen(template)
filename = emitter.get_file_name(['hwpe', 'package', ['hw', 'rtl']])
emitter.out_gen(out_target, filename, emitter.out_hw_hwpe_engine)

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

'''
    Accelerator integration
    =======================

    Instantiate overlay item
''' 
overlay = overlay()

'''
    Generate design components ~ Overlay accelerator package
''' 
template = overlay.acc_pkg()
out_target = genacc.gen(template)
filename = emitter.get_file_name(['ov', 'acc_pkg', ['hw', 'rtl']])
emitter.out_gen(out_target, filename, emitter.out_ov_integr)

'''
    Generate design components ~ Overlay accelerator interface
''' 
template = overlay.acc_intf()
out_target = genacc.gen(template)
filename = emitter.get_file_name(['ov', 'acc_intf', ['hw', 'rtl']])
emitter.out_gen(out_target, filename, emitter.out_ov_integr)

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

'''
    Hardware support
    ================

    Instantiate integration support item
''' 
integr_support = integr_support()

'''
    Generate design components ~ Bender
''' 
template = integr_support.bender()
out_target = genacc.gen(template)
filename = emitter.get_file_name(['integr_support', 'bender', ['integr_support', 'bender']])
emitter.out_gen(out_target, filename, emitter.out_ov_integr)

'''
    Generate design components ~ QuestaSim waves
''' 
template = integr_support.vsim_wave()
out_target = genacc.gen(template)
filename = emitter.get_file_name(['integr_support', 'pulp_tb', ['integr_support', 'vsim_wave']])
emitter.out_gen(out_target, filename, emitter.out_ov_integr)

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

'''
    Software testbench
    ==================

    Instantiate SW testbench item
''' 
hwpe_wrapper_tb = hwpe_wrapper_tb()

'''
    Generate design components ~ archi
    Retrieve memory-mapped hardware accelerator registers.
''' 
template = hwpe_wrapper_tb.archi_hwpe()
out_target = genacc.gen(template)
filename = emitter.get_file_name(['sw', 'archi', ['sw', 'archi']])
emitter.out_gen(out_target, filename, emitter.out_sw_hwpe_lib)

'''
    Generate design components ~ hardware abstraction layer (HAL)
    Retrieve Hardware Abstraction Layer with functions that permit 
    to create an interaction between the RISC-V processor and the 
    hardware accelerator.
''' 
template = hwpe_wrapper_tb.hal_hwpe()
out_target = genacc.gen(template)
filename = emitter.get_file_name(['sw', 'hal', ['sw', 'hal']])
emitter.out_gen(out_target, filename, emitter.out_sw_hwpe_lib)

'''
    Generate design components ~ software testbench 
    Retrieve software testbench to assess HWPE functionality. This 
    is a pure baremetal test running on the riscv proxy core commprised 
    in the overlay system. This tb can be used as a starting point for 
    additional platform testing.
''' 
template = hwpe_wrapper_tb.tb_hwpe()
out_target = genacc.gen(template)
filename = emitter.get_file_name(['sw', 'tb_hwpe', ['sw', 'tb']])
emitter.out_gen(out_target, filename, emitter.out_sw_outdir)
