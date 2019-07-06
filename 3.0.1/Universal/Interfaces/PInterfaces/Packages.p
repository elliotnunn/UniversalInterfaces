{
 	File:		Packages.p
 
 	Contains:	Package Manager Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1985-1997, 1995, 1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Packages;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __PACKAGES__}
{$SETC __PACKAGES__ := 1}

{$I+}
{$SETC PackagesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	listMgr						= 0;							{  list manager  }
	dskInit						= 2;							{  Disk Initializaton  }
	stdFile						= 3;							{  Standard File  }
	flPoint						= 4;							{  Floating-Point Arithmetic  }
	trFunc						= 5;							{  Transcendental Functions  }
	intUtil						= 6;							{  International Utilities  }
	bdConv						= 7;							{  Binary/Decimal Conversion  }
	editionMgr					= 11;							{  Edition Manager  }

PROCEDURE InitPack(packID: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9E5;
	{$ENDC}
PROCEDURE InitAllPacks;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9E6;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := PackagesIncludes}

{$ENDC} {__PACKAGES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}