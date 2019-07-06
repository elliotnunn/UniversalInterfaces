/*
     File:       Dialogs.h
 
     Contains:   Dialog Manager interfaces.
 
     Version:    Technology: Mac OS 9
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1985-2000 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __DIALOGS__
#define __DIALOGS__

#ifndef __MACTYPES__
#include <MacTypes.h>
#endif

#ifndef __MIXEDMODE__
#include <MixedMode.h>
#endif

#ifndef __EVENTS__
#include <Events.h>
#endif

#ifndef __MACWINDOWS__
#include <MacWindows.h>
#endif

#ifndef __TEXTEDIT__
#include <TextEdit.h>
#endif

#ifndef __CONTROLS__
#include <Controls.h>
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
                                                                /* new, more standard names for dialog item types*/
    kControlDialogItem          = 4,
    kButtonDialogItem           = kControlDialogItem | 0,
    kCheckBoxDialogItem         = kControlDialogItem | 1,
    kRadioButtonDialogItem      = kControlDialogItem | 2,
    kResourceControlDialogItem  = kControlDialogItem | 3,
    kStaticTextDialogItem       = 8,
    kEditTextDialogItem         = 16,
    kIconDialogItem             = 32,
    kPictureDialogItem          = 64,
    kUserDialogItem             = 0,
    kHelpDialogItem             = 1,
    kItemDisableBit             = 128
};

enum {
                                                                /* old names for dialog item types*/
    ctrlItem                    = 4,
    btnCtrl                     = 0,
    chkCtrl                     = 1,
    radCtrl                     = 2,
    resCtrl                     = 3,
    statText                    = 8,
    editText                    = 16,
    iconItem                    = 32,
    picItem                     = 64,
    userItem                    = 0,
    itemDisable                 = 128
};

enum {
                                                                /* standard dialog item numbers*/
    kStdOkItemIndex             = 1,
    kStdCancelItemIndex         = 2,                            /* old names*/
    ok                          = kStdOkItemIndex,
    cancel                      = kStdCancelItemIndex
};

enum {
                                                                /* standard icon resource id's    */
    kStopIcon                   = 0,
    kNoteIcon                   = 1,
    kCautionIcon                = 2,                            /* old names*/
    stopIcon                    = kStopIcon,
    noteIcon                    = kNoteIcon,
    cautionIcon                 = kCautionIcon
};




#if OLDROUTINENAMES
/*
   These constants lived briefly on ETO 16.  They suggest
   that there is only one index you can use for the OK 
   item, which is not true.  You can put the ok item 
   anywhere you want in the DITL.
*/
enum {
    kOkItemIndex                = 1,
    kCancelItemIndex            = 2
};

#endif  /* OLDROUTINENAMES */

/*  Dialog Item List Manipulation Constants */
typedef SInt16                          DITLMethod;
enum {
    overlayDITL                 = 0,
    appendDITLRight             = 1,
    appendDITLBottom            = 2
};

typedef SInt16                          StageList;
/* DialogPtr is obsolete. Use DialogRef instead.*/
typedef DialogPtr                       DialogRef;
#if !OPAQUE_TOOLBOX_STRUCTS

struct DialogRecord {
    WindowRecord                    window;                     /* in Carbon use GetDialogWindow or GetDialogPort*/
    Handle                          items;                      /* in Carbon use Get/SetDialogItem*/
    TEHandle                        textH;                      /* in Carbon use GetDialogTextEditHandle*/
    SInt16                          editField;                  /* in Carbon use SelectDialogItemText*/
    SInt16                          editOpen;                   /* not available in Carbon */
    SInt16                          aDefItem;                   /* in Carbon use Get/SetDialogDefaultItem*/
};
typedef struct DialogRecord             DialogRecord;

typedef DialogRecord *                  DialogPeek;
#endif  /* !OPAQUE_TOOLBOX_STRUCTS */


struct DialogTemplate {
    Rect                            boundsRect;
    SInt16                          procID;
    Boolean                         visible;
    Boolean                         filler1;
    Boolean                         goAwayFlag;
    Boolean                         filler2;
    SInt32                          refCon;
    SInt16                          itemsID;
    Str255                          title;
};
typedef struct DialogTemplate           DialogTemplate;

