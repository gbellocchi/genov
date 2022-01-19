'''
 =====================================================================
 Project:       SoC class
 Title:         soc.py
 Description:   The SoC class recalls all the the templates compliant 
                with the generation of the top-level SoC compoenents.

 Date:          29.12.2021
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

from templates.ov_templ.hw.soc.bender.top.bender import Bender
from templates.ov_templ.hw.soc.dmac_wrap_ooc.top.dmac_wrap_ooc import DmacWrapOOC
from templates.ov_templ.hw.soc.hero_axi_mailbox.top.hero_axi_mailbox import HeroAxiMailbox
from templates.ov_templ.hw.soc.l2_mem.top.l2_mem import L2Mem
from templates.ov_templ.hw.soc.pulp.top.pulp import Pulp
from templates.ov_templ.hw.soc.pulp_cluster_ooc.top.pulp_cluster_ooc import PulpClusterOOC
from templates.ov_templ.hw.soc.pulp_ooc.top.pulp_ooc import PulpOoc
from templates.ov_templ.hw.soc.soc_bus.top.soc_bus import SocBus
from templates.ov_templ.hw.soc.soc_ctrl_regs.top.soc_ctrl_regs import SocCtrlRegs
from templates.ov_templ.hw.soc.soc_cfg_pkg.top.soc_cfg_pkg import SocCfgPkg
from templates.ov_templ.hw.soc.soc_peripherals.top.soc_peripherals import SocPeripherals

class Soc:
    def __init__(self):
        self.path_common = 'templates/ov_templ/hw/common/'

    def Bender(self):
        print("\n[py] >> SoC ~ Bender")
        return Bender(
            temp_type = 'templates/ov_templ/hw/soc/bender/',
            temp_top = 'bender.template_yml',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def DmacWrapOOC(self):
        print("\n[py] >> SoC ~ DMA wrapper OOC")
        return DmacWrapOOC(
            temp_type = 'templates/ov_templ/hw/soc/dmac_wrap_ooc/',
            temp_top = 'dmac_wrap_ooc.template_sv',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def HeroAxiMailbox(self):
        print("\n[py] >> SoC ~ HERO AXI mailbox")
        return HeroAxiMailbox(
            temp_type = 'templates/ov_templ/hw/soc/hero_axi_mailbox/',
            temp_top = 'hero_axi_mailbox.template_sv',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def L2Mem(self):
        print("\n[py] >> SoC ~ L2 memory")
        return L2Mem(
            temp_type = 'templates/ov_templ/hw/soc/l2_mem/',
            temp_top = 'l2_mem.template_sv',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def Pulp(self):
        print("\n[py] >> SoC ~ PULP")
        return Pulp(
            temp_type = 'templates/ov_templ/hw/soc/pulp/',
            temp_top = 'pulp.template_sv',
            temp_modules = ['process_params.template_sv'],
            path_common = self.path_common
        ).top()

    def PulpClusterOOC(self):
        print("\n[py] >> SoC ~ PULP cluster OOC")
        return PulpClusterOOC(
            temp_type = 'templates/ov_templ/hw/soc/pulp_cluster_ooc/',
            temp_top = 'pulp_cluster_ooc.template_sv',
            temp_modules = ['hwpe_lic.template_sv',
                            'hwpe_hci.template_sv'],
            path_common = self.path_common
        ).top()

    def PulpOoc(self):
        print("\n[py] >> SoC ~ PULP OOC")
        return PulpOoc(
            temp_type = 'templates/ov_templ/hw/soc/pulp_ooc/',
            temp_top = 'pulp_ooc.template_sv',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def SocBus(self):
        print("\n[py] >> SoC ~ SoC bus")
        return SocCtrlRegs(
            temp_type = 'templates/ov_templ/hw/soc/soc_bus/',
            temp_top = 'soc_bus.template_sv',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def SocCtrlRegs(self):
        print("\n[py] >> SoC ~ SoC control registers")
        return SocCtrlRegs(
            temp_type = 'templates/ov_templ/hw/soc/soc_ctrl_regs/',
            temp_top = 'soc_ctrl_regs.template_sv',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def SocCfgPkg(self):
        print("\n[py] >> SoC ~ SoC configuration package")
        return SocCfgPkg(
            temp_type = 'templates/ov_templ/hw/soc/soc_cfg_pkg/',
            temp_top = 'soc_cfg_pkg.template_sv',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def SocPeripherals(self):
        print("\n[py] >> SoC ~ SoC peripherals")
        return SocPeripherals(
            temp_type = 'templates/ov_templ/hw/soc/soc_peripherals/',
            temp_top = 'soc_peripherals.template_sv',
            temp_modules = [],
            path_common = self.path_common
        ).top()