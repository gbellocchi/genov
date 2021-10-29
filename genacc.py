
from classes import genacc, emitter

# HW packages
from templates.hw.hwpe_wrapper.hwpe_wrapper import hwpe_wrapper
# from templates.hw.overlay.overlay import overlay

# # HW-management packages
# from templates.hw_management.hw_management import hw_management

# # SW packages
# from templates.sw.hwpe_wrapper_tb.hwpe_wrapper_tb import hwpe_wrapper_tb


# -------------------------------------- #
# -------------  HARDWARE  ------------- #
# -------------------------------------- #

# Instantiate generator item
genacc = genacc()

# Instantiate export item
emitter = emitter()

# Create output environment
emitter.create_out_hw_env()
emitter.create_out_sw_env()
emitter.create_out_ov_integr_env()

# Instantiate hwpe_wrapper item
hwpe_wrapper = hwpe_wrapper()

# Generate design components ~ top wrapper
template = hwpe_wrapper.top_wrapper()
out_target = genacc.gen(template)
filename = emitter.get_file_name(['top_wrapper', 'hw', 'rtl'])
emitter.output(out_target, filename, emitter.out_hw_hwpe_engine)

# Generate design components ~ top
template = hwpe_wrapper.top()
out_target = genacc.gen(template)
filename = emitter.get_file_name(['top', 'hw', 'rtl'])
emitter.output(out_target, filename, emitter.out_hw_hwpe_engine)

# Generate design components ~ engine
template = hwpe_wrapper.engine()
out_target = genacc.gen(template)
filename = emitter.get_file_name(['engine', 'hw', 'rtl'])
emitter.output(out_target, filename, emitter.out_hw_hwpe_engine)





# # Read hwpe specs
# specs = hwpe_specs()

# # Create device generator
# gen = hwpe_gen(specs)

# # # Get a structure of python template modules 
# # gen.struct_mod()

# # Static components (hw, sw, ..)
# static_comps = 'static'

# # Copy static components
# source = static_comps + '/static_rtl/hwpe-stream/rtl'
# destination = hwpe_streamer_rtl
# shutil.copytree(source, destination)

# source = static_comps + '/static_rtl/hwpe-ctrl/rtl'
# destination = hwpe_ctrl_rtl
# shutil.copytree(source, destination)

# # Create repo for datapth
# dirname = hwpe_engine_rtl + '/engine_dev'
# source = 'engine_dev/rtl'
# destination = dirname
# shutil.copytree(source, destination)

# #
# # OVERLAY
# #

# # Create overlay
# overlay = overlay(specs)

# # Generate packages to integrate hwpe in the overlay
# dev = overlay.acc_pkg(specs)
# filename = 'ov_acc_pkg.sv'
# dest_dir = hwpe_overlay_integration
# gen.gen_dev(dev, filename, dest_dir)

# # Generate interface between overlay and accelerator
# dev = overlay.acc_intf(specs)
# filename = 'ov_acc_intf.sv'
# dest_dir = hwpe_overlay_integration
# gen.gen_dev(dev, filename, dest_dir)

# #
# # HWPE
# #

# # Create hwpe wrapper
# hwpe_wrapper = hwpe_wrapper(specs)

# # # Generate hwpe top wrapper
# # dev = hwpe_wrapper.top_wrapper(specs)
# # filename = specs.hwpe_target + '_' + 'top_wrapper.sv'
# # dest_dir = hwpe_rtl + '/wrap'
# # gen.gen_dev(dev, filename, dest_dir)

# # Generate hwpe top
# dev = hwpe_wrapper.top(specs)
# filename = specs.hwpe_target + '_' + 'top.sv'
# dest_dir = hwpe_engine_rtl
# gen.gen_dev(dev, filename, dest_dir)

# # Generate hwpe engine
# dev = hwpe_wrapper.engine(specs)
# filename = specs.hwpe_target + '_' + 'engine.sv'
# dest_dir = hwpe_engine_rtl
# gen.gen_dev(dev, filename, dest_dir)

# # Generate kernel adapter
# dev = hwpe_wrapper.kernel_adapter(specs)
# filename = specs.hwpe_target + '_' + 'kernel_adapter.sv'
# dest_dir = hwpe_engine_rtl
# gen.gen_dev(dev, filename, dest_dir)

