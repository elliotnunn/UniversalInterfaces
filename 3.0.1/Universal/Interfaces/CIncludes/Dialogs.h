/*
 	File:		Dialogs.h
 
 	Contains:	Dialog Manager interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1985-1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
*/
#ifndef __DIALOGS__
#define __DIALOGS__

#ifndef __TYPES__
#include <Types.h>
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
	kControlDialogItem			= 4,
	kButtonDialogItem			= kControlDialogItem | 0,
	kCheckBoxDialogItem			= kControlDialogItem | 1,
	kRadioButtonDialogItem		= kControlDialogItem | 2,
	kResourceControlDialogItem	= kControlDialogItem | 3,
	kStaticTextDialogItem		= 8,
	kEditTextDialogItem			= 16,
	kIconDialogItem				= 32,
	kPictureDialogItem			= 64,
	kUserDialogItem				= 0,
	kItemDisableBit				= 128
};


enum {
																/* old names for dialog item types*/
	ctrlItem					= 4,
	btnCtrl						= 0,
	chkCtrl						= 1,
	radCtrl						= 2,
	resCtrl						= 3,
	statText					= 8,
	editText					= 16,
	iconItem					= 32,
	picItem						= 64,
	userItem					= 0,
	itemDisable					= 128
};


enum {
																/* standard dialog item numbers*/
	kStdOkItemIndex				= 1,
	kStdCancelItemIndex			= 2,							/* old names*/
	ok							= kStdOkItemIndex,
	cancel						= kStdCancelItemIndex
};


enum {
																/* standard icon resource id's 	*/
	kStopIcon					= 0,
	kNoteIcon					= 1,
	kCautionIcon				= 2,							/* old names*/
	stopIcon					= kStopIcon,
	noteIcon					= kNoteIcon,
	cautionIcon					= kCautionIcon
};



#if OLDROUTINENAMES
/*
   These constants lived briefly on ETO 16.  They suggest
   that there is only one index you can use for the OK 
   item, which is not true.  You can put the ok item 
   anywhere you want in the DITL.
*/

enum {
	kOkItemIndex				= 1,
	kCancelItemIndex			= 2
};

#endif  /* OLDROUTINENAMES */

/*	Dialog Item List Manipulation Constants	*/
typedef SInt16 							DITLMethod;

enum {
	overlayDITL					= 0,
	appendDITLRight				= 1,
	appendDITLBottom			= 2
};

typedef SInt16 							StageList;
/* DialogRef is obsolete. Use DialogPtr instead.*/
typedef DialogPtr 						DialogRef;
struct DialogRecord {
	WindowRecord 					window;
	Handle 							items;
	TEHandle 						textH;
	SInt16 							editField;
	SInt16 							editOpen;
	SInt16 							aDefItem;
};
typedef struct DialogRecord DialogRecord;

typedef DialogRecord *					DialogPeek;
struct DialogTemplate {
	Rect 							boundsRect;
	SInt16 							procID;
	Boolean 						visible;
	Boolean 						filler1;
	Boolean 						goAwayFlag;
	Boolean 						filler2;
	SInt32 							refCon;
	SInt16 							itemsID;
	Str255 							title;
};
typedef struct DialogTemplate DialogTemplate;

typedef DialogTemplate *				DialogTPtr;
typedef DialogTPtr *					DialogTHndl;
struct AlertTemplate {
	Rect 							boundsRect;
	SInt16 							itemsID;
	StageList 						stages;
};
typedef struct AlertTemplate AlertTemplate;

