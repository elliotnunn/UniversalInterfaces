{
 	File:		Events.p
 
 	Contains:	Event Manager Interfaces.
 
 	Version:	Technology:	Mac OS 8
 				Release:	Universal Interfaces 3.1
 
 	Copyright:	© 1985-1998 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Events;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __EVENTS__}
{$SETC __EVENTS__ := 1}

{$I+}
{$SETC EventsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __OSUTILS__}
{$I OSUtils.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}

{$IFC NOT TARGET_OS_MAC }
{$IFC UNDEFINED __ENDIAN__}
{$I Endian.p}
{$ENDC}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	EventKind							= UInt16;
	EventMask							= UInt16;

CONST
	nullEvent					= 0;
	mouseDown					= 1;
	mouseUp						= 2;
	keyDown						= 3;
	keyUp						= 4;
	autoKey						= 5;
	updateEvt					= 6;
	diskEvt						= 7;
	activateEvt					= 8;
	osEvt						= 15;
	kHighLevelEvent				= 23;

	mDownMask					= $02;							{  mouse button pressed }
	mUpMask						= $04;							{  mouse button released }
	keyDownMask					= $08;							{  key pressed }
	keyUpMask					= $10;							{  key released }
	autoKeyMask					= $20;							{  key repeatedly held down }
	updateMask					= $40;							{  window needs updating }
	diskMask					= $80;							{  disk inserted }
	activMask					= $0100;						{  activate/deactivate window }
	highLevelEventMask			= $0400;						{  high-level events (includes AppleEvents) }
	osMask						= $8000;						{  operating system events (suspend, resume) }
	everyEvent					= $FFFF;						{  all of the above }

	charCodeMask				= $000000FF;
	keyCodeMask					= $0000FF00;
	adbAddrMask					= $00FF0000;
	osEvtMessageMask			= $FF000000;

																{  OS event messages.  Event (sub)code is in the high byte of the message field. }
	mouseMovedMessage			= $00FA;
	suspendResumeMessage		= $0001;

	resumeFlag					= 1;							{  Bit 0 of message indicates resume vs suspend }
	convertClipboardFlag		= 2;							{  Bit 1 in resume message indicates clipboard change }



TYPE
	EventModifiers						= UInt16;

CONST
																{  modifiers  }
	activeFlagBit				= 0;							{  activate? (activateEvt and mouseDown) }
	btnStateBit					= 7;							{  state of button? }
	cmdKeyBit					= 8;							{  command key down? }
	shiftKeyBit					= 9;							{  shift key down? }
	alphaLockBit				= 10;							{  alpha lock down? }
	optionKeyBit				= 11;							{  option key down? }
	controlKeyBit				= 12;							{  control key down? }
	rightShiftKeyBit			= 13;							{  right shift key down? }
	rightOptionKeyBit			= 14;							{  right Option key down? }
	rightControlKeyBit			= 15;							{  right Control key down? }

	activeFlag					= $01;
	btnState					= $80;
	cmdKey						= $0100;
	shiftKey					= $0200;
	alphaLock					= $0400;
	optionKey					= $0800;
	controlKey					= $1000;
	rightShiftKey				= $2000;
	rightOptionKey				= $4000;
	rightControlKey				= $8000;

	kNullCharCode				= 0;
	kHomeCharCode				= 1;
	kEnterCharCode				= 3;
	kEndCharCode				= 4;
	kHelpCharCode				= 5;
	kBellCharCode				= 7;
	kBackspaceCharCode			= 8;
	kTabCharCode				= 9;
	kLineFeedCharCode			= 10;
	kVerticalTabCharCode		= 11;
	kPageUpCharCode				= 11;
	kFormFeedCharCode			= 12;
	kPageDownCharCode			= 12;
	kReturnCharCode				= 13;
	kFunctionKeyCharCode		= 16;
	kEscapeCharCode				= 27;
	kClearCharCode				= 27;
	kLeftArrowCharCode			= 28;
	kRightArrowCharCode			= 29;
	kUpArrowCharCode			= 30;
	kDownArrowCharCode			= 31;
	kDeleteCharCode				= 127;
	kNonBreakingSpaceCharCode	= 202;


TYPE
	EventRecordPtr = ^EventRecord;
	EventRecord = RECORD
		what:					EventKind;
		message:				UInt32;
		when:					UInt32;
		where:					Point;
		modifiers:				EventModifiers;
	END;


{$IFC TYPED_FUNCTION_POINTERS}
	FKEYProcPtr = PROCEDURE;
{$ELSEC}
	FKEYProcPtr = ProcPtr;
{$ENDC}

	FKEYUPP = UniversalProcPtr;

