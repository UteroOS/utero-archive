// Copyright (c) 2016-2017 Utero OS Developers. See the COPYRIGHT
// file at the top-level directory of this distribution.
//
// Licensed under the Apache License, Version 2.0 <LICENSE-APACHE or
// http://www.apache.org/licenses/LICENSE-2.0> or the MIT license
// <LICENSE-MIT or http://opensource.org/licenses/MIT>, at your
// option. This file may not be copied, modified, or distributed
// except according to those terms.
//
// Functions are taken from musl/arch/x86_64/bits/io.h

#ifndef IO_H
#define IO_H

static __inline void outb(unsigned char __val, unsigned short __port)
{
	__asm__ volatile ("outb %0,%1" : : "a" (__val), "dN" (__port));
}

#endif /* end of include guard: IO_H */
