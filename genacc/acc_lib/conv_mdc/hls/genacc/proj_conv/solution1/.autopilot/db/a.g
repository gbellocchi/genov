#!/bin/sh
lli=${LLVMINTERP-lli}
exec $lli \
    /home/gbellocchi/workspace_pulp/genacc/genacc/acc_lib/conv_mdc/hls/genacc/proj_conv/solution1/.autopilot/db/a.g.bc ${1+"$@"}
