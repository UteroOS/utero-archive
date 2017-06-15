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
// https://github.com/RWTH-OS/eduOS/blob/master/include/eduos/config.h.example

#ifndef CONFIG_H
#define CONFIG_H

#define MAX_TASKS 16
#define VIDEO_MEM_ADDR 0xb8000
#define CACHE_LINE 64

#define NORETURN __attribute__((noreturn))
#define STDCALL __attribute__((stdcall))

#endif /* end of include guard: CONFIG_H */