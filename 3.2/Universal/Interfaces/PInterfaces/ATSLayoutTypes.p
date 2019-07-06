{
 	File:		ATSLayoutTypes.p
 
 	Contains:	Apple Text Services layout public structures and constants.
 
 	Version:	Technology:	Allegro
 				Release:	Universal Interfaces 3.2
 
 	Copyright:	© 1994-1998 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT ATSLayoutTypes;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __ATSLAYOUTTYPES__}
{$SETC __ATSLAYOUTTYPES__ := 1}

{$I+}
{$SETC ATSLayoutTypesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __SFNTTYPES__}
{$I SFNTTypes.p}
{$ENDC}
{$IFC UNDEFINED __SFNTLAYOUTTYPES__}
{$I SFNTLayoutTypes.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ ----------------------------------------------------------------------------------------- }
{ CONSTANTS }
{ LineOptions flags }

CONST
	kATSLineNoLayoutOptions		= $00000000;
	kATSLineIsDisplayOnly		= $00000001;
	kATSLineHasNoHangers		= $00000002;
	kATSLineHasNoOpticalAlignment = $00000004;
	kATSLineKeepSpacesOutOfMargin = $00000008;
	kATSLineNoSpecialJustification = $00000010;
	kATSLineLastNoJustification	= $00000020;

{ Miscellaneous constants }
	kATSExtendedQDScale			= 81920;						{  fixed value of 1.25  }
	kATSCondensedQDScale		= 52428;						{  fixed value of approx. 0.8  }
	kATSItalicQDSkew			= $00004000;					{  fixed value of 0.25  }
	kATSRadiansFactor			= 1144;							{  fixed value of approx. pi/180 (0.0174560546875)  }
	kATSNoTracking				= $80000000;					{  negativeInfinity  }
	kATSDeletedGlyphcode		= $FFFF;
	kATSSelectToEnd				= $FFFFFFFF;
	kATSOffsetToNoData			= $FFFFFFFF;

{ --------------------------------------------------------------------------- }
{ TYPES }
{ --------------------------------------------------------------------------- }

TYPE
	ATSLineLayoutOptions				= UInt32;
{
	The JustWidthDeltaEntryOverride structure specifies values for the grow and shrink case during
	justification, both on the left and on the right. It also contains flags.  This particular structure
	is used for passing justification overrides to LLC.  For further sfnt resource 'just' table
	constants and structures, see SFNTLayoutTypes.h.
}
	ATSJustWidthDeltaEntryOverridePtr = ^ATSJustWidthDeltaEntryOverride;
	ATSJustWidthDeltaEntryOverride = RECORD
		beforeGrowLimit:		Fixed;									{  ems AW can grow by at most on LT  }
		beforeShrinkLimit:		Fixed;									{  ems AW can shrink by at most on LT  }
		afterGrowLimit:			Fixed;									{  ems AW can grow by at most on RB  }
		afterShrinkLimit:		Fixed;									{  ems AW can shrink by at most on RB  }
		growFlags:				JustificationFlags;						{  flags controlling grow case  }
		shrinkFlags:			JustificationFlags;						{  flags controlling shrink case  }
	END;

{ The JustPriorityOverrides type is an array of 4 width delta records, one per priority level override. }
	ATSJustPriorityWidthDeltaOverrides	= ARRAY [0..3] OF ATSJustWidthDeltaEntryOverride;
{ --------------------------------------------------------------------------- }
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ATSLayoutTypesIncludes}

{$ENDC} {__ATSLAYOUTTYPES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
