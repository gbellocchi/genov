#include "fir_128_mdc.h"
#include "AESL_pkg.h"

using namespace std;

namespace ap_rtl {

void fir_128_mdc::thread_hdltv_gen() {
    const char* dump_tv = std::getenv("AP_WRITE_TV");
    if (!(dump_tv && string(dump_tv) == "on")) return;

    wait();

    mHdltvinHandle << "[ " << endl;
    mHdltvoutHandle << "[ " << endl;
    int ap_cycleNo = 0;
    while (1) {
        wait();
        const char* mComma = ap_cycleNo == 0 ? " " : ", " ;
        mHdltvinHandle << mComma << "{"  <<  " \"ap_rst_n\" :  \"" << ap_rst_n.read() << "\" ";
        mHdltvinHandle << " , " <<  " \"x_V_TDATA\" :  \"" << x_V_TDATA.read() << "\" ";
        mHdltvinHandle << " , " <<  " \"x_V_TVALID\" :  \"" << x_V_TVALID.read() << "\" ";
        mHdltvoutHandle << mComma << "{"  <<  " \"x_V_TREADY\" :  \"" << x_V_TREADY.read() << "\" ";
        mHdltvoutHandle << " , " <<  " \"y_V_TDATA\" :  \"" << y_V_TDATA.read() << "\" ";
        mHdltvoutHandle << " , " <<  " \"y_V_TVALID\" :  \"" << y_V_TVALID.read() << "\" ";
        mHdltvinHandle << " , " <<  " \"y_V_TREADY\" :  \"" << y_V_TREADY.read() << "\" ";
        mHdltvinHandle << "}" << std::endl;
        mHdltvoutHandle << "}" << std::endl;
        ap_cycleNo++;
    }
}

}

