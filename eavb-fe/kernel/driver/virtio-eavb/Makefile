# SPDX-License-Identifier: GPL-2.0-only
KBUILD_OPTIONS += EAVB_KERNEL_ROOT=$(shell pwd)
KBUILD_OPTIONS += KERNEL_ROOT=$(ROOT_DIR)/$(KERNEL_DIR)
KBUILD_OPTIONS += MODNAME=eavb_fe

ccflags-y := -DEAVB_DEBUGFS

ifeq ($(RELEASE_PACKAGE),1)
EXTRA_CFLAGS+=-DRELEASE_PACKAGE
endif
LBITS ?= $(shell getconf LONG_BIT)
ifeq ($(LBITS),64)
CCFLAGS += -m64
EXTRA_CFLAGS+=-DSYSTEM_IS_64
else
CCFLAGS += -m32
endif

M ?= $(shell pwd)
KERNEL_SRC ?= /lib/modules/$(shell uname -r)/build

all: modules

modules dtbs:
	$(MAKE) -C $(KERNEL_SRC) M=$(M) modules $(KBUILD_OPTIONS)

modules_install:
	$(MAKE) M=$(M) -C $(KERNEL_SRC) modules_install

clean:
	$(MAKE) -C $(KERNEL_SRC) M=$(M) clean
