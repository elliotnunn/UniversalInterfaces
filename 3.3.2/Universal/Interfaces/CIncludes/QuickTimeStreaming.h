/*
     File:       QuickTimeStreaming.h
 
     Contains:   QuickTime interfaces
 
     Version:    Technology: 
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1990-2000 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __QUICKTIMESTREAMING__
#define __QUICKTIMESTREAMING__

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif

#ifndef __COMPONENTS__
#include <Components.h>
#endif

#ifndef __MOVIES__
#include <Movies.h>
#endif

#ifndef __QUICKTIMECOMPONENTS__
#include <QuickTimeComponents.h>
#endif

#ifndef __MACERRORS__
#include <MacErrors.h>
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

enum {
    kQTSInfiniteDuration        = 0x7FFFFFFF,
    kQTSUnknownDuration         = 0x00000000,
    kQTSNormalForwardRate       = 0x00010000,
    kQTSStoppedRate             = 0x00000000
};


struct QTSPresentationRecord {
    long                            data[1];
};
typedef struct QTSPresentationRecord    QTSPresentationRecord;

typedef QTSPresentationRecord *         QTSPresentation;

struct QTSStreamRecord {
    long                            data[1];
};
typedef struct QTSStreamRecord          QTSStreamRecord;

typedef QTSStreamRecord *               QTSStream;

struct QTSEditEntry {
    TimeValue64                     presentationDuration;
    TimeValue64                     streamStartTime;
    Fixed                           streamRate;
};
typedef struct QTSEditEntry             QTSEditEntry;

struct QTSEditList {
    SInt32                          numEdits;
    QTSEditEntry                    edits[1];
};
typedef struct QTSEditList              QTSEditList;
typedef QTSEditList *                   QTSEditListPtr;
typedef QTSEditListPtr *                QTSEditListHandle;
#define kQTSInvalidPresentation     (QTSPresentation)0L
#define kQTSAllPresentations        (QTSPresentation)0L
#define kQTSInvalidStream           (QTSStream)0L
#define kQTSAllStreams              (QTSStream)0L

/*-----------------------------------------
    Get / Set Info
-----------------------------------------*/
enum {
    kQTSGetURLLink              = FOUR_CHAR_CODE('gull')        /* QTSGetURLLinkRecord* */
};

/* get and set */
enum {
    kQTSTargetBufferDurationInfo = FOUR_CHAR_CODE('bufr'),      /* Fixed* in seconds; expected, not actual */
    kQTSDurationInfo            = FOUR_CHAR_CODE('dura'),       /* QTSDurationAtom* */
    kQTSSourceTrackIDInfo       = FOUR_CHAR_CODE('otid'),       /* UInt32* */
    kQTSSourceLayerInfo         = FOUR_CHAR_CODE('olyr'),       /* UInt16* */
    kQTSSourceLanguageInfo      = FOUR_CHAR_CODE('olng'),       /* UInt16* */
    kQTSSourceTrackFlagsInfo    = FOUR_CHAR_CODE('otfl'),       /* SInt32* */
    kQTSSourceDimensionsInfo    = FOUR_CHAR_CODE('odim'),       /* QTSDimensionParams* */
    kQTSSourceVolumesInfo       = FOUR_CHAR_CODE('ovol'),       /* QTSVolumesParams* */
    kQTSSourceMatrixInfo        = FOUR_CHAR_CODE('omat'),       /* MatrixRecord* */
    kQTSSourceClipRectInfo      = FOUR_CHAR_CODE('oclp'),       /* Rect* */
    kQTSSourceGraphicsModeInfo  = FOUR_CHAR_CODE('ogrm'),       /* QTSGraphicsModeParams* */
    kQTSSourceScaleInfo         = FOUR_CHAR_CODE('oscl'),       /* Point* */
    kQTSSourceBoundingRectInfo  = FOUR_CHAR_CODE('orct'),       /* Rect* */
    kQTSSourceUserDataInfo      = FOUR_CHAR_CODE('oudt'),       /* UserData */
    kQTSSourceInputMapInfo      = FOUR_CHAR_CODE('oimp')        /* QTAtomContainer */
};

/* get only */
enum {
    kQTSStatisticsInfo          = FOUR_CHAR_CODE('stat'),       /* QTSStatisticsParams* */
    kQTSMinStatusDimensionsInfo = FOUR_CHAR_CODE('mstd'),       /* QTSDimensionParams* */
    kQTSNormalStatusDimensionsInfo = FOUR_CHAR_CODE('nstd'),    /* QTSDimensionParams* */
    kQTSTotalDataRateInfo       = FOUR_CHAR_CODE('drtt'),       /* UInt32*, add to what's there */
    kQTSTotalDataRateInInfo     = FOUR_CHAR_CODE('drti'),       /* UInt32*, add to what's there */
    kQTSTotalDataRateOutInfo    = FOUR_CHAR_CODE('drto'),       /* UInt32*, add to what's there */
    kQTSDataRateHistoryInfo     = FOUR_CHAR_CODE('drth'),       /* QTSDataRateHistoryParams* */
    kQTSLostPercentInfo         = FOUR_CHAR_CODE('lpct'),       /* QTSLostPercentParams*, add to what's there */
    kQTSMediaTypeInfo           = FOUR_CHAR_CODE('mtyp'),       /* OSType* */
    kQTSNameInfo                = FOUR_CHAR_CODE('name'),       /* QTSNameParams* */
    kQTSSampleDescriptionInfo   = FOUR_CHAR_CODE('sdsc'),       /* SampleDescriptionHandle */
    kQTSCanHandleSendDataType   = FOUR_CHAR_CODE('chsd'),       /* QTSCanHandleSendDataTypeParams* */
    kQTSAnnotationsInfo         = FOUR_CHAR_CODE('meta')        /* QTAtomContainer */
};

enum {
    kQTSTargetBufferDurationTimeScale = 1000
};



struct QTSDataRateHistoryParams {
    UInt32                          changeSeed;
    UInt32                          millisecondsBetweenElements;
    UInt32                          numberOfIntervals;
    UInt32 *                        elements;                   /* in bits/sec; callee allocates; caller must dispose */

};
typedef struct QTSDataRateHistoryParams QTSDataRateHistoryParams;

