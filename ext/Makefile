ROOT_DIR  = ..
# BUILD_DIR = ..
ROOT_DIR_REALPATH = $(shell echo -n `cd $(ROOT_DIR); pwd`)
PREFIX := $(ROOT_DIR_REALPATH)/ext/musl
# include $(BUILD_DIR)/config.mak

# -w Suppress all warnings
MUSL_CFLAGS = -march=x86-64 -m64 -w -std=c11
MUSL_LDFLAGS = -nostdlib -z nodefaultlib
MUSL_OPTION = --target=x86_64-unknown-linux-musl --prefix=$(PREFIX)
# MUSL_OPTION = --disable-shared --target=x86_64-unknown-linux-musl --prefix=$(ROOT_DIR_REALPATH)/ext/musl

CC = gcc

SRC_DIR = $(ROOT_DIR)/musl
VPATH = $(SRC_DIR)

.PHONY: all clean clobber

# all: lib/libc.a
all: MAKEOVERRIDES=
all: $(SRC_DIR)/config.mak
	$(MAKE) -C $(SRC_DIR) -j8
	$(MAKE) -C $(SRC_DIR) install -j8

clean: clobber

clobber:
	$(MAKE) -C $(SRC_DIR) clean
	rm -f $(SRC_DIR)/config.mak

# lib/libcr.a: lib/libc.a
# 	@cp $(VPATH)/$< $(VPATH)/$@

# lib/libc.a: MAKEOVERRIDES=
# lib/libc.a: config.mak
# 	$(MAKE) -C $(SRC_DIR)

$(SRC_DIR)/config.mak:
	cd $(SRC_DIR); CROSS_COMPILE="$(ARCH)-" CFLAGS="$(MUSL_CFLAGS)" CC="$(CC)" ./configure $(MUSL_OPTION)
	# cd $(SRC_DIR); CROSS_COMPILE="$(ARCH)-" CFLAGS="$(MUSL_CFLAGS)" CC="$(CC)" LDFLAGS="$(MUSL_LDFLAGS)" ./configure $(MUSL_OPTION)
