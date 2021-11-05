# 1 "conv.cpp"
# 1 "conv.cpp" 1
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 155 "<built-in>" 3
# 1 "<command line>" 1






# 1 "/usr/pack/vitis-2019.2-kgf/Vivado/2019.2/common/technology/autopilot/etc/autopilot_ssdm_op.h" 1
# 157 "/usr/pack/vitis-2019.2-kgf/Vivado/2019.2/common/technology/autopilot/etc/autopilot_ssdm_op.h"
extern "C" {






    void _ssdm_op_IfRead(...) __attribute__ ((nothrow));
    void _ssdm_op_IfWrite(...) __attribute__ ((nothrow));
    unsigned int __attribute__ ((bitwidth(1))) _ssdm_op_IfNbRead(...) __attribute__ ((nothrow));
    unsigned int __attribute__ ((bitwidth(1))) _ssdm_op_IfNbWrite(...) __attribute__ ((nothrow));
    unsigned int __attribute__ ((bitwidth(1))) _ssdm_op_IfCanRead(...) __attribute__ ((nothrow));
    unsigned int __attribute__ ((bitwidth(1))) _ssdm_op_IfCanWrite(...) __attribute__ ((nothrow));


    void _ssdm_StreamRead(...) __attribute__ ((nothrow));
    void _ssdm_StreamWrite(...) __attribute__ ((nothrow));
    unsigned int __attribute__ ((bitwidth(1))) _ssdm_StreamNbRead(...) __attribute__ ((nothrow));
    unsigned int __attribute__ ((bitwidth(1))) _ssdm_StreamNbWrite(...) __attribute__ ((nothrow));
    unsigned int __attribute__ ((bitwidth(1))) _ssdm_StreamCanRead(...) __attribute__ ((nothrow));
    unsigned int __attribute__ ((bitwidth(1))) _ssdm_StreamCanWrite(...) __attribute__ ((nothrow));
    unsigned _ssdm_StreamSize(...) __attribute__ ((nothrow));




    void _ssdm_op_MemShiftRead(...) __attribute__ ((nothrow));

    void _ssdm_op_Wait(...) __attribute__ ((nothrow));
    void _ssdm_op_Poll(...) __attribute__ ((nothrow));

    void _ssdm_op_Return(...) __attribute__ ((nothrow));


    void _ssdm_op_SpecSynModule(...) __attribute__ ((nothrow));
    void _ssdm_op_SpecTopModule(...) __attribute__ ((nothrow));
    void _ssdm_op_SpecProcessDecl(...) __attribute__ ((nothrow));
    void _ssdm_op_SpecProcessDef(...) __attribute__ ((nothrow));
    void _ssdm_op_SpecPort(...) __attribute__ ((nothrow));
    void _ssdm_op_SpecConnection(...) __attribute__ ((nothrow));
    void _ssdm_op_SpecChannel(...) __attribute__ ((nothrow));
    void _ssdm_op_SpecSensitive(...) __attribute__ ((nothrow));
    void _ssdm_op_SpecModuleInst(...) __attribute__ ((nothrow));
    void _ssdm_op_SpecPortMap(...) __attribute__ ((nothrow));

    void _ssdm_op_SpecReset(...) __attribute__ ((nothrow));

    void _ssdm_op_SpecPlatform(...) __attribute__ ((nothrow));
    void _ssdm_op_SpecClockDomain(...) __attribute__ ((nothrow));
    void _ssdm_op_SpecPowerDomain(...) __attribute__ ((nothrow));

    int _ssdm_op_SpecRegionBegin(...) __attribute__ ((nothrow));
    int _ssdm_op_SpecRegionEnd(...) __attribute__ ((nothrow));

    void _ssdm_op_SpecLoopName(...) __attribute__ ((nothrow));

    void _ssdm_op_SpecLoopTripCount(...) __attribute__ ((nothrow));

    int _ssdm_op_SpecStateBegin(...) __attribute__ ((nothrow));
    int _ssdm_op_SpecStateEnd(...) __attribute__ ((nothrow));

    void _ssdm_op_SpecInterface(...) __attribute__ ((nothrow));

    void _ssdm_op_SpecPipeline(...) __attribute__ ((nothrow));
    void _ssdm_op_SpecDataflowPipeline(...) __attribute__ ((nothrow));


    void _ssdm_op_SpecLatency(...) __attribute__ ((nothrow));
    void _ssdm_op_SpecParallel(...) __attribute__ ((nothrow));
    void _ssdm_op_SpecProtocol(...) __attribute__ ((nothrow));
    void _ssdm_op_SpecOccurrence(...) __attribute__ ((nothrow));

    void _ssdm_op_SpecResource(...) __attribute__ ((nothrow));
    void _ssdm_op_SpecResourceLimit(...) __attribute__ ((nothrow));
    void _ssdm_op_SpecCHCore(...) __attribute__ ((nothrow));
    void _ssdm_op_SpecFUCore(...) __attribute__ ((nothrow));
    void _ssdm_op_SpecIFCore(...) __attribute__ ((nothrow));
    void _ssdm_op_SpecIPCore(...) __attribute__ ((nothrow));
    void _ssdm_op_SpecKeepValue(...) __attribute__ ((nothrow));
    void _ssdm_op_SpecMemCore(...) __attribute__ ((nothrow));

    void _ssdm_op_SpecExt(...) __attribute__ ((nothrow));




    void _ssdm_SpecArrayDimSize(...) __attribute__ ((nothrow));

    void _ssdm_RegionBegin(...) __attribute__ ((nothrow));
    void _ssdm_RegionEnd(...) __attribute__ ((nothrow));

    void _ssdm_Unroll(...) __attribute__ ((nothrow));
    void _ssdm_UnrollRegion(...) __attribute__ ((nothrow));

    void _ssdm_InlineAll(...) __attribute__ ((nothrow));
    void _ssdm_InlineLoop(...) __attribute__ ((nothrow));
    void _ssdm_Inline(...) __attribute__ ((nothrow));
    void _ssdm_InlineSelf(...) __attribute__ ((nothrow));
    void _ssdm_InlineRegion(...) __attribute__ ((nothrow));

    void _ssdm_SpecArrayMap(...) __attribute__ ((nothrow));
    void _ssdm_SpecArrayPartition(...) __attribute__ ((nothrow));
    void _ssdm_SpecArrayReshape(...) __attribute__ ((nothrow));

    void _ssdm_SpecStream(...) __attribute__ ((nothrow));

    void _ssdm_op_SpecStable(...) __attribute__ ((nothrow));
    void _ssdm_op_SpecStableContent(...) __attribute__ ((nothrow));

    void _ssdm_op_SpecPipoDepth(...) __attribute__ ((nothrow));

    void _ssdm_SpecExpr(...) __attribute__ ((nothrow));
    void _ssdm_SpecExprBalance(...) __attribute__ ((nothrow));

    void _ssdm_SpecDependence(...) __attribute__ ((nothrow));

    void _ssdm_SpecLoopMerge(...) __attribute__ ((nothrow));
    void _ssdm_SpecLoopFlatten(...) __attribute__ ((nothrow));
    void _ssdm_SpecLoopRewind(...) __attribute__ ((nothrow));

    void _ssdm_SpecFuncInstantiation(...) __attribute__ ((nothrow));
    void _ssdm_SpecFuncBuffer(...) __attribute__ ((nothrow));
    void _ssdm_SpecFuncExtract(...) __attribute__ ((nothrow));
    void _ssdm_SpecConstant(...) __attribute__ ((nothrow));

    void _ssdm_DataPack(...) __attribute__ ((nothrow));
    void _ssdm_SpecDataPack(...) __attribute__ ((nothrow));

    void _ssdm_op_SpecBitsMap(...) __attribute__ ((nothrow));
    void _ssdm_op_SpecLicense(...) __attribute__ ((nothrow));

    void __xilinx_ip_top(...) __attribute__ ((nothrow));


}
# 8 "<command line>" 2
# 1 "<built-in>" 2
# 1 "conv.cpp" 2
# 17 "conv.cpp"
# 1 "./conv.h" 1
# 20 "./conv.h"
# 1 "/usr/include/assert.h" 1 3 4
# 36 "/usr/include/assert.h" 3 4
# 1 "/usr/include/features.h" 1 3 4
# 345 "/usr/include/features.h" 3 4
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 346 "/usr/include/features.h" 2 3 4
# 375 "/usr/include/features.h" 3 4
# 1 "/usr/include/sys/cdefs.h" 1 3 4
# 392 "/usr/include/sys/cdefs.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 393 "/usr/include/sys/cdefs.h" 2 3 4
# 376 "/usr/include/features.h" 2 3 4
# 399 "/usr/include/features.h" 3 4
# 1 "/usr/include/gnu/stubs.h" 1 3 4
# 10 "/usr/include/gnu/stubs.h" 3 4
# 1 "/usr/include/gnu/stubs-64.h" 1 3 4
# 11 "/usr/include/gnu/stubs.h" 2 3 4
# 400 "/usr/include/features.h" 2 3 4
# 37 "/usr/include/assert.h" 2 3 4
# 65 "/usr/include/assert.h" 3 4
extern "C" {


extern void __assert_fail (const char *__assertion, const char *__file,
      unsigned int __line, const char *__function)
     throw () __attribute__ ((__noreturn__));


extern void __assert_perror_fail (int __errnum, const char *__file,
      unsigned int __line, const char *__function)
     throw () __attribute__ ((__noreturn__));




extern void __assert (const char *__assertion, const char *__file, int __line)
     throw () __attribute__ ((__noreturn__));


}
# 21 "./conv.h" 2
# 1 "/usr/pack/vitis-2019.2-kgf/Vivado/2019.2/lnx64/tools/clang/bin/../lib/clang/3.1/include/stdint.h" 1 3
# 33 "/usr/pack/vitis-2019.2-kgf/Vivado/2019.2/lnx64/tools/clang/bin/../lib/clang/3.1/include/stdint.h" 3
# 1 "/usr/include/stdint.h" 1 3 4
# 26 "/usr/include/stdint.h" 3 4
# 1 "/usr/include/bits/wchar.h" 1 3 4
# 22 "/usr/include/bits/wchar.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 23 "/usr/include/bits/wchar.h" 2 3 4
# 27 "/usr/include/stdint.h" 2 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 28 "/usr/include/stdint.h" 2 3 4








