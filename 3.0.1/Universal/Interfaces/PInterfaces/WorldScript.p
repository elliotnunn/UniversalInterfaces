{
 	File:		WorldScript.p
 
 	Contains:	WorldScript I Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1994-1997 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT WorldScript;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __WORLDSCRIPT__}
{$SETC __WORLDSCRIPT__ := 1}

{$I+}
{$SETC WorldScriptIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{$IFC UNDEFINED __TRAPS__}
{$I Traps.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAWTEXT__}
{$I QuickdrawText.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	WSIOffset							= UInt16;
	WSIByteCount						= UInt8;
	WSIByteIndex						= UInt8;
{ offset from start of sub-table to row in state table }
	WSIStateOffset						= UInt16;
	WSITableOffset						= UInt32;
	WSISubtableOffset					= UInt16;
	WSIGlyphcode						= UInt16;
	WSITableIdentifiers					= UInt32;

CONST
	kScriptSettingsTag			= 'info';
	kMetamorphosisTag			= 'mort';
	kGlyphExpansionTag			= 'g2g#';
	kPropertiesTag				= 'prop';
	kJustificationTag			= 'kash';
	kCharToGlyphTag				= 'cmap';
	kGlyphToCharTag				= 'pamc';
	kFindScriptRunTag			= 'fstb';



{*** 			L O O K U P    T A B L E    T Y P E S		***}
	WSILookupSimpleArray		= 0;							{  a simple array indexed by glyph code  }
	WSILookupSegmentSingle		= 2;							{  segment mapping to single value  }
	WSILookupSegmentArray		= 4;							{  segment mapping to lookup array  }
	WSILookupSingleTable		= 6;							{  sorted list of glyph, value pairs  }
	WSILookupTrimmedArray		= 8;							{  a simple trimmed array indexed by glyph code  }


TYPE
	WSILookupTableFormat				= INTEGER;
	WSILookupValue						= INTEGER;
{ An offset from the beginning of the lookup table }
	WSILookupOffset						= INTEGER;
{	FORMAT SPECIFIC DEFINITIONS }
{
		lookupSimpleArray:
		
		This is a simple array which maps all glyphs in the font
		to lookup values.
	}
	WSILookupArrayHeaderPtr = ^WSILookupArrayHeader;
	WSILookupArrayHeader = RECORD
		lookupValues:			ARRAY [0..0] OF WSILookupValue;			{  The array of values indexed by glyph code  }
	END;

{
		lookupTrimmedArray:
		
		This is a single trimmed array which maps a single range
		of glyhs in the font to lookup values.
	}
	WSILookupTrimmedArrayHeaderPtr = ^WSILookupTrimmedArrayHeader;
	WSILookupTrimmedArrayHeader = RECORD
		firstGlyph:				WSIGlyphcode;
		limitGlyph:				WSIGlyphcode;
		valueArray:				ARRAY [0..0] OF WSILookupValue;
	END;

{ The format specific part of the subtable header }
	WSILookupFormatSpecificHeaderPtr = ^WSILookupFormatSpecificHeader;
	WSILookupFormatSpecificHeader = RECORD
		CASE INTEGER OF
		0: (
			simpleArray:		WSILookupArrayHeader;					{  rename lookupArray as simpleArray <9>  }
			);
		1: (
			trimmedArray:		WSILookupTrimmedArrayHeader;
			);
	END;

{ The overall subtable header }
	WSILookupTableHeaderPtr = ^WSILookupTableHeader;
	WSILookupTableHeader = RECORD
		format:					WSILookupTableFormat;					{  table format  }
		fsHeader:				WSILookupFormatSpecificHeader;			{  format specific header  }
	END;


{***		G L Y P H    E X P A N S I O N    ***}

CONST
																{  fixed 1.0  }
	kCurrentGlyphExpansionVersion = $00010000;


TYPE
	GlyphExpansionFormats				= INTEGER;

CONST
	GlyphExpansionLookupFormat	= 1;
	GlyphExpansionContextualFormat = 2;


TYPE
	ExpandedGlyphClusterPtr = ^ExpandedGlyphCluster;
	ExpandedGlyphCluster = PACKED RECORD
		numGlyphs:				WSIByteCount;
		bestGlyph:				WSIByteIndex;
		glyphs:					ARRAY [0..0] OF WSIGlyphcode;
	END;

	ExpandedGlyphOffsetPtr = ^ExpandedGlyphOffset;
	ExpandedGlyphOffset = RECORD
		glyph:					WSIGlyphcode;
		offset:					WSIOffset;								{  offset to ExpandedGlyphCluster  }
	END;

	GlyphExpansionStateTablePtr = ^GlyphExpansionStateTable;
	GlyphExpansionStateTable = RECORD
		stateTableOffset:		WSISubtableOffset;
		classTableOffset:		WSISubtableOffset;
		actionTableOffset:		WSISubtableOffset;						{  state, class and actions tables follow here...  }
	END;

	GlyphExpansionTablePtr = ^GlyphExpansionTable;
	GlyphExpansionTable = RECORD
		version:				Fixed;
		format:					INTEGER;
		expansionNumer:			INTEGER;
		expansionDenom:			INTEGER;								{  num/denom ratio for expansion <2>  }
		CASE INTEGER OF
		0: (
			stateTable:			GlyphExpansionStateTable;
			);
		1: (
			lookup:				WSILookupTableHeader;					{  expanded glyph clusters follow here...  }
			);
	END;


{ Glyph-to-Character constants and types  }

CONST
	kCurrentGlyphToCharVersion	= $00010100;


TYPE
	GlyphToCharLookupFormats			= INTEGER;

CONST
	kGlyphToCharLookup8Format	= 1;
	kGlyphToCharLookup16Format	= 2;
	kGlyphToCharLookup32Format	= 3;


TYPE
	GlyphToCharFontIndex				= UInt8;
	QDGlyphcode							= UInt8;
	GlyphToCharActionTablePtr = ^GlyphToCharActionTable;
	GlyphToCharActionTable = RECORD
		fontNameOffset:			WSISubtableOffset;						{  offset relative to this table  }
		actions:				WSILookupTableHeader;					{  only support lookupSimpleArray format for now  }
	END;

	GlyphToCharActionHeaderPtr = ^GlyphToCharActionHeader;
	GlyphToCharActionHeader = RECORD
		numTables:				INTEGER;								{  0..n  }
		offsets:				ARRAY [0..0] OF WSISubtableOffset;		{  offsets from start of action table header  }
	END;

	GlyphToCharHeaderPtr = ^GlyphToCharHeader;
	GlyphToCharHeader = RECORD
		version:				Fixed;
		actionOffset:			WSISubtableOffset;						{  offset to GlyphToCharActionHeader  }
		format:					INTEGER;								{  size of font mask  }
		mappingTable:			WSILookupTableHeader;
	END;


{ JUSTIFICATION TYPES
	WorldScript supports justification of text using insertion. The justification
	table specifies a insertion string to insert between 2 specified glyphs.
	Each combination of inter-glyph boundary can be assigned a justification priority,
	the higher the priority the more justification strings inserted at that position.
	
	The priorities for each inter-glyph boundary are specified by the justification table's
	state table.
	
	Special handling is done for scripts which use spaces to justify, because the width of 
	a space varies depending on the setting of SpaceExtra. This is why the number of spaces
	per inserting string is specified in the justification table.

}

CONST
																{  1.0 not supported  }
	kCurrentJustificationVersion = $0200;

	kJustificationStateTableFormat = 1;

																{  WSI's internal limitation <12>  }
	kMaxJustificationStringLength = 13;


TYPE
	WSIJustificationPriority			= UInt8;

CONST
	WSIJustificationSetMarkMask	= $80;


TYPE
	WSIJustificationStateEntryPtr = ^WSIJustificationStateEntry;
	WSIJustificationStateEntry = PACKED RECORD
		markPriority:			WSIJustificationPriority;				{  non-zero priorities means insertion  }
		priority:				WSIJustificationPriority;
		newState:				WSIStateOffset;
	END;

	WSIJustificationClasses				= INTEGER;

CONST
	wsiJustEndOfLineClass		= 0;
	wsiJustEndOfRunClass		= 1;
	wsiJustDeletedGlyphClass	= 2;
	wsiJustUserDefinedClass		= 3;


TYPE
	WSIJustificationStates				= INTEGER;

CONST
	wsiStartOfLineState			= 0;							{  pre-defined states  }
	wsiStartOfRunState			= 1;
	wsiUserDefinedState			= 2;

{ pre-multiplied: class# * sizeof(WSIJustificationStateEntry) }

TYPE
	WSIJustificationClassOffset			= UInt8;
	WSIJustificationStateTablePtr = ^WSIJustificationStateTable;
	WSIJustificationStateTable = RECORD
		maxPriorities:			INTEGER;
		rowWidth:				INTEGER;								{  width of a state table row in bytes  }
		classTableOffset:		INTEGER;
		stateTableOffset:		INTEGER;
	END;

{
			Last two fields of above structure - someday?
			WSIJustificationClassOffset	classes[up to 64 classes supported];
			WSIJustificationStateEntry	states[up to your heart's desire];
		}
	WSIJustificationHeaderPtr = ^WSIJustificationHeader;
	WSIJustificationHeader = RECORD
		version:				INTEGER;
		format:					INTEGER;
		scaling:				Point;									{  numer/denom scaling of priority weights <7>  }
		spacesPerInsertion:		INTEGER;								{  # of $20 chars in justification insertion string <12>  }
		justStringOffset:		INTEGER;								{  offset to justification string  }
		stateTable:				WSIJustificationStateTable;				{  long-aligned boundary aligned w/ spacesPerInsertion field - justification string follows  }
	END;


{ Line Layout's Property table version <11> }

CONST
																{  v1.0  }
	currentPropsTableVersion	= $00010000;

																{  version is octal 0100 or hex 0x40 (#64)  }
	kCharToGlyphCurrentVersion	= $40;

{ pass as priorityWeight to JustifyWSILayout to use script's current just setting }
	kScriptsDefaultJustWeight	= -1;


{ feature selectors used in FindScriptRun and itl5 configuration tables <9> }

TYPE
	WSIFeatureType						= UInt16;
	WSIFeatureSelector					= UInt16;
	WSIFeaturePtr = ^WSIFeature;
	WSIFeature = RECORD
		featureType:			WSIFeatureType;
		featureSelector:		WSIFeatureSelector;
	END;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := WorldScriptIncludes}

{$ENDC} {__WORLDSCRIPT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
