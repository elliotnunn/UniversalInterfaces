/*
	iostream.h -- Streams classes: ios, streambuf, istream, ostream, iostream
	
	Copyright Apple Computer,Inc.	1994-1995
	All rights reserved.

*/

#ifndef __IOSTREAM__
#define __IOSTREAM__       1

#include <string.h>		// For memcpy
#include <stdio.h>		// For EOF and NULL


#define zapeof(c)       ((c) & 0377)

typedef long streampos;
typedef long streamoff;

#ifdef powerc
#pragma options align=power
#endif

#if defined(powerc) || defined(mc68000)
/*
 * removed from ios.c and placed here to avoid forward reference problem - rjd 921223
 */
union ios_user_union
{
    long i_word;
    void *p_word;
};
#endif

class streambuf;
class ostream;

class ios
{

public:
    /*
     * Some enums are declared in ios to avoid pollution of global namespace
     */
    enum io_state
    {
        goodbit  = 0,
        eofbit   = 1,
        failbit  = 2,
        badbit   = 4,
        hardfail = 0200
    };
    /*
     * hard fail can be set and reset internally, but not via public function
     */
    enum open_mode
    {
        in        =    1,
        out       =    2,
        ate       =    4,
        app       =  010,
        trunc     =  020,
        nocreate  =  040,
        noreplace = 0100
    };
    enum seek_dir
    {
        beg = 0,
        cur = 1,
        end = 2
    };
    /*
     * flags for controlling format
     */
    enum
    {
        skipws     =     01,        // skip whitespace on input

        left       =     02,        // padding location
        right      =     04,
        internal   =    010,

        dec        =    020,        // conversion base
        oct        =    040,
        hex        =   0100,

        showbase   =   0200,        // modifiers
        showpoint  =   0400,
        uppercase  =  01000,
        showpos    =  02000,

        scientific =  04000,        // floating point notation
        fixed      = 010000,

        unitbuf    = 020000,        // stuff to control flushing
        stdio      = 040000
    };
    static const long basefield;    // = dec | oct | hex
    static const long adjustfield;  // = left | right | internal
    static const long floatfield;   // = scientific | fixed

public:
    ios(streambuf*);
    virtual ~ios();

    long flags() const          { return x_flags; }
    long flags(long f);

    long setf(long setbits, long field);
    long setf(long);
    long unsetf(long);

    int  width() const          { return x_width; }
    int  width(int w)           { int i = x_width; x_width = w; return i; }

    int  precision(int);
    int  precision() const      { return x_precision; }

    char fill(char);
    char fill() const           { return x_fill; }
    ostream* tie(ostream* s);
    ostream* tie()              { return x_tie; }

    operator void*()            { return (state & (failbit | badbit | hardfail)) ? NULL : this; }
#if defined(powerc)
    operator const void*() const{ return (state & (failbit | badbit | hardfail)) ? NULL : this; }
#endif
    int operator!() const       { return state & (failbit | badbit | hardfail); }
    int rdstate() const         { return state; }
    int eof() const             { return state & eofbit; }
    int fail() const            { return state & (failbit | badbit | hardfail); }
    int bad() const             { return state & badbit; }
    int good() const            { return state == 0; }
    void clear(int i = 0)
    {
        state =  (i & 0377) | (state & hardfail);
        ispecial = (ispecial & ~0377) | state;
        ospecial = (ospecial & ~0377) | state;
    }
    streambuf* rdbuf()          { return bp; }

public:
    /*
     * Members related to user allocated bits and words
     */
    long& iword(int);
    void*& pword(int);
    static long bitalloc();
    static int xalloc();

private:
    static long nextbit;
    static long nextword;