typedef signed char int8_t;
typedef short int int16_t;
typedef int int32_t;

typedef long int int64_t;







typedef unsigned char uint8_t;
typedef unsigned short int uint16_t;

typedef unsigned int uint32_t;



typedef unsigned long int uint64_t;
# 65 "/usr/include/stdint.h" 3 4
typedef signed char int_least8_t;
typedef short int int_least16_t;
typedef int int_least32_t;

typedef long int int_least64_t;






typedef unsigned char uint_least8_t;
typedef unsigned short int uint_least16_t;
typedef unsigned int uint_least32_t;

typedef unsigned long int uint_least64_t;
# 90 "/usr/include/stdint.h" 3 4
typedef signed char int_fast8_t;

typedef long int int_fast16_t;
typedef long int int_fast32_t;
typedef long int int_fast64_t;
# 103 "/usr/include/stdint.h" 3 4
typedef unsigned char uint_fast8_t;

typedef unsigned long int uint_fast16_t;
typedef unsigned long int uint_fast32_t;
typedef unsigned long int uint_fast64_t;
# 119 "/usr/include/stdint.h" 3 4
typedef long int intptr_t;


typedef unsigned long int uintptr_t;
# 134 "/usr/include/stdint.h" 3 4
typedef long int intmax_t;
typedef unsigned long int uintmax_t;
# 34 "/usr/pack/vitis-2019.2-kgf/Vivado/2019.2/lnx64/tools/clang/bin/../lib/clang/3.1/include/stdint.h" 2 3
# 22 "./conv.h" 2
# 1 "/usr/pack/vitis-2019.2-kgf/Vivado/2019.2/common/technology/autopilot/hls_stream.h" 1
# 66 "/usr/pack/vitis-2019.2-kgf/Vivado/2019.2/common/technology/autopilot/hls_stream.h"
# 1 "/usr/pack/vitis-2019.2-kgf/Vivado/2019.2/common/technology/autopilot/etc/autopilot_enum.h" 1
# 58 "/usr/pack/vitis-2019.2-kgf/Vivado/2019.2/common/technology/autopilot/etc/autopilot_enum.h"
enum SsdmDataTypes {
    _ssdm_sc_int = 0,
    _ssdm_c_int = _ssdm_sc_int,
    _ssdm_sc_uint = 1,
    _ssdm_c_uint = _ssdm_sc_uint,
    _ssdm_sc_bigint = 2,
    _ssdm_sc_biguint = 3,
};