typedef DialogTemplate *                DialogTPtr;
typedef DialogTPtr *                    DialogTHndl;

struct AlertTemplate {
    Rect                            boundsRect;
    SInt16                          itemsID;
    StageList                       stages;
};
typedef struct AlertTemplate            AlertTemplate;

typedef AlertTemplate *                 AlertTPtr;
typedef AlertTPtr *                     AlertTHndl;
/* new type abstractions for the dialog manager */
typedef SInt16                          DialogItemIndexZeroBased;
typedef SInt16                          DialogItemIndex;
typedef SInt16                          DialogItemType;
/* dialog manager callbacks */
typedef CALLBACK_API( void , SoundProcPtr )(SInt16 soundNumber);
typedef CALLBACK_API( Boolean , ModalFilterProcPtr )(DialogRef theDialog, EventRecord *theEvent, DialogItemIndex *itemHit);
typedef CALLBACK_API( void , UserItemProcPtr )(DialogRef theDialog, DialogItemIndex itemNo);
typedef STACK_UPP_TYPE(SoundProcPtr)                            SoundUPP;
typedef STACK_UPP_TYPE(ModalFilterProcPtr)                      ModalFilterUPP;
typedef STACK_UPP_TYPE(UserItemProcPtr)                         UserItemUPP;
#if OPAQUE_UPP_TYPES
#if CALL_NOT_IN_CARBON
    EXTERN_API(SoundUPP)
    NewSoundUPP                    (SoundProcPtr            userRoutine);

#endif  /* CALL_NOT_IN_CARBON */

    EXTERN_API(ModalFilterUPP)
    NewModalFilterUPP              (ModalFilterProcPtr      userRoutine);

    EXTERN_API(UserItemUPP)
    NewUserItemUPP                 (UserItemProcPtr         userRoutine);

#if CALL_NOT_IN_CARBON
    EXTERN_API(void)
    DisposeSoundUPP                (SoundUPP                userUPP);

#endif  /* CALL_NOT_IN_CARBON */

    EXTERN_API(void)
    DisposeModalFilterUPP          (ModalFilterUPP          userUPP);

    EXTERN_API(void)
    DisposeUserItemUPP             (UserItemUPP             userUPP);

#if CALL_NOT_IN_CARBON
    EXTERN_API(void)
    InvokeSoundUPP                 (SInt16                  soundNumber,
                                    SoundUPP                userUPP);

#endif  /* CALL_NOT_IN_CARBON */

    EXTERN_API(Boolean)
    InvokeModalFilterUPP           (DialogRef               theDialog,
                                    EventRecord *           theEvent,
                                    DialogItemIndex *       itemHit,
                                    ModalFilterUPP          userUPP);

    EXTERN_API(void)
    InvokeUserItemUPP              (DialogRef               theDialog,
                                    DialogItemIndex         itemNo,
                                    UserItemUPP             userUPP);

#else
    enum { uppSoundProcInfo = 0x00000080 };                         /* pascal no_return_value Func(2_bytes) */
    enum { uppModalFilterProcInfo = 0x00000FD0 };                   /* pascal 1_byte Func(4_bytes, 4_bytes, 4_bytes) */
    enum { uppUserItemProcInfo = 0x000002C0 };                      /* pascal no_return_value Func(4_bytes, 2_bytes) */
    #define NewSoundUPP(userRoutine)                                (SoundUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppSoundProcInfo, GetCurrentArchitecture())
    #define NewModalFilterUPP(userRoutine)                          (ModalFilterUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppModalFilterProcInfo, GetCurrentArchitecture())
    #define NewUserItemUPP(userRoutine)                             (UserItemUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppUserItemProcInfo, GetCurrentArchitecture())
    #define DisposeSoundUPP(userUPP)                                DisposeRoutineDescriptor(userUPP)
    #define DisposeModalFilterUPP(userUPP)                          DisposeRoutineDescriptor(userUPP)
    #define DisposeUserItemUPP(userUPP)                             DisposeRoutineDescriptor(userUPP)
    #define InvokeSoundUPP(soundNumber, userUPP)                    CALL_ONE_PARAMETER_UPP((userUPP), uppSoundProcInfo, (soundNumber))
    #define InvokeModalFilterUPP(theDialog, theEvent, itemHit, userUPP)  (Boolean)CALL_THREE_PARAMETER_UPP((userUPP), uppModalFilterProcInfo, (theDialog), (theEvent), (itemHit))
    #define InvokeUserItemUPP(theDialog, itemNo, userUPP)           CALL_TWO_PARAMETER_UPP((userUPP), uppUserItemProcInfo, (theDialog), (itemNo))
