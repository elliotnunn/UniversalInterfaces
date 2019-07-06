{
 	File:		Scrap.p
 
 	Contains:	Scrap Manager Interfaces.
 
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
 UNIT Scrap;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __SCRAP__}
{$SETC __SCRAP__ := 1}

{$I+}
{$SETC ScrapIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
  _________________________________________________________________________________________________________
   • CLASSIC SCRAP MANAGER API
  _________________________________________________________________________________________________________
}


TYPE
	ScrapStuffPtr = ^ScrapStuff;
	ScrapStuff = RECORD
		scrapSize:				SInt32;
		scrapHandle:			Handle;
		scrapCount:				SInt16;
		scrapState:				SInt16;
		scrapName:				StringPtr;
	END;

	PScrapStuff							= ^ScrapStuff;
FUNCTION InfoScrap: ScrapStuffPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9F9;
	{$ENDC}
FUNCTION UnloadScrap: SInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9FA;
	{$ENDC}
FUNCTION LoadScrap: SInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9FB;
	{$ENDC}
FUNCTION GetScrap(hDest: Handle; theType: ResType; VAR offset: SInt32): SInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9FD;
	{$ENDC}
FUNCTION ZeroScrap: SInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9FC;
	{$ENDC}
FUNCTION PutScrap(length: SInt32; theType: ResType; source: UNIV Ptr): SInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9FE;
	{$ENDC}
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ScrapIncludes}

{$ENDC} {__SCRAP__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