CONST
	uppFKEYProcInfo = $00000000;

FUNCTION NewFKEYProc(userRoutine: FKEYProcPtr): FKEYUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallFKEYProc(userRoutine: FKEYUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
PROCEDURE GetMouse(VAR mouseLoc: Point);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A972;
	{$ENDC}
FUNCTION Button: BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A974;
	{$ENDC}
FUNCTION StillDown: BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A973;
	{$ENDC}
FUNCTION WaitMouseUp: BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A977;
	{$ENDC}
FUNCTION TickCount: UInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A975;
	{$ENDC}
FUNCTION KeyTranslate(transData: UNIV Ptr; keycode: UInt16; VAR state: UInt32): UInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9C3;
	{$ENDC}
FUNCTION GetCaretTime: UInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2EB8, $02F4;
	{$ENDC}

TYPE
	KeyMap							= PACKED ARRAY [0..127] OF BOOLEAN;

PROCEDURE GetKeys(VAR theKeys: KeyMap);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A976;
	{$ENDC}


{ Obsolete event types & masks }

CONST
	networkEvt					= 10;
	driverEvt					= 11;
	app1Evt						= 12;
	app2Evt						= 13;
	app3Evt						= 14;
	app4Evt						= 15;
	networkMask					= $0400;
	driverMask					= $0800;
	app1Mask					= $1000;
	app2Mask					= $2000;
	app3Mask					= $4000;
	app4Mask					= $8000;


TYPE
	EvQElPtr = ^EvQEl;
	EvQEl = RECORD
		qLink:					QElemPtr;
		qType:					SInt16;
		evtQWhat:				EventKind;								{  this part is identical to the EventRecord as defined above  }
		evtQMessage:			UInt32;
		evtQWhen:				UInt32;
		evtQWhere:				Point;
		evtQModifiers:			EventModifiers;
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	GetNextEventFilterProcPtr = PROCEDURE(VAR theEvent: EventRecord; VAR result: BOOLEAN);
{$ELSEC}
	GetNextEventFilterProcPtr = Register68kProcPtr;
{$ENDC}

	GetNextEventFilterUPP = UniversalProcPtr;

CONST
	uppGetNextEventFilterProcInfo = $000000BF;

FUNCTION NewGetNextEventFilterProc(userRoutine: GetNextEventFilterProcPtr): GetNextEventFilterUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallGetNextEventFilterProc(VAR theEvent: EventRecord; VAR result: BOOLEAN; userRoutine: GetNextEventFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

TYPE
	GNEFilterUPP						= GetNextEventFilterUPP;
FUNCTION GetEvQHdr: QHdrPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2EBC, $0000, $014A;
	{$ENDC}
FUNCTION GetDblTime: UInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2EB8, $02F0;
	{$ENDC}
PROCEDURE SetEventMask(value: EventMask);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $31DF, $0144;
	{$ENDC}
FUNCTION PPostEvent(eventCode: EventKind; eventMsg: UInt32; VAR qEl: EvQElPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $225F, $201F, $305F, $A12F, $2288, $3E80;
	{$ENDC}
FUNCTION KeyTrans(transData: UNIV Ptr; keycode: UInt16; VAR state: UInt32): UInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9C3;
	{$ENDC}
FUNCTION GetNextEvent(eventMask: EventMask; VAR theEvent: EventRecord): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A970;
	{$ENDC}
FUNCTION WaitNextEvent(eventMask: EventMask; VAR theEvent: EventRecord; sleep: UInt32; mouseRgn: RgnHandle): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A860;
	{$ENDC}
FUNCTION EventAvail(eventMask: EventMask; VAR theEvent: EventRecord): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A971;
	{$ENDC}

FUNCTION PostEvent(eventNum: EventKind; eventMsg: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $201F, $305F, $A02F, $3E80;
	{$ENDC}
FUNCTION OSEventAvail(mask: EventMask; VAR theEvent: EventRecord): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $301F, $A030, $5240, $1E80;
	{$ENDC}
FUNCTION GetOSEvent(mask: EventMask; VAR theEvent: EventRecord): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $301F, $A031, $5240, $1E80;
	{$ENDC}
PROCEDURE FlushEvents(whichMask: EventMask; stopMask: EventMask);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $201F, $A032;
	{$ENDC}
PROCEDURE SystemClick({CONST}VAR theEvent: EventRecord; theWindow: WindowPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9B3;
	{$ENDC}
PROCEDURE SystemTask;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9B4;
	{$ENDC}
FUNCTION SystemEvent({CONST}VAR theEvent: EventRecord): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9B2;
	{$ENDC}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := EventsIncludes}

{$ENDC} {__EVENTS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