typedef AlertTemplate *					AlertTPtr;
typedef AlertTPtr *						AlertTHndl;
/* new type abstractions for the dialog manager */
typedef SInt16 							DialogItemIndexZeroBased;
typedef SInt16 							DialogItemIndex;
typedef SInt16 							DialogItemType;
/* dialog manager callbacks */
typedef CALLBACK_API( void , SoundProcPtr )(SInt16 soundNumber);
typedef CALLBACK_API( Boolean , ModalFilterProcPtr )(DialogPtr theDialog, EventRecord *theEvent, DialogItemIndex *itemHit);
typedef CALLBACK_API( void , UserItemProcPtr )(WindowPtr theWindow, DialogItemIndex itemNo);
typedef STACK_UPP_TYPE(SoundProcPtr) 							SoundUPP;
typedef STACK_UPP_TYPE(ModalFilterProcPtr) 						ModalFilterUPP;
typedef STACK_UPP_TYPE(UserItemProcPtr) 						UserItemUPP;
enum { uppSoundProcInfo = 0x00000080 }; 						/* pascal no_return_value Func(2_bytes) */
enum { uppModalFilterProcInfo = 0x00000FD0 }; 					/* pascal 1_byte Func(4_bytes, 4_bytes, 4_bytes) */
enum { uppUserItemProcInfo = 0x000002C0 }; 						/* pascal no_return_value Func(4_bytes, 2_bytes) */
#define NewSoundProc(userRoutine) 								(SoundUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppSoundProcInfo, GetCurrentArchitecture())
#define NewModalFilterProc(userRoutine) 						(ModalFilterUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppModalFilterProcInfo, GetCurrentArchitecture())
#define NewUserItemProc(userRoutine) 							(UserItemUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppUserItemProcInfo, GetCurrentArchitecture())
#define CallSoundProc(userRoutine, soundNumber) 				CALL_ONE_PARAMETER_UPP((userRoutine), uppSoundProcInfo, (soundNumber))
#define CallModalFilterProc(userRoutine, theDialog, theEvent, itemHit)  CALL_THREE_PARAMETER_UPP((userRoutine), uppModalFilterProcInfo, (theDialog), (theEvent), (itemHit))
#define CallUserItemProc(userRoutine, theWindow, itemNo) 		CALL_TWO_PARAMETER_UPP((userRoutine), uppUserItemProcInfo, (theWindow), (itemNo))

/*
	NOTE: Code running under MultiFinder or System 7.0 or newer
	should always pass NULL to InitDialogs.
*/
EXTERN_API( void )
InitDialogs						(void *					ignored)							ONEWORDINLINE(0xA97B);

EXTERN_API( void )
ErrorSound						(SoundUPP 				soundProc)							ONEWORDINLINE(0xA98C);

EXTERN_API( DialogPtr )
NewDialog						(void *					dStorage,
								 const Rect *			boundsRect,
								 ConstStr255Param 		title,
								 Boolean 				visible,
								 SInt16 				procID,
								 WindowPtr 				behind,
								 Boolean 				goAwayFlag,
								 SInt32 				refCon,
								 Handle 				items)								ONEWORDINLINE(0xA97D);

EXTERN_API( DialogPtr )
GetNewDialog					(SInt16 				dialogID,
								 void *					dStorage,
								 WindowPtr 				behind)								ONEWORDINLINE(0xA97C);

EXTERN_API( DialogPtr )
NewColorDialog					(void *					dStorage,
								 const Rect *			boundsRect,
								 ConstStr255Param 		title,
								 Boolean 				visible,
								 SInt16 				procID,
								 WindowPtr 				behind,
								 Boolean 				goAwayFlag,
								 SInt32 				refCon,
								 Handle 				items)								ONEWORDINLINE(0xAA4B);

EXTERN_API( void )
CloseDialog						(DialogPtr 				theDialog)							ONEWORDINLINE(0xA982);

EXTERN_API( void )
DisposeDialog					(DialogPtr 				theDialog)							ONEWORDINLINE(0xA983);

EXTERN_API( void )
ModalDialog						(ModalFilterUPP 		modalFilter,
								 DialogItemIndex *		itemHit)							ONEWORDINLINE(0xA991);

EXTERN_API( Boolean )
IsDialogEvent					(const EventRecord *	theEvent)							ONEWORDINLINE(0xA97F);

EXTERN_API( Boolean )
DialogSelect					(const EventRecord *	theEvent,
								 DialogPtr *			theDialog,
								 DialogItemIndex *		itemHit)							ONEWORDINLINE(0xA980);

EXTERN_API( void )
DrawDialog						(DialogPtr 				theDialog)							ONEWORDINLINE(0xA981);

EXTERN_API( void )
UpdateDialog					(DialogPtr 				theDialog,
								 RgnHandle 				updateRgn)							ONEWORDINLINE(0xA978);

EXTERN_API( void )
HideDialogItem					(DialogPtr 				theDialog,
								 DialogItemIndex 		itemNo)								ONEWORDINLINE(0xA827);

EXTERN_API( void )
ShowDialogItem					(DialogPtr 				theDialog,
								 DialogItemIndex 		itemNo)								ONEWORDINLINE(0xA828);

EXTERN_API( DialogItemIndexZeroBased )
FindDialogItem					(DialogPtr 				theDialog,
								 Point 					thePt)								ONEWORDINLINE(0xA984);

EXTERN_API( void )
DialogCut						(DialogPtr 				theDialog);

EXTERN_API( void )
DialogPaste						(DialogPtr 				theDialog);

EXTERN_API( void )
DialogCopy						(DialogPtr 				theDialog);

EXTERN_API( void )
DialogDelete					(DialogPtr 				theDialog);

