/*
	iomanip.h -- Streams manipulator functions.
	
	Copyright Apple Computer,Inc.	1994-1995
	All rights reserved.

*/

#ifndef __IOMANIP__
#define __IOMANIP__       1

#include <generic.h>
#include <iostream.h>

#define SMANIP(T)name2(smanip_,T)
#define SAPP(T)name2(sapply_,T)
#define IMANIP(T)name2(imanip_,T)
#define OMANIP(T)name2(omanip_,T)
#define IOMANIP(T)name2(iomanip_,T)
#define IAPP(T)name2(iapply_,T)
#define OAPP(T)name2(oapply_,T)
#define IOAPP(T)name2(ioapply_,T)

/*
 *------------------------------------------------------------------------
 * NOTE: (For users of the following macro)
 * Whenever the following macro is used, proper structure alignment pragma
 * should used to ensure the uniformity of the structure's alignment.
 *------------------------------------------------------------------------
 */
#define IOMANIPdeclare(T)                                               \
class SMANIP(T) {                                                       \
        ios& (*fct)(ios&,T);                                            \
        T arg;                                                          \
public:                                                                 \
        SMANIP(T)(ios& (*f)(ios&, T), T a) :                            \
                        fct(f), arg(a) { }                              \
        friend istream& operator>>(istream& i, const SMANIP(T)& m) {    \
                        ios* s = &i;                                    \
                        (*m.fct)(*s,m.arg);  return i;  }               \
        friend ostream& operator<<(ostream& o, const SMANIP(T)& m) {    \
                        ios* s = &o;                                    \
                        (*m.fct)(*s,m.arg);  return o;  }               \
        };                                                              \
class SAPP(T) {                                                         \
        ios& (*fct)(ios&, T);                                           \
public:                                                                 \
        SAPP(T)(ios& (*f)(ios&,T)) : fct(f) { }                         \
        SMANIP(T) operator()(T a) {                                     \
                        return SMANIP(T)(fct,a);  }                     \
        };                                                              \
class IMANIP(T) {                                                       \
        istream& (*fct)(istream&,T);                                    \
        T arg;                                                          \
public:                                                                 \
        IMANIP(T)(istream& (*f)(istream&, T), T a ) :                   \
                fct(f), arg(a) { }                                      \
        friend istream& operator>>(istream& s, const IMANIP(T)& m) {    \
                return(*m.fct)(s,m.arg);                                \
                }                                                       \
        };                                                              \
class IAPP(T) {                                                         \
        istream& (*fct)(istream&, T);                                   \
public:                                                                 \
        IAPP(T)(istream& (*f)(istream&,T)) : fct(f) { }                 \
        IMANIP(T) operator()(T a) {                                     \
                        return IMANIP(T)(fct,a);  }                     \
        };                                                              \
class OMANIP(T) {                                                       \
        ostream& (*fct)(ostream&,T);                                    \
        T arg;                                                          \
public:                                                                 \
        OMANIP(T)(ostream& (*f)(ostream&, T), T a ) :                   \
                fct(f), arg(a) { }                                      \
        friend ostream& operator<<(ostream& s, const OMANIP(T)& m) {    \
                return(*m.fct)(s,m.arg);                                \
                }                                                       \
        };                                                              \
class OAPP(T) {                                                         \
        ostream& (*fct)(ostream&, T);                                   \
public:                                                                 \
        OAPP(T)(ostream& (*f)(ostream&,T)) : fct(f) { }                 \
        OMANIP(T) operator()(T a) {                                     \
                        return OMANIP(T)(fct,a);  }                     \
        };                                                              \
class IOMANIP(T) {                                                      \
        iostream& (*fct)(iostream&,T);                                  \
        T arg;                                                          \
public:                                                                 \
        IOMANIP(T)(iostream& (*f)(iostream&, T), T a ) :                \
                fct(f), arg(a) { }                                      \
        friend istream& operator>>(iostream& s, const IOMANIP(T)& m) {  \
                return(*m.fct)(s,m.arg);                                \
                }                                                       \
        friend ostream& operator<<(iostream& s, const IOMANIP(T)& m) {  \
                return(*m.fct)(s,m.arg);                                \
                }                                                       \
        };                                                              \
class IOAPP(T) {                                                        \
        iostream& (*fct)(iostream&, T);                                 \
public:                                                                 \
        IOAPP(T)(iostream& (*f)(iostream&,T)) : fct(f) { }              \
        IOMANIP(T) operator()(T a) {                                    \
                        return IOMANIP(T)(fct,a);  }                    \
        }

IOMANIPdeclare(int);
IOMANIPdeclare(long);

SMANIP(int)     setbase(int b);         /* 10, 8, 16 or 0 */
SMANIP(long)    resetiosflags(long b);
SMANIP(long)    setiosflags(long b);
SMANIP(int)     setfill(int f);
SMANIP(int)     setprecision(int p);
SMANIP(int)     setw(int w);

#endif	/* __IOMANIP__ */