struct QTSCanHandleSendDataTypeParams {
    SInt32                          modifierTypeOrInputID;
    Boolean                         isModifierType;
    Boolean                         returnedCanHandleSendDataType; /* callee sets to true if it can handle it*/
};
typedef struct QTSCanHandleSendDataTypeParams QTSCanHandleSendDataTypeParams;

struct QTSNameParams {
    SInt32                          maxNameLength;
    SInt32                          requestedLanguage;
    SInt32                          returnedActualLanguage;
    unsigned char *                 returnedName;               /* pascal string; caller supplies*/
};
typedef struct QTSNameParams            QTSNameParams;

struct QTSLostPercentParams {
    UInt32                          receivedPkts;
    UInt32                          lostPkts;
    Fixed                           percent;
};
typedef struct QTSLostPercentParams     QTSLostPercentParams;

struct QTSDimensionParams {
    Fixed                           width;
    Fixed                           height;
};
typedef struct QTSDimensionParams       QTSDimensionParams;

struct QTSVolumesParams {
    SInt16                          leftVolume;
    SInt16                          rightVolume;
};
typedef struct QTSVolumesParams         QTSVolumesParams;

struct QTSGraphicsModeParams {
    SInt16                          graphicsMode;
    RGBColor                        opColor;
};
typedef struct QTSGraphicsModeParams    QTSGraphicsModeParams;

struct QTSGetURLLinkRecord {
    Point                           displayWhere;
    Handle                          returnedURLLink;
};
typedef struct QTSGetURLLinkRecord      QTSGetURLLinkRecord;
/*-----------------------------------------
    Characteristics
-----------------------------------------*/
/* characteristics in Movies.h work here too */
enum {
    kQTSSupportsPerStreamControlCharacteristic = FOUR_CHAR_CODE('psct')
};


struct QTSVideoParams {
    Fixed                           width;
    Fixed                           height;
    MatrixRecord                    matrix;
    CGrafPtr                        gWorld;
    GDHandle                        gdHandle;
    RgnHandle                       clip;
    short                           graphicsMode;
    RGBColor                        opColor;
};
typedef struct QTSVideoParams           QTSVideoParams;

struct QTSAudioParams {
    SInt16                          leftVolume;
    SInt16                          rightVolume;
    SInt16                          bassLevel;
    SInt16                          trebleLevel;
    short                           frequencyBandsCount;
    void *                          frequencyBands;
    Boolean                         levelMeteringEnabled;
};
typedef struct QTSAudioParams           QTSAudioParams;

struct QTSMediaParams {
    QTSVideoParams                  v;
    QTSAudioParams                  a;
};
typedef struct QTSMediaParams           QTSMediaParams;
enum {
    kQTSMustDraw                = 1 << 3,
    kQTSAtEnd                   = 1 << 4,
    kQTSPreflightDraw           = 1 << 5,
    kQTSSyncDrawing             = 1 << 6
};

/* media task result flags */
enum {
    kQTSDidDraw                 = 1 << 0,
    kQTSNeedsToDraw             = 1 << 2,
    kQTSDrawAgain               = 1 << 3,
    kQTSPartialDraw             = 1 << 4
};

/*============================================================================
        Notifications
============================================================================*/
typedef CALLBACK_API( ComponentResult , QTSNotificationProcPtr )(ComponentResult inErr, OSType inNotificationType, void *inNotificationParams, void *inRefCon);
typedef STACK_UPP_TYPE(QTSNotificationProcPtr)                  QTSNotificationUPP;
/* ------ notification types ------ */
enum {
    kQTSNullNotification        = FOUR_CHAR_CODE('null'),       /* NULL */
    kQTSErrorNotification       = FOUR_CHAR_CODE('err '),       /* QTSErrorParams*, optional */
    kQTSNewPresDetectedNotification = FOUR_CHAR_CODE('newp'),   /* QTSNewPresDetectedParams* */
    kQTSPresBeginChangingNotification = FOUR_CHAR_CODE('prcb'), /* NULL */
    kQTSPresDoneChangingNotification = FOUR_CHAR_CODE('prcd'),  /* NULL */
    kQTSPresentationChangedNotification = FOUR_CHAR_CODE('prch'), /* NULL */
    kQTSNewStreamNotification   = FOUR_CHAR_CODE('stnw'),       /* QTSNewStreamParams* */
    kQTSStreamBeginChangingNotification = FOUR_CHAR_CODE('stcb'), /* QTSStream */
    kQTSStreamDoneChangingNotification = FOUR_CHAR_CODE('stcd'), /* QTSStream */
    kQTSStreamChangedNotification = FOUR_CHAR_CODE('stch'),     /* QTSStreamChangedParams* */
    kQTSStreamGoneNotification  = FOUR_CHAR_CODE('stgn'),       /* QTSStreamGoneParams* */
    kQTSPreviewAckNotification  = FOUR_CHAR_CODE('pvak'),       /* QTSStream */
    kQTSPrerollAckNotification  = FOUR_CHAR_CODE('pack'),       /* QTSStream */
    kQTSStartAckNotification    = FOUR_CHAR_CODE('sack'),       /* QTSStream */
    kQTSStopAckNotification     = FOUR_CHAR_CODE('xack'),       /* QTSStream */
    kQTSStatusNotification      = FOUR_CHAR_CODE('stat'),       /* QTSStatusParams* */
    kQTSURLNotification         = FOUR_CHAR_CODE('url '),       /* QTSURLParams* */
    kQTSDurationNotification    = FOUR_CHAR_CODE('dura'),       /* QTSDurationAtom* */
    kQTSNewPresentationNotification = FOUR_CHAR_CODE('nprs'),   /* QTSPresentation */
    kQTSPresentationGoneNotification = FOUR_CHAR_CODE('xprs'),  /* QTSPresentation */
    kQTSServerNameNotification  = FOUR_CHAR_CODE('snam'),       /* const char * */
    kQTSPresentationDoneNotification = FOUR_CHAR_CODE('pdon'),  /* NULL */
    kQTSBandwidthAlertNotification = FOUR_CHAR_CODE('bwal'),    /* QTSBandwidthAlertParams* */
    kQTSAnnotationsChangedNotification = FOUR_CHAR_CODE('meta') /* NULL */
};


