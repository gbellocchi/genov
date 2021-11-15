// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2019.2.1
// Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

#include "generate_req.h"
#include "AESL_pkg.h"

using namespace std;

namespace ap_rtl {

const sc_logic generate_req::ap_const_logic_1 = sc_dt::Log_1;
const sc_logic generate_req::ap_const_logic_0 = sc_dt::Log_0;
const sc_lv<5> generate_req::ap_ST_fsm_state1 = "1";
const sc_lv<5> generate_req::ap_ST_fsm_state2 = "10";
const sc_lv<5> generate_req::ap_ST_fsm_state3 = "100";
const sc_lv<5> generate_req::ap_ST_fsm_pp1_stage0 = "1000";
const sc_lv<5> generate_req::ap_ST_fsm_state6 = "10000";
const bool generate_req::ap_const_boolean_1 = true;
const sc_lv<32> generate_req::ap_const_lv32_0 = "00000000000000000000000000000000";
const sc_lv<32> generate_req::ap_const_lv32_1 = "1";
const sc_lv<1> generate_req::ap_const_lv1_0 = "0";
const sc_lv<32> generate_req::ap_const_lv32_3 = "11";
const bool generate_req::ap_const_boolean_0 = false;
const sc_lv<32> generate_req::ap_const_lv32_2 = "10";
const sc_lv<1> generate_req::ap_const_lv1_1 = "1";
const sc_lv<11> generate_req::ap_const_lv11_0 = "00000000000";
const sc_lv<11> generate_req::ap_const_lv11_1 = "1";
const sc_lv<32> generate_req::ap_const_lv32_4 = "100";

generate_req::generate_req(sc_module_name name) : sc_module(name), mVcdFile(0) {
    local_U = new generate_req_local("local_U");
    local_U->clk(ap_clk);
    local_U->reset(ap_rst);
    local_U->address0(local_address0);
    local_U->ce0(local_ce0);
    local_U->we0(local_we0);
    local_U->d0(stream_in_V_TDATA);
    local_U->q0(local_q0);

    SC_METHOD(thread_ap_clk_no_reset_);
    dont_initialize();
    sensitive << ( ap_clk.pos() );

    SC_METHOD(thread_ap_CS_fsm_pp1_stage0);
    sensitive << ( ap_CS_fsm );

    SC_METHOD(thread_ap_CS_fsm_state1);
    sensitive << ( ap_CS_fsm );

    SC_METHOD(thread_ap_CS_fsm_state2);
    sensitive << ( ap_CS_fsm );

    SC_METHOD(thread_ap_CS_fsm_state3);
    sensitive << ( ap_CS_fsm );

    SC_METHOD(thread_ap_CS_fsm_state6);
    sensitive << ( ap_CS_fsm );

    SC_METHOD(thread_ap_block_pp1_stage0);

    SC_METHOD(thread_ap_block_pp1_stage0_01001);

    SC_METHOD(thread_ap_block_pp1_stage0_11001);
    sensitive << ( ap_enable_reg_pp1_iter1 );
    sensitive << ( ap_block_state5_io );

    SC_METHOD(thread_ap_block_pp1_stage0_subdone);
    sensitive << ( ap_enable_reg_pp1_iter1 );
    sensitive << ( ap_block_state5_io );

    SC_METHOD(thread_ap_block_state2);
    sensitive << ( stream_in_V_TVALID );
    sensitive << ( icmp_ln39_fu_120_p2 );

    SC_METHOD(thread_ap_block_state4_pp1_stage0_iter0);

    SC_METHOD(thread_ap_block_state5_io);
    sensitive << ( stream_out_V_TREADY );
    sensitive << ( icmp_ln44_reg_166 );

    SC_METHOD(thread_ap_block_state5_pp1_stage0_iter1);

    SC_METHOD(thread_ap_condition_pp1_exit_iter0_state4);
    sensitive << ( icmp_ln44_fu_136_p2 );

    SC_METHOD(thread_ap_done);
    sensitive << ( ap_start );
    sensitive << ( ap_CS_fsm_state1 );
    sensitive << ( ap_CS_fsm_state6 );

    SC_METHOD(thread_ap_enable_pp1);
    sensitive << ( ap_idle_pp1 );

    SC_METHOD(thread_ap_idle);
    sensitive << ( ap_start );
    sensitive << ( ap_CS_fsm_state1 );

    SC_METHOD(thread_ap_idle_pp1);
    sensitive << ( ap_enable_reg_pp1_iter1 );
    sensitive << ( ap_enable_reg_pp1_iter0 );

    SC_METHOD(thread_ap_ready);
    sensitive << ( ap_CS_fsm_state6 );

    SC_METHOD(thread_empty_fu_116_p1);
    sensitive << ( n_trans );

    SC_METHOD(thread_icmp_ln39_fu_120_p2);
    sensitive << ( stream_in_V_TVALID );
    sensitive << ( ap_CS_fsm_state2 );
    sensitive << ( icmp_ln39_fu_120_p2 );
    sensitive << ( empty_reg_152 );
    sensitive << ( ii_0_reg_94 );

    SC_METHOD(thread_icmp_ln44_fu_136_p2);
    sensitive << ( ap_CS_fsm_pp1_stage0 );
    sensitive << ( jj_0_reg_105 );
    sensitive << ( empty_reg_152 );
    sensitive << ( ap_block_pp1_stage0_11001 );
    sensitive << ( ap_enable_reg_pp1_iter0 );

    SC_METHOD(thread_ii_fu_125_p2);
    sensitive << ( ii_0_reg_94 );

    SC_METHOD(thread_jj_fu_141_p2);
    sensitive << ( jj_0_reg_105 );

    SC_METHOD(thread_local_address0);
    sensitive << ( ap_CS_fsm_state2 );
    sensitive << ( ap_CS_fsm_pp1_stage0 );
    sensitive << ( ap_block_pp1_stage0 );
    sensitive << ( ap_enable_reg_pp1_iter0 );
    sensitive << ( zext_ln41_fu_131_p1 );
    sensitive << ( zext_ln46_fu_147_p1 );

    SC_METHOD(thread_local_ce0);
    sensitive << ( stream_in_V_TVALID );
    sensitive << ( ap_CS_fsm_state2 );
    sensitive << ( icmp_ln39_fu_120_p2 );
    sensitive << ( ap_CS_fsm_pp1_stage0 );
    sensitive << ( ap_block_pp1_stage0_11001 );
    sensitive << ( ap_enable_reg_pp1_iter0 );

    SC_METHOD(thread_local_we0);
    sensitive << ( stream_in_V_TVALID );
    sensitive << ( ap_CS_fsm_state2 );
    sensitive << ( icmp_ln39_fu_120_p2 );

    SC_METHOD(thread_stream_in_V_TDATA_blk_n);
    sensitive << ( stream_in_V_TVALID );
    sensitive << ( ap_CS_fsm_state2 );
    sensitive << ( icmp_ln39_fu_120_p2 );

    SC_METHOD(thread_stream_in_V_TREADY);
    sensitive << ( stream_in_V_TVALID );
    sensitive << ( ap_CS_fsm_state2 );
    sensitive << ( icmp_ln39_fu_120_p2 );

    SC_METHOD(thread_stream_out_V_TDATA);
    sensitive << ( ap_CS_fsm_pp1_stage0 );
    sensitive << ( ap_enable_reg_pp1_iter1 );
    sensitive << ( icmp_ln44_reg_166 );
    sensitive << ( local_q0 );
    sensitive << ( ap_block_pp1_stage0_01001 );

    SC_METHOD(thread_stream_out_V_TDATA_blk_n);
    sensitive << ( stream_out_V_TREADY );
    sensitive << ( ap_CS_fsm_pp1_stage0 );
    sensitive << ( ap_enable_reg_pp1_iter1 );
    sensitive << ( ap_block_pp1_stage0 );
    sensitive << ( icmp_ln44_reg_166 );

    SC_METHOD(thread_stream_out_V_TVALID);
    sensitive << ( ap_CS_fsm_pp1_stage0 );
    sensitive << ( ap_enable_reg_pp1_iter1 );
    sensitive << ( icmp_ln44_reg_166 );
    sensitive << ( ap_block_pp1_stage0_11001 );

    SC_METHOD(thread_zext_ln41_fu_131_p1);
    sensitive << ( ii_0_reg_94 );

    SC_METHOD(thread_zext_ln46_fu_147_p1);
    sensitive << ( jj_0_reg_105 );

    SC_METHOD(thread_ap_NS_fsm);
    sensitive << ( ap_start );
    sensitive << ( ap_CS_fsm );
    sensitive << ( ap_CS_fsm_state1 );
    sensitive << ( stream_in_V_TVALID );
    sensitive << ( ap_CS_fsm_state2 );
    sensitive << ( icmp_ln39_fu_120_p2 );
    sensitive << ( icmp_ln44_fu_136_p2 );
    sensitive << ( ap_enable_reg_pp1_iter0 );
    sensitive << ( ap_block_pp1_stage0_subdone );

    ap_CS_fsm = "00001";
    ap_enable_reg_pp1_iter1 = SC_LOGIC_0;
    ap_enable_reg_pp1_iter0 = SC_LOGIC_0;
    static int apTFileNum = 0;
    stringstream apTFilenSS;
    apTFilenSS << "generate_req_sc_trace_" << apTFileNum ++;
    string apTFn = apTFilenSS.str();
    mVcdFile = sc_create_vcd_trace_file(apTFn.c_str());
    mVcdFile->set_time_unit(1, SC_PS);
    if (1) {
#ifdef __HLS_TRACE_LEVEL_PORT_HIER__
    sc_trace(mVcdFile, ap_clk, "(port)ap_clk");
    sc_trace(mVcdFile, ap_rst, "(port)ap_rst");
    sc_trace(mVcdFile, ap_start, "(port)ap_start");
    sc_trace(mVcdFile, ap_done, "(port)ap_done");
    sc_trace(mVcdFile, ap_idle, "(port)ap_idle");
    sc_trace(mVcdFile, ap_ready, "(port)ap_ready");
    sc_trace(mVcdFile, stream_in_V_TDATA, "(port)stream_in_V_TDATA");
    sc_trace(mVcdFile, stream_in_V_TVALID, "(port)stream_in_V_TVALID");
    sc_trace(mVcdFile, stream_in_V_TREADY, "(port)stream_in_V_TREADY");
    sc_trace(mVcdFile, stream_out_V_TDATA, "(port)stream_out_V_TDATA");
    sc_trace(mVcdFile, stream_out_V_TVALID, "(port)stream_out_V_TVALID");
    sc_trace(mVcdFile, stream_out_V_TREADY, "(port)stream_out_V_TREADY");
    sc_trace(mVcdFile, n_trans, "(port)n_trans");
#endif
#ifdef __HLS_TRACE_LEVEL_INT__
    sc_trace(mVcdFile, ap_CS_fsm, "ap_CS_fsm");
    sc_trace(mVcdFile, ap_CS_fsm_state1, "ap_CS_fsm_state1");
    sc_trace(mVcdFile, stream_in_V_TDATA_blk_n, "stream_in_V_TDATA_blk_n");
    sc_trace(mVcdFile, ap_CS_fsm_state2, "ap_CS_fsm_state2");
    sc_trace(mVcdFile, icmp_ln39_fu_120_p2, "icmp_ln39_fu_120_p2");
    sc_trace(mVcdFile, stream_out_V_TDATA_blk_n, "stream_out_V_TDATA_blk_n");
    sc_trace(mVcdFile, ap_CS_fsm_pp1_stage0, "ap_CS_fsm_pp1_stage0");
    sc_trace(mVcdFile, ap_enable_reg_pp1_iter1, "ap_enable_reg_pp1_iter1");
    sc_trace(mVcdFile, ap_block_pp1_stage0, "ap_block_pp1_stage0");
    sc_trace(mVcdFile, icmp_ln44_reg_166, "icmp_ln44_reg_166");
    sc_trace(mVcdFile, jj_0_reg_105, "jj_0_reg_105");
    sc_trace(mVcdFile, empty_fu_116_p1, "empty_fu_116_p1");
    sc_trace(mVcdFile, empty_reg_152, "empty_reg_152");
    sc_trace(mVcdFile, ii_fu_125_p2, "ii_fu_125_p2");
    sc_trace(mVcdFile, ap_block_state2, "ap_block_state2");
    sc_trace(mVcdFile, icmp_ln44_fu_136_p2, "icmp_ln44_fu_136_p2");
    sc_trace(mVcdFile, ap_block_state4_pp1_stage0_iter0, "ap_block_state4_pp1_stage0_iter0");
    sc_trace(mVcdFile, ap_block_state5_pp1_stage0_iter1, "ap_block_state5_pp1_stage0_iter1");
    sc_trace(mVcdFile, ap_block_state5_io, "ap_block_state5_io");
    sc_trace(mVcdFile, ap_block_pp1_stage0_11001, "ap_block_pp1_stage0_11001");
    sc_trace(mVcdFile, jj_fu_141_p2, "jj_fu_141_p2");
    sc_trace(mVcdFile, ap_enable_reg_pp1_iter0, "ap_enable_reg_pp1_iter0");
    sc_trace(mVcdFile, ap_CS_fsm_state3, "ap_CS_fsm_state3");
    sc_trace(mVcdFile, ap_block_pp1_stage0_subdone, "ap_block_pp1_stage0_subdone");
    sc_trace(mVcdFile, ap_condition_pp1_exit_iter0_state4, "ap_condition_pp1_exit_iter0_state4");
    sc_trace(mVcdFile, local_address0, "local_address0");
    sc_trace(mVcdFile, local_ce0, "local_ce0");
    sc_trace(mVcdFile, local_we0, "local_we0");
    sc_trace(mVcdFile, local_q0, "local_q0");
    sc_trace(mVcdFile, ii_0_reg_94, "ii_0_reg_94");
    sc_trace(mVcdFile, zext_ln41_fu_131_p1, "zext_ln41_fu_131_p1");
    sc_trace(mVcdFile, zext_ln46_fu_147_p1, "zext_ln46_fu_147_p1");
    sc_trace(mVcdFile, ap_block_pp1_stage0_01001, "ap_block_pp1_stage0_01001");
    sc_trace(mVcdFile, ap_CS_fsm_state6, "ap_CS_fsm_state6");
    sc_trace(mVcdFile, ap_NS_fsm, "ap_NS_fsm");
    sc_trace(mVcdFile, ap_idle_pp1, "ap_idle_pp1");
    sc_trace(mVcdFile, ap_enable_pp1, "ap_enable_pp1");
#endif

    }
}

generate_req::~generate_req() {
    if (mVcdFile) 
        sc_close_vcd_trace_file(mVcdFile);

    delete local_U;
}

void generate_req::thread_ap_clk_no_reset_() {
    if ( ap_rst.read() == ap_const_logic_1) {
        ap_CS_fsm = ap_ST_fsm_state1;
    } else {
        ap_CS_fsm = ap_NS_fsm.read();
    }
    if ( ap_rst.read() == ap_const_logic_1) {
        ap_enable_reg_pp1_iter0 = ap_const_logic_0;
    } else {
        if ((esl_seteq<1,1,1>(ap_const_logic_1, ap_CS_fsm_pp1_stage0.read()) && 
             esl_seteq<1,1,1>(ap_block_pp1_stage0_subdone.read(), ap_const_boolean_0) && 
             esl_seteq<1,1,1>(ap_const_logic_1, ap_condition_pp1_exit_iter0_state4.read()))) {
            ap_enable_reg_pp1_iter0 = ap_const_logic_0;
        } else if (esl_seteq<1,1,1>(ap_const_logic_1, ap_CS_fsm_state3.read())) {
            ap_enable_reg_pp1_iter0 = ap_const_logic_1;
        }
    }
    if ( ap_rst.read() == ap_const_logic_1) {
        ap_enable_reg_pp1_iter1 = ap_const_logic_0;
    } else {
        if ((esl_seteq<1,1,1>(ap_block_pp1_stage0_subdone.read(), ap_const_boolean_0) && 
             esl_seteq<1,1,1>(ap_const_logic_1, ap_condition_pp1_exit_iter0_state4.read()))) {
            ap_enable_reg_pp1_iter1 = (ap_condition_pp1_exit_iter0_state4.read() ^ ap_const_logic_1);
        } else if (esl_seteq<1,1,1>(ap_block_pp1_stage0_subdone.read(), ap_const_boolean_0)) {
            ap_enable_reg_pp1_iter1 = ap_enable_reg_pp1_iter0.read();
        } else if (esl_seteq<1,1,1>(ap_const_logic_1, ap_CS_fsm_state3.read())) {
            ap_enable_reg_pp1_iter1 = ap_const_logic_0;
        }
    }
    if ((esl_seteq<1,1,1>(ap_const_logic_1, ap_CS_fsm_state1.read()) && 
         esl_seteq<1,1,1>(ap_start.read(), ap_const_logic_1))) {
        ii_0_reg_94 = ap_const_lv11_0;
    } else if ((esl_seteq<1,1,1>(ap_const_logic_1, ap_CS_fsm_state2.read()) && 
                esl_seteq<1,1,1>(icmp_ln39_fu_120_p2.read(), ap_const_lv1_0) && 
                !(esl_seteq<1,1,1>(icmp_ln39_fu_120_p2.read(), ap_const_lv1_0) && esl_seteq<1,1,1>(ap_const_logic_0, stream_in_V_TVALID.read())))) {
        ii_0_reg_94 = ii_fu_125_p2.read();
    }
    if (esl_seteq<1,1,1>(ap_const_logic_1, ap_CS_fsm_state3.read())) {
        jj_0_reg_105 = ap_const_lv11_0;
    } else if ((esl_seteq<1,1,1>(ap_const_logic_1, ap_CS_fsm_pp1_stage0.read()) && 
                esl_seteq<1,1,1>(ap_block_pp1_stage0_11001.read(), ap_const_boolean_0) && 
                esl_seteq<1,1,1>(ap_const_logic_1, ap_enable_reg_pp1_iter0.read()) && 
                esl_seteq<1,1,1>(ap_const_lv1_0, icmp_ln44_fu_136_p2.read()))) {
        jj_0_reg_105 = jj_fu_141_p2.read();
    }
    if ((esl_seteq<1,1,1>(ap_const_logic_1, ap_CS_fsm_state1.read()) && esl_seteq<1,1,1>(ap_start.read(), ap_const_logic_1))) {
        empty_reg_152 = empty_fu_116_p1.read();
    }
    if ((esl_seteq<1,1,1>(ap_const_logic_1, ap_CS_fsm_pp1_stage0.read()) && esl_seteq<1,1,1>(ap_block_pp1_stage0_11001.read(), ap_const_boolean_0))) {
        icmp_ln44_reg_166 = icmp_ln44_fu_136_p2.read();
    }
}

void generate_req::thread_ap_CS_fsm_pp1_stage0() {
    ap_CS_fsm_pp1_stage0 = ap_CS_fsm.read()[3];
}

void generate_req::thread_ap_CS_fsm_state1() {
    ap_CS_fsm_state1 = ap_CS_fsm.read()[0];
}

void generate_req::thread_ap_CS_fsm_state2() {
    ap_CS_fsm_state2 = ap_CS_fsm.read()[1];
}

void generate_req::thread_ap_CS_fsm_state3() {
    ap_CS_fsm_state3 = ap_CS_fsm.read()[2];
}

void generate_req::thread_ap_CS_fsm_state6() {
    ap_CS_fsm_state6 = ap_CS_fsm.read()[4];
}

void generate_req::thread_ap_block_pp1_stage0() {
    ap_block_pp1_stage0 = !esl_seteq<1,1,1>(ap_const_boolean_1, ap_const_boolean_1);
}

void generate_req::thread_ap_block_pp1_stage0_01001() {
    ap_block_pp1_stage0_01001 = !esl_seteq<1,1,1>(ap_const_boolean_1, ap_const_boolean_1);
}

void generate_req::thread_ap_block_pp1_stage0_11001() {
    ap_block_pp1_stage0_11001 = (esl_seteq<1,1,1>(ap_const_logic_1, ap_enable_reg_pp1_iter1.read()) && esl_seteq<1,1,1>(ap_const_boolean_1, ap_block_state5_io.read()));
}

void generate_req::thread_ap_block_pp1_stage0_subdone() {
    ap_block_pp1_stage0_subdone = (esl_seteq<1,1,1>(ap_const_logic_1, ap_enable_reg_pp1_iter1.read()) && esl_seteq<1,1,1>(ap_const_boolean_1, ap_block_state5_io.read()));
}

void generate_req::thread_ap_block_state2() {
    ap_block_state2 = (esl_seteq<1,1,1>(icmp_ln39_fu_120_p2.read(), ap_const_lv1_0) && esl_seteq<1,1,1>(ap_const_logic_0, stream_in_V_TVALID.read()));
}

void generate_req::thread_ap_block_state4_pp1_stage0_iter0() {
    ap_block_state4_pp1_stage0_iter0 = !esl_seteq<1,1,1>(ap_const_boolean_1, ap_const_boolean_1);
}

void generate_req::thread_ap_block_state5_io() {
    ap_block_state5_io = (esl_seteq<1,1,1>(ap_const_lv1_0, icmp_ln44_reg_166.read()) && esl_seteq<1,1,1>(ap_const_logic_0, stream_out_V_TREADY.read()));
}

void generate_req::thread_ap_block_state5_pp1_stage0_iter1() {
    ap_block_state5_pp1_stage0_iter1 = !esl_seteq<1,1,1>(ap_const_boolean_1, ap_const_boolean_1);
}

void generate_req::thread_ap_condition_pp1_exit_iter0_state4() {
    if (esl_seteq<1,1,1>(icmp_ln44_fu_136_p2.read(), ap_const_lv1_1)) {
        ap_condition_pp1_exit_iter0_state4 = ap_const_logic_1;
    } else {
        ap_condition_pp1_exit_iter0_state4 = ap_const_logic_0;
    }
}

void generate_req::thread_ap_done() {
    if (((esl_seteq<1,1,1>(ap_const_logic_0, ap_start.read()) && 
          esl_seteq<1,1,1>(ap_const_logic_1, ap_CS_fsm_state1.read())) || 
         esl_seteq<1,1,1>(ap_const_logic_1, ap_CS_fsm_state6.read()))) {
        ap_done = ap_const_logic_1;
    } else {
        ap_done = ap_const_logic_0;
    }
}

void generate_req::thread_ap_enable_pp1() {
    ap_enable_pp1 = (ap_idle_pp1.read() ^ ap_const_logic_1);
}

void generate_req::thread_ap_idle() {
    if ((esl_seteq<1,1,1>(ap_const_logic_0, ap_start.read()) && 
         esl_seteq<1,1,1>(ap_const_logic_1, ap_CS_fsm_state1.read()))) {
        ap_idle = ap_const_logic_1;
    } else {
        ap_idle = ap_const_logic_0;
    }
}

void generate_req::thread_ap_idle_pp1() {
    if ((esl_seteq<1,1,1>(ap_const_logic_0, ap_enable_reg_pp1_iter0.read()) && 
         esl_seteq<1,1,1>(ap_const_logic_0, ap_enable_reg_pp1_iter1.read()))) {
        ap_idle_pp1 = ap_const_logic_1;
    } else {
        ap_idle_pp1 = ap_const_logic_0;
    }
}

void generate_req::thread_ap_ready() {
    if (esl_seteq<1,1,1>(ap_const_logic_1, ap_CS_fsm_state6.read())) {
        ap_ready = ap_const_logic_1;
    } else {
        ap_ready = ap_const_logic_0;
    }
}

void generate_req::thread_empty_fu_116_p1() {
    empty_fu_116_p1 = n_trans.read().range(11-1, 0);
}

void generate_req::thread_icmp_ln39_fu_120_p2() {
    icmp_ln39_fu_120_p2 = (!ii_0_reg_94.read().is_01() || !empty_reg_152.read().is_01())? sc_lv<1>(): sc_lv<1>(ii_0_reg_94.read() == empty_reg_152.read());
}

void generate_req::thread_icmp_ln44_fu_136_p2() {
    icmp_ln44_fu_136_p2 = (!jj_0_reg_105.read().is_01() || !empty_reg_152.read().is_01())? sc_lv<1>(): sc_lv<1>(jj_0_reg_105.read() == empty_reg_152.read());
}

void generate_req::thread_ii_fu_125_p2() {
    ii_fu_125_p2 = (!ii_0_reg_94.read().is_01() || !ap_const_lv11_1.is_01())? sc_lv<11>(): (sc_biguint<11>(ii_0_reg_94.read()) + sc_biguint<11>(ap_const_lv11_1));
}

void generate_req::thread_jj_fu_141_p2() {
    jj_fu_141_p2 = (!jj_0_reg_105.read().is_01() || !ap_const_lv11_1.is_01())? sc_lv<11>(): (sc_biguint<11>(jj_0_reg_105.read()) + sc_biguint<11>(ap_const_lv11_1));
}

void generate_req::thread_local_address0() {
    if ((esl_seteq<1,1,1>(ap_const_logic_1, ap_CS_fsm_pp1_stage0.read()) && 
         esl_seteq<1,1,1>(ap_block_pp1_stage0.read(), ap_const_boolean_0) && 
         esl_seteq<1,1,1>(ap_const_logic_1, ap_enable_reg_pp1_iter0.read()))) {
        local_address0 =  (sc_lv<11>) (zext_ln46_fu_147_p1.read());
    } else if (esl_seteq<1,1,1>(ap_const_logic_1, ap_CS_fsm_state2.read())) {
        local_address0 =  (sc_lv<11>) (zext_ln41_fu_131_p1.read());
    } else {
        local_address0 = "XXXXXXXXXXX";
    }
}

void generate_req::thread_local_ce0() {
    if (((esl_seteq<1,1,1>(ap_const_logic_1, ap_CS_fsm_state2.read()) && 
          !(esl_seteq<1,1,1>(icmp_ln39_fu_120_p2.read(), ap_const_lv1_0) && esl_seteq<1,1,1>(ap_const_logic_0, stream_in_V_TVALID.read()))) || 
         (esl_seteq<1,1,1>(ap_const_logic_1, ap_CS_fsm_pp1_stage0.read()) && 
          esl_seteq<1,1,1>(ap_block_pp1_stage0_11001.read(), ap_const_boolean_0) && 
          esl_seteq<1,1,1>(ap_const_logic_1, ap_enable_reg_pp1_iter0.read())))) {
        local_ce0 = ap_const_logic_1;
    } else {
        local_ce0 = ap_const_logic_0;
    }
}

void generate_req::thread_local_we0() {
    if ((esl_seteq<1,1,1>(ap_const_logic_1, ap_CS_fsm_state2.read()) && 
         esl_seteq<1,1,1>(icmp_ln39_fu_120_p2.read(), ap_const_lv1_0) && 
         !(esl_seteq<1,1,1>(icmp_ln39_fu_120_p2.read(), ap_const_lv1_0) && esl_seteq<1,1,1>(ap_const_logic_0, stream_in_V_TVALID.read())))) {
        local_we0 = ap_const_logic_1;
    } else {
        local_we0 = ap_const_logic_0;
    }
}

void generate_req::thread_stream_in_V_TDATA_blk_n() {
    if ((esl_seteq<1,1,1>(ap_const_logic_1, ap_CS_fsm_state2.read()) && 
         esl_seteq<1,1,1>(icmp_ln39_fu_120_p2.read(), ap_const_lv1_0))) {
        stream_in_V_TDATA_blk_n = stream_in_V_TVALID.read();
    } else {
        stream_in_V_TDATA_blk_n = ap_const_logic_1;
    }
}

void generate_req::thread_stream_in_V_TREADY() {
    if ((esl_seteq<1,1,1>(ap_const_logic_1, ap_CS_fsm_state2.read()) && 
         esl_seteq<1,1,1>(icmp_ln39_fu_120_p2.read(), ap_const_lv1_0) && 
         !(esl_seteq<1,1,1>(icmp_ln39_fu_120_p2.read(), ap_const_lv1_0) && esl_seteq<1,1,1>(ap_const_logic_0, stream_in_V_TVALID.read())))) {
        stream_in_V_TREADY = ap_const_logic_1;
    } else {
        stream_in_V_TREADY = ap_const_logic_0;
    }
}

void generate_req::thread_stream_out_V_TDATA() {
    stream_out_V_TDATA = local_q0.read();
}

void generate_req::thread_stream_out_V_TDATA_blk_n() {
    if ((esl_seteq<1,1,1>(ap_const_logic_1, ap_CS_fsm_pp1_stage0.read()) && 
         esl_seteq<1,1,1>(ap_const_logic_1, ap_enable_reg_pp1_iter1.read()) && 
         esl_seteq<1,1,1>(ap_block_pp1_stage0.read(), ap_const_boolean_0) && 
         esl_seteq<1,1,1>(ap_const_lv1_0, icmp_ln44_reg_166.read()))) {
        stream_out_V_TDATA_blk_n = stream_out_V_TREADY.read();
    } else {
        stream_out_V_TDATA_blk_n = ap_const_logic_1;
    }
}

void generate_req::thread_stream_out_V_TVALID() {
    if ((esl_seteq<1,1,1>(ap_const_logic_1, ap_CS_fsm_pp1_stage0.read()) && 
         esl_seteq<1,1,1>(ap_const_logic_1, ap_enable_reg_pp1_iter1.read()) && 
         esl_seteq<1,1,1>(ap_const_lv1_0, icmp_ln44_reg_166.read()) && 
         esl_seteq<1,1,1>(ap_block_pp1_stage0_11001.read(), ap_const_boolean_0))) {
        stream_out_V_TVALID = ap_const_logic_1;
    } else {
        stream_out_V_TVALID = ap_const_logic_0;
    }
}

void generate_req::thread_zext_ln41_fu_131_p1() {
    zext_ln41_fu_131_p1 = esl_zext<64,11>(ii_0_reg_94.read());
}

void generate_req::thread_zext_ln46_fu_147_p1() {
    zext_ln46_fu_147_p1 = esl_zext<64,11>(jj_0_reg_105.read());
}

void generate_req::thread_ap_NS_fsm() {
    switch (ap_CS_fsm.read().to_uint64()) {
        case 1 : 
            if ((esl_seteq<1,1,1>(ap_const_logic_1, ap_CS_fsm_state1.read()) && esl_seteq<1,1,1>(ap_start.read(), ap_const_logic_1))) {
                ap_NS_fsm = ap_ST_fsm_state2;
            } else {
                ap_NS_fsm = ap_ST_fsm_state1;
            }
            break;
        case 2 : 
            if ((esl_seteq<1,1,1>(ap_const_logic_1, ap_CS_fsm_state2.read()) && esl_seteq<1,1,1>(icmp_ln39_fu_120_p2.read(), ap_const_lv1_0) && !(esl_seteq<1,1,1>(icmp_ln39_fu_120_p2.read(), ap_const_lv1_0) && esl_seteq<1,1,1>(ap_const_logic_0, stream_in_V_TVALID.read())))) {
                ap_NS_fsm = ap_ST_fsm_state2;
            } else if ((esl_seteq<1,1,1>(ap_const_logic_1, ap_CS_fsm_state2.read()) && !(esl_seteq<1,1,1>(icmp_ln39_fu_120_p2.read(), ap_const_lv1_0) && esl_seteq<1,1,1>(ap_const_logic_0, stream_in_V_TVALID.read())) && esl_seteq<1,1,1>(icmp_ln39_fu_120_p2.read(), ap_const_lv1_1))) {
                ap_NS_fsm = ap_ST_fsm_state3;
            } else {
                ap_NS_fsm = ap_ST_fsm_state2;
            }
            break;
        case 4 : 
            ap_NS_fsm = ap_ST_fsm_pp1_stage0;
            break;
        case 8 : 
            if (!(esl_seteq<1,1,1>(ap_const_logic_1, ap_enable_reg_pp1_iter0.read()) && esl_seteq<1,1,1>(ap_block_pp1_stage0_subdone.read(), ap_const_boolean_0) && esl_seteq<1,1,1>(icmp_ln44_fu_136_p2.read(), ap_const_lv1_1))) {
                ap_NS_fsm = ap_ST_fsm_pp1_stage0;
            } else if ((esl_seteq<1,1,1>(ap_const_logic_1, ap_enable_reg_pp1_iter0.read()) && esl_seteq<1,1,1>(ap_block_pp1_stage0_subdone.read(), ap_const_boolean_0) && esl_seteq<1,1,1>(icmp_ln44_fu_136_p2.read(), ap_const_lv1_1))) {
                ap_NS_fsm = ap_ST_fsm_state6;
            } else {
                ap_NS_fsm = ap_ST_fsm_pp1_stage0;
            }
            break;
        case 16 : 
            ap_NS_fsm = ap_ST_fsm_state1;
            break;
        default : 
            ap_NS_fsm =  (sc_lv<5>) ("XXXXX");
            break;
    }
}

}
