{
 	File:		Lists.p
 
 	Contains:	List Manager Interfaces.
 
 	Version:	Technology:	Mac OS 8
 				Release:	Universal Interfaces 3.2
 
 	Copyright:	© 1985-1998 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Lists;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __LISTS__}
{$SETC __LISTS__ := 1}

{$I+}
{$SETC ListsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __CONTROLS__}
{$I Controls.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	Cell								= Point;
	CellPtr 							= ^Cell;
	ListBounds							= Rect;
	ListBoundsPtr 						= ^ListBounds;
	DataArray							= PACKED ARRAY [0..32000] OF CHAR;
	DataPtr								= ^DataArray;
	DataHandle							= ^DataPtr;
{$IFC TYPED_FUNCTION_POINTERS}
	ListSearchProcPtr = FUNCTION(aPtr: Ptr; bPtr: Ptr; aLen: INTEGER; bLen: INTEGER): INTEGER;
{$ELSEC}
	ListSearchProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ListClickLoopProcPtr = FUNCTION: BOOLEAN;
{$ELSEC}
	ListClickLoopProcPtr = Register68kProcPtr;
{$ENDC}

	ListSearchUPP = UniversalProcPtr;
	ListClickLoopUPP = UniversalProcPtr;
{$IFC NOT TARGET_OS_MAC }
{ QuickTime 3.0 }
	ListNotification					= LONGINT;

CONST
	listNotifyNothing			= 'nada';						{  No (null) notification }
	listNotifyClick				= 'clik';						{  Control was clicked }
	listNotifyDoubleClick		= 'dblc';						{  Control was double-clicked }
	listNotifyPreClick			= 'pclk';						{  Control about to be clicked }

{$ENDC}


TYPE
	ListRecPtr = ^ListRec;
	ListRec = RECORD
		rView:					Rect;
		port:					GrafPtr;
		indent:					Point;
		cellSize:				Point;
		visible:				ListBounds;
		vScroll:				ControlHandle;
		hScroll:				ControlHandle;
		selFlags:				SInt8;
		lActive:				BOOLEAN;
		lReserved:				SInt8;
		listFlags:				SInt8;
		clikTime:				LONGINT;
		clikLoc:				Point;
		mouseLoc:				Point;
		lClickLoop:				ListClickLoopUPP;
		lastClick:				Cell;
		refCon:					LONGINT;
		listDefProc:			Handle;
		userHandle:				Handle;
		dataBounds:				ListBounds;
		cells:					DataHandle;
		maxIndex:				INTEGER;
		cellArray:				ARRAY [0..0] OF INTEGER;
	END;

	ListPtr								= ^ListRec;
	ListHandle							= ^ListPtr;
{  ListRef is obsolete.  Use ListHandle.  }
	ListRef								= ListHandle;



CONST
																{  ListRec.listFlags bits }
	lDoVAutoscrollBit			= 1;
	lDoHAutoscrollBit			= 0;

																{  ListRec.listFlags masks }
	lDoVAutoscroll				= 2;
	lDoHAutoscroll				= 1;


																{  ListRec.selFlags bits }
	lOnlyOneBit					= 7;
	lExtendDragBit				= 6;
	lNoDisjointBit				= 5;
	lNoExtendBit				= 4;
	lNoRectBit					= 3;
	lUseSenseBit				= 2;
	lNoNilHiliteBit				= 1;


																{  ListRec.selFlags masks }
	lOnlyOne					= -128;
	lExtendDrag					= 64;
	lNoDisjoint					= 32;
	lNoExtend					= 16;
	lNoRect						= 8;
	lUseSense					= 4;
	lNoNilHilite				= 2;


																{  LDEF messages }
	lInitMsg					= 0;
	lDrawMsg					= 1;
	lHiliteMsg					= 2;
	lCloseMsg					= 3;





TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	ListDefProcPtr = PROCEDURE(lMessage: INTEGER; lSelect: BOOLEAN; VAR lRect: Rect; lCell: Cell; lDataOffset: INTEGER; lDataLen: INTEGER; lHandle: ListHandle);
{$ELSEC}
	ListDefProcPtr = ProcPtr;
{$ENDC}

	ListDefUPP = UniversalProcPtr;

CONST
	uppListSearchProcInfo = $00002BE0;
	uppListClickLoopProcInfo = $00000012;
	uppListDefProcInfo = $000EBD80;

FUNCTION NewListSearchProc(userRoutine: ListSearchProcPtr): ListSearchUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewListClickLoopProc(userRoutine: ListClickLoopProcPtr): ListClickLoopUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewListDefProc(userRoutine: ListDefProcPtr): ListDefUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallListSearchProc(aPtr: Ptr; bPtr: Ptr; aLen: INTEGER; bLen: INTEGER; userRoutine: ListSearchUPP): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallListClickLoopProc(userRoutine: ListClickLoopUPP): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

PROCEDURE CallListDefProc(lMessage: INTEGER; lSelect: BOOLEAN; VAR lRect: Rect; lCell: Cell; lDataOffset: INTEGER; lDataLen: INTEGER; lHandle: ListHandle; userRoutine: ListDefUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}


{$IFC NOT TARGET_OS_MAC }
{ QuickTime 3.0 }

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	ListNotificationProcPtr = PROCEDURE(theList: ListHandle; notification: ListNotification; param: LONGINT);
{$ELSEC}
	ListNotificationProcPtr = ProcPtr;
{$ENDC}

PROCEDURE LSetNotificationCallback(callBack: ListNotificationProcPtr; lHandle: ListHandle); C;
{$ENDC}



FUNCTION LNew({CONST}VAR rView: Rect; {CONST}VAR dataBounds: ListBounds; cSize: Point; theProc: INTEGER; theWindow: WindowPtr; drawIt: BOOLEAN; hasGrow: BOOLEAN; scrollHoriz: BOOLEAN; scrollVert: BOOLEAN): ListHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0044, $A9E7;
	{$ENDC}
PROCEDURE LDispose(lHandle: ListHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0028, $A9E7;
	{$ENDC}
FUNCTION LAddColumn(count: INTEGER; colNum: INTEGER; lHandle: ListHandle): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0004, $A9E7;
	{$ENDC}
FUNCTION LAddRow(count: INTEGER; rowNum: INTEGER; lHandle: ListHandle): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0008, $A9E7;
	{$ENDC}
PROCEDURE LDelColumn(count: INTEGER; colNum: INTEGER; lHandle: ListHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0020, $A9E7;
	{$ENDC}
PROCEDURE LDelRow(count: INTEGER; rowNum: INTEGER; lHandle: ListHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0024, $A9E7;
	{$ENDC}
FUNCTION LGetSelect(next: BOOLEAN; VAR theCell: Cell; lHandle: ListHandle): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $003C, $A9E7;
	{$ENDC}
FUNCTION LLastClick(lHandle: ListHandle): Cell;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0040, $A9E7;
	{$ENDC}
FUNCTION LNextCell(hNext: BOOLEAN; vNext: BOOLEAN; VAR theCell: Cell; lHandle: ListHandle): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0048, $A9E7;
	{$ENDC}
FUNCTION LSearch(dataPtr: UNIV Ptr; dataLen: INTEGER; searchProc: ListSearchUPP; VAR theCell: Cell; lHandle: ListHandle): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0054, $A9E7;
	{$ENDC}
PROCEDURE LSize(listWidth: INTEGER; listHeight: INTEGER; lHandle: ListHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0060, $A9E7;
	{$ENDC}
PROCEDURE LSetDrawingMode(drawIt: BOOLEAN; lHandle: ListHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $002C, $A9E7;
	{$ENDC}
PROCEDURE LScroll(dCols: INTEGER; dRows: INTEGER; lHandle: ListHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0050, $A9E7;
	{$ENDC}
PROCEDURE LAutoScroll(lHandle: ListHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0010, $A9E7;
	{$ENDC}
PROCEDURE LUpdate(theRgn: RgnHandle; lHandle: ListHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0064, $A9E7;
	{$ENDC}
PROCEDURE LActivate(act: BOOLEAN; lHandle: ListHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $4267, $A9E7;
	{$ENDC}
PROCEDURE LCellSize(cSize: Point; lHandle: ListHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0014, $A9E7;
	{$ENDC}
FUNCTION LClick(pt: Point; modifiers: INTEGER; lHandle: ListHandle): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0018, $A9E7;
	{$ENDC}
PROCEDURE LAddToCell(dataPtr: UNIV Ptr; dataLen: INTEGER; theCell: Cell; lHandle: ListHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $000C, $A9E7;
	{$ENDC}
PROCEDURE LClrCell(theCell: Cell; lHandle: ListHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $001C, $A9E7;
	{$ENDC}
PROCEDURE LGetCell(dataPtr: UNIV Ptr; VAR dataLen: INTEGER; theCell: Cell; lHandle: ListHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0038, $A9E7;
	{$ENDC}
PROCEDURE LRect(VAR cellRect: Rect; theCell: Cell; lHandle: ListHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $004C, $A9E7;
	{$ENDC}
PROCEDURE LSetCell(dataPtr: UNIV Ptr; dataLen: INTEGER; theCell: Cell; lHandle: ListHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0058, $A9E7;
	{$ENDC}
PROCEDURE LSetSelect(setIt: BOOLEAN; theCell: Cell; lHandle: ListHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $005C, $A9E7;
	{$ENDC}
PROCEDURE LDraw(theCell: Cell; lHandle: ListHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0030, $A9E7;
	{$ENDC}

PROCEDURE LGetCellDataLocation(VAR offset: INTEGER; VAR len: INTEGER; theCell: Cell; lHandle: ListHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0034, $A9E7;
	{$ENDC}
{$IFC NOT TARGET_OS_MAC }
{ QuickTime 3.0 }
PROCEDURE LSetLDEF(proc: ListDefProcPtr; lHandle: ListRef); C;
{$ENDC}

{$IFC OLDROUTINENAMES }
PROCEDURE LDoDraw(drawIt: BOOLEAN; lHandle: ListHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $002C, $A9E7;
	{$ENDC}
PROCEDURE LFind(VAR offset: INTEGER; VAR len: INTEGER; theCell: Cell; lHandle: ListHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0034, $A9E7;
	{$ENDC}
{$ENDC}  {OLDROUTINENAMES}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ListsIncludes}

{$ENDC} {__LISTS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