/* flags for QTSErrorParams */
enum {
    kQTSFatalErrorFlag          = 0x00000001
};


struct QTSErrorParams {
    const char *                    errorString;
    SInt32                          flags;
};
typedef struct QTSErrorParams           QTSErrorParams;

struct QTSNewPresDetectedParams {
    void *                          data;
};
typedef struct QTSNewPresDetectedParams QTSNewPresDetectedParams;

struct QTSNewStreamParams {
    QTSStream                       stream;
};
typedef struct QTSNewStreamParams       QTSNewStreamParams;

struct QTSStreamChangedParams {
    QTSStream                       stream;
    ComponentInstance               mediaComponent;             /* could be NULL */
};
typedef struct QTSStreamChangedParams   QTSStreamChangedParams;

struct QTSStreamGoneParams {
    QTSStream                       stream;
};
typedef struct QTSStreamGoneParams      QTSStreamGoneParams;

struct QTSStatusParams {
    UInt32                          status;
    const char *                    statusString;
    UInt32                          detailedStatus;
    const char *                    detailedStatusString;
};
typedef struct QTSStatusParams          QTSStatusParams;

struct QTSInfoParams {
    OSType                          infoType;
    void *                          infoParams;
};
typedef struct QTSInfoParams            QTSInfoParams;

struct QTSURLParams {
    UInt32                          urlLength;
    const char *                    url;
};
typedef struct QTSURLParams             QTSURLParams;
enum {
    kQTSBandwidthAlertNeedToStop = 1 << 0,
    kQTSBandwidthAlertRestartAt = 1 << 1
};


struct QTSBandwidthAlertParams {
    long                            flags;
    TimeValue                       restartAt;                  /* new field in QT 4.1*/
    void *                          reserved;
};
typedef struct QTSBandwidthAlertParams  QTSBandwidthAlertParams;
/*============================================================================
        Presentation
============================================================================*/
/*-----------------------------------------
     Flags
-----------------------------------------*/
/* flags for NewPresentationFromData */
enum {
    kQTSAutoModeFlag            = 0x00000001,
    kQTSDontShowStatusFlag      = 0x00000008,
    kQTSSendMediaFlag           = 0x00010000,
    kQTSReceiveMediaFlag        = 0x00020000
};


struct QTSNewPresentationParams {
    OSType                          dataType;
    const void *                    data;
    UInt32                          dataLength;
    QTSEditListHandle               editList;
    SInt32                          flags;
    TimeScale                       timeScale;                  /* set to 0 for default timescale */
    QTSMediaParams *                mediaParams;
    QTSNotificationUPP              notificationProc;
    void *                          notificationRefCon;
};
typedef struct QTSNewPresentationParams QTSNewPresentationParams;

struct QTSPresIdleParams {
    QTSStream                       stream;
    TimeValue64                     movieTimeToDisplay;
    SInt32                          flagsIn;
    SInt32                          flagsOut;
};
typedef struct QTSPresIdleParams        QTSPresIdleParams;
/*-----------------------------------------
    Toolbox Init/Close
-----------------------------------------*/
/* all "apps" must call this */
#if CALL_NOT_IN_CARBON
EXTERN_API_C( OSErr )
InitializeQTS                   (void);

EXTERN_API_C( OSErr )
TerminateQTS                    (void);

/*-----------------------------------------
    Presentation Functions
-----------------------------------------*/
EXTERN_API_C( OSErr )
QTSNewPresentation              (const QTSNewPresentationParams * inParams,
                                 QTSPresentation *      outPresentation);

EXTERN_API_C( OSErr )
QTSDisposePresentation          (QTSPresentation        inPresentation,
                                 SInt32                 inFlags);

EXTERN_API_C( void )
QTSPresIdle                     (QTSPresentation        inPresentation,
                                 QTSPresIdleParams *    ioParams);

EXTERN_API_C( OSErr )
QTSPresInvalidateRegion         (QTSPresentation        inPresentation,
                                 RgnHandle              inRegion);

/*-----------------------------------------
    Presentation Configuration
-----------------------------------------*/
EXTERN_API_C( OSErr )
QTSPresSetFlags                 (QTSPresentation        inPresentation,
                                 SInt32                 inFlags,
                                 SInt32                 inFlagsMask);

EXTERN_API_C( OSErr )
QTSPresGetFlags                 (QTSPresentation        inPresentation,
                                 SInt32 *               outFlags);

EXTERN_API_C( OSErr )
QTSPresGetTimeBase              (QTSPresentation        inPresentation,
                                 TimeBase *             outTimeBase);

EXTERN_API_C( OSErr )
QTSPresGetTimeScale             (QTSPresentation        inPresentation,
                                 TimeScale *            outTimeScale);

EXTERN_API_C( OSErr )
QTSPresSetInfo                  (QTSPresentation        inPresentation,
                                 QTSStream              inStream,
                                 OSType                 inSelector,
                                 void *                 ioParam);

EXTERN_API_C( OSErr )
QTSPresGetInfo                  (QTSPresentation        inPresentation,
                                 QTSStream              inStream,
                                 OSType                 inSelector,
                                 void *                 ioParam);

EXTERN_API_C( OSErr )
QTSPresHasCharacteristic        (QTSPresentation        inPresentation,
                                 QTSStream              inStream,
                                 OSType                 inCharacteristic,
                                 Boolean *              outHasIt);

EXTERN_API_C( OSErr )
QTSPresSetNotificationProc      (QTSPresentation        inPresentation,
                                 QTSNotificationUPP     inNotificationProc,
                                 void *                 inRefCon);

EXTERN_API_C( OSErr )
QTSPresGetNotificationProc      (QTSPresentation        inPresentation,
                                 QTSNotificationUPP *   outNotificationProc,
                                 void **                outRefCon);

/*-----------------------------------------
    Presentation Control
-----------------------------------------*/
EXTERN_API_C( OSErr )
QTSPresPreroll                  (QTSPresentation        inPresentation,
                                 QTSStream              inStream,
                                 UInt32                 inTimeValue,
                                 Fixed                  inRate,
                                 SInt32                 inFlags);

