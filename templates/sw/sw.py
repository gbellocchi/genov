########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

# Packages
from templates.hw.hwpe_specs.hwpe_specs import hwpe_specs
from templates.hw.pulp_cluster_hwpe_pkg.pulp_cluster_hwpe_pkg import pulp_cluster_hwpe_pkg
from templates.hw.hwpe_top.hwpe_top_wrapper.hwpe_top_wrapper import hwpe_top_wrapper
from templates.hw.hwpe_top.hwpe_top.hwpe_top import hwpe_top
from templates.hw.hwpe_engine.hwpe_engine import hwpe_engine
from templates.hw.hwpe_streamer.hwpe_streamer import hwpe_streamer
from templates.hw.hwpe_ctrl.hwpe_ctrl.hwpe_ctrl import hwpe_ctrl
from templates.hw.hwpe_ctrl.hwpe_fsm.hwpe_fsm import hwpe_fsm
from templates.hw.hwpe_package.hwpe_package import hwpe_package

# HWPE overlay
class hwpe_overlay:
    def __init__(self, hwpe_specs):
        self.author = hwpe_specs.author
        self.email = hwpe_specs.email

    def pulp_hwpe_pkg(self, hwpe_specs):
        pulp_hwpe_pkg = pulp_cluster_hwpe_pkg(hwpe_specs)
        return pulp_hwpe_pkg.gen()

    def top_wrapper(self, hwpe_specs):
        top_wrapper = hwpe_top_wrapper(hwpe_specs)
        return top_wrapper.gen()

    def top(self, hwpe_specs):
        top = hwpe_top(hwpe_specs)
        return top.gen()

    def engine(self, hwpe_specs):
        engine = hwpe_engine(hwpe_specs)
        return engine.gen()

    def streamer(self, hwpe_specs):
        streamer = hwpe_streamer(hwpe_specs)
        return streamer.gen()

    def ctrl(self, hwpe_specs):
        ctrl = hwpe_ctrl(hwpe_specs)
        return ctrl.gen()

    def fsm(self, hwpe_specs):
        fsm = hwpe_fsm(hwpe_specs)
        return fsm.gen()

    def package(self, hwpe_specs):
        package = hwpe_package(hwpe_specs)
        return package.gen()

