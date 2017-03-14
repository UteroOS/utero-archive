ROOT_DIR  = ../..
BUILD_DIR = ..

# include $(BUILD_DIR)/config.mak

MUSL_CFLAGS = -march=x86-64 -m64
MUSL_OPTION = --disable-shared

CC = clang

SRC_DIR = $(ROOT_DIR)/src/musl
VPATH = $(SRC_DIR)

.PHONY: all clean clobber

all: lib/libcr.a

clean: clobber

clobber:
	$(MAKE) -C $(SRC_DIR) clean
	rm -f $(SRC_DIR)/config.mak

lib/libcr.a: lib/libc.a
	@cp $(VPATH)/$< $(VPATH)/$@

lib/libc.a: MAKEOVERRIDES=
lib/libc.a: config.mak
	$(MAKE) -C $(SRC_DIR)

config.mak:
	cd $(SRC_DIR); CROSS_COMPILE="llvm-" CFLAGS="$(MUSL_CFLAGS)" CC="$(CC)" ./configure $(MUSL_OPTION)
