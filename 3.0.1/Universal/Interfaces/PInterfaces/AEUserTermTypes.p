{
 	File:		AEUserTermTypes.p
 
 	Contains:	AppleEvents AEUT resource format Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1991-1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT AEUserTermTypes;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __AEUSERTERMTYPES__}
{$SETC __AEUSERTERMTYPES__ := 1}

{$I+}
{$SETC AEUserTermTypesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	kAEUserTerminology			= 'aeut';						{   0x61657574   }
	kAETerminologyExtension		= 'aete';						{   0x61657465   }
	kAEScriptingSizeResource	= 'scsz';						{   0x7363737a   }

	kAEUTHasReturningParam		= 31;							{  if event has a keyASReturning param  }
	kAEUTOptional				= 15;							{  if something is optional  }
	kAEUTlistOfItems			= 14;							{  if property or reply is a list.  }
	kAEUTEnumerated				= 13;							{  if property or reply is of an enumerated type.  }
	kAEUTReadWrite				= 12;							{  if property is writable.  }
	kAEUTChangesState			= 12;							{  if an event changes state.  }
	kAEUTTightBindingFunction	= 12;							{  if this is a tight-binding precedence function.  }
	kAEUTApostrophe				= 3;							{  if a term contains an apostrophe.  }
	kAEUTFeminine				= 2;							{  if a term is feminine gender.  }
	kAEUTMasculine				= 1;							{  if a term is masculine gender.  }
	kAEUTPlural					= 0;							{  if a term is plural.  }


TYPE
	TScriptingSizeResourcePtr = ^TScriptingSizeResource;
	TScriptingSizeResource = RECORD
		scriptingSizeFlags:		INTEGER;
		minStackSize:			LONGINT;
		preferredStackSize:		LONGINT;
		maxStackSize:			LONGINT;
		minHeapSize:			LONGINT;
		preferredHeapSize:		LONGINT;
		maxHeapSize:			LONGINT;
	END;


CONST
	kLaunchToGetTerminology		= $8000;						{ 	If kLaunchToGetTerminology is 0, 'aete' is read directly from res file.  If set to 1, then launch and use 'gdut' to get terminology.  }
	kDontFindAppBySignature		= $4000;						{ 	If kDontFindAppBySignature is 0, then find app with signature if lost.  If 1, then don't  }
	kAlwaysSendSubject			= $2000;						{  	If kAlwaysSendSubject 0, then send subject when appropriate. If 1, then every event has Subject Attribute  }

{ old names for above bits. }
	kReadExtensionTermsMask		= $8000;




{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := AEUserTermTypesIncludes}

{$ENDC} {__AEUSERTERMTYPES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
