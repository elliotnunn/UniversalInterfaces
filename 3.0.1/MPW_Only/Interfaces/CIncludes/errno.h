/************************************************************

    errno.h
    Error reporting macros

    Copyright Apple Computer,Inc.  1995
    All rights reserved

 * Warning:  Not all of these macros are a part of the ANSI C standard.
 *           This header is not POSIX compliant.
 *           The library functions are not guaranteed to set "errno"
 *              to the value of any of the non-ANSI macros.
 *           For portable code, do not use the non-ANSI macros.

 ************************************************************/


#ifndef __ERRNO__
#define __ERRNO__

#if defined (__powerc) || defined (powerc) || defined (__CFM68K__)
    #pragma import on
#endif

/* ANSI specified declarations */

#define EDOM        33   /* Argument outside function domain    */
#define ERANGE      34   /* Result is too large to represent    */

extern int errno;

/* Mac specific declaration */

extern short MacOSErr;

/* Non-ANSI macro definitions */

#define EPERM        1   /* Operation not permitted             */
#define ENOENT       2   /* No such file or directory           */
#define ENORSRC      3   /* No such process                     */
#define EINTR        4   /* Interrupted function call           */
#define EIO          5   /* Input/Output error                  */
#define ENXIO        6   /* No such device or address           */
#define E2BIG        7   /* Argument list too long              */
#define ENOEXEC      8   /* File not in executable format       */
#define EBADF        9   /* Bad file descriptor (or number)     */
#define ECHILD      10   /* No child process                    */
#define EAGAIN      11   /* Resource temporarily unavailable    */
#define ENOMEM      12   /* Not enough space                    */
#define EACCES      13   /* File access permission denied       */
#define EFAULT      14   /* Bad address as argument in call     */
#define ENOTBLK     15   /* For backward compatibility          */
#define EBUSY       16   /* System resource busy                */
#define EEXIST      17   /* File already exists                 */
#define EXDEV       18   /* Improper link attempted             */
#define ENODEV      19   /* No such device                      */
#define ENOTDIR     20   /* Pathname was not a directory        */
#define EISDIR      21   /* Attempt to open directory for write */
#define EINVAL      22   /* Invalid argument                    */
#define ENFILE      23   /* Too many open files in system       */
#define EMFILE      24   /* Too many open files in process      */
#define ENOTTY      25   /* Inappropriate I/O control operation */
#define ETXTBSY     26   /* Text file is busy                   */
#define EFBIG       27   /* File too large                      */
#define ENOSPC      28   /* No space left on device             */
#define ESPIPE      29   /* Invalid seek                        */
#define EROFS       30   /* Attempt to modify a read-only file  */
#define EMLINK      31   /* Too many links on a single file     */
#define EPIPE       32   /* Broken pipe; no process to read it  */


#if defined (__powerc) || defined (powerc) || defined (__CFM68K__)
    #pragma import off
#endif

#endif  /* __ERRNO__ */
