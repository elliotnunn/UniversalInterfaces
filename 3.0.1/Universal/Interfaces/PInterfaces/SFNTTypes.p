{
 	File:		SFNTTypes.p
 
 	Contains:	Font file structures.
 
 	Version:	Technology:	Quickdraw GX 1.1
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
 UNIT SFNTTypes;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __SFNTTYPES__}
{$SETC __SFNTTYPES__ := 1}

{$I+}
{$SETC SFNTTypesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	sfntDirectoryEntryPtr = ^sfntDirectoryEntry;
	sfntDirectoryEntry = RECORD
		tableTag:				FourCharCode;
		checkSum:				UInt32;
		offset:					UInt32;
		length:					UInt32;
	END;

{ The search fields limits numOffsets to 4096. }
	sfntDirectoryPtr = ^sfntDirectory;
	sfntDirectory = RECORD
		format:					FourCharCode;
		numOffsets:				UInt16;									{  number of tables  }
		searchRange:			UInt16;									{  (max2 <= numOffsets)*16  }
		entrySelector:			UInt16;									{  log2(max2 <= numOffsets)  }
		rangeShift:				UInt16;									{  numOffsets*16-searchRange }
		table:					ARRAY [0..0] OF sfntDirectoryEntry;		{  table[numOffsets]  }
	END;


CONST
	sizeof_sfntDirectory		= 12;

{ Cmap - character id to glyph id mapping }
	cmapFontTableTag			= 'cmap';


TYPE
	sfntCMapSubHeaderPtr = ^sfntCMapSubHeader;
	sfntCMapSubHeader = RECORD
		format:					UInt16;
		length:					UInt16;
		languageID:				UInt16;									{  base-1  }
	END;


CONST
	sizeof_sfntCMapSubHeader	= 6;


TYPE
	sfntCMapEncodingPtr = ^sfntCMapEncoding;
	sfntCMapEncoding = RECORD
		platformID:				UInt16;									{  base-0  }
		scriptID:				UInt16;									{  base-0  }
		offset:					UInt32;
	END;


CONST
	sizeof_sfntCMapEncoding		= 8;


TYPE
	sfntCMapHeaderPtr = ^sfntCMapHeader;
	sfntCMapHeader = RECORD
		version:				UInt16;
		numTables:				UInt16;
		encoding:				ARRAY [0..0] OF sfntCMapEncoding;
	END;


CONST
	sizeof_sfntCMapHeader		= 4;

{ Name table }
	nameFontTableTag			= 'name';


TYPE
	sfntNameRecordPtr = ^sfntNameRecord;
	sfntNameRecord = RECORD
		platformID:				UInt16;									{  base-0  }
		scriptID:				UInt16;									{  base-0  }
		languageID:				UInt16;									{  base-0  }
		nameID:					UInt16;									{  base-0  }
		length:					UInt16;
		offset:					UInt16;
	END;


CONST
	sizeof_sfntNameRecord		= 12;


TYPE
	sfntNameHeaderPtr = ^sfntNameHeader;
	sfntNameHeader = RECORD
		format:					UInt16;
		count:					UInt16;
		stringOffset:			UInt16;
		rec:					ARRAY [0..0] OF sfntNameRecord;
	END;


CONST
	sizeof_sfntNameHeader		= 6;

{ Fvar table - font variations }
	variationFontTableTag		= 'fvar';

{ These define each font variation }

TYPE
	sfntVariationAxisPtr = ^sfntVariationAxis;
	sfntVariationAxis = RECORD
		axisTag:				FourCharCode;
		minValue:				Fixed;
		defaultValue:			Fixed;
		maxValue:				Fixed;
		flags:					SInt16;
		nameID:					SInt16;
	END;


CONST
	sizeof_sfntVariationAxis	= 20;

{ These are named locations in style-space for the user }

TYPE
	sfntInstancePtr = ^sfntInstance;
	sfntInstance = RECORD
		nameID:					SInt16;
		flags:					SInt16;
		coord:					ARRAY [0..0] OF Fixed;					{  [axisCount]  }
																		{  room to grow since the header carries a tupleSize field  }
	END;


CONST
	sizeof_sfntInstance			= 4;


TYPE
	sfntVariationHeaderPtr = ^sfntVariationHeader;
	sfntVariationHeader = RECORD
		version:				Fixed;									{  1.0 Fixed  }
		offsetToData:			UInt16;									{  to first axis = 16 }
		countSizePairs:			UInt16;									{  axis+inst = 2  }
		axisCount:				UInt16;
		axisSize:				UInt16;
		instanceCount:			UInt16;
		instanceSize:			UInt16;
																		{  …other <count,size> pairs  }
		axis:					ARRAY [0..0] OF sfntVariationAxis;		{  [axisCount]  }
		instance:				ARRAY [0..0] OF sfntInstance;			{  [instanceCount]  …other arrays of data  }
	END;


CONST
	sizeof_sfntVariationHeader	= 16;

{ Fdsc table - font descriptor }
	descriptorFontTableTag		= 'fdsc';


TYPE
	sfntFontDescriptorPtr = ^sfntFontDescriptor;
	sfntFontDescriptor = RECORD
		name:					FourCharCode;
		value:					Fixed;
	END;

	sfntDescriptorHeaderPtr = ^sfntDescriptorHeader;
	sfntDescriptorHeader = RECORD
		version:				Fixed;									{  1.0 in Fixed  }
		descriptorCount:		SInt32;
		descriptor:				ARRAY [0..0] OF sfntFontDescriptor;
	END;


CONST
	sizeof_sfntDescriptorHeader	= 8;

{ Feat Table - layout feature table }
	featureFontTableTag			= 'feat';


TYPE
	sfntFeatureNamePtr = ^sfntFeatureName;
	sfntFeatureName = RECORD
		featureType:			UInt16;
		settingCount:			UInt16;
		offsetToSettings:		SInt32;
		featureFlags:			UInt16;
		nameID:					UInt16;
	END;

	sfntFontFeatureSettingPtr = ^sfntFontFeatureSetting;
	sfntFontFeatureSetting = RECORD
		setting:				UInt16;
		nameID:					UInt16;
	END;

	sfntFontRunFeaturePtr = ^sfntFontRunFeature;
	sfntFontRunFeature = RECORD
		featureType:			UInt16;
		setting:				UInt16;
	END;

	sfntFeatureHeaderPtr = ^sfntFeatureHeader;
	sfntFeatureHeader = RECORD
		version:				SInt32;									{  1.0  }
		featureNameCount:		UInt16;
		featureSetCount:		UInt16;
		reserved:				SInt32;									{  set to 0  }
		names:					ARRAY [0..0] OF sfntFeatureName;
		settings:				ARRAY [0..0] OF sfntFontFeatureSetting;
		runs:					ARRAY [0..0] OF sfntFontRunFeature;
	END;

{ OS/2 Table }

CONST
	os2FontTableTag				= 'OS/2';

{  Special invalid glyph ID value, useful as a sentinel value, for example }
	nonGlyphID					= 65535;

{ Data types for encoding components as used in interfaces }

TYPE
	FontPlatformCode					= UInt32;
	FontScriptCode						= UInt32;
	FontLanguageCode					= UInt32;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := SFNTTypesIncludes}

{$ENDC} {__SFNTTYPES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
