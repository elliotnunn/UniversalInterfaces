/*
     File:       PMApplication.h
 
     Contains:   Carbon Printing Manager Interfaces.
 
     Version:    Technology: Mac OS 8.x
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1998-2000 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __PMAPPLICATION__
#define __PMAPPLICATION__

#ifndef __MACERRORS__
#include <MacErrors.h>
#endif

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif

#ifndef __DIALOGS__
#include <Dialogs.h>
#endif

#ifndef __CMAPPLICATION__
#include <CMApplication.h>
#endif



#if PRAGMA_ONCE
#pragma once
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_IMPORT
#pragma import on
#endif

#if PRAGMA_STRUCT_ALIGN
    #pragma options align=mac68k
#elif PRAGMA_STRUCT_PACKPUSH
    #pragma pack(push, 2)
#elif PRAGMA_STRUCT_PACK
    #pragma pack(2)
#endif

/* Carbon printing structures */
typedef struct OpaquePMObject*          PMObject;
typedef struct OpaquePMDialog*          PMDialog;
typedef PMObject                        PMPrintSettings;
typedef PMObject                        PMPageFormat;
typedef struct OpaquePMPrintContext*    PMPrintContext;

struct PMResolution {
    double                          hRes;
    double                          vRes;
};
typedef struct PMResolution             PMResolution;

struct PMLanguageInfo {
    Str32                           level;
    Str32                           version;
    Str32                           release;
};
typedef struct PMLanguageInfo           PMLanguageInfo;

struct PMRect {
    double                          top;
    double                          left;
    double                          bottom;
    double                          right;
};
typedef struct PMRect                   PMRect;
/* Callbacks */
typedef CALLBACK_API( void , PMIdleProcPtr )(void );
typedef CALLBACK_API( void , PMItemProcPtr )(DialogPtr theDialog, short item);
typedef CALLBACK_API( void , PMPrintDialogInitProcPtr )(PMPrintSettings printSettings, PMDialog *theDialog);
typedef CALLBACK_API( void , PMPageSetupDialogInitProcPtr )(PMPageFormat pageFormat, PMDialog *theDialog);
typedef STACK_UPP_TYPE(PMIdleProcPtr)                           PMIdleUPP;
typedef STACK_UPP_TYPE(PMItemProcPtr)                           PMItemUPP;
typedef STACK_UPP_TYPE(PMPrintDialogInitProcPtr)                PMPrintDialogInitUPP;
typedef STACK_UPP_TYPE(PMPageSetupDialogInitProcPtr)            PMPageSetupDialogInitUPP;
#if OPAQUE_UPP_TYPES
    EXTERN_API(PMIdleUPP)
    NewPMIdleUPP                   (PMIdleProcPtr           userRoutine);

    EXTERN_API(PMItemUPP)
    NewPMItemUPP                   (PMItemProcPtr           userRoutine);

    EXTERN_API(PMPrintDialogInitUPP)
    NewPMPrintDialogInitUPP        (PMPrintDialogInitProcPtr userRoutine);

    EXTERN_API(PMPageSetupDialogInitUPP)
    NewPMPageSetupDialogInitUPP    (PMPageSetupDialogInitProcPtr userRoutine);

    EXTERN_API(void)
    DisposePMIdleUPP               (PMIdleUPP               userUPP);

    EXTERN_API(void)
    DisposePMItemUPP               (PMItemUPP               userUPP);

    EXTERN_API(void)
    DisposePMPrintDialogInitUPP    (PMPrintDialogInitUPP    userUPP);

    EXTERN_API(void)
    DisposePMPageSetupDialogInitUPP    (PMPageSetupDialogInitUPP userUPP);

    EXTERN_API(void)
    InvokePMIdleUPP                (PMIdleUPP               userUPP);

    EXTERN_API(void)
    InvokePMItemUPP                (DialogPtr               theDialog,
                                    short                   item,
                                    PMItemUPP               userUPP);

    EXTERN_API(void)
    InvokePMPrintDialogInitUPP     (PMPrintSettings         printSettings,
                                    PMDialog *              theDialog,
                                    PMPrintDialogInitUPP    userUPP);

    EXTERN_API(void)
    InvokePMPageSetupDialogInitUPP    (PMPageFormat         pageFormat,
                                    PMDialog *              theDialog,
                                    PMPageSetupDialogInitUPP userUPP);

