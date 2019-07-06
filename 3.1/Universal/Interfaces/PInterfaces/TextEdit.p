{
 	File:		TextEdit.p
 
 	Contains:	TextEdit Interfaces.
 
 	Version:	Technology:	System 7.5
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
 UNIT TextEdit;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __TEXTEDIT__}
{$SETC __TEXTEDIT__ := 1}

{$I+}
{$SETC TextEditIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	TERecPtr = ^TERec;
	TEPtr								= ^TERec;
	TEHandle							= ^TEPtr;
{$IFC TYPED_FUNCTION_POINTERS}
	HighHookProcPtr = PROCEDURE({CONST}VAR r: Rect; pTE: TEPtr);
{$ELSEC}
	HighHookProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	EOLHookProcPtr = FUNCTION(theChar: ByteParameter; pTE: TEPtr; hTE: TEHandle): BOOLEAN;
{$ELSEC}
	EOLHookProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CaretHookProcPtr = PROCEDURE({CONST}VAR r: Rect; pTE: TEPtr);
{$ELSEC}
	CaretHookProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	WidthHookProcPtr = FUNCTION(textLen: UInt16; textOffset: UInt16; textBufferPtr: UNIV Ptr; pTE: TEPtr; hTE: TEHandle): UInt16;
{$ELSEC}
	WidthHookProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TextWidthHookProcPtr = FUNCTION(textLen: UInt16; textOffset: UInt16; textBufferPtr: UNIV Ptr; pTE: TEPtr; hTE: TEHandle): UInt16;
{$ELSEC}
	TextWidthHookProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	NWidthHookProcPtr = FUNCTION(styleRunLen: UInt16; styleRunOffset: UInt16; slop: INTEGER; direction: INTEGER; textBufferPtr: UNIV Ptr; VAR lineStart: INTEGER; pTE: TEPtr; hTE: TEHandle): UInt16;
{$ELSEC}
	NWidthHookProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	DrawHookProcPtr = PROCEDURE(textOffset: UInt16; drawLen: UInt16; textBufferPtr: UNIV Ptr; pTE: TEPtr; hTE: TEHandle);
{$ELSEC}
	DrawHookProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	HitTestHookProcPtr = FUNCTION(styleRunLen: UInt16; styleRunOffset: UInt16; slop: UInt16; textBufferPtr: UNIV Ptr; pTE: TEPtr; hTE: TEHandle; VAR pixelWidth: UInt16; VAR charOffset: UInt16; VAR pixelInChar: BOOLEAN): BOOLEAN;
{$ELSEC}
	HitTestHookProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TEFindWordProcPtr = PROCEDURE(currentPos: UInt16; caller: INTEGER; pTE: TEPtr; hTE: TEHandle; VAR wordStart: UInt16; VAR wordEnd: UInt16);
{$ELSEC}
	TEFindWordProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TERecalcProcPtr = PROCEDURE(pTE: TEPtr; changeLength: UInt16; VAR lineStart: UInt16; VAR firstChar: UInt16; VAR lastChar: UInt16);
{$ELSEC}
	TERecalcProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TEDoTextProcPtr = PROCEDURE(pTE: TEPtr; firstChar: UInt16; lastChar: UInt16; selector: INTEGER; VAR currentGrafPort: GrafPtr; VAR charPosition: INTEGER);
{$ELSEC}
	TEDoTextProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TEClickLoopProcPtr = FUNCTION(pTE: TEPtr): BOOLEAN;
{$ELSEC}
	TEClickLoopProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	WordBreakProcPtr = FUNCTION(text: Ptr; charPos: INTEGER): BOOLEAN;
{$ELSEC}
	WordBreakProcPtr = Register68kProcPtr;
{$ENDC}

{ 
	Important note about TEClickLoopProcPtr and WordBreakProcPtr

	At one point these were defined as returning the function result in the 
	condition code Z-bit.  This was correct, in that it was what the 68K
	implementation of TextEdit actually tested.  But, MixedMode had a different 
	idea of what returning a boolean in the Z-bit meant.  MixedMode was setting
	the Z-bit the complement of what was wanted.  
	
	Therefore, these ProcPtrs have been changed (back) to return the result in
	register D0.  It turns out that for register based routines, 
	MixedMode sets the Z-bit of the 68K emulator based on the contents 
	of the return result register.  Thus we can get the Z-bit set correctly.  
	
	But, when TextEdit is recoded in PowerPC, if it calls a 68K ClickLoop
	or WordBreak routine, register D0 had better have the result (in addition
	to the Z-bit). Therefore all 68K apps should make sure their ClickLoop or
	WordBreak routines set register D0 at the end.
}

{ 
	There is no function to get/set the low-mem for FindWordHook at 0x07F8.
	This is because it is not a low-mem ProcPtr. That address is the entry
	in the OS TrapTable for trap 0xA0FE.  You can use Get/SetTrapAddress to 
	acccess it.	
}

{
	The following ProcPtrs cannot be written in or called from a high-level 
	language without the help of mixed mode or assembly glue because they 
	use the following parameter-passing conventions:

	typedef pascal void (*HighHookProcPtr)(const Rect *r, TEPtr pTE);
	typedef pascal void (*CaretHookProcPtr)(const Rect *r, TEPtr pTE);

		In:
			=> 	r						on stack
			=>	pTE						A3.L
		Out:
			none

	typedef pascal Boolean (*EOLHookProcPtr)(char theChar, TEPtr pTE, TEHandle hTE);

		In:
			=> 	theChar					D0.B
			=>	pTE						A3.L
			=>	hTE						A4.L
		Out:
			<=	Boolean					Z bit of the CCR

	typedef pascal unsigned short (*WidthHookProcPtr)(unsigned short textLen,
	 unsigned short textOffset, void *textBufferPtr, TEPtr pTE, TEHandle hTE);
	typedef pascal unsigned short (*TextWidthHookProcPtr)(unsigned short textLen,
	 unsigned short textOffset, void *textBufferPtr, TEPtr pTE, TEHandle hTE);

		In:
			=> 	textLen					D0.W
			=>	textOffset				D1.W
			=>	textBufferPtr			A0.L
			=>	pTE						A3.L
			=>	hTE						A4.L
		Out:
			<=	unsigned short			D1.W

	typedef pascal unsigned short (*NWidthHookProcPtr)(unsigned short styleRunLen,
	 unsigned short styleRunOffset, short slop, short direction, void *textBufferPtr, 
	 short *lineStart, TEPtr pTE, TEHandle hTE);

		In:
			=> 	styleRunLen				D0.W
			=>	styleRunOffset			D1.W
			=>	slop					D2.W (low)
			=>	direction				D2.W (high)
			=>	textBufferPtr			A0.L
			=>	lineStart				A2.L
			=>	pTE						A3.L
			=>	hTE						A4.L
		Out:
			<=	unsigned short			D1.W

	typedef pascal void (*DrawHookProcPtr)(unsigned short textOffset, unsigned short drawLen,
	 void *textBufferPtr, TEPtr pTE, TEHandle hTE);

		In:
			=> 	textOffset				D0.W
			=>	drawLen					D1.W
			=>	textBufferPtr			A0.L
			=>	pTE						A3.L
			=>	hTE						A4.L
		Out:
			none

	typedef pascal Boolean (*HitTestHookProcPtr)(unsigned short styleRunLen,
	 unsigned short styleRunOffset, unsigned short slop, void *textBufferPtr,
	 TEPtr pTE, TEHandle hTE, unsigned short *pixelWidth, unsigned short *charOffset, 
	 Boolean *pixelInChar);

		In:
			=> 	styleRunLen				D0.W
			=>	styleRunOffset			D1.W
			=>	slop					D2.W
			=>	textBufferPtr			A0.L
			=>	pTE						A3.L
			=>	hTE						A4.L
		Out:
			<=	pixelWidth				D0.W (low)
			<=	Boolean					D0.W (high)
			<=	charOffset				D1.W
			<=	pixelInChar				D2.W

	typedef pascal void (*TEFindWordProcPtr)(unsigned short currentPos, short caller, 
	 TEPtr pTE, TEHandle hTE, unsigned short *wordStart, unsigned short *wordEnd);

		In:
			=> 	currentPos				D0.W
			=>	caller					D2.W
			=>	pTE						A3.L
			=>	hTE						A4.L
		Out:
			<=	wordStart				D0.W
			<=	wordEnd					D1.W

	typedef pascal void (*TERecalcProcPtr)(TEPtr pTE, unsigned short changeLength,
  	 unsigned short *lineStart, unsigned short *firstChar, unsigned short *lastChar);

		In:
			=> 	pTE						A3.L
			=>	changeLength			D7.W
		Out:
			<=	lineStart				D2.W
			<=	firstChar				D3.W
			<=	lastChar				D4.W

	typedef pascal void (*TEDoTextProcPtr)(TEPtr pTE, unsigned short firstChar, unsigned short lastChar,
	 					short selector, GrafPtr *currentGrafPort, short *charPosition);

		In:
			=> 	pTE						A3.L
			=>	firstChar				D3.W
			=>	lastChar				D4.W
			=>	selector				D7.W
		Out:
			<=	currentGrafPort			A0.L
			<=	charPosition			D0.W
			
}
	HighHookUPP = UniversalProcPtr;
	EOLHookUPP = UniversalProcPtr;
	CaretHookUPP = UniversalProcPtr;
	WidthHookUPP = UniversalProcPtr;
	TextWidthHookUPP = UniversalProcPtr;
	NWidthHookUPP = UniversalProcPtr;
	DrawHookUPP = UniversalProcPtr;
	HitTestHookUPP = UniversalProcPtr;
	TEFindWordUPP = UniversalProcPtr;
	TERecalcUPP = UniversalProcPtr;
	TEDoTextUPP = UniversalProcPtr;
	TEClickLoopUPP = UniversalProcPtr;
	WordBreakUPP = UniversalProcPtr;
	TERec = RECORD
		destRect:				Rect;
		viewRect:				Rect;
		selRect:				Rect;
		lineHeight:				INTEGER;
		fontAscent:				INTEGER;
		selPoint:				Point;
		selStart:				INTEGER;
		selEnd:					INTEGER;
		active:					INTEGER;
		wordBreak:				WordBreakUPP;
		clickLoop:				TEClickLoopUPP;
		clickTime:				LONGINT;
		clickLoc:				INTEGER;
		caretTime:				LONGINT;
		caretState:				INTEGER;
		just:					INTEGER;
		teLength:				INTEGER;
		hText:					Handle;
		hDispatchRec:			LONGINT;								{  added to replace recalBack & recalLines.  it's a handle anyway  }
		clikStuff:				INTEGER;
		crOnly:					INTEGER;
		txFont:					INTEGER;
		txFace:					StyleField;								{ txFace is unpacked byte }
		txMode:					INTEGER;
		txSize:					INTEGER;
		inPort:					GrafPtr;
		highHook:				HighHookUPP;
		caretHook:				CaretHookUPP;
		nLines:					INTEGER;
		lineStarts:				ARRAY [0..16000] OF INTEGER;
	END;


CONST
																{  Justification (word alignment) styles  }
	teJustLeft					= 0;
	teJustCenter				= 1;
	teJustRight					= -1;
	teForceLeft					= -2;							{  new names for the Justification (word alignment) styles  }
	teFlushDefault				= 0;							{ flush according to the line direction  }
	teCenter					= 1;							{ center justify (word alignment)  }
	teFlushRight				= -1;							{ flush right for all scripts  }
	teFlushLeft					= -2;							{ flush left for all scripts  }

																{  Set/Replace style modes  }
	fontBit						= 0;							{ set font }
	faceBit						= 1;							{ set face }
	sizeBit						= 2;							{ set size }
	clrBit						= 3;							{ set color }
	addSizeBit					= 4;							{ add size mode }
	toggleBit					= 5;							{ set faces in toggle mode }

																{  TESetStyle/TEContinuousStyle modes  }
	doFont						= 1;							{  set font (family) number }
	doFace						= 2;							{ set character style }
	doSize						= 4;							{ set type size }
	doColor						= 8;							{ set color }
	doAll						= 15;							{ set all attributes }
	addSize						= 16;							{ adjust type size }
	doToggle					= 32;							{ toggle mode for TESetStyle }

																{  offsets into TEDispatchRec  }
	EOLHook						= 0;							{ [UniversalProcPtr] TEEOLHook }
	DRAWHook					= 4;							{ [UniversalProcPtr] TEWidthHook }
	WIDTHHook					= 8;							{ [UniversalProcPtr] TEDrawHook }
	HITTESTHook					= 12;							{ [UniversalProcPtr] TEHitTestHook }
	nWIDTHHook					= 24;							{ [UniversalProcPtr] nTEWidthHook }
	TextWidthHook				= 28;							{ [UniversalProcPtr] TETextWidthHook }

																{  selectors for TECustomHook  }
	intEOLHook					= 0;							{ TEIntHook value }
	intDrawHook					= 1;							{ TEIntHook value }
	intWidthHook				= 2;							{ TEIntHook value }
	intHitTestHook				= 3;							{ TEIntHook value }
	intNWidthHook				= 6;							{ TEIntHook value for new version of WidthHook }
	intTextWidthHook			= 7;							{ TEIntHook value for new TextWidthHook }
	intInlineInputTSMTEPreUpdateHook = 8;						{ TEIntHook value for TSMTEPreUpdateProcPtr callback }
	intInlineInputTSMTEPostUpdateHook = 9;						{ TEIntHook value for TSMTEPostUpdateProcPtr callback }

																{  feature or bit definitions for TEFeatureFlag  }
	teFAutoScroll				= 0;							{ 00000001b }
	teFTextBuffering			= 1;							{ 00000010b }
	teFOutlineHilite			= 2;							{ 00000100b }
	teFInlineInput				= 3;							{ 00001000b  }
	teFUseWhiteBackground		= 4;							{ 00010000b  }
	teFUseInlineInput			= 5;							{ 00100000b  }
	teFInlineInputAutoScroll	= 6;							{ 01000000b  }

																{  action for the new "bit (un)set" interface, TEFeatureFlag  }
	teBitClear					= 0;
	teBitSet					= 1;							{ set the selector bit }
	teBitTest					= -1;							{ no change; just return the current setting }

																{ constants for identifying the routine that called FindWord  }
	teWordSelect				= 4;							{ clickExpand to select word }
	teWordDrag					= 8;							{ clickExpand to drag new word }
	teFromFind					= 12;							{ FindLine called it ($0C) }
	teFromRecal					= 16;							{ RecalLines called it ($10)      obsolete  }

																{ constants for identifying TEDoText selectors  }
	teFind						= 0;							{ TEDoText called for searching }
	teHighlight					= 1;							{ TEDoText called for highlighting }
	teDraw						= -1;							{ TEDoText called for drawing text }
	teCaret						= -2;							{ TEDoText called for drawing the caret }




TYPE
	Chars								= PACKED ARRAY [0..32000] OF CHAR;
	CharsPtr							= ^Chars;
	CharsHandle							= ^CharsPtr;
	StyleRunPtr = ^StyleRun;
	StyleRun = RECORD
		startChar:				INTEGER;								{ starting character position }
		styleIndex:				INTEGER;								{ index in style table }
	END;

	STElementPtr = ^STElement;
	STElement = RECORD
		stCount:				INTEGER;								{ number of runs in this style }
		stHeight:				INTEGER;								{ line height }
		stAscent:				INTEGER;								{ font ascent }
		stFont:					INTEGER;								{ font (family) number }
		stFace:					StyleField;								{ character Style }
		stSize:					INTEGER;								{ size in points }
		stColor:				RGBColor;								{ absolute (RGB) color }
	END;

	TEStyleTable						= ARRAY [0..1776] OF STElement;
	STPtr								= ^TEStyleTable;
	STHandle							= ^STPtr;
	LHElementPtr = ^LHElement;
	LHElement = RECORD
		lhHeight:				INTEGER;								{ maximum height in line }
		lhAscent:				INTEGER;								{ maximum ascent in line }
	END;

	LHTable								= ARRAY [0..8000] OF LHElement;
	LHPtr								= ^LHTable;
	LHHandle							= ^LHPtr;
	ScrpSTElementPtr = ^ScrpSTElement;
	ScrpSTElement = RECORD
		scrpStartChar:			LONGINT;								{ starting character position }
		scrpHeight:				INTEGER;
		scrpAscent:				INTEGER;
		scrpFont:				INTEGER;
		scrpFace:				StyleField;								{ unpacked byte }
		scrpSize:				INTEGER;
		scrpColor:				RGBColor;
	END;

{ ARRAY [0..1600] OF ScrpSTElement }
	ScrpSTTable							= ARRAY [0..1600] OF ScrpSTElement;
	StScrpRecPtr = ^StScrpRec;
	StScrpRec = RECORD
		scrpNStyles:			INTEGER;								{ number of styles in scrap }
		scrpStyleTab:			ScrpSTTable;							{ table of styles for scrap }
	END;

	StScrpPtr							= ^StScrpRec;
	StScrpHandle						= ^StScrpPtr;
	NullStRecPtr = ^NullStRec;
	NullStRec = RECORD
		teReserved:				LONGINT;								{ reserved for future expansion }
		nullScrap:				StScrpHandle;							{ handle to scrap style table }
	END;

	NullStPtr							= ^NullStRec;
	NullStHandle						= ^NullStPtr;
	TEStyleRecPtr = ^TEStyleRec;
	TEStyleRec = RECORD
		nRuns:					INTEGER;								{ number of style runs }
		nStyles:				INTEGER;								{ size of style table }
		styleTab:				STHandle;								{ handle to style table }
		lhTab:					LHHandle;								{ handle to line-height table }
		teRefCon:				LONGINT;								{ reserved for application use }
		nullStyle:				NullStHandle;							{ Handle to style set at null selection }
		runs:					ARRAY [0..8000] OF StyleRun;			{ ARRAY [0..8000] OF StyleRun }
	END;

	TEStylePtr							= ^TEStyleRec;
	TEStyleHandle						= ^TEStylePtr;
	TextStylePtr = ^TextStyle;
	TextStyle = RECORD
		tsFont:					INTEGER;								{ font (family) number }
		tsFace:					StyleField;								{ character Style }
		tsSize:					INTEGER;								{ size in point }
		tsColor:				RGBColor;								{ absolute (RGB) color }
	END;

	TextStyleHandle						= ^TextStylePtr;
	TEIntHook							= INTEGER;

CONST
	uppHighHookProcInfo = $0000000F;
	uppEOLHookProcInfo = $0000001F;
	uppCaretHookProcInfo = $0000000F;
	uppWidthHookProcInfo = $0000002F;
	uppTextWidthHookProcInfo = $0000002F;
	uppNWidthHookProcInfo = $0000003F;
	uppDrawHookProcInfo = $0000004F;
	uppHitTestHookProcInfo = $0000005F;
	uppTEFindWordProcInfo = $0000006F;
	uppTERecalcProcInfo = $0000009F;
	uppTEDoTextProcInfo = $000000AF;
	uppTEClickLoopProcInfo = $0000F812;
	uppWordBreakProcInfo = $00029812;

FUNCTION NewHighHookProc(userRoutine: HighHookProcPtr): HighHookUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewEOLHookProc(userRoutine: EOLHookProcPtr): EOLHookUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewCaretHookProc(userRoutine: CaretHookProcPtr): CaretHookUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewWidthHookProc(userRoutine: WidthHookProcPtr): WidthHookUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewTextWidthHookProc(userRoutine: TextWidthHookProcPtr): TextWidthHookUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewNWidthHookProc(userRoutine: NWidthHookProcPtr): NWidthHookUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewDrawHookProc(userRoutine: DrawHookProcPtr): DrawHookUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewHitTestHookProc(userRoutine: HitTestHookProcPtr): HitTestHookUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewTEFindWordProc(userRoutine: TEFindWordProcPtr): TEFindWordUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewTERecalcProc(userRoutine: TERecalcProcPtr): TERecalcUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewTEDoTextProc(userRoutine: TEDoTextProcPtr): TEDoTextUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewTEClickLoopProc(userRoutine: TEClickLoopProcPtr): TEClickLoopUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewWordBreakProc(userRoutine: WordBreakProcPtr): WordBreakUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallHighHookProc({CONST}VAR r: Rect; pTE: TEPtr; userRoutine: HighHookUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

FUNCTION CallEOLHookProc(theChar: ByteParameter; pTE: TEPtr; hTE: TEHandle; userRoutine: EOLHookUPP): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

PROCEDURE CallCaretHookProc({CONST}VAR r: Rect; pTE: TEPtr; userRoutine: CaretHookUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

FUNCTION CallWidthHookProc(textLen: UInt16; textOffset: UInt16; textBufferPtr: UNIV Ptr; pTE: TEPtr; hTE: TEHandle; userRoutine: WidthHookUPP): UInt16;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

FUNCTION CallTextWidthHookProc(textLen: UInt16; textOffset: UInt16; textBufferPtr: UNIV Ptr; pTE: TEPtr; hTE: TEHandle; userRoutine: TextWidthHookUPP): UInt16;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

FUNCTION CallNWidthHookProc(styleRunLen: UInt16; styleRunOffset: UInt16; slop: INTEGER; direction: INTEGER; textBufferPtr: UNIV Ptr; VAR lineStart: INTEGER; pTE: TEPtr; hTE: TEHandle; userRoutine: NWidthHookUPP): UInt16;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

PROCEDURE CallDrawHookProc(textOffset: UInt16; drawLen: UInt16; textBufferPtr: UNIV Ptr; pTE: TEPtr; hTE: TEHandle; userRoutine: DrawHookUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

FUNCTION CallHitTestHookProc(styleRunLen: UInt16; styleRunOffset: UInt16; slop: UInt16; textBufferPtr: UNIV Ptr; pTE: TEPtr; hTE: TEHandle; VAR pixelWidth: UInt16; VAR charOffset: UInt16; VAR pixelInChar: BOOLEAN; userRoutine: HitTestHookUPP): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

PROCEDURE CallTEFindWordProc(currentPos: UInt16; caller: INTEGER; pTE: TEPtr; hTE: TEHandle; VAR wordStart: UInt16; VAR wordEnd: UInt16; userRoutine: TEFindWordUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

PROCEDURE CallTERecalcProc(pTE: TEPtr; changeLength: UInt16; VAR lineStart: UInt16; VAR firstChar: UInt16; VAR lastChar: UInt16; userRoutine: TERecalcUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

PROCEDURE CallTEDoTextProc(pTE: TEPtr; firstChar: UInt16; lastChar: UInt16; selector: INTEGER; VAR currentGrafPort: GrafPtr; VAR charPosition: INTEGER; userRoutine: TEDoTextUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

FUNCTION CallTEClickLoopProc(pTE: TEPtr; userRoutine: TEClickLoopUPP): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

FUNCTION CallWordBreakProc(text: Ptr; charPos: INTEGER; userRoutine: WordBreakUPP): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

CONST
																{  feature bit 4 for TEFeatureFlag no longer in use  }
	teFUseTextServices			= 4;							{ 00010000b  }


FUNCTION TEScrapHandle: Handle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2EB8, $0AB4;
	{$ENDC}
FUNCTION TEGetScrapLength: LONGINT;
PROCEDURE TEInit;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9CC;
	{$ENDC}
FUNCTION TENew({CONST}VAR destRect: Rect; {CONST}VAR viewRect: Rect): TEHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9D2;
	{$ENDC}
PROCEDURE TEDispose(hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9CD;
	{$ENDC}
PROCEDURE TESetText(text: UNIV Ptr; length: LONGINT; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9CF;
	{$ENDC}
FUNCTION TEGetText(hTE: TEHandle): CharsHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9CB;
	{$ENDC}
PROCEDURE TEIdle(hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9DA;
	{$ENDC}
PROCEDURE TESetSelect(selStart: LONGINT; selEnd: LONGINT; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9D1;
	{$ENDC}
PROCEDURE TEActivate(hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9D8;
	{$ENDC}
PROCEDURE TEDeactivate(hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9D9;
	{$ENDC}
PROCEDURE TEKey(key: CharParameter; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9DC;
	{$ENDC}
PROCEDURE TECut(hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9D6;
	{$ENDC}
PROCEDURE TECopy(hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9D5;
	{$ENDC}
PROCEDURE TEPaste(hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9DB;
	{$ENDC}
PROCEDURE TEDelete(hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9D7;
	{$ENDC}
PROCEDURE TEInsert(text: UNIV Ptr; length: LONGINT; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9DE;
	{$ENDC}
PROCEDURE TESetAlignment(just: INTEGER; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9DF;
	{$ENDC}
PROCEDURE TEUpdate({CONST}VAR rUpdate: Rect; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9D3;
	{$ENDC}
PROCEDURE TETextBox(text: UNIV Ptr; length: LONGINT; {CONST}VAR box: Rect; just: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9CE;
	{$ENDC}
PROCEDURE TEScroll(dh: INTEGER; dv: INTEGER; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9DD;
	{$ENDC}
PROCEDURE TESelView(hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A811;
	{$ENDC}
PROCEDURE TEPinScroll(dh: INTEGER; dv: INTEGER; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A812;
	{$ENDC}
PROCEDURE TEAutoView(fAuto: BOOLEAN; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A813;
	{$ENDC}
PROCEDURE TECalText(hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9D0;
	{$ENDC}
FUNCTION TEGetOffset(pt: Point; hTE: TEHandle): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A83C;
	{$ENDC}
FUNCTION TEGetPoint(offset: INTEGER; hTE: TEHandle): Point;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0008, $A83D;
	{$ENDC}
PROCEDURE TEClick(pt: Point; fExtend: BOOLEAN; h: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9D4;
	{$ENDC}
FUNCTION TEStyleNew({CONST}VAR destRect: Rect; {CONST}VAR viewRect: Rect): TEHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A83E;
	{$ENDC}
PROCEDURE TESetStyleHandle(theHandle: TEStyleHandle; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0005, $A83D;
	{$ENDC}
FUNCTION TEGetStyleHandle(hTE: TEHandle): TEStyleHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0004, $A83D;
	{$ENDC}
PROCEDURE TEGetStyle(offset: INTEGER; VAR theStyle: TextStyle; VAR lineHeight: INTEGER; VAR fontAscent: INTEGER; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0003, $A83D;
	{$ENDC}
PROCEDURE TEStylePaste(hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0000, $A83D;
	{$ENDC}
PROCEDURE TESetStyle(mode: INTEGER; {CONST}VAR newStyle: TextStyle; fRedraw: BOOLEAN; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0001, $A83D;
	{$ENDC}
PROCEDURE TEReplaceStyle(mode: INTEGER; {CONST}VAR oldStyle: TextStyle; {CONST}VAR newStyle: TextStyle; fRedraw: BOOLEAN; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0002, $A83D;
	{$ENDC}
FUNCTION TEGetStyleScrapHandle(hTE: TEHandle): StScrpHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0006, $A83D;
	{$ENDC}
PROCEDURE TEStyleInsert(text: UNIV Ptr; length: LONGINT; hST: StScrpHandle; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0007, $A83D;
	{$ENDC}
FUNCTION TEGetHeight(endLine: LONGINT; startLine: LONGINT; hTE: TEHandle): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0009, $A83D;
	{$ENDC}
FUNCTION TEContinuousStyle(VAR mode: INTEGER; VAR aStyle: TextStyle; hTE: TEHandle): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $000A, $A83D;
	{$ENDC}
PROCEDURE TEUseStyleScrap(rangeStart: LONGINT; rangeEnd: LONGINT; newStyles: StScrpHandle; fRedraw: BOOLEAN; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $000B, $A83D;
	{$ENDC}
PROCEDURE TECustomHook(which: TEIntHook; VAR addr: UniversalProcPtr; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $000C, $A83D;
	{$ENDC}
FUNCTION TENumStyles(rangeStart: LONGINT; rangeEnd: LONGINT; hTE: TEHandle): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $000D, $A83D;
	{$ENDC}
FUNCTION TEFeatureFlag(feature: INTEGER; action: INTEGER; hTE: TEHandle): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $000E, $A83D;
	{$ENDC}
FUNCTION TEGetHiliteRgn(region: RgnHandle; hTE: TEHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $000F, $A83D;
	{$ENDC}
PROCEDURE TESetScrapLength(length: LONGINT);
FUNCTION TEFromScrap: OSErr;
FUNCTION TEToScrap: OSErr;
PROCEDURE TESetClickLoop(clikProc: TEClickLoopUPP; hTE: TEHandle);
PROCEDURE TESetWordBreak(wBrkProc: WordBreakUPP; hTE: TEHandle);

{$IFC OLDROUTINENAMES }
PROCEDURE TESetJust(just: INTEGER; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9DF;
	{$ENDC}
PROCEDURE TextBox(text: UNIV Ptr; length: LONGINT; {CONST}VAR box: Rect; just: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9CE;
	{$ENDC}
FUNCTION TEStylNew({CONST}VAR destRect: Rect; {CONST}VAR viewRect: Rect): TEHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A83E;
	{$ENDC}
PROCEDURE SetStylHandle(theHandle: TEStyleHandle; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0005, $A83D;
	{$ENDC}
PROCEDURE SetStyleHandle(theHandle: TEStyleHandle; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0005, $A83D;
	{$ENDC}
FUNCTION GetStylHandle(hTE: TEHandle): TEStyleHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0004, $A83D;
	{$ENDC}
FUNCTION GetStyleHandle(hTE: TEHandle): TEStyleHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0004, $A83D;
	{$ENDC}
PROCEDURE TEStylPaste(hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0000, $A83D;
	{$ENDC}
FUNCTION GetStylScrap(hTE: TEHandle): StScrpHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0006, $A83D;
	{$ENDC}
FUNCTION GetStyleScrap(hTE: TEHandle): StScrpHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0006, $A83D;
	{$ENDC}
PROCEDURE SetStylScrap(rangeStart: LONGINT; rangeEnd: LONGINT; newStyles: StScrpHandle; fRedraw: BOOLEAN; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $000B, $A83D;
	{$ENDC}
PROCEDURE SetStyleScrap(rangeStart: LONGINT; rangeEnd: LONGINT; newStyles: StScrpHandle; fRedraw: BOOLEAN; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $000B, $A83D;
	{$ENDC}
PROCEDURE TEStylInsert(text: UNIV Ptr; length: LONGINT; hST: StScrpHandle; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0007, $A83D;
	{$ENDC}
PROCEDURE TESetScrapLen(length: LONGINT);
FUNCTION TEGetScrapLen: LONGINT;
PROCEDURE SetClikLoop(clikProc: TEClickLoopUPP; hTE: TEHandle);
PROCEDURE SetWordBreak(wBrkProc: WordBreakUPP; hTE: TEHandle);
{$ENDC}  {OLDROUTINENAMES}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := TextEditIncludes}

{$ENDC} {__TEXTEDIT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