EXTERN_API( DialogItemIndex )
Alert							(SInt16 				alertID,
								 ModalFilterUPP 		modalFilter)						ONEWORDINLINE(0xA985);

EXTERN_API( DialogItemIndex )
StopAlert						(SInt16 				alertID,
								 ModalFilterUPP 		modalFilter)						ONEWORDINLINE(0xA986);

EXTERN_API( DialogItemIndex )
NoteAlert						(SInt16 				alertID,
								 ModalFilterUPP 		modalFilter)						ONEWORDINLINE(0xA987);

EXTERN_API( DialogItemIndex )
CautionAlert					(SInt16 				alertID,
								 ModalFilterUPP 		modalFilter)						ONEWORDINLINE(0xA988);

EXTERN_API( void )
GetDialogItem					(DialogPtr 				theDialog,
								 DialogItemIndex 		itemNo,
								 DialogItemType *		itemType,
								 Handle *				item,
								 Rect *					box)								ONEWORDINLINE(0xA98D);

EXTERN_API( void )
SetDialogItem					(DialogPtr 				theDialog,
								 DialogItemIndex 		itemNo,
								 DialogItemType 		itemType,
								 Handle 				item,
								 const Rect *			box)								ONEWORDINLINE(0xA98E);

EXTERN_API( void )
ParamText						(ConstStr255Param 		param0,
								 ConstStr255Param 		param1,
								 ConstStr255Param 		param2,
								 ConstStr255Param 		param3)								ONEWORDINLINE(0xA98B);

EXTERN_API( void )
SelectDialogItemText			(DialogPtr 				theDialog,
								 DialogItemIndex 		itemNo,
								 SInt16 				strtSel,
								 SInt16 				endSel)								ONEWORDINLINE(0xA97E);

EXTERN_API( void )
GetDialogItemText				(Handle 				item,
								 Str255 				text)								ONEWORDINLINE(0xA990);

EXTERN_API( void )
SetDialogItemText				(Handle 				item,
								 ConstStr255Param 		text)								ONEWORDINLINE(0xA98F);

EXTERN_API( SInt16 )
GetAlertStage					(void)														TWOWORDINLINE(0x3EB8, 0x0A9A);

EXTERN_API( void )
SetDialogFont					(SInt16 				value)								TWOWORDINLINE(0x31DF, 0x0AFA);

EXTERN_API( void )
ResetAlertStage					(void)														TWOWORDINLINE(0x4278, 0x0A9A);


#if CGLUESUPPORTED
EXTERN_API_C( DialogPtr )
newdialog						(void *					dStorage,
								 const Rect *			boundsRect,
								 const char *			title,
								 Boolean 				visible,
								 SInt16 				procID,
								 WindowPtr 				behind,
								 Boolean 				goAwayFlag,
								 SInt32 				refCon,
								 Handle 				items);

EXTERN_API_C( DialogPtr )
newcolordialog					(void *					dStorage,
								 const Rect *			boundsRect,
								 const char *			title,
								 Boolean 				visible,
								 SInt16 				procID,
								 WindowPtr 				behind,
								 Boolean 				goAwayFlag,
								 SInt32 				refCon,
								 Handle 				items);

EXTERN_API_C( void )
paramtext						(const char *			param0,
								 const char *			param1,
								 const char *			param2,
								 const char *			param3);

EXTERN_API_C( void )
getdialogitemtext				(Handle 				item,
								 char *					text);

EXTERN_API_C( void )
setdialogitemtext				(Handle 				item,
								 const char *			text);

EXTERN_API_C( DialogItemIndexZeroBased )
finddialogitem					(DialogPtr 				theDialog,
								 Point *				thePt);

#endif  /* CGLUESUPPORTED */

EXTERN_API( void )
AppendDITL						(DialogPtr 				theDialog,
								 Handle 				theHandle,
								 DITLMethod 			method);

EXTERN_API( DialogItemIndex )
CountDITL						(DialogPtr 				theDialog);

EXTERN_API( void )
ShortenDITL						(DialogPtr 				theDialog,
								 DialogItemIndex 		numberItems);

EXTERN_API( Boolean )
StdFilterProc					(DialogPtr 				theDialog,
								 EventRecord *			event,
								 DialogItemIndex *		itemHit);

EXTERN_API( OSErr )
GetStdFilterProc				(ModalFilterUPP *		theProc)							THREEWORDINLINE(0x303C, 0x0203, 0xAA68);

EXTERN_API( OSErr )
SetDialogDefaultItem			(DialogPtr 				theDialog,
								 DialogItemIndex 		newItem)							THREEWORDINLINE(0x303C, 0x0304, 0xAA68);