#else
    enum { uppPMIdleProcInfo = 0x00000000 };                        /* pascal no_return_value Func() */
    enum { uppPMItemProcInfo = 0x000002C0 };                        /* pascal no_return_value Func(4_bytes, 2_bytes) */
    enum { uppPMPrintDialogInitProcInfo = 0x000003C0 };             /* pascal no_return_value Func(4_bytes, 4_bytes) */
    enum { uppPMPageSetupDialogInitProcInfo = 0x000003C0 };         /* pascal no_return_value Func(4_bytes, 4_bytes) */
    #define NewPMIdleUPP(userRoutine)                               (PMIdleUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPMIdleProcInfo, GetCurrentArchitecture())
    #define NewPMItemUPP(userRoutine)                               (PMItemUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPMItemProcInfo, GetCurrentArchitecture())
    #define NewPMPrintDialogInitUPP(userRoutine)                    (PMPrintDialogInitUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPMPrintDialogInitProcInfo, GetCurrentArchitecture())
    #define NewPMPageSetupDialogInitUPP(userRoutine)                (PMPageSetupDialogInitUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPMPageSetupDialogInitProcInfo, GetCurrentArchitecture())
    #define DisposePMIdleUPP(userUPP)                               DisposeRoutineDescriptor(userUPP)
    #define DisposePMItemUPP(userUPP)                               DisposeRoutineDescriptor(userUPP)
    #define DisposePMPrintDialogInitUPP(userUPP)                    DisposeRoutineDescriptor(userUPP)
    #define DisposePMPageSetupDialogInitUPP(userUPP)                DisposeRoutineDescriptor(userUPP)
    #define InvokePMIdleUPP(userUPP)                                CALL_ZERO_PARAMETER_UPP((userUPP), uppPMIdleProcInfo)
    #define InvokePMItemUPP(theDialog, item, userUPP)               CALL_TWO_PARAMETER_UPP((userUPP), uppPMItemProcInfo, (theDialog), (item))
    #define InvokePMPrintDialogInitUPP(printSettings, theDialog, userUPP)  CALL_TWO_PARAMETER_UPP((userUPP), uppPMPrintDialogInitProcInfo, (printSettings), (theDialog))
    #define InvokePMPageSetupDialogInitUPP(pageFormat, theDialog, userUPP)  CALL_TWO_PARAMETER_UPP((userUPP), uppPMPageSetupDialogInitProcInfo, (pageFormat), (theDialog))
#endif
/* support for pre-Carbon UPP routines: NewXXXProc and CallXXXProc */
#define NewPMIdleProc(userRoutine)                              NewPMIdleUPP(userRoutine)
#define NewPMItemProc(userRoutine)                              NewPMItemUPP(userRoutine)
#define NewPMPrintDialogInitProc(userRoutine)                   NewPMPrintDialogInitUPP(userRoutine)
#define NewPMPageSetupDialogInitProc(userRoutine)               NewPMPageSetupDialogInitUPP(userRoutine)
#define CallPMIdleProc(userRoutine)                             InvokePMIdleUPP(userRoutine)
#define CallPMItemProc(userRoutine, theDialog, item)            InvokePMItemUPP(theDialog, item, userRoutine)
#define CallPMPrintDialogInitProc(userRoutine, printSettings, theDialog) InvokePMPrintDialogInitUPP(printSettings, theDialog, userRoutine)
#define CallPMPageSetupDialogInitProc(userRoutine, pageFormat, theDialog) InvokePMPageSetupDialogInitUPP(pageFormat, theDialog, userRoutine)
/* enums */
#define kPMCancel           (0x0080)    /* user hit cancel button in dialogs */
#define kPMNoData           NULL        /* for general use */
#define kPMDontWantSize     NULL        /* for parameters which return size information */
#define kPMDontWantData     NULL        /* for parameters which return data */
#define kPMDontWantBoolean  NULL        /* for parameters which take a boolean reference */
#define kPMNoPrintSettings  NULL        /* for parameters which take a PrintSettings reference */ 
#define kPMNoPageFormat     NULL        /* for parameters which take a PageFormat reference */
#define kPMNoReference      NULL        /* for parameters which take an address pointer */

typedef UInt32 PMTag;
enum {
                                                                /* common tags */
    kPMCurrentValue             = FOUR_CHAR_CODE('curr'),       /* current setting or value */
    kPMDefaultValue             = FOUR_CHAR_CODE('dflt'),       /* default setting or value */
    kPMMinimumValue             = FOUR_CHAR_CODE('minv'),       /* the minimum setting or value */
    kPMMaximumValue             = FOUR_CHAR_CODE('maxv'),       /* the maximum setting or value */
                                                                /* profile tags */
    kPMSourceProfile            = FOUR_CHAR_CODE('srcp'),       /* source profile */
                                                                /* resolution tags */
    kPMMinRange                 = FOUR_CHAR_CODE('mnrg'),       /* Min range supported by a printer */
    kPMMaxRange                 = FOUR_CHAR_CODE('mxrg'),       /* Max range supported by a printer */
    kPMMinSquareResolution      = FOUR_CHAR_CODE('mins'),       /* Min with X and Y resolution equal */
    kPMMaxSquareResolution      = FOUR_CHAR_CODE('maxs'),       /* Max with X and Y resolution equal */
    kPMDefaultResolution        = FOUR_CHAR_CODE('dftr')        /* printer default resolution */
};



