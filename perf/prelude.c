/*
 * prelude.c - prelude for the measurement stuff.
 * 
 * Copyright (c) 1998 Phil Maker <pjm@gnu.org>
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 *
 * $Id: prelude.c,v 1.1.1.1 1999/09/12 03:26:49 pjm Exp $
 */

#include <stdio.h>

#define L_DEFAULT_PARAMS stdout
#define DL_DEFAULT_PARAMS stdout

#include <nana-config.h>

#include <nana.h>
#include <now.h>
#include <assert.h>
#include <L_buffer.h>
#include <syslog.h>

#define C8(c) c;c;c;c;c;c;c;c;
#define C32(c) C8(c);C8(c);C8(c);C8(c);
#define C128(c) C32(c);C32(c);C32(c);C32(c);
#define C256(c) C128(c);C128(c);
#define C512(c) C128(c);C128(c);C128(c);C128(c);
#define C1024(c) C512(c);C512(c);
#define C2048(c) C1024(c);C1024(c)
#define C4096(c) C2048(c);C2048(c);
#define C8192(c) C4096(c);C4096(c);

#define STR(s) #s

volatile false = 0;

volatile int gi = 10;
volatile float gf = 3.14;
volatile float gfs = 3.14;

int a[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
volatile int za[1024*1024];

char str[] = "helloworld";

char dest[80];

/**** Code for tests *****/

#include <assert.h>
#include <ctype.h>
#include <string.h>
#include <math.h>

/* BSD_assert (in particular assert.h 8.2 (Berkeley) 1/21/94 */
#define BSD_assert(e)  ((e) ? (void)0 : __BSD_assert(__FILE__, __LINE__, #e))

void __BSD_assert(char *f, int n, char *e) {
}

/* TRAD_assert - a traditional assert using if, etc */
#define TRAD_assert(e) if(!(e)) { \
                         fprintf(stderr, "Assert: %s failed at %d in %s.", \
				 #e, __LINE__, __FILE__); \
			 exit(1); \
                       }

/* cycles.h testing -- SHOULD only work on pentiums/cyrixs/... */
/* See below for more code */
#if HAVE_CYCLES
volatile long long cycles_t;
#include "../src/cycles.h"


/**** End of code for tests ****/

main() {
  volatile int i = 10;
  volatile int j;
  volatile float f = 3.14;
  volatile double d;

  int n;
  double s, e, te;

  L_BUFFER *buf = L_buffer_create(16*1024);

  FILE *log = fopen("log.dat", "w");