EXTERN_API_C( OSErr )
QTSPresPreroll64                (QTSPresentation        inPresentation,
                                 QTSStream              inStream,
                                 const TimeValue64 *    inPrerollTime,
                                 Fixed                  inRate,
                                 SInt32                 inFlags);

EXTERN_API_C( OSErr )
QTSPresStart                    (QTSPresentation        inPresentation,
                                 QTSStream              inStream,
                                 SInt32                 inFlags);

EXTERN_API_C( OSErr )
QTSPresSkipTo                   (QTSPresentation        inPresentation,
                                 UInt32                 inTimeValue);

EXTERN_API_C( OSErr )
QTSPresSkipTo64                 (QTSPresentation        inPresentation,
                                 const TimeValue64 *    inTimeValue);

EXTERN_API_C( OSErr )
QTSPresStop                     (QTSPresentation        inPresentation,
                                 QTSStream              inStream,
                                 SInt32                 inFlags);

/*============================================================================
        Streams
============================================================================*/
/*-----------------------------------------
    Stream Functions
-----------------------------------------*/
EXTERN_API_C( OSErr )
QTSPresNewStream                (QTSPresentation        inPresentation,
                                 OSType                 inDataType,
                                 const void *           inData,
                                 UInt32                 inDataLength,
                                 SInt32                 inFlags,
                                 QTSStream *            outStream);

EXTERN_API_C( OSErr )
QTSDisposeStream                (QTSStream              inStream,
                                 SInt32                 inFlags);

EXTERN_API_C( UInt32 )
QTSPresGetNumStreams            (QTSPresentation        inPresentation);

EXTERN_API_C( QTSStream )
QTSPresGetIndStream             (QTSPresentation        inPresentation,
                                 UInt32                 inIndex);

EXTERN_API_C( QTSPresentation )
QTSGetStreamPresentation        (QTSStream              inStream);

EXTERN_API_C( OSErr )
QTSPresSetPreferredRate         (QTSPresentation        inPresentation,
                                 Fixed                  inRate,
                                 SInt32                 inFlags);

EXTERN_API_C( OSErr )
QTSPresGetPreferredRate         (QTSPresentation        inPresentation,
                                 Fixed *                outRate);

EXTERN_API_C( OSErr )
QTSPresSetEnable                (QTSPresentation        inPresentation,
                                 QTSStream              inStream,
                                 Boolean                inEnableMode);

EXTERN_API_C( OSErr )
QTSPresGetEnable                (QTSPresentation        inPresentation,
                                 QTSStream              inStream,
                                 Boolean *              outEnableMode);

EXTERN_API_C( OSErr )
QTSPresSetPresenting            (QTSPresentation        inPresentation,
                                 QTSStream              inStream,
                                 Boolean                inPresentingMode);

EXTERN_API_C( OSErr )
QTSPresGetPresenting            (QTSPresentation        inPresentation,
                                 QTSStream              inStream,
                                 Boolean *              outPresentingMode);

EXTERN_API_C( OSErr )
QTSPresSetActiveSegment         (QTSPresentation        inPresentation,
                                 QTSStream              inStream,
                                 const TimeValue64 *    inStartTime,
                                 const TimeValue64 *    inDuration);

EXTERN_API_C( OSErr )
QTSPresGetActiveSegment         (QTSPresentation        inPresentation,
                                 QTSStream              inStream,
                                 TimeValue64 *          outStartTime,
                                 TimeValue64 *          outDuration);

EXTERN_API_C( OSErr )
QTSPresSetPlayHints             (QTSPresentation        inPresentation,
                                 QTSStream              inStream,
                                 SInt32                 inFlags,
                                 SInt32                 inFlagsMask);

EXTERN_API_C( OSErr )
QTSPresGetPlayHints             (QTSPresentation        inPresentation,
                                 QTSStream              inStream,
                                 SInt32 *               outFlags);

/*-----------------------------------------
    Stream Spatial Functions
-----------------------------------------*/
EXTERN_API_C( OSErr )
QTSPresSetGWorld                (QTSPresentation        inPresentation,
                                 QTSStream              inStream,
                                 CGrafPtr               inGWorld,
                                 GDHandle               inGDHandle);

EXTERN_API_C( OSErr )
QTSPresGetGWorld                (QTSPresentation        inPresentation,
                                 QTSStream              inStream,
                                 CGrafPtr *             outGWorld,
                                 GDHandle *             outGDHandle);

EXTERN_API_C( OSErr )
QTSPresSetClip                  (QTSPresentation        inPresentation,
                                 QTSStream              inStream,
                                 RgnHandle              inClip);

EXTERN_API_C( OSErr )
QTSPresGetClip                  (QTSPresentation        inPresentation,
                                 QTSStream              inStream,
                                 RgnHandle *            outClip);

EXTERN_API_C( OSErr )
QTSPresSetMatrix                (QTSPresentation        inPresentation,
                                 QTSStream              inStream,
                                 const MatrixRecord *   inMatrix);

EXTERN_API_C( OSErr )
QTSPresGetMatrix                (QTSPresentation        inPresentation,
                                 QTSStream              inStream,
                                 MatrixRecord *         outMatrix);

EXTERN_API_C( OSErr )
QTSPresSetDimensions            (QTSPresentation        inPresentation,
                                 QTSStream              inStream,
                                 Fixed                  inWidth,
                                 Fixed                  inHeight);

EXTERN_API_C( OSErr )
QTSPresGetDimensions            (QTSPresentation        inPresentation,
                                 QTSStream              inStream,
                                 Fixed *                outWidth,
                                 Fixed *                outHeight);

EXTERN_API_C( OSErr )
QTSPresSetGraphicsMode          (QTSPresentation        inPresentation,
                                 QTSStream              inStream,
                                 short                  inMode,
                                 const RGBColor *       inOpColor);

EXTERN_API_C( OSErr )
QTSPresGetGraphicsMode          (QTSPresentation        inPresentation,
                                 QTSStream              inStream,
                                 short *                outMode,
                                 RGBColor *             outOpColor);

