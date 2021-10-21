
# Accelerator Wrapper Generator (GenAcc)

## Introduction
### Description
The HWPE Wrapper Generator Tool consists of a set of Python packages, System Verilog templates and a Makefile that permit to speed up the integration and deployment of hardware accelerators in PULP-based systems [1]. To learn more about HWPE, take a look at [2] and [3].

The integration of custom accelerators is simplified by the definition of a communication/control interface in the form of a wrapper to the acceleration logic that can be instantiated multiple times within a PULP-based cluster. A wrapper encapsulates the functionality of a HWPE streamer and controller modules. Since these modules have dependencies on the specific accelerator (engine) implementation, it is necessary to distinguish between their static and variable RTL components. Once the user has defined key properties of its accelerator design, the specialization of the wrapper is simplified via template instantiation.

Given a set of initial design rules, the designer is equipped with a high-level language (HLL) interface to allow for wrapper specialization. This tool does not mandate any specific methodology to design the engine of accelerators. Both HLS tools or manually optimized HDL code are supported. An automated flow permits to integrate the acceleration logic within the wrapper, which is in turn integrated with the PULP system for validation.

## Getting Started

### Clone the Repository
We recommed the toolchain to be cloned in the hardware subdirectory of the PULP-based Overlay subsystem, as most of its functionalities will directly interact with that system portion.

```
git clone https://git.hipert.unimore.it/comp4drones/HERO/hwpe-wrapper-gen-tool.git
```

### Overlay Environment

We recommend to set the following environment variable to the top directory of your HERO ecosystem:

```
export HERO_OV_HOME_DIR=<your_path> (typically something like $HOME/workspace_user/hero)
```

Most of the specialization flow is handled locally to the tool subdirectory. At a certain point the user may decide to export and integrate the specialized hardware/software products to the overlay system. This process is fully automated and no-error-prone as far as the tool knows how to securely interface to the overlay.

Thus, it is recommended to set the following environment variable to the location of the overlay hardware subsystem.

```
export HERO_OV_HW_EXPORT=<your_path> (typically something like $HERO_HOME_DIR/hardware)
```

This location should at least comprise the following directories that are going to be targeted in the integration phase:

-  `src/` - This location comprises SystemVerilog source files to parametrize the PULP-based overlay system.
-  `deps/` - This location comprises SystemVerilog dependencies. Basically, the overlay IPs (RISC-V core, DMA, accelerators, etc.).
-  `test/` - This location comprises a SystemVerilog testbench to simulate the hardware behavior.

### External Sources
The tool uses Git submodules that have to be initialized. In order to fetch the submodules in the repository, run:

```
make init_gen
```

### Python Virtual Environment
To manage the project's dependencies a Python virtual environment is employed. To initialize it and download the required packages (see 'requirements.txt'), run:

```
make init_py_env
```

This command manages the installation of the required Python packages, including the Mako template library [6] that is employed for the templating operation.

In case of an update of the package requirements, it is possible to 'activate' the virtual environment, install the package and subsequently run:

```
make update_reqs_py_venv
```

## Accelerator Integration Methodology

### Engine Design
The methodology currently supports wrapping of custom acceleration engines that exhibit the following features:

 1. **Streaming accelerators** - This class of accelerators permit to take advantage of the strong decoupling in designing the wrapper and the accelerator engine.
 2. **Defined data access pattern** - The user must be able to describe the data access pattern of each set of input/output TCDM masters. This has to be easily describable in a for-loop fashion, as reported in the listing below. To this end, the user can take advantage of address generators to map local memory accesses to data streams. More information concerning the address generator and the mapping of its parameters to the specific data access pattern of the accelerator are to be found in [3].

```python
int word_addr=0, line_addr=0, feat_addr=0;
int trans_idx=0;
while(trans_idx < trans_size) {
	if(!enable)
		continue;
	for(int feat_idx=0; feat_idx<feat_roll; feat_idx++) { // feature loop
		for(int line_idx=0; line_idx<feat_length; line_idx++) { // line loop
			for(int word_idx=0; word_idx<line_length; word_idx++) { // word loop
				gen_addr = base_addr + feat_addr + line_addr + word_idx * STEP;
			}
			line_addr += line_stride; 
		}
		if((loop_outer) && (feat_idx == feat_roll-1)) {
			feat_addr += feat_stride;
			feat_idx = 0;
			}
		else if ((!loop_outer) && (feat_idx < feat_roll-1)){
			feat_addr += feat_stride;
		}
		else if ((!loop_outer) && (feat_idx == feat_roll-1)){
			feat_addr = 0;
			feat_idx = 0;
		}
	}
}
```


#### Accelerator Library

User-defined engine specifications are to be inserted in the accelerator library (`acc_lib`). There exist exemplary library items to guide the user in the phase of integration of new wrapper specifications.
To extend the content of the library, the best practice is to create a new library folder comprising the following sections:

1.  `specs/` - This location contains the Python specification file `hwpe_specs.py`. The latter embodies the required information to specialize the interface between the accelerator wrapper and the integrated engine, as well as additional features.
2.  `rtl/` - This location contains the RTL components of the engine the user wants to wrap. To this end, the flow does not mandate any specific design methodology for the target accelerator engines.
3.  `sw/` - This location contains additional software components for the testing phase.
  