typedef UInt16 PMOrientation;
enum {
    kPMPortrait                 = 1,
    kPMLandscape                = 2,
    kPMReversePortrait          = 3,                            /* will revert to kPortrait for current drivers */
    kPMReverseLandscape         = 4                             /* will revert to kLandscape for current drivers */
};

enum {
    kSizeOfTPrint               = 120                           /* size of old TPrint record */
};

/* OSStatus return codes */
enum {
    kPMNoError                  = 0,
    kPMGeneralError             = -30870,
    kPMOutOfScope               = -30871,                       /* an API call is out of scope */
    kPMInvalidParameter         = -30872,                       /* a required parameter is missing or invalid */
    kPMNotImplemented           = -30873,                       /* this API call is not supported */
    kPMNoSuchEntry              = -30874,                       /* no such entry */
    kPMInvalidPrintSettings     = -30875,                       /* the printsettings reference is invalid */
    kPMInvalidPageFormat        = -30876,                       /* the pageformat reference is invalid */
    kPMValueOutOfRange          = -30877,                       /* a value passed in is out of range */
    kPMLockIgnored              = -30878                        /* the lock value was ignored */
};

/* Print loop */
EXTERN_API( OSStatus )
PMBegin                         (void);

EXTERN_API( OSStatus )
PMEnd                           (void);

EXTERN_API( OSStatus )
PMBeginDocument                 (PMPrintSettings        printSettings,
                                 PMPageFormat           pageFormat,
                                 PMPrintContext *       printContext);

EXTERN_API( OSStatus )
PMEndDocument                   (PMPrintContext         printContext);

EXTERN_API( OSStatus )
PMBeginPage                     (PMPrintContext         printContext,
                                 const PMRect *         pageFrame);

EXTERN_API( OSStatus )
PMEndPage                       (PMPrintContext         printContext);

EXTERN_API( OSStatus )
PMSetIdleProc                   (PMIdleUPP              idleProc);

EXTERN_API( OSStatus )
PMGetGrafPtr                    (PMPrintContext         printContext,
                                 GrafPtr *              grafPort);

/* PMPageFormat */
EXTERN_API( OSStatus )
PMNewPageFormat                 (PMPageFormat *         pageFormat);

EXTERN_API( OSStatus )
PMDisposePageFormat             (PMPageFormat           pageFormat);

EXTERN_API( OSStatus )
PMDefaultPageFormat             (PMPageFormat           pageFormat);

EXTERN_API( OSStatus )
PMValidatePageFormat            (PMPageFormat           pageFormat,
                                 Boolean *              result);

EXTERN_API( OSStatus )
PMCopyPageFormat                (PMPageFormat           formatSrc,
                                 PMPageFormat           formatDest);

EXTERN_API( OSStatus )
PMFlattenPageFormat             (PMPageFormat           pageFormat,
                                 Handle *               flatFormat);

EXTERN_API( OSStatus )
PMUnflattenPageFormat           (Handle                 flatFormat,
                                 PMPageFormat *         pageFormat);

EXTERN_API( OSStatus )
PMGetPageFormatExtendedData     (PMPageFormat           pageFormat,
                                 OSType                 dataID,
                                 UInt32 *               size,
                                 void *                 theData);

EXTERN_API( OSStatus )
PMSetPageFormatExtendedData     (PMPageFormat           pageFormat,
                                 OSType                 dataID,
                                 UInt32                 size,
                                 void *                 theData);

/* PMPageFormat Accessors */
EXTERN_API( OSStatus )
PMGetScale                      (PMPageFormat           pageFormat,
                                 double *               scale);

EXTERN_API( OSStatus )
PMSetScale                      (PMPageFormat           pageFormat,
                                 double                 scale);

EXTERN_API( OSStatus )
PMGetResolution                 (PMPageFormat           pageFormat,
                                 PMResolution *         res);

EXTERN_API( OSStatus )
PMSetResolution                 (PMPageFormat           pageFormat,
                                 const PMResolution *   res);

