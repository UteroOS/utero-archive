// Copyright (c) 2016-2017 Utero OS Developers. See the COPYRIGHT
// file at the top-level directory of this distribution.
//
// Licensed under the Apache License, Version 2.0 <LICENSE-APACHE or
// http://www.apache.org/licenses/LICENSE-2.0> or the MIT license
// <LICENSE-MIT or http://opensource.org/licenses/MIT>, at your
// option. This file may not be copied, modified, or distributed
// except according to those terms.
//
// The part of this file was taken from:
// musl/obj/include/bits/alltypes.h
#define _Addr long
#define _Int64 long
#define _Reg long

#if defined(__NEED_va_list) && !defined(__DEFINED_va_list)
typedef __builtin_va_list va_list;
#define __DEFINED_va_list
#endif

#if defined(__NEED_uintptr_t) && !defined(__DEFINED_uintptr_t)
typedef unsigned _Addr uintptr_t;
#define __DEFINED_uintptr_t
#endif

#undef _Addr
#undef _Int64
#undef _Reg