An `__init__.py` is always required to properly propagate information from the accelerator library throughout the template library. The content of the former has to be interpretable and accessible by Python as part of the tool package.


### Wrapper Specialization
Once the accelerator library has been updated, return back to the top folder. Here is a Makefile comprising all the recipes that are necessary to manage the specialization environment and export HW/SW products to the overlay system.

The first required step is to open the Makefile and modify the value of the macro `HWPE_TARGET` specifying the name of the accelerator the user wants to wrap. This has to match the name of an accelerator library component. As an example:

```
HWPE_TARGET = mmult_parallel
```

Subsequently, to specialize the wrapper is required to just run `make`.
  
This way, the Python template libraries will process the SystemVerilog wrapper templates on the basis of the information the input Python specification file has been compiled with. This permits the wrapping of the specified accelerator engine design. The generated files are exported to the `output` folder.

### System-Level Optimization
System-level optimization is enabled by propagating intra-process optimization knobs across the overlay infrastructure. The latter is possible since the tool renders SystemVerilog templates too. These templates deal with the different architectural blocks composing the overlay infrastructure, e.g. the accelerator interconnect, memory, DMA. Automated parametrization of this set of components is possible by exploiting the information comprised in the input Python specification file.

### System-Level Integration
To export the generated HW/SW to the overlay ecosystem run:

```
make overlay_integration
```

### Runtime Accelerator Control
The overlay and the wrapper feed the accelerator datapath exploiting **data tiling**. Complex control routines, data management policies and accelerator programming are all managed in software taking advantage of the overlay proxy core.

## Back-End
**WORK-IN-PROGRESS**
Python is exploited as a way of packaging a rendering environment for **templates** of different nature - RTL, C, yml, etc. To implement the functionalities required by such an environment we have decided to exploit the simple and straightfoward Mako template library [6].

The back-end flow is managed by `genacc.py` in the root folder.

### Package Structure
#### Hardware
##### HWPE Wrapper
##### Overlay
#### Software
### How to Integrate New Functionalities
#### Modules

## Verification

### Standalone Wrapper Testbench
From WR:
*I have in mind to add up to the repository some continuous development methodologies to help with the insertion of new templating functionalities. I think this is important as our view is to expand the repository and to give other people the opportunity to modify the back-end. Discussing this point with Alessandro and Andrea, we think that It would be nice to have a regression control. To this end, something like the continuous integration (CI) runner that HERO already supports might be a nice-to-have feature to guarantee robustness. At first, a cool idea could be to take advantage of the testbench generation to “silently” run RTL tests on the accelerator library examples. This is to cover the first portion of the bugs that might manifest in the case of back-end updates.
The latter idea also overlaps with the requirement of having some verification of new user wrappers. We currently miss a way of giving feedback on the correct functionality of new wrappers at the RTL level apart from the employment of traditional RTL verification in QuestaSim. My idea is to head up to a sort of “silent” and automatic RTL simulation with minimal user intervention. I think this would be a nice addition to keep abstraction on the proposed methodology.*

### Standalone Overlay Testbench
GenAcc supports the generation of a simple test routine for the instantiation of HWPE in a standalone PULP-based overlay system. The routine is a software test that is run in bare-metal and generated through templating (as is the RTL).
Together with the latter are generated also: 

-  `archi.h` - This C header file comprises the definition of the base address of the HWPE slave port, as well as its register offsets.
-  `hal.h` - This C header file comprises the hardware abstraction layer of HWPE, that is to say the first software layer on top of the RTL. This comprises the APIs definition to access the HWPE registers. 

To simplify the life of the verification engineer, the tool also generates a list of QuestaSim waves that are invoked before the beginning of the simulation. This obviously only works when employing the QuestaSim GUI. The list of waves include all the basic hardware components for a complete verification at system-level. The simulation components are integrated at system-level together with the aforementioned Makefile recipe (`make overlay_integration`).

 If QuestaSim is installed, the simulation infrastructure can be initialized as follows:

```
cd HERO_OV_HW_EXPORT
make
cd vsim
make compile
```
To compile the software applications to run the standalone overlay tests is necessary to set up the simulation environment. At first, it is necessary to set the following environment variable:

```
export HERO_OV_OPENMP_TESTS=<your_path> (typically something like $HERO_HOME_DIR/openmp-examples)
```

To build applications for the simulation, the dynamic environment can be loaded with `source $HERO_OV_HOME_DIR/env/esim.sh`. Then, the software can be find in the `sw` sub-directory of the exported wrapper. To compile it:
```
make clean all
```

Afterwards, the binary can be loaded in the simulator with:

```
cd $HERO_OV_HW_EXPORT/vsim
make gen_slm_hwpe HWPE_REPO=hwpe-<target_acc_name>-wrapper/sw
make sim
```
where `<target_acc_name>` is the name of the repository of the generated accelerator wrapper (e.g. *mmult_parallel*).

## GitLab CI/CD

## References
1) "A RISC-V-based FPGA Overlay to Simplify Embedded Accelerator Deployment" - G. Bellocchi et al. (2021)
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
* Position: Researcher at University of Modena and Reggio Emilia 
* E-mail: <gianluca.bellocchi@unimore.it>