EXTERN_API( OSStatus )
PMGetPhysicalPaperSize          (PMPageFormat           pageFormat,
                                 PMRect *               paperSize);

EXTERN_API( OSStatus )
PMSetPhysicalPaperSize          (PMPageFormat           pageFormat,
                                 const PMRect *         paperSize);

EXTERN_API( OSStatus )
PMGetPhysicalPageSize           (PMPageFormat           pageFormat,
                                 PMRect *               pageSize);

EXTERN_API( OSStatus )
PMGetAdjustedPaperRect          (PMPageFormat           pageFormat,
                                 PMRect *               paperRect);

EXTERN_API( OSStatus )
PMGetAdjustedPageRect           (PMPageFormat           pageFormat,
                                 PMRect *               pageRect);

EXTERN_API( OSStatus )
PMGetOrientation                (PMPageFormat           pageFormat,
                                 PMOrientation *        orientation);

EXTERN_API( OSStatus )
PMSetOrientation                (PMPageFormat           pageFormat,
                                 PMOrientation          orientation,
                                 Boolean                lock);

/* PMPrintSettings */
EXTERN_API( OSStatus )
PMNewPrintSettings              (PMPrintSettings *      printSettings);

EXTERN_API( OSStatus )
PMDisposePrintSettings          (PMPrintSettings        printSettings);

EXTERN_API( OSStatus )
PMDefaultPrintSettings          (PMPrintSettings        printSettings);

EXTERN_API( OSStatus )
PMValidatePrintSettings         (PMPrintSettings        printSettings,
                                 Boolean *              result);

EXTERN_API( OSStatus )
PMCopyPrintSettings             (PMPrintSettings        settingSrc,
                                 PMPrintSettings        settingDest);

EXTERN_API( OSStatus )
PMFlattenPrintSettings          (PMPrintSettings        printSettings,
                                 Handle *               flatSettings);

EXTERN_API( OSStatus )
PMUnflattenPrintSettings        (Handle                 flatSettings,
                                 PMPrintSettings *      printSettings);

EXTERN_API( OSStatus )
PMGetPrintSettingsExtendedData  (PMPrintSettings        printSettings,
                                 OSType                 dataID,
                                 UInt32 *               size,
                                 void *                 theData);

EXTERN_API( OSStatus )
PMSetPrintSettingsExtendedData  (PMPrintSettings        printSettings,
                                 OSType                 dataID,
                                 UInt32                 size,
                                 void *                 theData);

/* PMPrintSettings Accessors */
EXTERN_API( OSStatus )
PMGetJobName                    (PMPrintSettings        printSettings,
                                 StringPtr              name);

EXTERN_API( OSStatus )
PMSetJobName                    (PMPrintSettings        printSettings,
                                 StringPtr              name);

EXTERN_API( OSStatus )
PMGetCopies                     (PMPrintSettings        printSettings,
                                 UInt32 *               copies);

EXTERN_API( OSStatus )
PMSetCopies                     (PMPrintSettings        printSettings,
                                 UInt32                 copies,
                                 Boolean                lock);

EXTERN_API( OSStatus )
PMGetFirstPage                  (PMPrintSettings        printSettings,
                                 UInt32 *               first);

EXTERN_API( OSStatus )
PMSetFirstPage                  (PMPrintSettings        printSettings,
                                 UInt32                 first,
                                 Boolean                lock);

EXTERN_API( OSStatus )
PMGetLastPage                   (PMPrintSettings        printSettings,
                                 UInt32 *               last);

EXTERN_API( OSStatus )
PMSetLastPage                   (PMPrintSettings        printSettings,
                                 UInt32                 last,
                                 Boolean                lock);

EXTERN_API( OSStatus )
PMGetPageRange                  (PMPrintSettings        printSettings,
                                 UInt32 *               minPage,
                                 UInt32 *               maxPage);

EXTERN_API( OSStatus )
PMSetPageRange                  (PMPrintSettings        printSettings,
                                 UInt32                 minPage,
                                 UInt32                 maxPage);

EXTERN_API( OSStatus )
PMSetProfile                    (PMPrintSettings        printSettings,
                                 PMTag                  tag,
                                 const CMProfileLocation * profile);

/* Printing Dialogs */
EXTERN_API( OSStatus )
PMPageSetupDialog               (PMPageFormat           pageFormat,
                                 Boolean *              accepted);

EXTERN_API( OSStatus )
PMPrintDialog                   (PMPrintSettings        printSettings,
                                 PMPageFormat           constPageFormat,
                                 Boolean *              accepted);