enum SsdmPortTypes {
    _ssdm_sc_in = 0,
    _ssdm_sc_out = 1,
    _ssdm_sc_inout = 2,
    _ssdm_sc_in_clk,

    _ssdm_fifo_in,
    _ssdm_sc_fifo_in = _ssdm_fifo_in,
    _ssdm_tlm_fifo_in = _ssdm_fifo_in,
    _ssdm_fifo_out,
    _ssdm_sc_fifo_out = _ssdm_fifo_out,
    _ssdm_tlm_fifo_out = _ssdm_fifo_out,
    _ssdm_fifo_inout,
    _ssdm_sc_fifo_inout = _ssdm_fifo_inout,
    _ssdm_tlm_fifo_inout = _ssdm_fifo_inout,
    _ssdm_sc_bus,
    _ssdm_hls_bus_port = _ssdm_sc_bus,
    _ssdm_AXI4M_bus_port = _ssdm_sc_bus,
    _ssdm_port_end,
};



enum SsdmProcessTypes {
    _ssdm_method = 0,
    _ssdm_sc_method = _ssdm_method,
    _ssdm_thread = 1,
    _ssdm_sc_thread = _ssdm_thread,
    _ssdm_cthread = 2,
    _ssdm_sc_cthread = _ssdm_cthread,
    _ssdm_process_end,
};



