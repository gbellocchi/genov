########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

# Templates - Top
from templates.hw.hwpe_wrapper.hwpe_top_wrapper.top.hwpe_top_wrapper import hwpe_top_wrapper
from templates.hw.hwpe_wrapper.hwpe_top.top.hwpe_top import hwpe_top
from templates.hw.hwpe_wrapper.hwpe_package.top.hwpe_package import hwpe_package

# Templates - Engine
from templates.hw.hwpe_wrapper.hwpe_engine.top.hwpe_engine import hwpe_engine
from templates.hw.hwpe_wrapper.hwpe_kernel_adapter.top.hwpe_kernel_adapter import hwpe_kernel_adapter

# Templates - Streamer
from templates.hw.hwpe_wrapper.hwpe_streamer.top.hwpe_streamer import hwpe_streamer

# Templates - Controller
from templates.hw.hwpe_wrapper.hwpe_ctrl.top.hwpe_ctrl import hwpe_ctrl
from templates.hw.hwpe_wrapper.hwpe_fsm.top.hwpe_fsm import hwpe_fsm

from collector import collector

# HWPE wrapper
class hwpe_wrapper:
    def __init__(self):
        print("\n>> HWPE wrapper ~ Retrieving hardware components")
        self.path_common = 'templates/hw/common/'

    def top_wrapper(self):
        print("\n>> HWPE wrapper ~ top wrapper")
        return hwpe_top_wrapper(
            temp_type = 'templates/hw/hwpe_wrapper/hwpe_top_wrapper/',
            temp_top = 'hwpe_top_wrapper.template_sv',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def top(self):
        print("\n>> HWPE wrapper ~ top")
        return hwpe_top(
            temp_type = 'templates/hw/hwpe_wrapper/hwpe_top/',
            temp_top = 'hwpe_top.template_sv',
            temp_modules = ['ctrl.template_sv', 'streaming.template_sv'],
            path_common = self.path_common
        ).top()

    def engine(self):
        print("\n>> HWPE wrapper ~ engine")
        return hwpe_engine(
            temp_type = 'templates/hw/hwpe_wrapper/hwpe_engine/',
            temp_top = 'hwpe_engine.template_sv',
            temp_modules = ['fsm_synch.template_sv', 'streaming.template_sv'],
            path_common = self.path_common
        ).top()

    def kernel_adapter(self):
        print("\n>> HWPE wrapper ~ kernel adapter")
        return hwpe_kernel_adapter(
            temp_type = 'templates/hw/hwpe_wrapper/hwpe_kernel_adapter/',
            temp_top = 'hwpe_kernel_adapter.template_sv',
            temp_modules = ['kernel_interface/xil_ap_ctrl_hs.template_sv', 'kernel_interface/mdc_dataflow.template_sv', 'streaming.template_sv'],
            path_common = self.path_common
        ).top()

    def streamer(self):
        print("\n>> HWPE wrapper ~ streamer")
        return hwpe_streamer(
            temp_type = 'templates/hw/hwpe_wrapper/hwpe_streamer/',
            temp_top = 'hwpe_streamer.template_sv',
            temp_modules = ['fifo.template_sv', 'tcdm.template_sv', 'streaming.template_sv'],
            path_common = self.path_common
        ).top()

    def ctrl(self):
        print("\n>> HWPE wrapper ~ ctrl")
        return hwpe_ctrl(
            temp_type = 'templates/hw/hwpe_wrapper/hwpe_ctrl/',
            temp_top = 'hwpe_ctrl.template_sv',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def fsm(self):
        print("\n>> HWPE wrapper ~ fsm")
        return hwpe_fsm(
            temp_type = 'templates/hw/hwpe_wrapper/hwpe_fsm/',
            temp_top = 'hwpe_fsm.template_sv',
            temp_modules = ['address_generator.template_sv', 'engine_communication.template_sv', 'streamer_communication.template_sv'],
            path_common = self.path_common
        ).top()

    def package(self):
        print("\n>> HWPE wrapper ~ package")
        return hwpe_package(
            temp_type = 'templates/hw/hwpe_wrapper/hwpe_package/',
            temp_top = 'hwpe_package.template_sv',
            temp_modules = ['address_generator_regs.template_sv', 'custom_regs.template_sv', 'standard_regs.template_sv', 'tcdm_regs.template_sv', 'uloop_regs.template_sv'],
            path_common = self.path_common
        ).top()

