#!/bin/sh
lli=${LLVMINTERP-lli}
exec $lli \
    /home/gbellocchi/workspace_pulp/genacc/genacc/acc_lib/fir_mdc/hls/genacc/proj_fir/solution1/.autopilot/db/a.g.bc ${1+"$@"}