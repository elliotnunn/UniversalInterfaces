{
     File:       Aliases.p
 
     Contains:   Alias Manager Interfaces.
 
     Version:    Technology: Mac OS 8.1
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1989-2000 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Aliases;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __ALIASES__}
{$SETC __ALIASES__ := 1}

{$I+}
{$SETC AliasesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	rAliasType					= 'alis';						{  Aliases are stored as resources of this type  }

																{  define alias resolution action rules mask  }
	kARMMountVol				= $00000001;					{  mount the volume automatically  }
	kARMNoUI					= $00000002;					{  no user interface allowed during resolution  }
	kARMMultVols				= $00000008;					{  search on multiple volumes  }
	kARMSearch					= $00000100;					{  search quickly  }
	kARMSearchMore				= $00000200;					{  search further  }
	kARMSearchRelFirst			= $00000400;					{  search target on a relative path first  }

																{  define alias record information types  }
	asiZoneName					= -3;							{  get zone name  }
	asiServerName				= -2;							{  get server name  }
	asiVolumeName				= -1;							{  get volume name  }
	asiAliasName				= 0;							{  get aliased file/folder/volume name  }
	asiParentName				= 1;							{  get parent folder name  }

{ ResolveAliasFileWithMountFlags options }
	kResolveAliasFileNoUI		= $00000001;					{  no user interaction during resolution  }

{ define the alias record that will be the blackbox for the caller }

TYPE
	AliasRecordPtr = ^AliasRecord;
	AliasRecord = RECORD
		userType:				OSType;									{  appl stored type like creator type  }
		aliasSize:				UInt16;									{  alias record size in bytes, for appl usage  }
	END;

	AliasPtr							= ^AliasRecord;
	AliasHandle							= ^AliasPtr;
{ alias record information type }
	AliasInfoType						= INTEGER;
{  create a new alias between fromFile-target and return alias record handle  }
FUNCTION NewAlias(fromFile: {Const}FSSpecPtr; {CONST}VAR target: FSSpec; VAR alias: AliasHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7002, $A823;
	{$ENDC}
{ create a minimal new alias for a target and return alias record handle }
FUNCTION NewAliasMinimal({CONST}VAR target: FSSpec; VAR alias: AliasHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7008, $A823;
	{$ENDC}
{ create a minimal new alias from a target fullpath (optional zone and server name) and return alias record handle  }
FUNCTION NewAliasMinimalFromFullPath(fullPathLength: INTEGER; fullPath: UNIV Ptr; zoneName: Str32; serverName: Str31; VAR alias: AliasHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7009, $A823;
	{$ENDC}
{ given an alias handle and fromFile, resolve the alias, update the alias record and return aliased filename and wasChanged flag. }
FUNCTION ResolveAlias(fromFile: {Const}FSSpecPtr; alias: AliasHandle; VAR target: FSSpec; VAR wasChanged: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7003, $A823;
	{$ENDC}
{ given an alias handle and an index specifying requested alias information type, return the information from alias record as a string. }
FUNCTION GetAliasInfo(alias: AliasHandle; index: AliasInfoType; VAR theString: Str63): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7007, $A823;
	{$ENDC}

FUNCTION IsAliasFile({CONST}VAR fileFSSpec: FSSpec; VAR aliasFileFlag: BOOLEAN; VAR folderFlag: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $702A, $A823;
	{$ENDC}
FUNCTION ResolveAliasWithMountFlags(fromFile: {Const}FSSpecPtr; alias: AliasHandle; VAR target: FSSpec; VAR wasChanged: BOOLEAN; mountFlags: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $702B, $A823;
	{$ENDC}
{ 
  Given a file spec, return target file spec if input file spec is an alias.
  It resolves the entire alias chain or one step of the chain.  It returns
  info about whether the target is a folder or file; and whether the input
  file spec was an alias or not. 
}
FUNCTION ResolveAliasFile(VAR theSpec: FSSpec; resolveAliasChains: BOOLEAN; VAR targetIsFolder: BOOLEAN; VAR wasAliased: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700C, $A823;
	{$ENDC}

FUNCTION ResolveAliasFileWithMountFlags(VAR theSpec: FSSpec; resolveAliasChains: BOOLEAN; VAR targetIsFolder: BOOLEAN; VAR wasAliased: BOOLEAN; mountFlags: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7029, $A823;
	{$ENDC}
FUNCTION FollowFinderAlias(fromFile: {Const}FSSpecPtr; alias: AliasHandle; logon: BOOLEAN; VAR target: FSSpec; VAR wasChanged: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700F, $A823;
	{$ENDC}
{ 
   Low Level Routines 
}
{ given a fromFile-target pair and an alias handle, update the lias record pointed to by alias handle to represent target as the new alias. }
FUNCTION UpdateAlias(fromFile: {Const}FSSpecPtr; {CONST}VAR target: FSSpec; alias: AliasHandle; VAR wasChanged: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7006, $A823;
	{$ENDC}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	AliasFilterProcPtr = FUNCTION(cpbPtr: CInfoPBPtr; VAR quitFlag: BOOLEAN; myDataPtr: Ptr): BOOLEAN;
{$ELSEC}
	AliasFilterProcPtr = ProcPtr;
{$ENDC}

	AliasFilterUPP = UniversalProcPtr;

CONST
	uppAliasFilterProcInfo = $00000FD0;

FUNCTION NewAliasFilterUPP(userRoutine: AliasFilterProcPtr): AliasFilterUPP; { old name was NewAliasFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeAliasFilterUPP(userUPP: AliasFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

FUNCTION InvokeAliasFilterUPP(cpbPtr: CInfoPBPtr; VAR quitFlag: BOOLEAN; myDataPtr: Ptr; userRoutine: AliasFilterUPP): BOOLEAN; { old name was CallAliasFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{  Given an alias handle and fromFile, match the alias and return aliased filename(s) and needsUpdate flag }
FUNCTION MatchAlias(fromFile: {Const}FSSpecPtr; rulesMask: UInt32; alias: AliasHandle; VAR aliasCount: INTEGER; aliasList: FSSpecArrayPtr; VAR needsUpdate: BOOLEAN; aliasFilter: AliasFilterUPP; yourDataPtr: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7005, $A823;
	{$ENDC}


{ The follow two calls are for Carbon only.  They allow tools and background apps to have
    AliasMgr functionality without ever having to deal with UI }
FUNCTION ResolveAliasFileWithMountFlagsNoUI(VAR theSpec: FSSpec; resolveAliasChains: BOOLEAN; VAR targetIsFolder: BOOLEAN; VAR wasAliased: BOOLEAN; mountFlags: UInt32): OSErr;
FUNCTION MatchAliasNoUI(fromFile: {Const}FSSpecPtr; rulesMask: UInt32; alias: AliasHandle; VAR aliasCount: INTEGER; aliasList: FSSpecArrayPtr; VAR needsUpdate: BOOLEAN; aliasFilter: AliasFilterUPP; yourDataPtr: UNIV Ptr): OSErr;


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := AliasesIncludes}

{$ENDC} {__ALIASES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
