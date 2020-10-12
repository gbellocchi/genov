# Hardware Processing Engine Generator

Author: Gianluca Bellocchi 
Email: gianluca.bellocchi@unimore.it

- HWPE GENERATOR -
The HWPE generator consists of a set of python packages, SV templates and a Makefile that permit to speed up
the design flow of HWPE devices. To learn more about this technology, take a look at [1] and [2].

- PROJECT STRUCTURE -
The current project directory tree is shown below. There is plenty of additional tools that have to be implemented. :)

hwpe-gen
├── hls_devices
├── output
│   ├── hw
│   └── sw
├── static_rtl
│   ├── hwpe-ctrl
│   └── hwpe-stream
│       ├── basic
│       ├── fifo
│       ├── streamer
│       ├── tcdm
│       └── verif
└── templates
    ├── hw
    │   ├── common
    │   ├── hwpe_ctrl
    │   │   ├── hwpe_ctrl
    │   │   └── hwpe_fsm
    │   ├── hwpe_engine
    │   ├── hwpe_package
    │   ├── hwpe_specs
    │   ├── hwpe_streamer
    │   ├── hwpe_top
    │   │   ├── hwpe_top
    │   │   └── hwpe_top_wrapper
    │   └── pulp_cluster_hwpe_pkg
    ├── hw_management
    │   ├── bender
    │   ├── ips_list
    │   ├── rtl_list
    │   └── src_files
    └── sw

- ENGINE DESIGN -
This product permits to easily generate an RTL overlay for an accelerator engine. The first requirement is the availability of a hardware accelerator that should embed a certain functionality (FFT, FIR, ..). Currently, this product has been tested using handcrafted and Vivado-HLS-generated accelerators. There are some design rules that should be respected. 
Below are described the main features a HWPE design must exhibit.

        < ENGINE CONTENT >
        The tested accelerators have embedded both a datapath and some control parts. For simplicity, we will refer to them as engines, 
        even though these blocks are not totally composed of data crunching elements. 

        < INTERFACE >
        The engine design should expose the following interface:
            - GLOBAL SIGNALS
                - ap_clk
                - ap_rst_n
            - CONTROL SIGNALS
                - ap_start
                - ap_done 
                - ap_idle
                - ap_ready
            - DATAPATH SIGNALS
                - Dependent on the particular HWPE design
            - HWPE-REGFILE SIGNALS
                - Dependent on the particular HWPE design

        < GLOBAL SIGNALS >
        The GLOBAL signals are automatically generated using Vivado HLS. In case of a handcrafted design, it is needed to
        specify these ports with the very same names and functionalities. The needed global signals are:
        - ap_clk    -> Clock signal.
        - ap_rst_n  -> Active-Low reset signal.

        < CONTROL SIGNALS >
        The CONTROL signals are automatically generated using Vivado HLS. In case of a handcrafted design, it is needed to
        specify these ports with the very same names and functionalities. The control parts that should be exposed to the 
        engine are responsible of communicating to the accelerator whether it should start a computation or they can be used
        to get to know when the accelerator is in an idle state, when a computation is terminated or if new input data can be 
        passed to its input ports. The functionality of the control signals is described below:
        - ap_start  -> This signal controls when the accelerator can start processing data. The design starts when ap_start is asserted High.
        - ap_done   -> This signal notifies when the accelerator has terminated its operation.
        - ap_idle   -> This signal indicates if the engine is idle or not. It is asserted Low to indicate the design is operating.
        - ap_ready  -> This signal indicates when the accelerator is ready to accept new inputs.
        More information about these signals can be found in the Vivado-HLS Documentation.

        < DATAPATH SIGNALS >
        The datapath is the accelerator surface area that is responsible for processing the input data and should 
        thus vary with the user needs. It is totally data dependent. If a FIR filter is needed, then a single input 
        and a single output ports may be enough, while a FFT engine may require more I/O ports. The HWPE philosophy
        envisions a streaming interface towards the L1 data memory of the PULP system. For this purpose, a HLS designer should define its
        accelerator I/O interfaces using the AXI-Stream protocol. A handcrafted design should follow the same trend and,
        in this case, an exhaustive description of an Open-Source streaming protocol (that is very similar to the AXI-Stream)
        can be found here: https://hwpe-doc.readthedocs.io/en/latest/protocols.html#hwpe-stream-protocol. The number of streaming ports
        can be controlled using the overlay scripts that are described below. Moreover, there are no restrictions on their names.

        * Abstraction of a function call -> if set of data, then you need to describe the c++ using the accelerator data-by-data -> pipelining etc. can make things more performant, etc.
        * Important this point cause it subsequently permits to generalize the use of external fsm. describe the difference between external and internal fsm.
        * spiega caratteristiche più tecniche (guarda hls)

        < HWPE-REGFILE SIGNALS >
        This overlay offers its users with a set of register files that can be totally customized following the user needs. These
        can be accessed through the slave port of the HWPE overlay and programmed using the RISC-V processor included in the proposed
        architecture. The best practice envisions the insertion of control parameters and stationary datapath parameters inside these
        registers. A little example may clarify this point. Let's think about a FIR filter with a transfer function composed of four
        coefficients. If the physics of the system permits to hypothize its stationarity, then the system coefficients will not vary
        in between different operation states. In this case, it is smarter to pass these coefficients through the slave port of the
        HWPE overlay and subsequently store them in dedicated register files instead of adding them to the input streaming flow. In
        case it is not possible to hipothize a condition of stationarity, then a designer may prefer an alternative implementation of
        these coefficients.

        * spiega caratteristiche più tecniche (guarda hls) - codice, ..
        

- OVERLAY SPECIFICATIONS -
The designer can customize the overlay acting on the class attributes that are comprised in the python script "hwpe_specs.py".
This class comprises different attribute fields:

    - Engineer(-s)
      This field can be filled with the designer(-s) information, such as their name, surname and email.
        
    - Environment
      This field can be filled with information concerning the project environent, such as the destination
      folder of the RTL designs.

    - HWPE
      This is the most interesting field. Here are comprised all the attributes that together with the SV block
      templates will define the output RTL devices. This field permits to specify the HWPE algorithm name, the
      number of I/O streaming ports and their names. The streaming directions are defined with respect to the engine that sinks data from the TCDM banks and returns its output results through as source streams. memor It is important to be aware of the fact 
      that the port names should be exactly equal (in terms of letters, symbols, numbers, case) to the ones that 
      have been handcrafted or generated via Vivado-HLS. Since the connections have been implemented by name, the port
      order is not strictly required. 

- SV TEMPLATES -
This project uses System Verilog templates that have already been tested in the aim of the PULP project. These scripts
have a similar style to a SV module but are different in the sense that their parts are dependentt on the overlay specifications.
The overlay blocks that are supported nowadays are
## TOBECOMPLETED

- RTL BUILD -

- DESIGN EXPORTING -

- FUTURE IMPROVEMENTS -




References:

    1) Hardware Processing Engines Documentation: https://hwpe-doc.readthedocs.io/en/latest/index.html

    2) "XNOR Neural Engine: A Hardware Accelerator IP for 21.6-fJ/op Binary Neural Network Inference" - F. Conti et al. (2018)

    3) Vivado-HLS Documentation: https://www.xilinx.com/support/documentation/sw_manuals/xilinx2017_4/ug902-vivado-high-level-synthesis.pdf