enum SsdmSensitiveTypes {
    _ssdm_sensitive = 0,
    _ssdm_sensitive_pos,
    _ssdm_sensitive_neg,
    _ssdm_sensitive_reset0,
    _ssdm_sensitive_reset1,
    _ssdm_sensitive_end,
};



enum SsdmChannelTypes {
    _ssdm_sc_sig,
    _ssdm_fifo,
    _ssdm_sc_fifo = _ssdm_fifo,
    _ssdm_mem_fifo,
    _ssdm_sc_mem_fifo = _ssdm_mem_fifo,
};


enum SsdmRegionTypes {
    _ssdm_region_reset,
    _ssdm_region_protocol,
    _ssdm_region_pipeline,
    _ssdm_region_parallel,
};
# 67 "/usr/pack/vitis-2019.2-kgf/Vivado/2019.2/common/technology/autopilot/hls_stream.h" 2


namespace hls {
# 88 "/usr/pack/vitis-2019.2-kgf/Vivado/2019.2/common/technology/autopilot/hls_stream.h"
template<typename __STREAM_T__>
class stream
{
  public:

    inline __attribute__((always_inline)) stream() {
    }

    inline __attribute__((always_inline)) stream(const char* name) {
    }


  private:
    inline __attribute__((always_inline)) stream(const stream< __STREAM_T__ >& chn):V(chn.V) {
    }

    inline __attribute__((always_inline)) stream& operator= (const stream< __STREAM_T__ >& chn) {
        V = chn.V;
        return *this;
    }

  public:

    inline __attribute__((always_inline)) void operator >> (__STREAM_T__& rdata) {
        read(rdata);
    }

    inline __attribute__((always_inline)) void operator << (const __STREAM_T__& wdata) {
        write(wdata);
    }


  public:

    inline __attribute__((always_inline)) bool empty() const {

        bool tmp = _ssdm_StreamCanRead(&V);
        return !tmp;



    }

    inline __attribute__((always_inline)) bool full() const {

        bool tmp = _ssdm_StreamCanWrite(&V);
        return !tmp;



    }


    inline __attribute__((always_inline)) void read(__STREAM_T__& dout) {

        __STREAM_T__ tmp;
        _ssdm_StreamRead(&V, &tmp);
        dout = tmp;



    }

    inline __attribute__((always_inline)) __STREAM_T__ read() {
        __STREAM_T__ tmp;

        _ssdm_StreamRead(&V, &tmp);



        return tmp;
    }


    inline __attribute__((always_inline)) bool read_nb(__STREAM_T__& dout) {

        __STREAM_T__ tmp;
        bool empty_n = _ssdm_StreamNbRead(&V, &tmp);
        dout = tmp;
        return empty_n;



    }