EXTERN_API_C( OSErr )
QTSPresGetPicture               (QTSPresentation        inPresentation,
                                 QTSStream              inStream,
                                 PicHandle *            outPicture);

/*-----------------------------------------
    Stream Sound Functions
-----------------------------------------*/
EXTERN_API_C( OSErr )
QTSPresSetVolumes               (QTSPresentation        inPresentation,
                                 QTSStream              inStream,
                                 short                  inLeftVolume,
                                 short                  inRightVolume);

EXTERN_API_C( OSErr )
QTSPresGetVolumes               (QTSPresentation        inPresentation,
                                 QTSStream              inStream,
                                 short *                outLeftVolume,
                                 short *                outRightVolume);


/*============================================================================
        Misc
============================================================================*/
/* flags for Get/SetNetworkAppName */
#endif  /* CALL_NOT_IN_CARBON */

enum {
    kQTSNetworkAppNameIsFullNameFlag = 0x00000001
};

#if CALL_NOT_IN_CARBON
EXTERN_API_C( OSErr )
QTSSetNetworkAppName            (const char *           inAppName,
                                 SInt32                 inFlags);

EXTERN_API_C( OSErr )
QTSGetNetworkAppName            (SInt32                 inFlags,
                                 char **                outCStringPtr);


/*-----------------------------------------
    Statistics Utilities
-----------------------------------------*/
#endif  /* CALL_NOT_IN_CARBON */


struct QTSStatHelperRecord {
    long                            data[1];
};
typedef struct QTSStatHelperRecord      QTSStatHelperRecord;

typedef QTSStatHelperRecord *           QTSStatHelper;
enum {
    kQTSInvalidStatHelper       = 0L
};

/* flags for QTSStatHelperNextParams */
enum {
    kQTSStatHelperReturnPascalStringsFlag = 0x00000001
};


struct QTSStatHelperNextParams {
    SInt32                          flags;
    OSType                          returnedStatisticsType;
    QTSStream                       returnedStream;
    UInt32                          maxStatNameLength;
    char *                          returnedStatName;           /* NULL if you don't want it*/
    UInt32                          maxStatStringLength;
    char *                          returnedStatString;         /* NULL if you don't want it*/
    UInt32                          maxStatUnitLength;
    char *                          returnedStatUnit;           /* NULL if you don't want it*/
};
typedef struct QTSStatHelperNextParams  QTSStatHelperNextParams;

struct QTSStatisticsParams {
    OSType                          statisticsType;
    QTAtomContainer                 container;
    QTAtom                          parentAtom;
    SInt32                          flags;
};
typedef struct QTSStatisticsParams      QTSStatisticsParams;
/* general statistics types */
enum {
    kQTSAllStatisticsType       = FOUR_CHAR_CODE('all '),
    kQTSShortStatisticsType     = FOUR_CHAR_CODE('shrt'),
    kQTSSummaryStatisticsType   = FOUR_CHAR_CODE('summ')
};

/* statistics flags */
enum {
    kQTSGetNameStatisticsFlag   = 0x00000001,
    kQTSDontGetDataStatisticsFlag = 0x00000002,
    kQTSUpdateAtomsStatisticsFlag = 0x00000004,
    kQTSGetUnitsStatisticsFlag  = 0x00000008
};

/* statistics atom types */
enum {
    kQTSStatisticsStreamAtomType = FOUR_CHAR_CODE('strm'),
    kQTSStatisticsNameAtomType  = FOUR_CHAR_CODE('name'),       /* chars only, no length or terminator */
    kQTSStatisticsDataFormatAtomType = FOUR_CHAR_CODE('frmt'),  /* OSType */
    kQTSStatisticsDataAtomType  = FOUR_CHAR_CODE('data'),
    kQTSStatisticsUnitsAtomType = FOUR_CHAR_CODE('unit'),       /* OSType */
    kQTSStatisticsUnitsNameAtomType = FOUR_CHAR_CODE('unin')    /* chars only, no length or terminator */
};

/* statistics data formats */
enum {
    kQTSStatisticsSInt32DataFormat = FOUR_CHAR_CODE('si32'),
    kQTSStatisticsUInt32DataFormat = FOUR_CHAR_CODE('ui32'),
    kQTSStatisticsSInt16DataFormat = FOUR_CHAR_CODE('si16'),
    kQTSStatisticsUInt16DataFormat = FOUR_CHAR_CODE('ui16'),
    kQTSStatisticsFixedDataFormat = FOUR_CHAR_CODE('fixd'),
    kQTSStatisticsStringDataFormat = FOUR_CHAR_CODE('strg'),
    kQTSStatisticsOSTypeDataFormat = FOUR_CHAR_CODE('ostp')
};

/* statistics units types */
enum {
    kQTSStatisticsNoUnitsType   = 0,
    kQTSStatisticsPercentUnitsType = FOUR_CHAR_CODE('pcnt'),
    kQTSStatisticsBitsPerSecUnitsType = FOUR_CHAR_CODE('bps '),
    kQTSStatisticsFramesPerSecUnitsType = FOUR_CHAR_CODE('fps ')
};

/* specific statistics types */
enum {
    kQTSTotalDataRateStat       = FOUR_CHAR_CODE('drtt'),
    kQTSTotalDataRateInStat     = FOUR_CHAR_CODE('drti'),
    kQTSTotalDataRateOutStat    = FOUR_CHAR_CODE('drto')
};

#if CALL_NOT_IN_CARBON
EXTERN_API_C( OSErr )
QTSNewStatHelper                (QTSPresentation        inPresentation,
                                 QTSStream              inStream,
                                 OSType                 inStatType,
                                 SInt32                 inFlags,
                                 QTSStatHelper *        outStatHelper);

EXTERN_API_C( OSErr )
QTSDisposeStatHelper            (QTSStatHelper          inStatHelper);

EXTERN_API_C( OSErr )
QTSStatHelperGetStats           (QTSStatHelper          inStatHelper);

EXTERN_API_C( OSErr )
QTSStatHelperResetIter          (QTSStatHelper          inStatHelper);

EXTERN_API_C( Boolean )
QTSStatHelperNext               (QTSStatHelper          inStatHelper,
                                 QTSStatHelperNextParams * ioParams);

