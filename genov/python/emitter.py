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
import importlib
import os

# Overlay specification package
try:
    from dev.ov_dev.specs.ov_specs import ov_specs
except ImportError:
    ov_specs = None

# Accelerator specification package
try:
    target_acc = os.environ['TARGET_ACC']
    module_name = "dev.acc_dev." + target_acc + ".specs.acc_specs"
    acc_specs = importlib.import_module(module_name)
except:
    acc_specs = None

'''
    =====================
    Overlay emitter class
    =====================
'''

if ov_specs is not None:

    class emit_ov(ov_specs):
        """
        The emitter class is responsible of creating the ouput environment,
        to assemble the associated repository, as well as its file components.

        The '__init__' method imports the input specification parameters from its
        parent class 'ov_specs'. Other than the latter, the paths to the output
        environment are specified. 
        """
        def __init__(self, dir_out_ov):
            # inherit
            super().__init__()

            '''
                Output environment
            '''
            self.out_dir                        = 'output'

            '''
                Output environment ~ Generated overlay

                This set of parameters describe the output environment
                where the generated overlay components are inserted. The
                parameters should match to the hierarchy of directories
                defined in the tool script "ov_gen_out_env.sh".
            '''

            self.out_ov                         = dir_out_ov

            # Hardware
            self.ov_gen_cl                      = self.out_ov + '/clusters'

            # Test and validation
            self.out_ov_test                    = self.out_ov + '/test'

            # System testbench
            self.out_ov_tb                      = self.out_ov + '/test/overlay_tb'
            self.out_ov_tb_sw                   = self.out_ov + '/test/overlay_tb/sw'
            self.out_ov_tb_inc                  = self.out_ov + '/test/overlay_tb/sw/inc'
            self.out_ov_tb_hwpe_lib             = self.out_ov + '/test/overlay_tb/sw/inc/hwpe_lib'

        """
        The 'out_gen' method is in charge of physically setting up the output 
        repository moving generated files to their target positions. The term 
        'gen' is used to denote files that are the targets of the rendering phase.
        The input arguments are:

        - 'out_target' ~ Generated design component. Typically an output string from 
        a generator item.

        - 'filename' ~ Name of generated design component. Typically an output string from 
        an emitter item.

        - 'filedir' ~ Target directory. Either a custom string or one of those defined 
        in the emitter constructor.
        """
        def out_gen(self, out_target, filename, filedir):
            try:
                if(os.path.isdir(filename)):
                    source = filename
                    destination = filedir
                    shutil.copytree(source, destination)
                else:
                    destination_file = os.path.join(filedir, filename)
                    print(destination_file)
                    with open(destination_file, "w") as f:
                        f.write(out_target)
                print("\nExporting generated item (", filename, ") to target destination (", filedir, ")")
            except shutil.Error as err:
                print("\nGenerated item (", filename, ") already exists at target destination (", filedir, ")")

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
                'ov'              : self.ov_file_name(),
                'cl'              : self.cl_file_name(),
                'tb'              : self.tb_file_name(),
                'integr_support'  : self.integr_support_file_name(),
                'sw'              : self.sw_file_name()
            }
            return dict_file_ext[self.device_type]

        '''
        Constructor of file names targeting the overlay.
        '''
        def ov_file_name(self):
            file_name = 'ov_' + self.design_name + self.file_ext
            return file_name

        '''
        Constructor of file names targeting the cluster.
        '''
        def cl_file_name(self):
            file_name = 'cl_' + self.design_name + self.file_ext
            return file_name

        '''
        Constructor of file names targeting the testbench.
        '''
        def tb_file_name(self):
            file_name = self.design_name + self.file_ext
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
                'integr_support'    : { "yml": ".yml", "vsim_wave": ".wave.do" } ,
                'sw'                : { "archi": ".h", "hal": ".h", "tb": ".c" }
            }
            return dict_file_ext[self.design_type[0]][self.design_type[1]]

'''
    =========================
    Accelerator emitter class
    =========================
'''

if acc_specs is not None:

    class emit_acc(acc_specs.acc_specs):
        """
        The emitter class is responsible of creating the ouput environment,
        to assemble the associated repository, as well as its file components.

        The '__init__' method imports the input specification parameters from its
        parent class 'acc_specs'. Other than the latter, the paths to the output
        environment are specified. 
        """
        def __init__(self, dir_out_hwpe):
            # inherit
            super().__init__()

            '''
                Output environment
            '''
            self.out_dir                        = 'output'

            '''
                Output environment ~ Generated accelerator

                This set of parameters describe the output environment
                where the generated accelerator wrapper is inserted. The
                parameters should match to the hierarchy of directories
                defined in the tool script "acc_gen_out_env.sh".
            '''
            
            self.out_hwpe                       = os.path.join(dir_out_hwpe, self.target)

            # Hardware
            self.out_hwpe_wrap                  = self.out_hwpe + '/wrap'
            self.out_hwpe_rtl                   = self.out_hwpe + '/rtl'
            self.out_hwpe_acc_kernel            = self.out_hwpe + '/rtl/acc_kernel'

            # Test and validation
            self.out_hwpe_test                  = self.out_hwpe + '/test'

            # Standalone testbench
            self.out_hwpe_tb                    = self.out_hwpe + '/test/hwpe_standalone_tb'
            self.out_hwpe_tb_sw                 = self.out_hwpe + '/test/hwpe_standalone_tb/sw'
            self.out_hwpe_tb_inc                = self.out_hwpe + '/test/hwpe_standalone_tb/sw/inc'
            self.out_hwpe_tb_hwpe_lib           = self.out_hwpe + '/test/hwpe_standalone_tb/sw/inc/hwpe_lib'

        """
        The 'out_gen' method is in charge of physically setting up the output 
        repository moving generated files to their target positions. The term 
        'gen' is used to denote files that are the targets of the rendering phase.
        The input arguments are:

        - 'out_target' ~ Generated design component. Typically an output string from 
        a generator item.

        - 'filename' ~ Name of generated design component. Typically an output string from 
        an emitter item.

        - 'filedir' ~ Target directory. Either a custom string or one of those defined 
        in the emitter constructor.
        """
        def out_gen(self, out_target, filename, filedir):
            try:
                if(os.path.isdir(filename)):
                    source = filename
                    destination = filedir
                    shutil.copytree(source, destination)
                else:
                    destination_file = os.path.join(filedir, filename)
                    print(destination_file)
                    with open(destination_file, "w") as f:
                        f.write(out_target)
                print("\nExporting generated item (", filename, ") to target destination (", filedir, ")")
            except shutil.Error as err:
                print("\nGenerated item (", filename, ") already exists at target destination (", filedir, ")")

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
                'tb'              : self.tb_file_name(),
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
        Constructor of file names targeting the testbench.
        '''
        def tb_file_name(self):
            file_name = self.design_name + self.file_ext
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
                'integr_support'    : { "yml": ".yml", "vsim_wave": ".wave.do" } ,
                'sw'                : { "archi": ".h", "hal": ".h", "tb": ".c" }
            }
            return dict_file_ext[self.design_type[0]][self.design_type[1]]