#endif
/* support for pre-Carbon UPP routines: NewXXXProc and CallXXXProc */
#define NewSoundProc(userRoutine)                               NewSoundUPP(userRoutine)
#define NewModalFilterProc(userRoutine)                         NewModalFilterUPP(userRoutine)
#define NewUserItemProc(userRoutine)                            NewUserItemUPP(userRoutine)
#define CallSoundProc(userRoutine, soundNumber)                 InvokeSoundUPP(soundNumber, userRoutine)
#define CallModalFilterProc(userRoutine, theDialog, theEvent, itemHit) InvokeModalFilterUPP(theDialog, theEvent, itemHit, userRoutine)
#define CallUserItemProc(userRoutine, theDialog, itemNo)        InvokeUserItemUPP(theDialog, itemNo, userRoutine)

#if !TARGET_OS_MAC
/* QuickTime 3.0 */
typedef CALLBACK_API_C( void , QTModelessCallbackProcPtr )(EventRecord *theEvent, DialogRef theDialog, DialogItemIndex itemHit);
#if CALL_NOT_IN_CARBON
EXTERN_API( void )
SetModelessDialogCallbackProc   (DialogRef              theDialog,
                                 QTModelessCallbackProcPtr  callbackProc);

#endif  /* CALL_NOT_IN_CARBON */

typedef QTModelessCallbackProcPtr       QTModelessCallbackUPP;
#if CALL_NOT_IN_CARBON
EXTERN_API( OSErr )
GetDialogControlNotificationProc (void *                theProc);

EXTERN_API( void )
SetDialogMovableModal           (DialogRef              theDialog);

EXTERN_API( void *)
GetDialogParent                 (DialogRef              theDialog);

#endif  /* CALL_NOT_IN_CARBON */

#endif  /* !TARGET_OS_MAC */

/*
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
    • Following types are valid with Appearance 1.0 and later
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
*/
enum {
                                                                /* Alert types to pass into StandardAlert */
    kAlertStopAlert             = 0,
    kAlertNoteAlert             = 1,
    kAlertCautionAlert          = 2,
    kAlertPlainAlert            = 3
};

typedef SInt16                          AlertType;
enum {
    kAlertDefaultOKText         = -1,                           /* "OK"*/
    kAlertDefaultCancelText     = -1,                           /* "Cancel"*/
    kAlertDefaultOtherText      = -1                            /* "Don't Save"*/
};

/* StandardAlert alert button numbers */
enum {
    kAlertStdAlertOKButton      = 1,
    kAlertStdAlertCancelButton  = 2,
    kAlertStdAlertOtherButton   = 3,
    kAlertStdAlertHelpButton    = 4
};

enum {
                                                                /* Dialog Flags for use in NewFeaturesDialog or dlgx resource */
    kDialogFlagsUseThemeBackground = (1 << 0),
    kDialogFlagsUseControlHierarchy = (1 << 1),
    kDialogFlagsHandleMovableModal = (1 << 2),
    kDialogFlagsUseThemeControls = (1 << 3)
};

enum {
                                                                /* Alert Flags for use in alrx resource */
    kAlertFlagsUseThemeBackground = (1 << 0),
    kAlertFlagsUseControlHierarchy = (1 << 1),
    kAlertFlagsAlertIsMovable   = (1 << 2),
    kAlertFlagsUseThemeControls = (1 << 3)
};