EXTERN_API( OSErr )
SetDialogCancelItem				(DialogPtr 				theDialog,
								 DialogItemIndex 		newItem)							THREEWORDINLINE(0x303C, 0x0305, 0xAA68);

EXTERN_API( OSErr )
SetDialogTracksCursor			(DialogPtr 				theDialog,
								 Boolean 				tracks)								THREEWORDINLINE(0x303C, 0x0306, 0xAA68);

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
#endif  /* CGLUESUPPORTED */

#endif  /* OLDROUTINENAMES */

/*
	*****************************************************************************
	*                                                                           *
	* The conditional STRICT_DIALOGS has been removed from this interface file. *
	* The accessor macros to a DialogRecord are no longer necessary.            *
	*                                                                           *
	* All ≈Ref Types have reverted to their original Handle and Ptr Types.      *
	*                                                                           *
	*****************************************************************************

	Details:
	The original purpose of the STRICT_ conditionals and accessor macros was to
	help ease the transition to Copland.  Shared data structures are difficult
	to coordinate in a preemptive multitasking OS.  By hiding the fields in a
	WindowRecord and other data structures, we would begin the migration to the
	discipline wherein system data structures are completely hidden from
	applications.
	
	After many design reviews, we finally concluded that with this sort of
	migration, the system could never tell when an application was no longer
	peeking at a WindowRecord, and thus the data structure might never become
	system owned.  Additionally, there were many other limitations in the
	classic toolbox that were begging to be addressed.  The final decision was
	to leave the traditional toolbox as a compatibility mode.
	
	We also decided to use the Handle and Ptr based types in the function
	declarations.  For example, NewWindow now returns a WindowPtr rather than a
	WindowRef.  The Ref types are still defined in the header files, so all
	existing code will still compile exactly as it did before.  There are
	several reasons why we chose to do this:
	
	- The importance of backwards compatibility makes it unfeasible for us to
	enforce real opaque references in the implementation anytime in the
	foreseeable future.  Therefore, any opaque data types (e.g. WindowRef,
	ControlRef, etc.) in the documentation and header files would always be a
	fake veneer of opacity.
	
	- There exists a significant base of books and sample code that neophyte
	Macintosh developers use to learn how to program the Macintosh.  These
	books and sample code all use direct data access.  Introducing opaque data
	types at this point would confuse neophyte programmers more than it would
	help them.
	
	- Direct data structure access is used by nearly all Macintosh developers. 
	Changing the interfaces to reflect a false opacity would not provide any
	benefit to these developers.
	
	- Accessor functions are useful in and of themselves as convenience
	functions, without being tied to opaque data types.  We will complete and
	document the Windows and Dialogs accessor functions in an upcoming release
	of the interfaces.
*/
#ifdef __cplusplus
inline WindowPtr 	GetDialogWindow(DialogPtr dialog)		{ return (WindowPtr) dialog; 						}
inline SInt16		GetDialogDefaultItem(DialogPtr dialog)  { return (*(SInt16 *) (((UInt8 *) dialog) + 168));	}
inline SInt16		GetDialogCancelItem(DialogPtr dialog) 	{ return (*(SInt16 *) (((UInt8 *) dialog) + 166));	}
inline SInt16		GetDialogKeyboardFocusItem(DialogPtr dialog)	{ return ((*(SInt16 *) (((UInt8 *) dialog) + 164)) < 0 ? -1 : (*(SInt16 *) (((UInt8 *) dialog) + 164)) + 1); }
inline void		SetGrafPortOfDialog(DialogPtr dialog) { SetPort ((GrafPtr) dialog); }
#else
#define GetDialogWindow(dialog)	((WindowPtr) dialog)
#define GetDialogDefaultItem(dialog) (*(SInt16 *) (((UInt8 *) dialog) + 168))
#define GetDialogCancelItem(dialog) (*(SInt16 *) (((UInt8 *) dialog) + 166))
#define GetDialogKeyboardFocusItem(dialog) ((*(SInt16 *) (((UInt8 *) dialog) + 164)) < 0 ? -1 : (*(SInt16 *) (((UInt8 *) dialog) + 164)) + 1)
#define SetGrafPortOfDialog(dialog) do { SetPort ((GrafPtr) dialog); } while (false)
#endif


EXTERN_API( void )
CouldDialog						(SInt16 				dialogID)							ONEWORDINLINE(0xA979);

EXTERN_API( void )
FreeDialog						(SInt16 				dialogID)							ONEWORDINLINE(0xA97A);

EXTERN_API( void )
CouldAlert						(SInt16 				alertID)							ONEWORDINLINE(0xA989);

EXTERN_API( void )
FreeAlert						(SInt16 				alertID)							ONEWORDINLINE(0xA98A);









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

