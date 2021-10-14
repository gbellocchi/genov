ROOT := $(patsubst %/,%, $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

only = pulp
CSRCS = $(wildcard *.c)

CC := clang
LINK := llvm-link
COB := clang-offload-bundler
DIS := llvm-dis

TARGET_HOST = ${HERO_TOOLCHAIN_HOST_TARGET}
TARGET_DEV = riscv32-hero-unknown-elf

ARCH_HOST = host-$(TARGET_HOST)
ARCH_DEV = openmp-$(TARGET_DEV)

HOST_OBJDUMP := $(TARGET_HOST)-objdump
DEV_OBJDUMP := $(TARGET_DEV)-objdump

ifeq ($(strip $(opt)),)
  opt = 3
endif

.DEFAULT_GOAL = all
DEFMK_ROOT := $(patsubst %/,%, $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

# CFLAGS and LDFLAGS have three components/stages
# 1) without suffix, they apply to heterogeneous compilation;
# 3) with _PULP suffix, they apply only to the PULP part of compilation;
# 4) with _COMMON suffix, they apply to both PULP and host compilation.
CFLAGS_COMMON += $(cflags) -fopenmp=libomp -O$(opt) -static
CFLAGS_PULP += $(CFLAGS_COMMON) -target $(TARGET_DEV) -I$(HERO_PULP_INC_DIR)
CFLAGS += -target $(TARGET_HOST) $(CFLAGS_COMMON) -fopenmp-targets=$(TARGET_DEV)
LDFLAGS_COMMON ?= $(ldflags) -static
ifdef HERCULES_INSTALL
	LDFLAGS_COMMON += -lpremnotify
endif
LDFLAGS_PULP += $(LDFLAGS_COMMON)
LDFLAGS += $(LDFLAGS_COMMON) -lhero-target
ifeq ($(TARGET_HOST),riscv64-hero-linux-gnu)
  # FIXME: we explicitly need to embed the correct linker for riscv
  LDFLAGS += -Wl,-dynamic-linker,/lib/ld-linux-riscv64-lp64.so.1
endif

INCPATHS += -I$(DEFMK_ROOT) -include $(HERO_OV_OPENMP_TESTS)/common/hero_64.h
LIBPATHS ?=

BENCHMARK = $(shell basename `pwd`)
EXE = $(BENCHMARK)
SRC = $(CSRCS)

DEPDIR := .deps
DEPFLAGS = -MT $@ -MMD -MP -MF $(DEPDIR)/$*.d

AS_ANNOTATE_ARGS ?=

only ?= # can be set to `pulp` to compile a binary only for PULP

.PHONY: all exe clean
.PRECIOUS: %.ll

all : $(DEPS) $(EXE) $(EXE).dis slm

%.ll: %.c $(DEPDIR)/%.d | $(DEPDIR)
	$(CC) -c -emit-llvm -S $(DEPFLAGS) $(CFLAGS_PULP) $(INCPATHS) $<

%.OMP.ll: %.ll
	cp $< $(<:.ll=.TMP.1.ll)
	hc-omp-pass $(<:.ll=.TMP.1.ll) OmpKernelWrapper "HERCULES-omp-kernel-wrapper" $(<:.ll=.TMP.2.ll)
	hc-omp-pass $(<:.ll=.TMP.2.ll) OmpHostPointerLegalizer "HERCULES-omp-host-pointer-legalizer" $(<:.ll=.TMP.3.ll)
	cp $(<:.ll=.TMP.3.ll) $(<:.ll=.OMP.ll)

$(EXE): $(SRC:.c=.OMP.ll)
	$(CC) $(LIBPATHS) $(CFLAGS_PULP) $^ $(LDFLAGS_PULP) -o $@

slm: $(EXE)_l1.slm $(EXE)_l2.slm

$(EXE)_l2.slm: $(EXE)
	$(DEV_OBJDUMP) -s --start-address=0x1c000000 --stop-address=0x1cffffff $^ | grep '^ ' | cut -c 2-45 \
      | sort \
      > $@
	$(DEFMK_ROOT)/one_word_per_line.py $@

$(EXE)_l1.slm: $(EXE)
	$(DEV_OBJDUMP) -s --start-address=0x10000000 --stop-address=0x1bffffff $^ | grep '^ ' | cut -c 2-45 \
      | perl -p -e 's/^1b/10/' \
      | sort \
      > $@
	$(DEFMK_ROOT)/one_word_per_line.py $@

$(EXE).dis: $(EXE)
	$(DEV_OBJDUMP) -d $^ > $@

$(DEPDIR):
	@mkdir -p $@

DEPFILES := $(CSRCS:%.c=$(DEPDIR)/%.d)
$(DEPFILES):

include $(wildcard $(DEPFILES))

clean::
	-rm -vf __hmpp* $(EXE) *~ *.bc *.dis *.elf *.i *.lh *.lk *.ll *.o *.s *.slm
	-rm -rvf $(DEPDIR)