/* For dftb resource */
enum {
    kDialogFontNoFontStyle      = 0,
    kDialogFontUseFontMask      = 0x0001,
    kDialogFontUseFaceMask      = 0x0002,
    kDialogFontUseSizeMask      = 0x0004,
    kDialogFontUseForeColorMask = 0x0008,
    kDialogFontUseBackColorMask = 0x0010,
    kDialogFontUseModeMask      = 0x0020,
    kDialogFontUseJustMask      = 0x0040,
    kDialogFontUseAllMask       = 0x00FF,
    kDialogFontAddFontSizeMask  = 0x0100,
    kDialogFontUseFontNameMask  = 0x0200,
    kDialogFontAddToMetaFontMask = 0x0400
};


struct AlertStdAlertParamRec {
    Boolean                         movable;                    /* Make alert movable modal */
    Boolean                         helpButton;                 /* Is there a help button? */
    ModalFilterUPP                  filterProc;                 /* Event filter */
    ConstStringPtr                  defaultText;                /* Text for button in OK position */
    ConstStringPtr                  cancelText;                 /* Text for button in cancel position */
    ConstStringPtr                  otherText;                  /* Text for button in left position */
    SInt16                          defaultButton;              /* Which button behaves as the default */
    SInt16                          cancelButton;               /* Which one behaves as cancel (can be 0) */
    UInt16                          position;                   /* Position (kWindowDefaultPosition in this case */
                                                                /* equals kWindowAlertPositionParentWindowScreen) */
};
typedef struct AlertStdAlertParamRec    AlertStdAlertParamRec;

typedef AlertStdAlertParamRec *         AlertStdAlertParamPtr;
/* ——— end Appearance 1.0 or later stuff*/


/*
    NOTE: Code running under MultiFinder or System 7.0 or newer
    should always pass NULL to InitDialogs.
*/
#if CALL_NOT_IN_CARBON
EXTERN_API( void )
InitDialogs                     (void *                 ignored)                            ONEWORDINLINE(0xA97B);

EXTERN_API( void )
ErrorSound                      (SoundUPP               soundProc)                          ONEWORDINLINE(0xA98C);

#endif  /* CALL_NOT_IN_CARBON */

EXTERN_API( DialogRef )
NewDialog                       (void *                 dStorage,
                                 const Rect *           boundsRect,
                                 ConstStr255Param       title,
                                 Boolean                visible,
                                 SInt16                 procID,
                                 WindowRef              behind,
                                 Boolean                goAwayFlag,
                                 SInt32                 refCon,
                                 Handle                 items)                              ONEWORDINLINE(0xA97D);

EXTERN_API( DialogRef )
GetNewDialog                    (SInt16                 dialogID,
                                 void *                 dStorage,
                                 WindowRef              behind)                             ONEWORDINLINE(0xA97C);

EXTERN_API( DialogRef )
NewColorDialog                  (void *                 dStorage,
                                 const Rect *           boundsRect,
                                 ConstStr255Param       title,
                                 Boolean                visible,
                                 SInt16                 procID,
                                 WindowRef              behind,
                                 Boolean                goAwayFlag,
                                 SInt32                 refCon,
                                 Handle                 items)                              ONEWORDINLINE(0xAA4B);

#if CALL_NOT_IN_CARBON
EXTERN_API( void )
CloseDialog                     (DialogRef              theDialog)                          ONEWORDINLINE(0xA982);

#endif  /* CALL_NOT_IN_CARBON */

EXTERN_API( void )
DisposeDialog                   (DialogRef              theDialog)                          ONEWORDINLINE(0xA983);

EXTERN_API( void )
ModalDialog                     (ModalFilterUPP         modalFilter,
                                 DialogItemIndex *      itemHit)                            ONEWORDINLINE(0xA991);

EXTERN_API( Boolean )
IsDialogEvent                   (const EventRecord *    theEvent)                           ONEWORDINLINE(0xA97F);

EXTERN_API( Boolean )
DialogSelect                    (const EventRecord *    theEvent,
                                 DialogRef *            theDialog,
                                 DialogItemIndex *      itemHit)                            ONEWORDINLINE(0xA980);