    int nuser;
    union ios_user_union* x_user;
    void uresize(int);

public:
    /*
     * static member functions
     */
    static void sync_with_stdio();

protected:
    enum
    {
        skipping = 01000,
        tied     = 02000
    };
    /*
     * bits 0377 are reserved for userbits
     */
    streambuf* bp;
    void setstate(int b)
    {
        state |= (b & 0377);
        ispecial |= b & ~skipping;
        ispecial |= b;
    }
    int         state;
    int         ispecial;
    int         ospecial;
    int         isfx_special;
    int         osfx_special;
    int         delbuf;
    ostream*    x_tie;
    long        x_flags;
    short       x_precision;
    char        x_fill;
    short       x_width;

    static void (*stdioflush)();

    void init(streambuf*);      // Does the real work of a constructor.
    ios();                      // No initialization at all.  Needed by multiple inheritance versions.
    int assign_private;         // Needed by with_assgn classes.

private:
    ios(ios&);                  // Declared but not defined
    void operator=(ios&);       // Declared but not defined

public:
    /*
     * old stream package compatibility
     */
    int skip(int i);

};  // class ios


class streambuf
{
public:
    /*
     * Constructors -- should be protected
     */
    streambuf();
    streambuf(char* p, int l);
    streambuf(char* p, int l, int c);                   // 3 argument form is obsolete. Use strstreambuf.

protected:
    short       alloc;

private:
    short       x_unbuf;
    char*       x_base;
    char*       x_pbase;
    char*       x_pptr;
    char*       x_epptr;
    char*       x_gptr;
    char*       x_egptr;
    char*       x_eback;
    int         x_blen;

private:
    streambuf(streambuf&);      // Declared but not defined
    void operator=(streambuf&); // Declared but not defined

public:
    void dbp();

protected:
    char*       base()          { return x_base; }
    char*       pbase()         { return x_pbase; }
    char*       pptr()          { return x_pptr; }
    char*       epptr()         { return x_epptr; }
    char*       gptr()          { return x_gptr; }
    char*       egptr()         { return x_egptr; }
    char*       eback()         { return x_eback; }
    char*       ebuf()          { return x_base + x_blen; }
    int         blen() const    { return x_blen; }
    void        pbump(int n)    { x_pptr += n; }
    void        gbump(int n)    { x_gptr += n; }
    void setp(char* p, char* ep)
    {
        x_pbase = x_pptr = p;
        x_epptr = ep;
    }
    void setg(char* eb, char* g, char* eg)
    {
        x_eback = eb;
        x_gptr = g;
        x_egptr = eg;
    }
    void setb(char* b, char* eb, int a = 0)
    {
        if (alloc && x_base)
            delete x_base;
        x_base = b;
        x_blen = (eb > b) ? (eb - b) : 0;
        alloc = a;
    }
    int unbuffered()            { return x_unbuf; }
    void unbuffered(int unb)    { x_unbuf = (unb != 0); }
    virtual int doallocate();
    int allocate()              { return (x_base == 0 && !unbuffered()) ? doallocate() : 0; }

public:
    virtual int overflow(int c = EOF);
    virtual int underflow();
    virtual int pbackfail(int c);
    virtual int sync();
    virtual streampos seekoff(streamoff, ios::seek_dir, int = ios::in | ios::out);
    virtual streampos seekpos(streampos, int = ios::in | ios::out);
    virtual int xsputn(const char* s, int n);
    virtual int xsgetn(char* s, int n);

