########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

# Packages
from templates.sw.baremetal_comps.archi_hwpe.archi_hwpe import archi_hwpe
from templates.sw.baremetal_comps.hal_hwpe.hal_hwpe import hal_hwpe
from templates.sw.baremetal_comps.test_hwpe.test_hwpe import test_hwpe

# RISC-V firmware (baremetal)
class firmware_baremetal:
    def __init__(self, hwpe_specs):
        self.author = hwpe_specs.author
        self.email = hwpe_specs.email

    def archi_hwpe(self, hwpe_specs):
        archi = archi_hwpe(hwpe_specs)
        return archi.gen()
    
    def hal_hwpe(self, hwpe_specs):
        hal = hal_hwpe(hwpe_specs)
        return hal.gen()

    def test_hwpe(self, hwpe_specs):
        test = test_hwpe(hwpe_specs)
        return test.gen()

# HOST (ARM) firmware (OpenMP offloading)
class firmware_offloading:
    def __init__(self, hwpe_specs):
        self.author = hwpe_specs.author
        self.email = hwpe_specs.email