EXTERN_API( void )
DrawDialog                      (DialogRef              theDialog)                          ONEWORDINLINE(0xA981);

EXTERN_API( void )
UpdateDialog                    (DialogRef              theDialog,
                                 RgnHandle              updateRgn)                          ONEWORDINLINE(0xA978);

EXTERN_API( void )
HideDialogItem                  (DialogRef              theDialog,
                                 DialogItemIndex        itemNo)                             ONEWORDINLINE(0xA827);

EXTERN_API( void )
ShowDialogItem                  (DialogRef              theDialog,
                                 DialogItemIndex        itemNo)                             ONEWORDINLINE(0xA828);

EXTERN_API( DialogItemIndexZeroBased )
FindDialogItem                  (DialogRef              theDialog,
                                 Point                  thePt)                              ONEWORDINLINE(0xA984);

EXTERN_API( void )
DialogCut                       (DialogRef              theDialog);

EXTERN_API( void )
DialogPaste                     (DialogRef              theDialog);

EXTERN_API( void )
DialogCopy                      (DialogRef              theDialog);

EXTERN_API( void )
DialogDelete                    (DialogRef              theDialog);

EXTERN_API( DialogItemIndex )
Alert                           (SInt16                 alertID,
                                 ModalFilterUPP         modalFilter)                        ONEWORDINLINE(0xA985);

EXTERN_API( DialogItemIndex )
StopAlert                       (SInt16                 alertID,
                                 ModalFilterUPP         modalFilter)                        ONEWORDINLINE(0xA986);

EXTERN_API( DialogItemIndex )
NoteAlert                       (SInt16                 alertID,
                                 ModalFilterUPP         modalFilter)                        ONEWORDINLINE(0xA987);

EXTERN_API( DialogItemIndex )
CautionAlert                    (SInt16                 alertID,
                                 ModalFilterUPP         modalFilter)                        ONEWORDINLINE(0xA988);

EXTERN_API( void )
GetDialogItem                   (DialogRef              theDialog,
                                 DialogItemIndex        itemNo,
                                 DialogItemType *       itemType,
                                 Handle *               item,
                                 Rect *                 box)                                ONEWORDINLINE(0xA98D);

EXTERN_API( void )
SetDialogItem                   (DialogRef              theDialog,
                                 DialogItemIndex        itemNo,
                                 DialogItemType         itemType,
                                 Handle                 item,
                                 const Rect *           box)                                ONEWORDINLINE(0xA98E);

EXTERN_API( void )
ParamText                       (ConstStr255Param       param0,
                                 ConstStr255Param       param1,
                                 ConstStr255Param       param2,
                                 ConstStr255Param       param3)                             ONEWORDINLINE(0xA98B);

EXTERN_API( void )
SelectDialogItemText            (DialogRef              theDialog,
                                 DialogItemIndex        itemNo,
                                 SInt16                 strtSel,
                                 SInt16                 endSel)                             ONEWORDINLINE(0xA97E);

EXTERN_API( void )
GetDialogItemText               (Handle                 item,
                                 Str255                 text)                               ONEWORDINLINE(0xA990);

EXTERN_API( void )
SetDialogItemText               (Handle                 item,
                                 ConstStr255Param       text)                               ONEWORDINLINE(0xA98F);

EXTERN_API( SInt16 )
GetAlertStage                   (void)                                                      TWOWORDINLINE(0x3EB8, 0x0A9A);

EXTERN_API( void )
SetDialogFont                   (SInt16                 fontNum)                            TWOWORDINLINE(0x31DF, 0x0AFA);

EXTERN_API( void )
ResetAlertStage                 (void)                                                      TWOWORDINLINE(0x4278, 0x0A9A);

/* APIs in Carbon*/
EXTERN_API( void )
GetParamText                    (StringPtr              param0,
                                 StringPtr              param1,
                                 StringPtr              param2,
                                 StringPtr              param3);


