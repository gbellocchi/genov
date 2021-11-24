/* =====================================================================
 * Project:      Traffic Generator
 * Title:        traffic_gen.cpp
 * Description:  Implementation of a generic accelerated kernel for DSE purposes.
 *
 * $Date:        12.11.2021
 * ===================================================================== */
/*
 * Copyright (C) 2021 University of Modena and Reggio Emilia..
 *
 * Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.
 *
 */


#include "traffic_gen.h"

// - // - // - // - // - // - // - // - // - // - // - // - // - // - // - // - 

template<typename T>
static void generate_req(
    hls::stream<T> &stream_in, 
    hls::stream<T> &stream_out,
    T n_trans, 
    T prob_req
) {

    // 
    // int numbers[] = { 2, 5, 22, 55, 332 };
    // int length = sizeof(numbers) / sizeof(int);
    // int randomNumber = numbers[rand() % length];

    // These assertions let HLS know the upper bounds of loops
    assert(n_trans < MAX_TRNCT);

    // Local array
    T local[MAX_TRNCT];

    read_in: for(int ii = 0; ii < n_trans; ii++){
    #pragma HLS PIPELINE
        local[ii] = stream_in.read();
    }

    write_out: for(int jj = 0; jj < n_trans; jj++){
    #pragma HLS PIPELINE
        stream_out << local[jj];
    }
}

// - // - // - // - // - // - // - // - // - // - // - // - // - // - // - // - 

void traffic_gen(

    // Data ports
    hls::stream<data_t> &stream_in, 
    hls::stream<data_t> &stream_out,

    // Custom registers
    int n_trans,    // Number of triggered requests
    int prob_req   // Probability of emitting a request (1000 -> 100%)

    // Ideas for other parameters
    // I/O ratio -> How many in correspond to an output?

) {

    #pragma HLS INTERFACE axis port=&stream_in 
    #pragma HLS INTERFACE axis port=&stream_out 

    generate_req<data_t>(   
		stream_in, 
        stream_out,
        n_trans, 
        prob_req
    );
}

// - // - // - // - // - // - // - // - // - // - // - // - // - // - // - // - 