EXTERN_API( OSStatus )
PMPageSetupDialogInit           (PMPageFormat           pageFormat,
                                 PMDialog *             newDialog);

EXTERN_API( OSStatus )
PMPrintDialogInit               (PMPrintSettings        printSettings,
                                 PMDialog *             newDialog);

EXTERN_API( OSStatus )
PMPrintDialogMain               (PMPrintSettings        printSettings,
                                 PMPageFormat           constPageFormat,
                                 Boolean *              accepted,
                                 PMPrintDialogInitUPP   myInitProc);

EXTERN_API( OSStatus )
PMPageSetupDialogMain           (PMPageFormat           pageFormat,
                                 Boolean *              accepted,
                                 PMPageSetupDialogInitUPP  myInitProc);

/* Printing Dialog accessors */
EXTERN_API( OSStatus )
PMGetDialogPtr                  (PMDialog               pmDialog,
                                 DialogPtr *            theDialog);

EXTERN_API( OSStatus )
PMGetModalFilterProc            (PMDialog               pmDialog,
                                 ModalFilterUPP *       filterProc);

EXTERN_API( OSStatus )
PMSetModalFilterProc            (PMDialog               pmDialog,
                                 ModalFilterUPP         filterProc);

EXTERN_API( OSStatus )
PMGetItemProc                   (PMDialog               pmDialog,
                                 PMItemUPP *            itemProc);

EXTERN_API( OSStatus )
PMSetItemProc                   (PMDialog               pmDialog,
                                 PMItemUPP              itemProc);

EXTERN_API( OSStatus )
PMGetDialogAccepted             (PMDialog               pmDialog,
                                 Boolean *              process);

EXTERN_API( OSStatus )
PMSetDialogAccepted             (PMDialog               pmDialog,
                                 Boolean                process);

EXTERN_API( OSStatus )
PMGetDialogDone                 (PMDialog               pmDialog,
                                 Boolean *              done);

EXTERN_API( OSStatus )
PMSetDialogDone                 (PMDialog               pmDialog,
                                 Boolean                done);

/* Classic Support */
EXTERN_API( OSStatus )
PMGeneral                       (Ptr                    pData);

EXTERN_API( OSStatus )
PMConvertOldPrintRecord         (Handle                 printRecordHandle,
                                 PMPrintSettings *      printSettings,
                                 PMPageFormat *         pageFormat);

EXTERN_API( OSStatus )
PMMakeOldPrintRecord            (PMPrintSettings        printSettings,
                                 PMPageFormat           pageFormat,
                                 Handle *               printRecordHandle);

/* Driver Information */
EXTERN_API( OSStatus )
PMIsPostScriptDriver            (Boolean *              isPostScript);

EXTERN_API( OSStatus )
PMGetLanguageInfo               (PMLanguageInfo *       info);

EXTERN_API( OSStatus )
PMGetDriverCreator              (OSType *               creator);

EXTERN_API( OSStatus )
PMGetDriverReleaseInfo          (VersRec *              release);

EXTERN_API( OSStatus )
PMGetPrinterResolutionCount     (UInt32 *               count);

EXTERN_API( OSStatus )
PMGetPrinterResolution          (PMTag                  tag,
                                 PMResolution *         res);

EXTERN_API( OSStatus )
PMGetIndexedPrinterResolution   (UInt32                 index,
                                 PMResolution *         res);

/* ColorSync & PostScript Support */
EXTERN_API( OSStatus )
PMEnableColorSync               (void);

EXTERN_API( OSStatus )
PMDisableColorSync              (void);

EXTERN_API( OSStatus )
PMPostScriptBegin               (void);

EXTERN_API( OSStatus )
PMPostScriptEnd                 (void);

EXTERN_API( OSStatus )
PMPostScriptHandle              (Handle                 psHandle);

EXTERN_API( OSStatus )
PMPostScriptData                (Ptr                    psPtr,
                                 Size                   len);

EXTERN_API( OSStatus )
PMPostScriptFile                (FSSpec *               psFile);

/* Error */
EXTERN_API( OSStatus )
PMError                         (void);

EXTERN_API( OSStatus )
PMSetError                      (OSStatus               printError);


#if PRAGMA_STRUCT_ALIGN
    #pragma options align=reset
#elif PRAGMA_STRUCT_PACKPUSH
    #pragma pack(pop)
#elif PRAGMA_STRUCT_PACK
    #pragma pack()
#endif

#ifdef PRAGMA_IMPORT_OFF
#pragma import off
#elif PRAGMA_IMPORT
#pragma import reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __PMAPPLICATION__ */