#if CALL_NOT_IN_CARBON
EXTERN_API_C( DialogRef )
newdialog                       (void *                 dStorage,
                                 const Rect *           boundsRect,
                                 const char *           title,
                                 Boolean                visible,
                                 SInt16                 procID,
                                 WindowRef              behind,
                                 Boolean                goAwayFlag,
                                 SInt32                 refCon,
                                 Handle                 items);

EXTERN_API_C( DialogRef )
newcolordialog                  (void *                 dStorage,
                                 const Rect *           boundsRect,
                                 const char *           title,
                                 Boolean                visible,
                                 SInt16                 procID,
                                 WindowRef              behind,
                                 Boolean                goAwayFlag,
                                 SInt32                 refCon,
                                 Handle                 items);

EXTERN_API_C( void )
paramtext                       (const char *           param0,
                                 const char *           param1,
                                 const char *           param2,
                                 const char *           param3);

EXTERN_API_C( void )
getdialogitemtext               (Handle                 item,
                                 char *                 text);

EXTERN_API_C( void )
setdialogitemtext               (Handle                 item,
                                 const char *           text);

EXTERN_API_C( DialogItemIndexZeroBased )
finddialogitem                  (DialogRef              theDialog,
                                 Point *                thePt);

#endif  /* CALL_NOT_IN_CARBON */

EXTERN_API( void )
AppendDITL                      (DialogRef              theDialog,
                                 Handle                 theHandle,
                                 DITLMethod             method);

EXTERN_API( DialogItemIndex )
CountDITL                       (DialogRef              theDialog);

EXTERN_API( void )
ShortenDITL                     (DialogRef              theDialog,
                                 DialogItemIndex        numberItems);

EXTERN_API( OSStatus )
InsertDialogItem                (DialogRef              theDialog,
                                 DialogItemIndex        afterItem,
                                 DialogItemType         itemType,
                                 Handle                 itemHandle,
                                 const Rect *           box);

EXTERN_API( OSStatus )
RemoveDialogItems               (DialogRef              theDialog,
                                 DialogItemIndex        itemNo,
                                 DialogItemIndex        amountToRemove,
                                 Boolean                disposeItemData);

EXTERN_API( Boolean )
StdFilterProc                   (DialogRef              theDialog,
                                 EventRecord *          event,
                                 DialogItemIndex *      itemHit);

EXTERN_API( OSErr )
GetStdFilterProc                (ModalFilterUPP *       theProc)                            THREEWORDINLINE(0x303C, 0x0203, 0xAA68);

EXTERN_API( OSErr )
SetDialogDefaultItem            (DialogRef              theDialog,
                                 DialogItemIndex        newItem)                            THREEWORDINLINE(0x303C, 0x0304, 0xAA68);

EXTERN_API( OSErr )
SetDialogCancelItem             (DialogRef              theDialog,
                                 DialogItemIndex        newItem)                            THREEWORDINLINE(0x303C, 0x0305, 0xAA68);

EXTERN_API( OSErr )
SetDialogTracksCursor           (DialogRef              theDialog,
                                 Boolean                tracks)                             THREEWORDINLINE(0x303C, 0x0306, 0xAA68);



/*
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
    • Appearance Dialog Routines (available only with Appearance 1.0 and later)
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
*/

EXTERN_API( DialogRef )
NewFeaturesDialog               (void *                 inStorage,
                                 const Rect *           inBoundsRect,
                                 ConstStr255Param       inTitle,
                                 Boolean                inIsVisible,
                                 SInt16                 inProcID,
                                 WindowRef              inBehind,
                                 Boolean                inGoAwayFlag,
                                 SInt32                 inRefCon,
                                 Handle                 inItemListHandle,
                                 UInt32                 inFlags)                            THREEWORDINLINE(0x303C, 0x110C, 0xAA68);

EXTERN_API( OSErr )
AutoSizeDialog                  (DialogRef              inDialog)                           THREEWORDINLINE(0x303C, 0x020D, 0xAA68);

