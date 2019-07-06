{
 	File:		GoggleSprocket.p
 
 	Contains:	Games Sprockets: GoggleSprocket interfaces
 
 	Version:	Technology:	Goggle Sprocket 1.1
 				Release:	Universal Interfaces 3.1
 
 	Copyright:	© 1996-1998 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT GoggleSprocket;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __GOGGLESPROCKET__}
{$SETC __GOGGLESPROCKET__ := 1}

{$I+}
{$SETC GoggleSprocketIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{$IFC TARGET_CPU_PPC }
{
********************************************************************************
** constants & data types
********************************************************************************
}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	GSpEventProcPtr = FUNCTION(VAR inEvent: EventRecord): BOOLEAN; C;
{$ELSEC}
	GSpEventProcPtr = ProcPtr;
{$ENDC}

{
********************************************************************************
** prototypes for application level calls
********************************************************************************
}
{ general }
FUNCTION GSpStartup(inReserved: UInt32): OSStatus; C;
FUNCTION GSpShutdown(inReserved: UInt32): OSStatus; C;
{ configuration }
FUNCTION GSpConfigure(inEventProc: GSpEventProcPtr; VAR inUpperLeft: Point): OSStatus; C;
{$ENDC}  {TARGET_CPU_PPC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := GoggleSprocketIncludes}

{$ENDC} {__GOGGLESPROCKET__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