EXTERN_API_C( UInt32 )
QTSStatHelperGetNumStats        (QTSStatHelper          inStatHelper);

/* used by components to put statistics into the atom container */
EXTERN_API_C( OSErr )
QTSGetOrMakeStatAtomForStream   (QTAtomContainer        inContainer,
                                 QTSStream              inStream,
                                 QTAtom *               outParentAtom);

EXTERN_API_C( OSErr )
QTSInsertStatistic              (QTAtomContainer        inContainer,
                                 QTAtom                 inParentAtom,
                                 OSType                 inStatType,
                                 void *                 inStatData,
                                 UInt32                 inStatDataLength,
                                 OSType                 inStatDataFormat,
                                 SInt32                 inFlags);

EXTERN_API_C( OSErr )
QTSInsertStatisticName          (QTAtomContainer        inContainer,
                                 QTAtom                 inParentAtom,
                                 OSType                 inStatType,
                                 const char *           inStatName,
                                 UInt32                 inStatNameLength);

EXTERN_API_C( OSErr )
QTSInsertStatisticUnits         (QTAtomContainer        inContainer,
                                 QTAtom                 inParentAtom,
                                 OSType                 inStatType,
                                 OSType                 inUnitsType,
                                 const char *           inUnitsName,
                                 UInt32                 inUnitsNameLength);

/*============================================================================
        Data Formats
============================================================================*/
/*-----------------------------------------
    Data Types
-----------------------------------------*/
/* universal data types */
#endif  /* CALL_NOT_IN_CARBON */

enum {
    kQTSNullDataType            = FOUR_CHAR_CODE('NULL'),
    kQTSUnknownDataType         = FOUR_CHAR_CODE('huh?'),
    kQTSAtomContainerDataType   = FOUR_CHAR_CODE('qtac'),       /* QTAtomContainer */
    kQTSAtomDataType            = FOUR_CHAR_CODE('qtat'),       /* QTSAtomContainerDataStruct* */
    kQTSAliasDataType           = FOUR_CHAR_CODE('alis'),
    kQTSFileDataType            = FOUR_CHAR_CODE('fspc')
};

/* these data types are specific to presentations */
enum {
    kQTSRTSPDataType            = FOUR_CHAR_CODE('rtsp'),
    kQTSSDPDataType             = FOUR_CHAR_CODE('sdp ')
};

/*-----------------------------------------
    Atom IDs
-----------------------------------------*/
enum {
    kQTSPresentationAID         = FOUR_CHAR_CODE('pres'),
    kQTSPresentationHeaderAID   = FOUR_CHAR_CODE('phdr'),       /* QTSPresentationHeaderAtom */
    kQTSMediaStreamAID          = FOUR_CHAR_CODE('mstr'),
    kQTSMediaStreamHeaderAID    = FOUR_CHAR_CODE('mshd'),       /* QTSMediaStreamHeaderAtom */
    kQTSMediaDescriptionTextAID = FOUR_CHAR_CODE('mdes'),       /* text, no length */
    kQTSClipRectAID             = FOUR_CHAR_CODE('clip'),       /* QTSClipRectAtom */
    kQTSDurationAID             = FOUR_CHAR_CODE('dura'),       /* QTSDurationAtom */
    kQTSBufferTimeAID           = FOUR_CHAR_CODE('bufr')        /* QTSBufferTimeAtom */
};


struct QTSAtomContainerDataStruct {
    QTAtomContainer                 container;
    QTAtom                          parentAtom;
};
typedef struct QTSAtomContainerDataStruct QTSAtomContainerDataStruct;
/* flags for QTSPresentationHeaderAtom */
enum {
    kQTSPresHeaderTypeIsData    = 0x00000100,
    kQTSPresHeaderDataIsHandle  = 0x00000200
};


struct QTSPresentationHeaderAtom {
    SInt32                          versionAndFlags;
    OSType                          conductorOrDataType;
    OSType                          dataAtomType;               /* where the data really is*/
};
typedef struct QTSPresentationHeaderAtom QTSPresentationHeaderAtom;

struct QTSMediaStreamHeaderAtom {
    SInt32                          versionAndFlags;
    OSType                          mediaTransportType;
    OSType                          mediaTransportDataAID;      /* where the data really is*/
};
typedef struct QTSMediaStreamHeaderAtom QTSMediaStreamHeaderAtom;

struct QTSBufferTimeAtom {
    SInt32                          versionAndFlags;
    Fixed                           bufferTime;
};
typedef struct QTSBufferTimeAtom        QTSBufferTimeAtom;

struct QTSDurationAtom {
    SInt32                          versionAndFlags;
    TimeScale                       timeScale;
    TimeValue64                     duration;
};
typedef struct QTSDurationAtom          QTSDurationAtom;

struct QTSClipRectAtom {
    SInt32                          versionAndFlags;
    Rect                            clipRect;
};
typedef struct QTSClipRectAtom          QTSClipRectAtom;
enum {
    kQTSEmptyEditStreamStartTime = -1
};



typedef UInt32                          QTSStatus;
enum {
    kQTSNullStatus              = 0,
    kQTSUninitializedStatus     = 1,
    kQTSConnectingStatus        = 2,
    kQTSOpeningConnectionDetailedStatus = 3,
    kQTSMadeConnectionDetailedStatus = 4,
    kQTSNegotiatingStatus       = 5,
    kQTSGettingDescriptionDetailedStatus = 6,
    kQTSGotDescriptionDetailedStatus = 7,
    kQTSSentSetupCmdDetailedStatus = 8,
    kQTSReceivedSetupResponseDetailedStatus = 9,
    kQTSSentPlayCmdDetailedStatus = 10,
    kQTSReceivedPlayResponseDetailedStatus = 11,
    kQTSBufferingStatus         = 12,
    kQTSPlayingStatus           = 13,
    kQTSPausedStatus            = 14,
    kQTSAutoConfiguringStatus   = 15,
    kQTSDownloadingStatus       = 16,
    kQTSWaitingDisconnectStatus = 100
};

