
# GenOv

## Introduction
### Description
**GenOv** is a set of Python-based tools to simplify the design of heterogeneous RISC-V-based FPGA overlays [1].

The tool generates both system components and accelerator wrappers, based on the HWPE protocol [2, 3].

***If you want to use _GenOv_, you can cite our paper [1].***

## Getting Started

### Clone the Repository
**GenOv** can be be cloned from:
```
https://github.com/gbellocchi/genov.git
```

### Initial Setup
```Shell
source $XIL_OPENHW_PATH/setup.sh
```

### Python Virtual Environment
To manage the tool dependencies, a Python virtual environment is employed. To initialize it and download the required packages (see 'requirements.txt'), run:

```
make py_env_init
```

This command manages the installation of the required Python packages, including the Mako template library [6] that is employed for the templating operation.

In case of an update of the package requirements run:

```
make py_env_update_reqs
```

### External Sources
The tool uses Git submodules that have to be initialized. To pull the required Git submodules, run:

```
make ov_gen_init
```

## Specification Source Files

### Accelerator Specification Source Files

User-defined accelerator specifications are collected in the accelerator library (`src/accelerators/`). 

Each project comprise the following items:

1.  `specs/` - This location contains the Python specification file `acc_specs.py` that embodies the required information to specialize the interface between the accelerator wrapper and the HLS accelerator kernel, as well as additional features.
2.  `rtl/` - This location contains the RTL components of the HLS accelerator. To this end, the flow does not mandate any specific design methodology for the target accelerator engines.
3.  `sw/` - This location contains additional software components for the testing phase. These components are not mandatory.

### Overlay Specification Source Files
Similarly, the user-defined source files to guide system generation are to be inserted in the overlay library (`src/overlays/`). 

Each project comprise the following item:

1.  `specs/` - The Python specification file is named `ov_specs.py`. This specification tells the tool how to connect accelerator wrappers at system-level and how to tailor HW resources to the application requirements.

### MatMul HLS examples
We provide examples of three alternative overlay-based platforms integrating the _MatMul accelerators_ previously developed with HLS.

## System Generation
To generate the system, you can run the command `make clean all`. 

Additionally, the following arguments can be added:

- **TARGET_OV**: It specifies what overlay to generate. For example, you can run the command `make clean all TARGET_OV=xil_open_hw_23_mmult_hw`.

The generated components are automatically exported to the FPGA overlay subsystem where they can be later built.

## References
1) **"A RISC-V-based FPGA Overlay to Simplify Embedded Accelerator Deployment" - G. Bellocchi et al. (2021)**
2) "XNOR Neural Engine: A Hardware Accelerator IP for 21.6-fJ/op Binary Neural Network Inference" - F. Conti et al. (2018)
3) Hardware Processing Engines Documentation: https://hwpe-doc.readthedocs.io/en/latest/index.html
  
## Useful Repositories
1) Hardware Processing Engine - Streamer: https://github.com/pulp-platform/hwpe-stream
2) Hardware Processing Engine - Controller: https://github.com/pulp-platform/hwpe-ctrl
3) Hardware Processing Engine - MAC engine example: https://github.com/pulp-platform/hwpe-mac-engine
4) Hardware Processing Engine - Standalone testbench: https://github.com/pulp-platform/hwpe-tb
5) PULP platform - https://github.com/pulp-platform
6) Mako Templates for Python - https://www.makotemplates.org/

## Contacts
**Gianluca Bellocchi**
* E-mail: <gianluca.bellocchi@unimore.it>