#!/bin/sh
#
# measure.sh - measure the performance of some single line code fragments
#   in space/time using a variety of compile time options.
# 
# Copyright (c) 1998 Phil Maker <pjm@gnu.org>
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.
#
# $Id: measure.sh,v 1.1.1.1 1999/09/12 03:26:49 pjm Exp $
#

while read code
do
    (cat prelude.c 
    echo "#ifndef NT"
    echo "#define NT 1024"
    echo "#endif"
    echo "  printf(STR($code) \"\\n\");" 
    echo "  if(false) {"
    echo "  s:" 
    echo "  asm(\"scode:\");"
    echo $code
    echo "  asm(\"ecode:\");"
    echo "  t:;"
    echo "  }"
    echo "  printf(\"%ld\\n\", &&t - &&s);"
    echo "  s = now();"
    echo "  for(n = 0; n != NT; n++) {"
    echo "    C256($code);"
    echo "  }"
    echo "  e = now();"
    echo "  te = ((e - s) * 1.0e9)/(NT * 256.0);"
    echo "  if(te < 1000.0) {"
    echo "    printf(\"%.0lfns\\n\", te);"
    echo "  } else {"
    echo "    printf(\"%.1lfus\\n\", te/1000.0);"
    echo "  }"

    cat postlude.c
    ) >tmp.c

    for args in $*
    do
	if gcc -fno-defer-pop -g -I. -I../src -L/usr/local/lib $args tmp.c -lnana -lm
	then
	    ../src/nana -I. -I../src tmp.c >nana.gdb
	    ../src/nana-run ./a.out -x nana.gdb | grep -v "^Breakpoint" |
	      grep -v "^Program" | grep -v "^helloworld" | grep -v "^\$"
            echo $args
	    gcc -fno-defer-pop -g $args -I. -I../src -S tmp.c
	    (
	    echo "\\item \\verb@$code@ with \verb@gcc -g $args@ produces:\\par"
	    echo "\\begin{verbatim}"
	    awk '/scode:/,/ecode:/' tmp.s | 
	     awk ' { x[NR] = $0 } 
                   END { for(i = 3; i < NR -2; i++) print x[i]; }' | 
		  expand
	      
	    echo "\\end{verbatim}"
	    echo "\\par"
	    ) >> code.mtex

	else
	    echo "compile error: giving up"
	    exit 1
	fi
	echo
    done
done |
awk '
BEGIN {
    RS = ""
    FS = "\n"
    OFS = "&"
    print "\\begin{tabular}{|l|l|l|l|}"
    print "\\hline"
    print "Code & Size & Time & Options \\\\"
    print "\\hline"
}

{
    print "\\verb@" $1 "@", $2, $3, $4 "\\\\"
}

END {
    print "\\hline"
    print "\\end{tabular}"
}'