    int in_avail()
    {
        return (x_gptr < x_egptr) ? x_egptr - x_gptr : 0;
    }
    int out_waiting()
    {
        return (x_pptr) ? x_pptr - x_pbase : 0;
    }
    int sgetc()
    {
        /*
         * WARNING: sgetc does not bump the pointer
         */
        return (x_gptr >= x_egptr) ? underflow() : zapeof(*x_gptr);
    }
    int snextc()
    {
        return (++x_gptr >= x_egptr) ? x_snextc() : zapeof(*x_gptr);
    }
    int sbumpc()
    {
        return (x_gptr >= x_egptr && underflow() == EOF) ? EOF : zapeof(*x_gptr++);
    }
    int optim_in_avail()
    {
        return x_gptr < x_egptr;
    }
    int optim_sbumpc()
    {
        return (underflow() == EOF) ? EOF : zapeof(*x_gptr++);
    }
    void stossc()
    {
        if (x_gptr++ > x_egptr)
            underflow();
    }
    int sputbackc(char c)
    {
        if (x_gptr > x_eback)
        {
            if (*--x_gptr == c)
                return zapeof(c);
            else
                return zapeof(*x_gptr = c);
        }
        else
            return pbackfail(c);
    }
    int sputc(int c)
    {
        return (x_pptr >= x_epptr) ? overflow(zapeof(c)) : zapeof(*x_pptr++ = c);
    }
    int sputn(const char* s,int n)
    {
        if (n <= (x_epptr - x_pptr))
        {
            memcpy(x_pptr, s, n);
            pbump(n);
            return n;
        }
        else
            return xsputn(s, n);
    }
    int sgetn(char* s,int n)
    {
        if (x_gptr + n <= x_egptr)
        {
            memcpy(s, x_gptr, n);
            gbump(n);
            return n;
        }
        else
            return xsgetn(s, n);
    }
    virtual streambuf* setbuf(char* p, int len);
    streambuf* setbuf(unsigned char* p, int len);
    streambuf* setbuf(char* p, int len, int count);     // obsolete third argument
    virtual ~streambuf();

private:
    int x_snextc();

};  // class streambuf


class istream : virtual public ios
{

public:
    /*
     * Constructor, destructor
     */
    istream(streambuf*);
    virtual ~istream();

public:
#if defined(powerc) || defined(__SC__)
    int         ipfx(int need);
#else
#if defined(applec) && !defined(__SC__)
    int         ipfx(int noskipws = 0)
    {
        return (noskipws ? (ispecial & ~skipping) : ispecial) ? do_ipfx(noskipws) : 1;
    }
#endif
#endif
    void        isfx()                                  { }
    istream&    seekg(streampos p);
    istream&    seekg(streamoff o, ios::seek_dir d);
    streampos   tellg();
    istream&    operator>>(istream& (*f)(istream&))     { return (*f)(*this); }
    istream&    operator>>(ios& (*f)(ios&));
    istream&    operator>>(char*);
    istream&    operator>>(unsigned char*);
#if defined(powerc) || defined(__SC__)
    istream&    operator>>(unsigned char& c);
    istream&    operator>>(char& c);
#else
#if defined(applec) && !defined(__SC__)
    istream&    operator>>(unsigned char& c)
    {
        if (!ispecial && bp->optim_in_avail())
        {
            c = bp->optim_sbumpc();
            return *this;
        }
        else
            return rs_complicated(c);
    }
    istream&    operator>>(char& c)
    {
        if (!ispecial && bp->optim_in_avail())
        {
            c = bp->optim_sbumpc();
            return *this;
        }
        else
            return rs_complicated(c);
    }
    istream&    rs_complicated(unsigned char& c);
    istream&    rs_complicated(char& c);
#endif
#endif
    istream&    operator>>(short&);
    istream&    operator>>(int&);
    istream&    operator>>(long&);
    istream&    operator>>(unsigned short&);
    istream&    operator>>(unsigned int&);
    istream&    operator>>(unsigned long&);
    istream&    operator>>(float&);
    istream&    operator>>(double&);
#ifdef powerc
    istream&    operator>>(long double&);
#else
#if defined(applec) || defined(__SC__)
    istream&    operator>>(extended&);
    istream&    operator>>(comp&);
#endif
#endif
    istream&    operator>>(streambuf*);
#if defined (__xlc) || defined (__xlC) || defined (__xlC__)
    istream&    get(char*,                int lim, char delim = '\015');
    istream&    get(unsigned char* b,     int lim, char delim = '\015');
    istream&    getline(char* b,          int lim, char delim = '\015');
    istream&    getline(unsigned char* b, int lim, char delim = '\015');
    istream&    get(streambuf& sb,                 char delim = '\015');
#else
    istream&    get(char*,                int lim, char delim = '\n');
    istream&    get(unsigned char* b,     int lim, char delim = '\n');
    istream&    getline(char* b,          int lim, char delim = '\n');
    istream&    getline(unsigned char* b, int lim, char delim = '\n');
    istream&    get(streambuf& sb,                 char delim = '\n');
#endif
    istream&    get_complicated(unsigned char& c);
    istream&    get_complicated(char& c);
#if defined(powerc) || defined(__SC__)
    istream&    get(unsigned char& c);
    istream&    get(char& c);
#else
#if defined(applec) && !defined(__SC__)
    istream&    get(unsigned char& c)
    {
        if (!(ispecial & ~skipping) && bp->optim_in_avail())
        {
            x_gcount = 1;
            c = bp->sbumpc();
            return *this;
        }
        else
            return (get_complicated(c));
    }
    istream&    get(char& c)
    {
        if (!(ispecial & ~skipping) && bp->optim_in_avail())
        {
            x_gcount = 1;
            c = bp->sbumpc();
            return *this;
        }
        else
            return (get_complicated(c));
    }
#endif
#endif
    int get()
    {
        int c;
        if (!ipfx(1))
            return EOF;
        else
        {
            c = bp->sbumpc();
            if (c == EOF)
                setstate(eofbit);
            return c;
        }
    }
    int         peek()                                  { return (ipfx(-1)) ? bp->sgetc() : EOF; }
    istream&    ignore(int n = 1, int delim = EOF);
    istream&    read(char* s,int n);
    istream&    read(unsigned char* s,int n)            { return read((char*)s, n); }
    istream&    putback(char c);
    int         gcount();
    int         sync()                                  { return bp->sync(); }
#if defined(powerc) || defined(__SC__)
    void        eatwhite();
#endif

protected:
#if defined(applec) && !defined(__SC__)
    void        eatwhite();
    int         do_ipfx(int noskipws);
#endif
    istream();

private:
    int         x_gcount;
    void        xget(char*  c);
#if defined(powerc) || defined(__SC__)
    long        scan_int();
#endif

#if defined(applec) || defined(__SC__)
public:
    /*
     * Obsolete constructors, carried over from stream package.
     */
    istream(streambuf*, int sk, ostream* t = 0);        // obsolete, set sk and tie via format state variables
    istream(int size, char*, int sk = 1);               // obsolete, use strstream
    istream(int fd, int sk = 1, ostream* t = 0);        // obsolete, use fstream
#endif

};  // class istream


