# HWPE Wrapper Generator Tool
The HWPE Wrapper Generator Tool consists of a set of python packages, SV templates and a Makefile that permit to speed up the 
integration and deployment of hardware accelerators in PULP-based systems. To learn more about HWPE, take a look at [1] and [2].

The integration of custom accelerators is simplified by the definition of a communication/control interface in the form of a wrapper 
to the acceleration logic that can be instantiated multiple times within a PULP-based cluster. A wrapper encapsulates the functionality 
of a HWPE streamer and controller modules. Since these modules have dependencies on the specific accelerator (engine) implementation, it 
is necessary to distinguish between their static and variable RTL components. Once the user has defined key properties of its accelerator 
design, the specialization of the wrapper is simplified via template instantiation.

Given a set of initial design rules, the designer is equipped with a high-level language (HLL) interface that allows him/her to customize 
the wrapper.This tool does not mandate any specific methodology to design theengine of accelerators. This can be accomplished with HLS tools, 
or by means of manually optimized RTL. An automated flow permits to integrate the acceleration logic within the wrapper, which is in turn integrated 
with the PULP system for validation. 

If you need further details, please contact me at <gianluca.bellocchi@unimore.it>

References:

    1) Hardware Processing Engines Documentation: https://hwpe-doc.readthedocs.io/en/latest/index.html

    2) "XNOR Neural Engine: A Hardware Accelerator IP for 21.6-fJ/op Binary Neural Network Inference" - F. Conti et al. (2018)






