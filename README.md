
# HWPE Wrapper Automated Generator Tool

## Introduction
### Description
The HWPE Wrapper Generator Tool consists of a set of Python packages, System Verilog templates and a Makefile that permit to speed up the integration and deployment of hardware accelerators in PULP-based systems [1]. To learn more about HWPE, take a look at [2] and [3].

The integration of custom accelerators is simplified by the definition of a communication/control interface in the form of a wrapper to the acceleration logic that can be instantiated multiple times within a PULP-based cluster. A wrapper encapsulates the functionality of a HWPE streamer and controller modules. Since these modules have dependencies on the specific accelerator (engine) implementation, it is necessary to distinguish between their static and variable RTL components. Once the user has defined key properties of its accelerator design, the specialization of the wrapper is simplified via template instantiation.

Given a set of initial design rules, the designer is equipped with a high-level language (HLL) interface to allow for wrapper specialization. This tool does not mandate any specific methodology to design the engine of accelerators. Both HLS tools or manually optimized HDL code are supported. An automated flow permits to integrate the acceleration logic within the wrapper, which is in turn integrated with the PULP system for validation.

## Contacts
**Gianluca Bellocchi**
* Position: Researcher at University of Modena and Reggio Emilia 
* E-mail: <gianluca.bellocchi@unimore.it>

## Getting Started

### Clone the repository
We recommed the toolchain to be cloned in the hardware subdirectory of the PULP-based Overlay subsystem, as most of its functionalities will directly interact with that system portion.

```
git clone https://git.hipert.unimore.it/comp4drones/HERO/hwpe-wrapper-gen-tool.git
```

### External sources
The tool uses Git submodules that have to be initialized. In order to fetch the submodules in the repository, run:

```
make init
```

This command also manages the installation of the required Python packages (defined in `setup.py`).

### Setup
Most of the specialization flow is handled locally to the tool subdirectory. At a certain point the user may decide to export and integrate the specialized hardware/software products to the overlay system. This process is fully automated (and no-error-prone) as far as the tool knows how to securely interface to the overlay.

Thus, we recommend to set the following environment variable to the location of the overlay hardware subsystem.

```
export OVERLAY_HW_EXPORT=<your_path>
```

This location should comprise the following directories that are going to be targeted in the integration phase:

 - `src` - SystemVerilog source files to parametrize the PULP-based overlay system.
 - `deps` - SystemVerilog dependencies. Basically, the overlay IPs (RISC-V core, DMA, HWPE accelerators, etc.).
 - `test` - SystemVerilog testbench to simulate the hardware behavior.

## Accelerator Integration Methodology

### Engine design
The methodology currently supports wrapping of custom acceleration engines that exhibit the following features:

 1. **Streaming accelerators** since they permit to take advantage of the strong decoupling in designing the wrapper and the accelerator engine.
 2. **Data access pattern** has to be easily describable in a for-loop fashion, as reported in the listing below. To this end, the user can take advantage of address generators to map local memory accesses to data streams. More information concerning the address generator and the mapping of its parameters to the specific data access pattern of the accelerator are to be found in [3].

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

#### Accelerator library
User-defined engine specifications and examples are to be inserted in the accelerator library (`acc_lib`).
To extend the content of the library, the best practice is to create a new library folder containing:

 1. `specs` - Python specification file with the information concerning the interface between the HWPE wrapper and the acceleration engine, as well as additional features
 2. `rtl` - RTL components of the engine the user wants to wrap. To this end, the flow does not mandate any specific design methodology for the target accelerator engines.
 3. `sw` - Additional software components to guide testing.

### Wrapper specialization 
Once the accelerator library has been updated, return back to the top folder. Here is a Makefile comprising all the recipes that are necessary to manage the specialization environment and export HW/SW products to the overlay system. 

The first required step is to open the Makefile and modify the value of the macro `HWPE_TARGET` specifying the name of the accelerator the user wants to wrap. This has to match the name of an accelerator library component. As an example: 

```
HWPE_TARGET = mac
```
Subsequently, to specialize the wrapper is required to just run `make`. 

This way, the Python template libraries will process the SystemVerilog wrapper templates on the basis of the information the input Python specification file has been compiled with. This permits the wrapping of the specified accelerator engine design. The generated files are exported to the `output` folder.

### System-Level Optimization
System-level optimization is enabled by propagating intra-process optimization knobs across the overlay infrastructure. The latter is possible since the tool renders SystemVerilog templates too. These templates deal with the different architectural blocks composing the overlay infrastructure, e.g. the accelerator interconnect, memory, DMA. Automated parametrization of this set of components is possible by exploiting the information comprised in the input Python specification file.

### System-Level Integration
To export the generated HW/SW to the Overlay ecosystem run:

```
make overlay_deps
```

### Runtime Accelerator Control
The overlay and the wrapper feed the accelerator datapath exploiting **data tiling**.

## References:
1) "A RISC-V-based FPGA Overlay to Simplify Embedded Accelerator Deployment" - G. Bellocchi et al. (2021)
2) "XNOR Neural Engine: A Hardware Accelerator IP for 21.6-fJ/op Binary Neural Network Inference" - F. Conti et al. (2018)
3) Hardware Processing Engines Documentation: https://hwpe-doc.readthedocs.io/en/latest/index.html

## Useful repositories:
1) Hardware Processing Engine - Streamer: https://github.com/pulp-platform/hwpe-stream
2) Hardware Processing Engine - Controller: https://github.com/pulp-platform/hwpe-ctrl
3) Hardware Processing Engine - MAC engine example: https://github.com/pulp-platform/hwpe-mac-engine
4) Hardware Processing Engine - Standalone testbench: https://github.com/pulp-platform/hwpe-tb
5) PULP platform - https://github.com/pulp-platform