/*
    Regarding StandardAlert and constness:
    Even though the inAlertParam parameter is marked const here, there was
    a chance Dialog Manager would modify it on versions of Mac OS prior to 9.
*/
EXTERN_API( OSErr )
StandardAlert                   (AlertType              inAlertType,
                                 ConstStr255Param       inError,
                                 ConstStr255Param       inExplanation,
                                 const AlertStdAlertParamRec * inAlertParam,
                                 SInt16 *               outItemHit)                         THREEWORDINLINE(0x303C, 0x090E, 0xAA68);

EXTERN_API( OSErr )
GetDialogItemAsControl          (DialogRef              inDialog,
                                 SInt16                 inItemNo,
                                 ControlRef *           outControl)                         THREEWORDINLINE(0x303C, 0x050F, 0xAA68);

EXTERN_API( OSErr )
MoveDialogItem                  (DialogRef              inDialog,
                                 SInt16                 inItemNo,
                                 SInt16                 inHoriz,
                                 SInt16                 inVert)                             THREEWORDINLINE(0x303C, 0x0510, 0xAA68);

EXTERN_API( OSErr )
SizeDialogItem                  (DialogRef              inDialog,
                                 SInt16                 inItemNo,
                                 SInt16                 inWidth,
                                 SInt16                 inHeight)                           THREEWORDINLINE(0x303C, 0x0511, 0xAA68);

EXTERN_API( OSErr )
AppendDialogItemList            (DialogRef              dialog,
                                 SInt16                 ditlID,
                                 DITLMethod             method)                             THREEWORDINLINE(0x303C, 0x0412, 0xAA68);

/*
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
    • Dialog Routines available only with Appearance 1.1 and later
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
*/

EXTERN_API( OSStatus )
SetDialogTimeout                (DialogRef              inDialog,
                                 SInt16                 inButtonToPress,
                                 UInt32                 inSecondsToWait);

EXTERN_API( OSStatus )
GetDialogTimeout                (DialogRef              inDialog,
                                 SInt16 *               outButtonToPress,
                                 UInt32 *               outSecondsToWait,
                                 UInt32 *               outSecondsRemaining);

EXTERN_API( OSStatus )
SetModalDialogEventMask         (DialogRef              inDialog,
                                 EventMask              inMask);

EXTERN_API( OSStatus )
GetModalDialogEventMask         (DialogRef              inDialog,
                                 EventMask *            outMask);

#if OLDROUTINENAMES
#define DisposDialog(theDialog) DisposeDialog(theDialog)
#define UpdtDialog(theDialog, updateRgn) UpdateDialog(theDialog, updateRgn)
#define GetDItem(theDialog, itemNo, itemType, item, box) GetDialogItem(theDialog, itemNo, itemType, item, box)
#define SetDItem(theDialog, itemNo, itemType, item, box) SetDialogItem(theDialog, itemNo, itemType, item, box)
#define HideDItem(theDialog, itemNo) HideDialogItem(theDialog, itemNo)
#define ShowDItem(theDialog, itemNo) ShowDialogItem(theDialog, itemNo)
#define SelIText(theDialog, itemNo, strtSel, endSel) SelectDialogItemText(theDialog, itemNo, strtSel, endSel)
#define GetIText(item, text) GetDialogItemText(item, text)
#define SetIText(item, text) SetDialogItemText(item, text)
#define FindDItem(theDialog, thePt) FindDialogItem(theDialog, thePt)
#define NewCDialog(dStorage, boundsRect, title, visible, procID, behind, goAwayFlag, refCon, items) \
NewColorDialog(dStorage, boundsRect, title, visible, procID, behind, goAwayFlag, refCon, items)
#define GetAlrtStage() GetAlertStage()
#define ResetAlrtStage() ResetAlertStage()
#define DlgCut(theDialog) DialogCut(theDialog)
#define DlgPaste(theDialog) DialogPaste(theDialog)
#define DlgCopy(theDialog) DialogCopy(theDialog)
#define DlgDelete(theDialog) DialogDelete(theDialog)
#define SetDAFont(fontNum) SetDialogFont(fontNum)
#if CGLUESUPPORTED
#define newcdialog(dStorage, boundsRect, title, visible, procID, behind, goAwayFlag, refCon, items) \
newcolordialog(dStorage, boundsRect, title, visible, procID, behind, goAwayFlag, refCon, items)
#define getitext(item, text) getdialogitemtext(item, text)
#define setitext(item, text) setdialogitemtext(item, text)
#define findditem(theDialog, thePt) finddialogitem(theDialog, thePt)
#endif