class ostream : virtual public ios
{

public:
    /*
     * Constructor, destructor
     */
    ostream(streambuf*);
    virtual ~ostream();

public:
#if defined(powerc) || defined(__SC__)
    int         opfx();         /* Output prefix */
    void        osfx();
#else
#if defined(applec) && !defined(__SC__)
    int         opfx()                                  { return (ospecial) ? do_opfx() : 1; }
    void        osfx()                                  { if (osfx_special) do_osfx(); }
#endif
#endif
    ostream&    flush();
    ostream&    seekp(streampos p);
    ostream&    seekp(streamoff o, ios::seek_dir d);
    streampos   tellp();
    ostream&    put(char c);
#if defined(powerc) || defined(__SC__)
    ostream&    operator<<(char c);
    ostream&    operator<<(unsigned char c);
#else
#if defined(applec) && !defined(__SC__)
    ostream&    complicated_put(char c);
    ostream&    ls_complicated(char c);
    ostream&    ls_complicated(unsigned char c);
    ostream&    operator<<(char c)
    {
        if (ospecial || osfx_special)
            return ls_complicated(c);
        else
        {
            if (bp->sputc(c) == EOF)
                setstate(eofbit | failbit);
            return *this;
        }
    }
    ostream&    operator<<(unsigned char c)
    {
        if (ospecial || osfx_special)
            return ls_complicated(c);
        else
        {
            if (bp->sputc(c) == EOF)
                setstate(eofbit | failbit);
            return *this;
        }
    }
#endif
#endif
    ostream&    operator<<(const char*);
    ostream&    operator<<(const unsigned char*);
    ostream&    operator<<(int a);
    ostream&    operator<<(long l);
#ifdef powerc
    ostream&    operator<<(float d)                     { return (*this) << (long double)d; }
    ostream&    operator<<(double d)                    { return (*this) << (long double)d; }
    ostream&    operator<<(long double d);
#else
#if defined(applec) || defined(__SC__)
    ostream&    operator<<(float d)                     { return (*this) << (extended)d; }
    ostream&    operator<<(double d)                    { return (*this) << (extended)d; }
    ostream&    operator<<(comp d)                      { return (*this) << (extended)d; }
    ostream&    operator<<(extended d);
#endif
#endif
    ostream&    operator<<(unsigned int a);
    ostream&    operator<<(unsigned long l);
    ostream&    operator<<(void*);
    ostream&    operator<<(streambuf*);
    ostream&    operator<<(short i)                     { return *this << (int)i; }
    ostream&    operator<<(unsigned short i)            { return *this << (int)i; }
    ostream&    operator<<(ostream& (*f)(ostream&))     { return (*f)(*this); }
    ostream&    operator<<(ios& (*f)(ios&));
    ostream&    write(const char* s, int n)
    {
        if (!state)
        {
            if (bp->sputn(s, n) != n)
                setstate(eofbit | failbit);
        }
        return *this;
    }
    ostream&    write(const unsigned char* s, int n)    { return write((const char*)s, n); }

protected:
#if defined(applec) || defined(__SC__)
    int         do_opfx();
    void        do_osfx();
#endif
    ostream();

#if defined(applec) || defined(__SC__)
public:
    /*
     * Obsolete constructors, carried over from stream package.
     */
    ostream(int fd);            // obsolete, use fstream.
    ostream(int size, char*);   // obsolete, use strstream.
#endif

};  // class ostream