    inline __attribute__((always_inline)) void write(const __STREAM_T__& din) {

        __STREAM_T__ tmp = din;
        _ssdm_StreamWrite(&V, &tmp);



    }


    inline __attribute__((always_inline)) bool write_nb(const __STREAM_T__& din) {

        __STREAM_T__ tmp = din;
        bool full_n = _ssdm_StreamNbWrite(&V, &tmp);
        return full_n;



    }



    inline __attribute__((always_inline)) unsigned size() {
        unsigned size = _ssdm_StreamSize(&V);
        return size;
    }


  public:
    __STREAM_T__ V ;
};


}
# 23 "./conv.h" 2








typedef uint32_t data_t;


void filter11x11_orig(
        int w, int h,
        const data_t *src_image, data_t *dst_image);

void conv_mdc(
        int w, int h,
        hls::stream<data_t> &src_image, hls::stream<data_t> &dst_image);
# 18 "conv.cpp" 2

template<typename T, int K>
static void convolution_orig(
        int width, int height,
        const T *src, T *dst,
        const T *hcoeff, const T *vcoeff)
{

    const int conv_size = K;

    const int border_width = int(conv_size / 2);



    T local[1080*1920];



    Clear_Local:for(int i = 0; i < height * width; i++){
        local[i]=0;
    }


    HconvH:for(int col = 0; col < height; col++){
        HconvW:for(int row = border_width; row < width - border_width; row++){
            Hconv:int pixel = col * width + row;
            for(int i = - border_width; i <= border_width; i++){
                local[pixel] += src[pixel + i] * hcoeff[i + border_width];
            }
        }
    }

    Clear_Dst:for(int i = 0; i < height * width; i++){
        dst[i]=0;
    }



    VconvH:for(int col = border_width; col < height - border_width; col++){
        VconvW:for(int row = 0; row < width; row++){
            int pixel = col * width + row;
            Vconv:for(int i = - border_width; i <= border_width; i++){
                int offset = i * width;
                dst[pixel] += local[pixel + offset] * vcoeff[i + border_width];
            }
        }
    }



    int border_width_offset = border_width * width;
    int border_height_offset = (height - border_width - 1) * width;
    Top_Border:for(int col = 0; col < border_width; col++){
        int offset = col * width;
        Top_Left:for(int row = 0; row < border_width; row++){
            int pixel = offset + row;
            dst[pixel] = dst[border_width_offset + border_width];
        }
        Top_Row:for(int row = border_width; row < width - border_width; row++){
            int pixel = offset + row;
            dst[pixel] = dst[border_width_offset + row];
        }
        Top_Right:for(int row = width - border_width; row < width; row++){
            int pixel = offset + row;
            dst[pixel] = dst[border_width_offset + width - border_width - 1];
        }
    }
    Side_Border:for(int col = border_width; col < height - border_width; col++){
        int offset = col * width;
        Left_Col:for(int row = 0; row < border_width; row++){
            int pixel = offset + row;
            dst[pixel] = dst[offset + border_width];
        }
        Right_Col:for(int row = width - border_width; row < width; row++){
            int pixel = offset + row;
            dst[pixel] = dst[offset + width - border_width - 1];
        }
    }
    Bottom_Border:for(int col = height - border_width; col < height; col++){
        int offset = col * width;
        Bottom_Left:for(int row = 0; row < border_width; row++){
            int pixel = offset + row;
            dst[pixel] = dst[border_height_offset + border_width];
        }
        Bottom_Row:for(int row = border_width; row < width - border_width; row++){
            int pixel = offset + row;
            dst[pixel] = dst[border_height_offset + row];
        }
        Bottom_Right:for(int row = width - border_width; row < width; row++){
            int pixel = offset + row;
            dst[pixel] = dst[border_height_offset + width - border_width - 1];
        }
    }
}

