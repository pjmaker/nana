# Local additions to Autoconf macros.

# nana_DEFINE(name,args,code) - generates a #define for use in nana-config.h
#   this needs to be redone (the naming and quoting is wonderful).
#
AC_DEFUN(nana_DEFINE,[
AC_MSG_CHECKING([$1])
if test -z "$$1"
then # use code to work out the value
  $3
# else its been defined by the user
fi

if test -z "$$1"
then 
  AC_MSG_RESULT("default")
else 
  AC_MSG_RESULT($$1)
  $1="#define $1$2 $$1"
fi
AC_SUBST($1)
])
#####
# And the old macros from the automake distribution
#
#
# Copyright (C) 1992, 1994, 1995 Free Software Foundation, Inc.
# Fran�ois Pinard <pinard@iro.umontreal.ca>, 1992.

## ------------------------------- ##
## Check for function prototypes.  ##
## ------------------------------- ##

AC_DEFUN(fp_C_PROTOTYPES,
[AC_REQUIRE([AM_PROG_CC_STDC])
AC_MSG_CHECKING([for function prototypes])
if test "$ac_cv_prog_cc_stdc" != no; then
  AC_MSG_RESULT(yes)
  AC_DEFINE(PROTOTYPES)
  U= ANSI2KNR=
else
  AC_MSG_RESULT(no)
  U=_ ANSI2KNR=./ansi2knr
fi
AC_SUBST(U)dnl
AC_SUBST(ANSI2KNR)dnl
])

## ----------------------------------------- ##
## ANSIfy the C compiler whenever possible.  ##
## ----------------------------------------- ##

# @defmac AC_PROG_CC_STDC
# @maindex PROG_CC_STDC
# @ovindex CC
# If the C compiler in not in ANSI C mode by default, try to add an option
# to output variable @code{CC} to make it so.  This macro tries various
# options that select ANSI C on some system or another.  It considers the
# compiler to be in ANSI C mode if it defines @code{__STDC__} to 1 and
# handles function prototypes correctly.
#
# If you use this macro, you should check after calling it whether the C
# compiler has been set to accept ANSI C; if not, the shell variable
# @code{ac_cv_prog_cc_stdc} is set to @samp{no}.  If you wrote your source
# code in ANSI C, you can make an un-ANSIfied copy of it by using the
# program @code{ansi2knr}, which comes with Ghostscript.
# @end defmac

AC_DEFUN(fp_PROG_CC_STDC,
[AC_MSG_CHECKING(for ${CC-cc} option to accept ANSI C)
AC_CACHE_VAL(ac_cv_prog_cc_stdc,
[ac_cv_prog_cc_stdc=no
ac_save_CFLAGS="$CFLAGS"
# Don't try gcc -ansi; that turns off useful extensions and
# breaks some systems' header files.
# AIX			-qlanglvl=ansi
# Ultrix and OSF/1	-std1
# HP-UX			-Aa -D_HPUX_SOURCE
# SVR4			-Xc
for ac_arg in "" -qlanglvl=ansi -std1 "-Aa -D_HPUX_SOURCE" -Xc
do
  CFLAGS="$ac_save_CFLAGS $ac_arg"
  AC_TRY_COMPILE(
[#if !defined(__STDC__) || __STDC__ != 1
choke me
#endif
], [int test (int i, double x);
struct s1 {int (*f) (int a);};
struct s2 {int (*f) (double a);};],
[ac_cv_prog_cc_stdc="$ac_arg"; break])
done
CFLAGS="$ac_save_CFLAGS"
])
AC_MSG_RESULT($ac_cv_prog_cc_stdc)
case "x$ac_cv_prog_cc_stdc" in
  x|xno) ;;
  *) CC="$CC $ac_cv_prog_cc_stdc" ;;
esac
])

## --------------------------------------------------------- ##
## Use AC_PROG_INSTALL, supplementing it with INSTALL_SCRIPT ##
## substitution.                                             ##
## --------------------------------------------------------- ##

AC_DEFUN(fp_PROG_INSTALL,
[AC_PROG_INSTALL
test -z "$INSTALL_SCRIPT" && INSTALL_SCRIPT='${INSTALL} -m 755'
AC_SUBST(INSTALL_SCRIPT)dnl
])

