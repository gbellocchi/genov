########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

# Packages
import numpy as np
import sys
import struct
import shutil
import getpass
import os

# Design specification package
from templates.hw.hwpe_specs.hwpe_specs import hwpe_specs

# HW packages
from templates.hw.hwpe_wrapper import hwpe_wrapper

# HW-management packages
from templates.hw_management.hw_management import hw_management

# Generator class
class hwpe_gen:
    def __init__(self, specs):
        self.specs = specs
    
    def gen_dev(self, dev, filename, dest_dir):
        n = filename
        with open(n, "w") as f:
            f.write(dev)
            try:
                source = n
                destination = dest_dir
                shutil.move(source, destination)
            except:
                val = getpass.getpass("There already exist old HWPE versions. Would you like to clean your environment? (y/n) ")
                while((val != "y") and (val != "n")):
                    val = input("There already exist old HWPE versions. Would you like to clean your environment? (y/n) ")
                if (val=="y"):
                    os.system('make clean >/dev/null 2>&1')
                    source = n
                    destination = dest_dir
                    shutil.move(source, destination)

# Read hwpe specs
specs = hwpe_specs()

# Create hwpe wrapper
hwpe_wrapper = hwpe_wrapper(specs)

# Create device generator
gen = hwpe_gen(specs)

# Create output environment
hwpe_outdir = specs.dest_dir + '/hw/hwpe-' + specs.hwpe_target + '-wrapper'
hwpe_rtl = hwpe_outdir + '/rtl'
hwpe_engine_rtl = hwpe_rtl + '/hwpe-engine'
hwpe_streamer_rtl = hwpe_rtl + '/hwpe-stream'
hwpe_ctrl_rtl = hwpe_rtl + '/hwpe-ctrl'

os.mkdir(hwpe_outdir)
os.mkdir(hwpe_rtl)
os.mkdir(hwpe_rtl + '/wrap')
os.mkdir(hwpe_engine_rtl)

source = 'static_rtl/hwpe-stream'
destination = hwpe_streamer_rtl
shutil.copytree(source, destination)

source = 'static_rtl/hwpe-ctrl'
destination = hwpe_ctrl_rtl
shutil.copytree(source, destination)

# Generate repo for datapth
dirname = hwpe_engine_rtl + '/engine_dev'
source = 'engine_dev'
destination = dirname
shutil.copytree(source, destination)

# Generate hwpe package for pulp system
dev = hwpe_wrapper.pulp_hwpe_pkg(specs)
filename = 'pulp_cluster_hwpe_pkg.sv'
dest_dir = specs.dest_dir + '/hw'
gen.gen_dev(dev, filename, dest_dir)

# Generate hwpe top wrapper
dev = hwpe_wrapper.top_wrapper(specs)
filename = specs.hwpe_target + '_' + 'top_wrapper.sv'
dest_dir = hwpe_rtl + '/wrap'
gen.gen_dev(dev, filename, dest_dir)

# Generate hwpe top
dev = hwpe_wrapper.top(specs)
filename = specs.hwpe_target + '_' + 'top.sv'
dest_dir = hwpe_engine_rtl
gen.gen_dev(dev, filename, dest_dir)

# Generate hwpe engine wrapper
dev = hwpe_wrapper.engine(specs)
filename = specs.hwpe_target + '_' + 'engine.sv'
dest_dir = hwpe_engine_rtl
gen.gen_dev(dev, filename, dest_dir)

# Generate hwpe streamer wrapper
dev = hwpe_wrapper.streamer(specs)
filename = specs.hwpe_target + '_' + 'streamer.sv'
dest_dir = hwpe_engine_rtl
gen.gen_dev(dev, filename, dest_dir)

# Generate hwpe ctrl wrapper
dev = hwpe_wrapper.ctrl(specs)
filename = specs.hwpe_target + '_' + 'ctrl.sv'
dest_dir = hwpe_engine_rtl
gen.gen_dev(dev, filename, dest_dir)

# Generate hwpe fsm
dev = hwpe_wrapper.fsm(specs)
filename = specs.hwpe_target + '_' + 'fsm.sv'
dest_dir = hwpe_engine_rtl
gen.gen_dev(dev, filename, dest_dir)

# Generate hwpe package
dev = hwpe_wrapper.package(specs)
filename = specs.hwpe_target + '_' + 'package.sv'
dest_dir = hwpe_engine_rtl
gen.gen_dev(dev, filename, dest_dir)

# Create hw management tool
hw_management = hw_management(specs)

# Generate bender
dev = hw_management.bender(specs)
filename = 'Bender.yml'
dest_dir = hwpe_outdir
gen.gen_dev(dev, filename, dest_dir)
