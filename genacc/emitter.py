########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

# Packages
import numpy as np
import sys
import struct
import shutil
from distutils.dir_util import copy_tree
import os

# Design specification package
from engine_dev.specs.hwpe_specs import hwpe_specs

'''
    Emitter class
    =============
'''

class emitter(hwpe_specs):
    """
    The emitter class is responsible of creating the ouput environment,
    to assemble the associated repository, as well as its file components.

    The '__init__' method imports the input specification parameters from its
    parent class 'hwpe_specs' and defines a set of directory names.
    """
    def __init__(self):
        # inherit
        super().__init__()
        # define output environment
        self.out_dir = 'output'
        # define output environment ~ HWPE wrapper
        self.out_hw_outdir = self.out_dir + '/hw'
        self.out_hw_hwpe = self.out_hw_outdir + '/hwpe-' + self.target + '-wrapper'
        self.out_hw_hwpe_wrap = self.out_hw_hwpe + '/wrap'
        self.out_hw_hwpe_rtl = self.out_hw_hwpe + '/rtl'
        # self.out_hw_hwpe_engine = self.out_hw_hwpe_rtl + '/hwpe-engine'
        self.out_hw_hwpe_engine_dev = self.out_hw_hwpe_rtl + '/engine_dev'
        self.out_hw_hwpe_streamer = self.out_hw_hwpe_rtl + '/hwpe-stream'
        self.out_hw_hwpe_ctrl = self.out_hw_hwpe_rtl + '/hwpe-ctrl'
        # define output environment ~ software
        self.out_sw_outdir = self.out_dir + '/sw'
        self.out_sw_inc = self.out_sw_outdir + '/inc'
        self.out_sw_test_lib = self.out_sw_inc + '/test_lib'
        self.out_sw_common = self.out_sw_inc + '/common'
        self.out_sw_eu_lib = self.out_sw_inc + '/eu_lib'
        self.out_sw_stim = self.out_sw_inc + '/stim'
        self.out_sw_hwpe_lib = self.out_sw_inc + '/hwpe_lib'
        self.out_sw_bigpulp = self.out_sw_inc + '/bigpulp'
        # define output environment ~ overlay integration
        self.out_ov_integr = self.out_dir + '/ov_integr'

    """
    Create environment for hardware.
    """
    def create_out_hw_env(self):
        # create output directories
        os.mkdir(self.out_hw_hwpe)
        os.mkdir(self.out_hw_hwpe_wrap)
        os.mkdir(self.out_hw_hwpe_rtl)
        # os.mkdir(self.out_hw_hwpe_engine)

    """
    Create environment for software.
    """
    def create_out_sw_env(self):
        # create output directories
        os.mkdir(self.out_sw_inc)
        os.mkdir(self.out_sw_hwpe_lib)

    """
    Create environment for overlay integration.
    """
    def create_out_ov_integr_env(self):
        pass

    """
    The 'out_gen' method is in charge of physically setting up the output 
    repository moving generated files to their target positions. The term 
    'gen' is used to denote files that are the targets of the rendering phase.
    The input arguments are:

    - 'out_target' ~ Generated design component. Typically an output string from 
    an emitter item.

    - 'filename' ~ Name of generated design component. Typically an output string from 
    a generator item.

    - 'filedir' ~ Target directory. Either a custom string or one of those defined 
    in the emitter constructor.
    """
    def out_gen(self, out_target, filename, filedir):
        print("\nExporting generated item (", filename, ") to target destination (", filedir, ")")
        with open(filename, "w") as f:
            f.write(out_target)
            try:
                source = filename
                destination = filedir
                shutil.move(source, destination)
            except:
                val = ""
                while((val != "y") and (val != "n")):
                    val = input(">> Trying to move generated components to output, but older versions have been found. Would you like to clean your environment? (y/n) ")
                if (val=="y"):
                    os.system('make clean >/dev/null 2>&1')
                    source = filename
                    destination = filedir
                    shutil.move(source, destination)

    """
    The 'out_hw_static' method is in charge of physically setting up the output 
    repository moving static HW files to their target positions. The term 'static'
    is used to denote files that are not targets of the rendering phase, but are
    either defined withing the repository, or cloned as external sources.
    """
    def out_hw_static(self):
        # static components (hw, sw, ..)
        static_comps = 'static'
        # ------------------------------------------------ #
        # # copy static components ~ streamer
        # source = static_comps + '/static_rtl/hwpe-stream/rtl'
        # destination = self.out_hw_hwpe_streamer
        # try:
        #     copy_tree(source, destination)
        # except:
        #     print(">> Erroneous path for static component of streamer!")
        # # ------------------------------------------------ #
        # # copy static components ~ controller
        # source = static_comps + '/static_rtl/hwpe-ctrl/rtl'
        # destination = self.out_hw_hwpe_ctrl
        # try:
        #     copy_tree(source, destination)
        # except:
        #     print(">> Erroneous path for static component of controller!")
        # ------------------------------------------------ #
        # create repo for wrapped hardware kernel
        source = 'engine_dev/rtl'
        destination = self.out_hw_hwpe_engine_dev
        try:
            copy_tree(source, destination)
        except:
            print(">> Erroneous path for static component of imported hardware kernel!")
        # ------------------------------------------------ #

    """
    The 'out_sw_static' method is in charge of physically setting up the output 
    repository moving static SW files to their target positions. The term 'static'
    is used to denote files that are not targets of the rendering phase, but are
    either defined within the repository, or cloned as external sources. 

    """
    def out_sw_static(self):
        # static components (hw, sw, ..)
        static_comps = 'static'
        # ------------------------------------------------ #
        # copy static components
        source = 'static/static_tb'
        destination = self.out_sw_outdir
        try:
            copy_tree(source, destination)
        except:
            print(">> Erroneous path for static component of imported hardware kernel!")
        # ------------------------------------------------ #
        # copy static components ~ input stimuli
        source = 'engine_dev/sw'
        destination = self.out_sw_stim
        try:
            copy_tree(source, destination)
        except:
            print(">> Erroneous path for input stimuli!")

    """
    The 'get_file_name' method gets information about the features of the
    generated IP, support file, SW component, etc. and constructs the name
    of the export file with the aid of the following methods:

    - 'construct_file_name' ~ it offers a dictionary that associates the supported
    device types (HWPE, overlay, etc.) with a particular file_name constructor;

    - 'hwpe_file_name' ~ an exemplary file_name constructor targeting HWPE devices;

    - 'get_dict_file_ext' ~ it offers a dictionary to derive the file_name extension.

    The input 'target' argument is a list of information about the target whose name
    has to be obtained. The input list is constructed in the following way:

    - Item 0 = Device type ~ the first list item aims at defining the type of the device
    the generated component is devoted to (HWPE? Overlay? QuestaSim? Bender?). Each device
    has its rules about filename construction, so a particular filename constructor is needed
    in most of cases. Thus, this input parameter changes the way the file_name is constructed. 
    For more information, take a look at the method 'construct_file_name' and the python
    dictionary that is used to choose the proper constructor.

    - Item 1 = Design name ~ this item defines the the name of the generated design item in the
    filename. Thus, this defines the use the generated file is used for.

    - Item 2 = Design type ~ this item is a sub-list that is employed to solve the choice of the 
    proper file extension. For more information about how file extensions are retrieved, see 
    method 'get_dict_file_ext'. The latter defines two nested dictionaries to associate the 
    design type information with a proper file extension.
    """
    def get_file_name(self, target):
        # #
        self.device_type = target[0] 
        self.design_name = target[1] 
        self.design_type = target[2] 
        # get file extension
        self.file_ext = self.get_dict_file_ext()
        # construct file name
        return self.construct_file_name()

    '''
    Defines a dictionary that associates the supported device types (HWPE, overlay, etc.) 
    with a particular file_name constructor.
    '''
    def construct_file_name(self):
        # dictionary for file extensions
        dict_file_ext = {
            'hwpe'            : self.hwpe_file_name(),
            'ov'              : self.ov_file_name(),
            'integr_support'  : self.integr_support_file_name(),
            'sw'              : self.sw_file_name()
        }
        return dict_file_ext[self.device_type]

    '''
    Constructor of file names targeting HWPE devices.
    '''
    def hwpe_file_name(self):
        file_name = self.target + '_' + self.design_name + self.file_ext
        return file_name

    '''
    Constructor of file names targeting the overlay.
    '''
    def ov_file_name(self):
        file_name = 'ov_' + self.design_name + self.file_ext
        return file_name

    '''
    Constructor of file names for support during integration.
    '''
    def integr_support_file_name(self):
        file_name = self.design_name + self.file_ext
        return file_name

    '''
    Constructor of file names for softare testbench.
    '''
    def sw_file_name(self):
        file_name = self.design_name + self.file_ext
        return file_name

    '''
    Retrieve file extension.
    '''
    def get_dict_file_ext(self):
        # dictionary for file extensions
        dict_file_ext = {
            'hw'                : { "rtl": ".sv" } , 
            'integr_support'    : { "bender": ".yml", "vsim_wave": ".wave.do" } ,
            'sw'                : { "archi": ".h", "hal": ".h", "tb": ".c" }
        }
        return dict_file_ext[self.design_type[0]][self.design_type[1]]