#endif  /* OLDROUTINENAMES */

/*
    We are back to using *Ref's for Mac OS X transition. Note that for the time
    being these are equivalent to the old *Ptr's.
*/
#if !OPAQUE_TOOLBOX_STRUCTS && !ACCESSOR_CALLS_ARE_FUNCTIONS
#ifdef __cplusplus
inline WindowRef    GetDialogWindow(DialogRef dialog)       { return (WindowRef) dialog;                        }
inline SInt16       GetDialogDefaultItem(DialogRef dialog)  { return (*(SInt16 *) (((UInt8 *) dialog) + 168));  }
inline SInt16       GetDialogCancelItem(DialogRef dialog)   { return (*(SInt16 *) (((UInt8 *) dialog) + 166));  }
inline SInt16       GetDialogKeyboardFocusItem(DialogRef dialog)    { return (SInt16) ((*(SInt16 *) (((UInt8 *) dialog) + 164)) < 0 ? -1 : (*(SInt16 *) (((UInt8 *) dialog) + 164)) + 1); }
inline void     SetGrafPortOfDialog(DialogRef dialog) { MacSetPort ((GrafPtr) dialog); }
#else
#define GetDialogWindow(dialog) ((WindowRef) dialog)
#define GetDialogDefaultItem(dialog) (*(SInt16 *) (((UInt8 *) dialog) + 168))
#define GetDialogCancelItem(dialog) (*(SInt16 *) (((UInt8 *) dialog) + 166))
#define GetDialogKeyboardFocusItem(dialog) ((SInt16)((*(SInt16 *) (((UInt8 *) dialog) + 164)) < 0 ? -1 : (*(SInt16 *) (((UInt8 *) dialog) + 164)) + 1))
#define SetGrafPortOfDialog(dialog) do { MacSetPort ((GrafPtr) dialog); } while (false)
#endif
#endif  /* !OPAQUE_TOOLBOX_STRUCTS && !ACCESSOR_CALLS_ARE_FUNCTIONS */

#if ACCESSOR_CALLS_ARE_FUNCTIONS
/* Getters */
EXTERN_API( WindowRef )
GetDialogWindow                 (DialogRef              dialog);

EXTERN_API( TEHandle )
GetDialogTextEditHandle         (DialogRef              dialog);

EXTERN_API( SInt16 )
GetDialogDefaultItem            (DialogRef              dialog);

EXTERN_API( SInt16 )
GetDialogCancelItem             (DialogRef              dialog);

EXTERN_API( SInt16 )
GetDialogKeyboardFocusItem      (DialogRef              dialog);

/* Setters */
/* Utilities */
EXTERN_API( void )
SetPortDialogPort               (DialogRef              dialog);

EXTERN_API( CGrafPtr )
GetDialogPort                   (DialogRef              dialog);

/* To prevent upward dependencies, GetDialogFromWindow() is defined here instead of MacWindows.i */
EXTERN_API( DialogRef )
GetDialogFromWindow             (WindowRef              window);

#endif  /* ACCESSOR_CALLS_ARE_FUNCTIONS */

#if CALL_NOT_IN_CARBON
EXTERN_API( void )
CouldDialog                     (SInt16                 dialogID)                           ONEWORDINLINE(0xA979);

EXTERN_API( void )
FreeDialog                      (SInt16                 dialogID)                           ONEWORDINLINE(0xA97A);

EXTERN_API( void )
CouldAlert                      (SInt16                 alertID)                            ONEWORDINLINE(0xA989);

EXTERN_API( void )
FreeAlert                       (SInt16                 alertID)                            ONEWORDINLINE(0xA98A);


#endif  /* CALL_NOT_IN_CARBON */




#if !TARGET_OS_MAC
#endif  /* !TARGET_OS_MAC */






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

#endif /* __DIALOGS__ */