# # Generate hwpe streamer wrapper
# dev = hwpe_wrapper.streamer(specs)
# filename = specs.hwpe_target + '_' + 'streamer.sv'
# dest_dir = hwpe_engine_rtl
# gen.gen_dev(dev, filename, dest_dir)

# # Generate hwpe ctrl wrapper
# dev = hwpe_wrapper.ctrl(specs)
# filename = specs.hwpe_target + '_' + 'ctrl.sv'
# dest_dir = hwpe_engine_rtl
# gen.gen_dev(dev, filename, dest_dir)

# # # Generate hwpe fsm
# dev = hwpe_wrapper.fsm(specs)
# filename = specs.hwpe_target + '_' + 'fsm.sv'
# dest_dir = hwpe_engine_rtl
# gen.gen_dev(dev, filename, dest_dir)

# # Generate hwpe package
# dev = hwpe_wrapper.package(specs)
# filename = specs.hwpe_target + '_' + 'package.sv'
# dest_dir = hwpe_engine_rtl
# gen.gen_dev(dev, filename, dest_dir)

# # ------------------------------------------------ #
# # -------------  HARDWARE MANAGEMENT ------------- #
# # ------------------------------------------------ #

# # Create hw management tool
# hw_management = hw_management(specs)

# # Generate bender
# dev = hw_management.bender(specs)
# filename = 'Bender.yml'
# dest_dir = hwpe_outdir
# gen.gen_dev(dev, filename, dest_dir)

# # Generate VSIM wave file
# dev = hw_management.vsim_wave(specs)
# filename = 'pulp_tb.wave.do'
# dest_dir = hwpe_overlay_integration
# gen.gen_dev(dev, filename, dest_dir)

# # -------------------------------------- #
# # -------------  SOFTWARE  ------------- #
# # -------------------------------------- #

# # Create software components for RTL simulation
# hwpe_wrapper_tb = hwpe_wrapper_tb(specs)

# # Create output environment
# sw_outdir = specs.dest_dir + '/sw'
# sw_inc = sw_outdir + '/inc'
# sw_test_lib = sw_inc + '/test_lib'
# sw_common = sw_inc + '/common'
# sw_eu_lib = sw_inc + '/eu_lib'
# sw_stim = sw_inc + '/stim'
# sw_hwpe_lib = sw_inc + '/hwpe_lib'
# sw_bigpulp = sw_inc + '/bigpulp'

# os.mkdir(sw_inc)
# os.mkdir(sw_hwpe_lib)

# # Copy static components
# source = static_comps + '/static_tb/Makefile'
# destination = sw_outdir
# shutil.copy(source, destination)

# source = static_comps + '/static_tb/inc/test_lib/'
# destination = sw_test_lib
# shutil.copytree(source, destination)

# source = static_comps + '/static_tb/inc/common/'
# destination = sw_common
# shutil.copytree(source, destination)

# source = static_comps + '/static_tb/inc/eu_lib/'
# destination = sw_eu_lib
# shutil.copytree(source, destination)

# source = static_comps + '/static_tb/inc/bigpulp/'
# destination = sw_bigpulp
# shutil.copytree(source, destination)

# # # Create repo for stimuli
# # dirname = sw_stim
# # source = 'engine_dev/sw/stim'
# # destination = dirname
# # shutil.copytree(source, destination)

# # Generate archi-hwpe 
# # Memory-mapped hardware accelerator registers
# dev = hwpe_wrapper_tb.archi(specs)
# filename = 'archi_hwpe.h'
# dest_dir = sw_hwpe_lib
# gen.gen_dev(dev, filename, dest_dir)

# # Generate hal-hwpe 
# # Hardware Abstraction Layer with functions that permit 
# # to create an inetaction between the RISC-V processor
# # and the hardware accelerator
# dev = hwpe_wrapper_tb.hal(specs)
# filename = 'hal_hwpe.h'
# dest_dir = sw_hwpe_lib
# gen.gen_dev(dev, filename, dest_dir)

# # Generate software testbench for HWPE wrapper
# # Software testbench of the hwpe functionality that can be
# # run in baremetal on the rv-fc commprised in the pulp system.
# # This tb can be used as a starting point for additional platform testing.
# dev = hwpe_wrapper_tb.tb(specs)
# filename = 'tb_hwpe.c'
# dest_dir = sw_outdir
# gen.gen_dev(dev, filename, dest_dir)