/*-----------------------------------------
    QuickTime Preferences Types
-----------------------------------------*/
enum {
    kQTSConnectionPrefsType     = FOUR_CHAR_CODE('stcm'),       /* root atom that all other atoms are contained in*/
                                                                /*    kQTSNotUsedForProxyPrefsType = 'nopr',     //        comma-delimited list of URLs that are never used for proxies*/
    kQTSConnectionMethodPrefsType = FOUR_CHAR_CODE('mthd'),     /*      connection method (OSType that matches one of the following three)*/
    kQTSDirectConnectPrefsType  = FOUR_CHAR_CODE('drct'),       /*       used if direct connect (QTSDirectConnectPrefsRecord)*/
                                                                /*    kQTSRTSPProxyPrefsType =     'rtsp',   //   used if RTSP Proxy (QTSProxyPrefsRecord)*/
    kQTSSOCKSPrefsType          = FOUR_CHAR_CODE('sock')        /*       used if SOCKS Proxy (QTSProxyPrefsRecord)*/
};

enum {
    kQTSDirectConnectHTTPProtocol = FOUR_CHAR_CODE('http'),
    kQTSDirectConnectRTSPProtocol = FOUR_CHAR_CODE('rtsp')
};


struct QTSDirectConnectPrefsRecord {
    UInt32                          tcpPortID;
    OSType                          protocol;
};
typedef struct QTSDirectConnectPrefsRecord QTSDirectConnectPrefsRecord;

struct QTSProxyPrefsRecord {
    Str255                          serverNameStr;
    UInt32                          portID;
};
typedef struct QTSProxyPrefsRecord      QTSProxyPrefsRecord;
#define kQTSTransAndProxyPrefsVersNum       2       // prefs atom format version
enum {
    kConnectionActive           = (1L << 0),
    kConnectionUseSystemPref    = (1L << 1)
};


struct QTSTransportPref {
    OSType                          protocol;                   /* udp, http, tcp, etc*/
    SInt32                          portID;                     /* port to use for this connection type*/
    UInt32                          flags;                      /* connection flags*/
    UInt32                          seed;                       /* seed value last time this setting was read from system prefs*/
};
typedef struct QTSTransportPref         QTSTransportPref;
enum {
    kProxyActive                = (1L << 0),
    kProxyUseSystemPref         = (1L << 1)
};


struct QTSProxyPref {
    UInt32                          flags;                      /* proxy flags*/
    SInt32                          portID;                     /* port to use for this connection type*/
    UInt32                          seed;                       /* seed value last time this setting was read from system prefs*/
    Str255                          serverNameStr;              /* proxy server url*/
};
typedef struct QTSProxyPref             QTSProxyPref;
enum {
    kNoProxyUseSystemPref       = (1L << 0)
};


struct QTSNoProxyPref {
    UInt32                          flags;                      /* no-proxy flags*/
    UInt32                          seed;                       /* seed value last time this setting was read from system prefs*/
    char                            urlList[1];                 /* NULL terminated, comma delimited list of urls*/
};
typedef struct QTSNoProxyPref           QTSNoProxyPref;
enum {
    kQTSTransAndProxyAtomType   = FOUR_CHAR_CODE('strp'),       /* transport/proxy prefs root atom*/
    kQTSConnectionPrefsVersion  = FOUR_CHAR_CODE('vers'),       /*   prefs format version*/
    kQTSTransportPrefsAtomType  = FOUR_CHAR_CODE('trns'),       /*   tranport prefs root atom*/
    kQTSConnectionAtomType      = FOUR_CHAR_CODE('conn'),       /*     connection prefs atom type, one for each transport type*/
    kQTSUDPTransportType        = FOUR_CHAR_CODE('udp '),       /*     udp transport prefs*/
    kQTSHTTPTransportType       = FOUR_CHAR_CODE('http'),       /*     http transport prefs*/
    kQTSTCPTransportType        = FOUR_CHAR_CODE('tcp '),       /*     tcp transport prefs    */
    kQTSProxyPrefsAtomType      = FOUR_CHAR_CODE('prxy'),       /*   proxy prefs root atom*/
    kQTSHTTPProxyPrefsType      = FOUR_CHAR_CODE('http'),       /*     http proxy settings*/
    kQTSRTSPProxyPrefsType      = FOUR_CHAR_CODE('rtsp'),       /*     rtsp proxy settings*/
    kQTSSOCKSProxyPrefsType     = FOUR_CHAR_CODE('scks'),       /*     socks proxy settings*/
    kQTSDontProxyPrefsAtomType  = FOUR_CHAR_CODE('nopr'),       /*   no-proxy prefs root atom*/
    kQTSDontProxyDataType       = FOUR_CHAR_CODE('data')        /*     no proxy settings*/
};

#if CALL_NOT_IN_CARBON
EXTERN_API_C( OSErr )
QTSPrefsAddProxySetting         (OSType                 proxyType,
                                 SInt32                 portID,
                                 UInt32                 flags,
                                 UInt32                 seed,
                                 Str255                 srvrURL);

EXTERN_API_C( OSErr )
QTSPrefsFindProxyByType         (OSType                 proxyType,
                                 UInt32                 flags,
                                 UInt32                 flagsMask,
                                 QTSProxyPref **        proxyHndl,
                                 SInt16 *               count);

EXTERN_API_C( OSErr )
QTSPrefsAddConnectionSetting    (OSType                 protocol,
                                 SInt32                 portID,
                                 UInt32                 flags,
                                 UInt32                 seed);

EXTERN_API_C( OSErr )
QTSPrefsFindConnectionByType    (OSType                 protocol,
                                 UInt32                 flags,
                                 UInt32                 flagsMask,
                                 QTSTransportPref **    connectionHndl,
                                 SInt16 *               count);

EXTERN_API_C( OSErr )
QTSPrefsGetActiveConnection     (OSType                 protocol,
                                 QTSTransportPref *     connectInfo);

EXTERN_API_C( OSErr )
QTSPrefsGetNoProxyURLs          (QTSNoProxyPref **      noProxyHndl);

EXTERN_API_C( OSErr )
QTSPrefsSetNoProxyURLs          (char *                 urls,
                                 UInt32                 flags,
                                 UInt32                 seed);