template<typename T, int K>
static void convolution_strm(int width, int height,
        hls::stream<T> &src, hls::stream<T> &dst,
        const T *hcoeff, const T *vcoeff)
{
    const int border_width = int(K / 2);

    T hwin[K];
    hls::stream<T> hconv("hconv");



    static T linebuf[K - 1][1920];
    hls::stream<T> vconv("vconv");
    const int vconv_xlim = width - (K - 1);

    T borderbuf[1920 - (K - 1)];
#pragma HLS ARRAY_PARTITION variable=&linebuf dim=1 complete
#pragma HLS INLINE

 ((height < 1080) ? static_cast<void> (0) : __assert_fail ("height < 1080", "conv.cpp", 133, __PRETTY_FUNCTION__));
    ((width < 1920) ? static_cast<void> (0) : __assert_fail ("width < 1920", "conv.cpp", 134, __PRETTY_FUNCTION__));
    ((vconv_xlim < 1920 - (K - 1)) ? static_cast<void> (0) : __assert_fail ("vconv_xlim < 1920 - (K - 1)", "conv.cpp", 135, __PRETTY_FUNCTION__));



    HConvH:for(int col = 0; col < height; col++) {
        HConvW:for(int row = 0; row < width; row++) {
#pragma HLS PIPELINE
 T in_val = src.read();

            T out_val = 0;
            HConv:for(int i = 0; i < K; i++) {
                hwin[i] = i < K - 1 ? hwin[i + 1] : in_val;
                out_val += hwin[i] * hcoeff[i];
            }
            if (row >= K - 1)
                hconv << out_val;
        }
    }



    VConvH:for(int col = 0; col < height; col++) {
        VConvW:for(int row = 0; row < vconv_xlim; row++) {
#pragma HLS DEPENDENCE variable=&linebuf inter false
#pragma HLS PIPELINE
 T in_val = hconv.read();

            T out_val = 0;
            VConv:for(int i = 0; i < K; i++) {
                T vwin_val = i < K - 1 ? linebuf[i][row] : in_val;
                out_val += vwin_val * vcoeff[i];
                if (i > 0)
                    linebuf[i - 1][row] = vwin_val;
            }
            if (col >= K - 1)
                vconv << out_val;
        }
    }


    Border:for (int i = 0; i < height; i++) {
        for (int j = 0; j < width; j++) {
            T pix_in, l_edge_pix, r_edge_pix, pix_out;
#pragma HLS PIPELINE
 if (i == 0 || (i > border_width && i < height - border_width)) {


                if (j < width - (K - 1)) {
                    pix_in = vconv.read();
                    borderbuf[j] = pix_in;
                }
                if (j == 0) {
                    l_edge_pix = pix_in;
                }
                if (j == width - K) {
                    r_edge_pix = pix_in;
                }
            }

            if (j <= border_width) {
                pix_out = l_edge_pix;
            } else if (j >= width - border_width - 1) {
                pix_out = r_edge_pix;
            } else {
                pix_out = borderbuf[j - border_width];
            }
            dst << pix_out;
        }
    }
}

void filter11x11_orig(int width, int height, const data_t *src, data_t *dst)
{
#pragma HLS INTERFACE m_axi port=&src depth=32400
#pragma HLS INTERFACE m_axi port=&dst depth=32400
#pragma HLS INTERFACE s_axilite port=&width bundle=hls_ctrl
#pragma HLS INTERFACE s_axilite port=&height bundle=hls_ctrl
#pragma HLS INTERFACE s_axilite port=return bundle=hls_ctrl

#pragma HLS INLINE
#pragma HLS DATAFLOW

 const data_t filt11_coeff[11] = {
    36, 111, 266, 498, 724, 821, 724, 498, 266, 111, 36
  };
_ssdm_SpecConstant(filt11_coeff);
# 217 "conv.cpp"


  convolution_orig<data_t, 11>(width, height,
          src, dst,
          filt11_coeff, filt11_coeff);
}

void conv_mdc(int width, int height,
        hls::stream<data_t> &src, hls::stream<data_t> &dst)
{
#pragma HLS INTERFACE axis port=&src
#pragma HLS INTERFACE axis port=&dst

#pragma HLS INTERFACE ap_ctrl_none port=return

#pragma HLS DATAFLOW
#pragma HLS INLINE

 const data_t filt11_coeff[11] = {
    36, 111, 266, 498, 724, 821, 724, 498, 266, 111, 36
  };
_ssdm_SpecConstant(filt11_coeff);
# 237 "conv.cpp"


  convolution_strm<data_t, 11>(width, height,
          src, dst,
          filt11_coeff, filt11_coeff);
}