class iostream : public istream, public ostream
{

public:
    iostream(streambuf*);
    virtual ~iostream();

protected:
    iostream();

};  // class iostream


class Iostream_init;

class istream_withassign : public istream
{

public:
    istream_withassign();
#if defined(applec) || defined(__SC__)
    istream_withassign(Iostream_init*);
#endif
    virtual ~istream_withassign();
    istream_withassign& operator=(istream&);
    istream_withassign& operator=(streambuf*);

};  // class istream_withassign


class ostream_withassign : public ostream
{

public:
    ostream_withassign();
#if defined(applec) || defined(__SC__)
    ostream_withassign(Iostream_init*);
#endif
    virtual ~ostream_withassign();
    ostream_withassign& operator=(ostream&);
    ostream_withassign& operator=(streambuf*);

};  // class ostream_withassign


class iostream_withassign : public iostream
{

public:
    iostream_withassign();
    virtual ~iostream_withassign();
    iostream_withassign& operator=(ios&);
    iostream_withassign& operator=(streambuf*);

};  // class iostream_withassign


extern istream_withassign cin;
extern ostream_withassign cout;
extern ostream_withassign cerr;
#if defined(powerc) || defined(__SC__)
extern ostream_withassign clog;
#else
#if defined(applec) && !defined(__SC__)
extern ostream_withassign cdebug;
#endif
#endif


ios&            dec(ios&);
ostream&        endl(ostream& i);
ostream&        ends(ostream& i);
ostream&        flush(ostream&);
ios&            hex(ios&);
ios&            oct(ios&);
istream&        ws(istream&);


/*
 * see iostream_init.c (or MPW cstearms.c)
 */
class Iostream_init
{

    static int stdstatus;
#if defined(powerc) || defined(__SC__)
    static int initcount;
#endif
    friend ios;

public:
    Iostream_init();
    ~Iostream_init();

};  // class Iostream_init

#ifdef powerc
#pragma options align=reset
#endif

#endif	/* __IOSTREAM__ */