/*============================================================================
        Memory Management Services
============================================================================*/
/*
   These routines allocate normal pointers and handles,
   but do the correct checking, etc.
   Dispose using the normal DisposePtr and DisposeHandle
   Call these routines for one time memory allocations.
   You do not need to set any hints to use these calls.
*/

EXTERN_API_C( Ptr )
QTSNewPtr                       (UInt32                 inByteCount,
                                 SInt32                 inFlags,
                                 SInt32 *               outFlags);

EXTERN_API_C( Handle )
QTSNewHandle                    (UInt32                 inByteCount,
                                 SInt32                 inFlags,
                                 SInt32 *               outFlags);

#define QTSNewPtrClear(_s)      QTSNewPtr((_s), kQTSMemAllocClearMem, NULL)
#define QTSNewHandleClear(_s)   QTSNewHandle((_s), kQTSMemAllocClearMem, NULL)
/* flags in*/
#endif  /* CALL_NOT_IN_CARBON */

enum {
    kQTSMemAllocClearMem        = 0x00000001,
    kQTSMemAllocDontUseTempMem  = 0x00000002,
    kQTSMemAllocTryTempMemFirst = 0x00000004,
    kQTSMemAllocDontUseSystemMem = 0x00000008,
    kQTSMemAllocTrySystemMemFirst = 0x00000010,
    kQTSMemAllocHoldMemory      = 0x00001000,
    kQTSMemAllocIsInterruptTime = 0x01010000                    /* currently not supported for alloc*/
};

/* flags out*/
enum {
    kQTSMemAllocAllocatedInTempMem = 0x00000001,
    kQTSMemAllocAllocatedInSystemMem = 0x00000002
};

typedef struct OpaqueQTSMemPtr*         QTSMemPtr;
/*
   These routines are for buffers that will be recirculated
   you must use QTReleaseMemPtr instead of DisposePtr
   QTSReleaseMemPtr can be used at interrupt time
   but QTSAllocMemPtr currently cannot 
*/
#if CALL_NOT_IN_CARBON
EXTERN_API_C( QTSMemPtr )
QTSAllocMemPtr                  (UInt32                 inByteCount,
                                 SInt32                 inFlags);

EXTERN_API_C( void )
QTSReleaseMemPtr                (QTSMemPtr              inMemPtr,
                                 SInt32                 inFlags);


/*============================================================================
        Buffer Management Services
============================================================================*/
#endif  /* CALL_NOT_IN_CARBON */


struct QTSStreamBuffer {
    struct QTSStreamBuffer *        reserved1;
    struct QTSStreamBuffer *        reserved2;
    struct QTSStreamBuffer *        next;                       /* next message block in a message */
    unsigned char *                 rptr;                       /* first byte with real data in the DataBuffer */
    unsigned char *                 wptr;                       /* last+1 byte with real data in the DataBuffer */
    long                            reserved3;
    UInt32                          metadata[4];                /* usage defined by message sender */
    SInt32                          flags;                      /* reserved */
};
typedef struct QTSStreamBuffer          QTSStreamBuffer;
#if CALL_NOT_IN_CARBON
EXTERN_API_C( QTSStreamBuffer *)
QTSAllocBuffer                  (SInt32                 size);

EXTERN_API_C( void )
QTSFreeMessage                  (QTSStreamBuffer *      inStreamBuffer);

EXTERN_API_C( QTSStreamBuffer *)
QTSDupMessage                   (QTSStreamBuffer *      inStreamBuffer);

EXTERN_API_C( QTSStreamBuffer *)
QTSCopyMessage                  (QTSStreamBuffer *      inStreamBuffer);

EXTERN_API_C( QTSStreamBuffer *)
QTSFlattenMessage               (QTSStreamBuffer *      inStreamBuffer);

EXTERN_API_C( SInt32 )
QTSMessageLength                (QTSStreamBuffer *      inStreamBuffer);


/*============================================================================
        Misc
============================================================================*/
EXTERN_API_C( Boolean )
QTSGetErrorString               (SInt32                 inErrorCode,
                                 UInt32                 inMaxErrorStringLength,
                                 char *                 outErrorString,
                                 SInt32                 inFlags);


/* UPP call backs */
#endif  /* CALL_NOT_IN_CARBON */

#if OPAQUE_UPP_TYPES
#if CALL_NOT_IN_CARBON
    EXTERN_API(QTSNotificationUPP)
    NewQTSNotificationUPP          (QTSNotificationProcPtr  userRoutine);

    EXTERN_API(void)
    DisposeQTSNotificationUPP      (QTSNotificationUPP      userUPP);

    EXTERN_API(ComponentResult)
    InvokeQTSNotificationUPP       (ComponentResult         inErr,
                                    OSType                  inNotificationType,
                                    void *                  inNotificationParams,
                                    void *                  inRefCon,
                                    QTSNotificationUPP      userUPP);

#endif  /* CALL_NOT_IN_CARBON */

#else
    enum { uppQTSNotificationProcInfo = 0x00003FF0 };               /* pascal 4_bytes Func(4_bytes, 4_bytes, 4_bytes, 4_bytes) */
    #define NewQTSNotificationUPP(userRoutine)                      (QTSNotificationUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppQTSNotificationProcInfo, GetCurrentArchitecture())
    #define DisposeQTSNotificationUPP(userUPP)                      DisposeRoutineDescriptor(userUPP)
    #define InvokeQTSNotificationUPP(inErr, inNotificationType, inNotificationParams, inRefCon, userUPP)  (ComponentResult)CALL_FOUR_PARAMETER_UPP((userUPP), uppQTSNotificationProcInfo, (inErr), (inNotificationType), (inNotificationParams), (inRefCon))
#endif
/* support for pre-Carbon UPP routines: NewXXXProc and CallXXXProc */
#define NewQTSNotificationProc(userRoutine)                     NewQTSNotificationUPP(userRoutine)
#define CallQTSNotificationProc(userRoutine, inErr, inNotificationType, inNotificationParams, inRefCon) InvokeQTSNotificationUPP(inErr, inNotificationType, inNotificationParams, inRefCon, userRoutine)

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

#endif /* __QUICKTIMESTREAMING__ */

