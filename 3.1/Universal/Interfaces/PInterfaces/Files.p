{
 	File:		Files.p
 
 	Contains:	File Manager (HFS and MFS) Interfaces.
 
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
 UNIT Files;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __FILES__}
{$SETC __FILES__ := 1}

{$I+}
{$SETC FilesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{$IFC UNDEFINED __OSUTILS__}
{$I OSUtils.p}
{$ENDC}

{ Finder constants where moved to Finder.≈ }
{$IFC UNDEFINED __FINDER__}
{$I Finder.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	fsAtMark					= 0;
	fsCurPerm					= 0;
	fsRdPerm					= 1;
	fInvisible					= 16384;
	fsWrPerm					= 2;
	fsRdWrPerm					= 3;
	fsRdWrShPerm				= 4;
	fsFromStart					= 1;
	fsFromLEOF					= 2;
	fsFromMark					= 3;
	rdVerify					= 64;
	ioMapBuffer					= 4;
	ioModeReserved				= 8;
	ioDirFlg					= 4;							{  see IM IV-125  }
	ioDirMask					= $10;
	fsRtParID					= 1;
	fsRtDirID					= 2;


																{  CatSearch Search bitmask Constants  }
	fsSBPartialName				= 1;
	fsSBFullName				= 2;
	fsSBFlAttrib				= 4;
	fsSBFlFndrInfo				= 8;
	fsSBFlLgLen					= 32;
	fsSBFlPyLen					= 64;
	fsSBFlRLgLen				= 128;
	fsSBFlRPyLen				= 256;
	fsSBFlCrDat					= 512;
	fsSBFlMdDat					= 1024;
	fsSBFlBkDat					= 2048;
	fsSBFlXFndrInfo				= 4096;
	fsSBFlParID					= 8192;
	fsSBNegate					= 16384;
	fsSBDrUsrWds				= 8;
	fsSBDrNmFls					= 16;
	fsSBDrCrDat					= 512;
	fsSBDrMdDat					= 1024;
	fsSBDrBkDat					= 2048;
	fsSBDrFndrInfo				= 4096;
	fsSBDrParID					= 8192;

																{  CatSearch Search bit value Constants  }
	fsSBPartialNameBit			= 0;							{ ioFileName points to a substring }
	fsSBFullNameBit				= 1;							{ ioFileName points to a match string }
	fsSBFlAttribBit				= 2;							{ search includes file attributes }
	fsSBFlFndrInfoBit			= 3;							{ search includes finder info }
	fsSBFlLgLenBit				= 5;							{ search includes data logical length }
	fsSBFlPyLenBit				= 6;							{ search includes data physical length }
	fsSBFlRLgLenBit				= 7;							{ search includes resource logical length }
	fsSBFlRPyLenBit				= 8;							{ search includes resource physical length }
	fsSBFlCrDatBit				= 9;							{ search includes create date }
	fsSBFlMdDatBit				= 10;							{ search includes modification date }
	fsSBFlBkDatBit				= 11;							{ search includes backup date }
	fsSBFlXFndrInfoBit			= 12;							{ search includes extended finder info }
	fsSBFlParIDBit				= 13;							{ search includes file's parent ID }
	fsSBNegateBit				= 14;							{ return all non-matches }
	fsSBDrUsrWdsBit				= 3;							{ search includes directory finder info }
	fsSBDrNmFlsBit				= 4;							{ search includes directory valence }
	fsSBDrCrDatBit				= 9;							{ directory-named version of fsSBFlCrDatBit }
	fsSBDrMdDatBit				= 10;							{ directory-named version of fsSBFlMdDatBit }
	fsSBDrBkDatBit				= 11;							{ directory-named version of fsSBFlBkDatBit }
	fsSBDrFndrInfoBit			= 12;							{ directory-named version of fsSBFlXFndrInfoBit }
	fsSBDrParIDBit				= 13;							{ directory-named version of fsSBFlParIDBit }

																{  vMAttrib (GetVolParms) bit position constants  }
	bLimitFCBs					= 31;
	bLocalWList					= 30;
	bNoMiniFndr					= 29;
	bNoVNEdit					= 28;
	bNoLclSync					= 27;
	bTrshOffLine				= 26;
	bNoSwitchTo					= 25;
	bNoDeskItems				= 20;
	bNoBootBlks					= 19;
	bAccessCntl					= 18;
	bNoSysDir					= 17;
	bHasExtFSVol				= 16;
	bHasOpenDeny				= 15;
	bHasCopyFile				= 14;
	bHasMoveRename				= 13;
	bHasDesktopMgr				= 12;
	bHasShortName				= 11;
	bHasFolderLock				= 10;
	bHasPersonalAccessPrivileges = 9;
	bHasUserGroupList			= 8;
	bHasCatSearch				= 7;
	bHasFileIDs					= 6;
	bHasBTreeMgr				= 5;
	bHasBlankAccessPrivileges	= 4;
	bSupportsAsyncRequests		= 3;							{  asynchronous requests to this volume are handled correctly at any time }
	bSupportsTrashVolumeCache	= 2;


																{  Desktop Database icon Constants  }
	kLargeIcon					= 1;
	kLarge4BitIcon				= 2;
	kLarge8BitIcon				= 3;
	kSmallIcon					= 4;
	kSmall4BitIcon				= 5;
	kSmall8BitIcon				= 6;

	kLargeIconSize				= 256;
	kLarge4BitIconSize			= 512;
	kLarge8BitIconSize			= 1024;
	kSmallIconSize				= 64;
	kSmall4BitIconSize			= 128;
	kSmall8BitIconSize			= 256;

																{  Foreign Privilege Model Identifiers  }
	fsUnixPriv					= 1;

																{  Authentication Constants  }
	kNoUserAuthentication		= 1;
	kPassword					= 2;
	kEncryptPassword			= 3;
	kTwoWayEncryptPassword		= 6;


{ mapping codes (ioObjType) for MapName & MapID }
	kOwnerID2Name				= 1;
	kGroupID2Name				= 2;
	kOwnerName2ID				= 3;
	kGroupName2ID				= 4;							{  types of oj object to be returned (ioObjType) for _GetUGEntry  }
	kReturnNextUser				= 1;
	kReturnNextGroup			= 2;
	kReturnNextUG				= 3;



{ Folder and File values of access privileges }
	kfullPrivileges				= $00070007;					{ 			; all privileges for everybody and owner }
	kownerPrivileges			= $00000007;					{ 			; all privileges for owner only }

{ values of user IDs and group IDs }
	knoUser						= 0;
	kadministratorUser			= 1;

	knoGroup					= 0;



TYPE
	GetVolParmsInfoBufferPtr = ^GetVolParmsInfoBuffer;
	GetVolParmsInfoBuffer = RECORD
		vMVersion:				INTEGER;								{ version number }
		vMAttrib:				LONGINT;								{ bit vector of attributes (see vMAttrib constants) }
		vMLocalHand:			Handle;									{ handle to private data }
		vMServerAdr:			LONGINT;								{ AppleTalk server address or zero }
		vMVolumeGrade:			LONGINT;								{ approx. speed rating or zero if unrated }
		vMForeignPrivID:		INTEGER;								{ foreign privilege model supported or zero if none }
	END;

	ParmBlkPtr							= ^ParamBlockRec;
{$IFC TYPED_FUNCTION_POINTERS}
	IOCompletionProcPtr = PROCEDURE(paramBlock: ParmBlkPtr);
{$ELSEC}
	IOCompletionProcPtr = Register68kProcPtr;
{$ENDC}

	IOCompletionUPP = UniversalProcPtr;
	IOParamPtr = ^IOParam;
	IOParam = RECORD
		qLink:					QElemPtr;								{ queue link in header }
		qType:					INTEGER;								{ type byte for safety check }
		ioTrap:					INTEGER;								{ FS: the Trap }
		ioCmdAddr:				Ptr;									{ FS: address to dispatch to }
		ioCompletion:			IOCompletionUPP;						{ completion routine addr (0 for synch calls) }
		ioResult:				OSErr;									{ result code }
		ioNamePtr:				StringPtr;								{ ptr to Vol:FileName string }
		ioVRefNum:				INTEGER;								{ volume refnum (DrvNum for Eject and MountVol) }
		ioRefNum:				INTEGER;								{ refNum for I/O operation }
		ioVersNum:				SInt8;									{ version number }
		ioPermssn:				SInt8;									{ Open: permissions (byte) }
		ioMisc:					Ptr;									{ Rename: new name (GetEOF,SetEOF: logical end of file) (Open: optional ptr to buffer) (SetFileType: new type) }
		ioBuffer:				Ptr;									{ data buffer Ptr }
		ioReqCount:				LONGINT;								{ requested byte count; also = ioNewDirID }
		ioActCount:				LONGINT;								{ actual byte count completed }
		ioPosMode:				INTEGER;								{ initial file positioning }
		ioPosOffset:			LONGINT;								{ file position offset }
	END;

	FileParamPtr = ^FileParam;
	FileParam = RECORD
		qLink:					QElemPtr;								{ queue link in header }
		qType:					INTEGER;								{ type byte for safety check }
		ioTrap:					INTEGER;								{ FS: the Trap }
		ioCmdAddr:				Ptr;									{ FS: address to dispatch to }
		ioCompletion:			IOCompletionUPP;						{ completion routine addr (0 for synch calls) }
		ioResult:				OSErr;									{ result code }
		ioNamePtr:				StringPtr;								{ ptr to Vol:FileName string }
		ioVRefNum:				INTEGER;								{ volume refnum (DrvNum for Eject and MountVol) }
		ioFRefNum:				INTEGER;								{ reference number }
		ioFVersNum:				SInt8;									{ version number }
		filler1:				SInt8;
		ioFDirIndex:			INTEGER;								{ GetFInfo directory index }
		ioFlAttrib:				SInt8;									{ GetFInfo: in-use bit=7, lock bit=0 }
		ioFlVersNum:			SInt8;									{ file version number }
		ioFlFndrInfo:			FInfo;									{ user info }
		ioFlNum:				UInt32;									{ GetFInfo: file number; TF- ioDirID }
		ioFlStBlk:				UInt16;									{ start file block (0 if none) }
		ioFlLgLen:				LONGINT;								{ logical length (EOF) }
		ioFlPyLen:				LONGINT;								{ physical length }
		ioFlRStBlk:				UInt16;									{ start block rsrc fork }
		ioFlRLgLen:				LONGINT;								{ file logical length rsrc fork }
		ioFlRPyLen:				LONGINT;								{ file physical length rsrc fork }
		ioFlCrDat:				UInt32;									{ file creation date& time (32 bits in secs) }
		ioFlMdDat:				UInt32;									{ last modified date and time }
	END;

	VolumeParamPtr = ^VolumeParam;
	VolumeParam = RECORD
		qLink:					QElemPtr;								{ queue link in header }
		qType:					INTEGER;								{ type byte for safety check }
		ioTrap:					INTEGER;								{ FS: the Trap }
		ioCmdAddr:				Ptr;									{ FS: address to dispatch to }
		ioCompletion:			IOCompletionUPP;						{ completion routine addr (0 for synch calls) }
		ioResult:				OSErr;									{ result code }
		ioNamePtr:				StringPtr;								{ ptr to Vol:FileName string }
		ioVRefNum:				INTEGER;								{ volume refnum (DrvNum for Eject and MountVol) }
		filler2:				LONGINT;
		ioVolIndex:				INTEGER;								{ volume index number }
		ioVCrDate:				UInt32;									{ creation date and time }
		ioVLsBkUp:				UInt32;									{ last backup date and time }
		ioVAtrb:				UInt16;									{ volume attrib }
		ioVNmFls:				UInt16;									{ number of files in directory }
		ioVDirSt:				UInt16;									{ start block of file directory }
		ioVBlLn:				INTEGER;								{ GetVolInfo: length of dir in blocks }
		ioVNmAlBlks:			UInt16;									{ for compatibilty ioVNmAlBlks * ioVAlBlkSiz <= 2 GB }
		ioVAlBlkSiz:			UInt32;									{ for compatibilty ioVAlBlkSiz is <= $0000FE00 (65,024) }
		ioVClpSiz:				UInt32;									{ GetVolInfo: bytes to allocate at a time }
		ioAlBlSt:				UInt16;									{ starting disk(512-byte) block in block map }
		ioVNxtFNum:				UInt32;									{ GetVolInfo: next free file number }
		ioVFrBlk:				UInt16;									{ GetVolInfo: # free alloc blks for this vol }
	END;

	CntrlParamPtr = ^CntrlParam;
	CntrlParam = RECORD
		qLink:					QElemPtr;								{ queue link in header }
		qType:					INTEGER;								{ type byte for safety check }
		ioTrap:					INTEGER;								{ FS: the Trap }
		ioCmdAddr:				Ptr;									{ FS: address to dispatch to }
		ioCompletion:			IOCompletionUPP;						{ completion routine addr (0 for synch calls) }
		ioResult:				OSErr;									{ result code }
		ioNamePtr:				StringPtr;								{ ptr to Vol:FileName string }
		ioVRefNum:				INTEGER;								{ volume refnum (DrvNum for Eject and MountVol) }
		ioCRefNum:				INTEGER;								{ refNum for I/O operation }
		csCode:					INTEGER;								{ word for control status code }
		csParam:				ARRAY [0..10] OF INTEGER;				{ operation-defined parameters }
	END;

	SlotDevParamPtr = ^SlotDevParam;
	SlotDevParam = RECORD
		qLink:					QElemPtr;								{ queue link in header }
		qType:					INTEGER;								{ type byte for safety check }
		ioTrap:					INTEGER;								{ FS: the Trap }
		ioCmdAddr:				Ptr;									{ FS: address to dispatch to }
		ioCompletion:			IOCompletionUPP;						{ completion routine addr (0 for synch calls) }
		ioResult:				OSErr;									{ result code }
		ioNamePtr:				StringPtr;								{ ptr to Vol:FileName string }
		ioVRefNum:				INTEGER;								{ volume refnum (DrvNum for Eject and MountVol) }
		ioSRefNum:				INTEGER;
		ioSVersNum:				SInt8;
		ioSPermssn:				SInt8;
		ioSMix:					Ptr;
		ioSFlags:				INTEGER;
		ioSlot:					SInt8;
		ioID:					SInt8;
	END;

	MultiDevParamPtr = ^MultiDevParam;
	MultiDevParam = RECORD
		qLink:					QElemPtr;								{ queue link in header }
		qType:					INTEGER;								{ type byte for safety check }
		ioTrap:					INTEGER;								{ FS: the Trap }
		ioCmdAddr:				Ptr;									{ FS: address to dispatch to }
		ioCompletion:			IOCompletionUPP;						{ completion routine addr (0 for synch calls) }
		ioResult:				OSErr;									{ result code }
		ioNamePtr:				StringPtr;								{ ptr to Vol:FileName string }
		ioVRefNum:				INTEGER;								{ volume refnum (DrvNum for Eject and MountVol) }
		ioMRefNum:				INTEGER;
		ioMVersNum:				SInt8;
		ioMPermssn:				SInt8;
		ioMMix:					Ptr;
		ioMFlags:				INTEGER;
		ioSEBlkPtr:				Ptr;
	END;

	ParamBlockRecPtr = ^ParamBlockRec;
	ParamBlockRec = RECORD
		qLink:					QElemPtr;								{ queue link in header }
		qType:					INTEGER;								{ type byte for safety check }
		ioTrap:					INTEGER;								{ FS: the Trap }
		ioCmdAddr:				Ptr;									{ FS: address to dispatch to }
		ioCompletion:			IOCompletionUPP;						{ completion routine addr (0 for synch calls) }
		ioResult:				OSErr;									{ result code }
		ioNamePtr:				StringPtr;								{ ptr to Vol:FileName string }
		ioVRefNum:				INTEGER;								{ volume refnum (DrvNum for Eject and MountVol) }
		CASE INTEGER OF
		0: (
			ioRefNum:			INTEGER;								{ refNum for I/O operation }
			ioVersNum:			SInt8;									{ version number }
			ioPermssn:			SInt8;									{ Open: permissions (byte) }
			ioMisc:				Ptr;									{ Rename: new name (GetEOF,SetEOF: logical end of file) (Open: optional ptr to buffer) (SetFileType: new type) }
			ioBuffer:			Ptr;									{ data buffer Ptr }
			ioReqCount:			LONGINT;								{ requested byte count; also = ioNewDirID }
			ioActCount:			LONGINT;								{ actual byte count completed }
			ioPosMode:			INTEGER;								{ initial file positioning }
			ioPosOffset:		LONGINT;								{ file position offset }
		   );
		1: (
			ioFRefNum:			INTEGER;								{ reference number }
			ioFVersNum:			SInt8;									{ version number }
			filler1:			SInt8;
			ioFDirIndex:		INTEGER;								{ GetFInfo directory index }
			ioFlAttrib:			SInt8;									{ GetFInfo: in-use bit=7, lock bit=0 }
			ioFlVersNum:		SInt8;									{ file version number }
			ioFlFndrInfo:		FInfo;									{ user info }
			ioFlNum:			UInt32;									{ GetFInfo: file number; TF- ioDirID }
			ioFlStBlk:			UInt16;									{ start file block (0 if none) }
			ioFlLgLen:			LONGINT;								{ logical length (EOF) }
			ioFlPyLen:			LONGINT;								{ physical length }
			ioFlRStBlk:			UInt16;									{ start block rsrc fork }
			ioFlRLgLen:			LONGINT;								{ file logical length rsrc fork }
			ioFlRPyLen:			LONGINT;								{ file physical length rsrc fork }
			ioFlCrDat:			UInt32;									{ file creation date& time (32 bits in secs) }
			ioFlMdDat:			UInt32;									{ last modified date and time }
		   );
		2: (
			filler2:			LONGINT;
			ioVolIndex:			INTEGER;								{ volume index number }
			ioVCrDate:			UInt32;									{ creation date and time }
			ioVLsBkUp:			UInt32;									{ last backup date and time }
			ioVAtrb:			UInt16;									{ volume attrib }
			ioVNmFls:			UInt16;									{ number of files in directory }
			ioVDirSt:			UInt16;									{ start block of file directory }
			ioVBlLn:			INTEGER;								{ GetVolInfo: length of dir in blocks }
			ioVNmAlBlks:		UInt16;									{ for compatibilty ioVNmAlBlks * ioVAlBlkSiz <= 2 GB }
			ioVAlBlkSiz:		UInt32;									{ for compatibilty ioVAlBlkSiz is <= $0000FE00 (65,024) }
			ioVClpSiz:			UInt32;									{ GetVolInfo: bytes to allocate at a time }
			ioAlBlSt:			UInt16;									{ starting disk(512-byte) block in block map }
			ioVNxtFNum:			UInt32;									{ GetVolInfo: next free file number }
			ioVFrBlk:			UInt16;									{ GetVolInfo: # free alloc blks for this vol }
		   );
		3: (
			ioCRefNum:			INTEGER;								{ refNum for I/O operation }
			csCode:				INTEGER;								{ word for control status code }
			csParam:			ARRAY [0..10] OF INTEGER;				{ operation-defined parameters }
		   );
		4: (
			ioSRefNum:			INTEGER;
			ioSVersNum:			SInt8;
			ioSPermssn:			SInt8;
			ioSMix:				Ptr;
			ioSFlags:			INTEGER;
			ioSlot:				SInt8;
			ioID:				SInt8;
		   );
		5: (
			ioMRefNum:			INTEGER;
			ioMVersNum:			SInt8;
			ioMPermssn:			SInt8;
			ioMMix:				Ptr;
			ioMFlags:			INTEGER;
			ioSEBlkPtr:			Ptr;
		   );
	END;

	CInfoPBRecPtr = ^CInfoPBRec;
	CInfoPBRec = RECORD
		qLink:					QElemPtr;								{ queue link in header }
		qType:					INTEGER;								{ type byte for safety check }
		ioTrap:					INTEGER;								{ FS: the Trap }
		ioCmdAddr:				Ptr;									{ FS: address to dispatch to }
		ioCompletion:			IOCompletionUPP;						{ completion routine addr (0 for synch calls) }
		ioResult:				OSErr;									{ result code }
		ioNamePtr:				StringPtr;								{ ptr to Vol:FileName string }
		ioVRefNum:				INTEGER;								{ volume refnum (DrvNum for Eject and MountVol) }
		ioFRefNum:				INTEGER;
		ioFVersNum:				SInt8;
		filler1:				SInt8;
		ioFDirIndex:			INTEGER;
		ioFlAttrib:				SInt8;
		ioACUser:				SInt8;
		CASE INTEGER OF
		0: (
			ioFlFndrInfo:		FInfo;
			ioDirID:			LONGINT;
			ioFlStBlk:			UInt16;
			ioFlLgLen:			LONGINT;
			ioFlPyLen:			LONGINT;
			ioFlRStBlk:			UInt16;
			ioFlRLgLen:			LONGINT;
			ioFlRPyLen:			LONGINT;
			ioFlCrDat:			UInt32;
			ioFlMdDat:			UInt32;
			ioFlBkDat:			UInt32;
			ioFlXFndrInfo:		FXInfo;
			ioFlParID:			LONGINT;
			ioFlClpSiz:			LONGINT;
		   );
		1: (
			ioDrUsrWds:			DInfo;
			ioDrDirID:			LONGINT;
			ioDrNmFls:			UInt16;
			filler3:			ARRAY [1..9] OF INTEGER;
			ioDrCrDat:			UInt32;
			ioDrMdDat:			UInt32;
			ioDrBkDat:			UInt32;
			ioDrFndrInfo:		DXInfo;
			ioDrParID:			LONGINT;
		   );
	END;

	CInfoPBPtr							= ^CInfoPBRec;
	CInfoPBPtrPtr 						= ^CInfoPBPtr;
	XCInfoPBRecPtr = ^XCInfoPBRec;
	XCInfoPBRec = RECORD
		qLink:					QElemPtr;
		qType:					INTEGER;
		ioTrap:					INTEGER;
		ioCmdAddr:				Ptr;
		ioCompletion:			ProcPtr;								{  --> A pointer to a completion routine  }
		ioResult:				OSErr;									{  --> The result code of the function  }
		ioNamePtr:				StringPtr;								{  --> Pointer to pathname to object  }
		ioVRefNum:				INTEGER;								{  --> A volume specification  }
		filler1:				LONGINT;
		ioShortNamePtr:			StringPtr;								{  <-> A pointer to the short name string buffer - required!  }
		filler2:				INTEGER;
		ioPDType:				INTEGER;								{  <-- The ProDOS file type  }
		ioPDAuxType:			LONGINT;								{  <-- The ProDOS aux type  }
		filler3:				ARRAY [0..1] OF LONGINT;
		ioDirID:				LONGINT;								{  --> A directory ID  }
	END;

	XCInfoPBPtr							= ^XCInfoPBRec;
{ Catalog position record }
	CatPositionRecPtr = ^CatPositionRec;
	CatPositionRec = RECORD
		initialize:				LONGINT;
		priv:					ARRAY [1..6] OF INTEGER;
	END;

	FSSpecPtr = ^FSSpec;
	FSSpec = RECORD
		vRefNum:				INTEGER;
		parID:					LONGINT;
		name:					StrFileName;							{  a Str63 on MacOS }
	END;

	FSSpecHandle						= ^FSSpecPtr;
{ pointer to array of FSSpecs }
	FSSpecArray							= ARRAY [0..0] OF FSSpec;
	FSSpecArrayPtr						= ^FSSpecArray;
{ 
	The only difference between "const FSSpec*" and "ConstFSSpecPtr" is 
	that as a parameter, ConstFSSpecPtr is allowed to be NULL 
}
	ConstFSSpecPtr						= ^FSSpec;

{ 
	The following are structures to be filled out with the _PBGetVolMountInfo call
	and passed back into the _PBVolumeMount call for external file system mounts. 
}
{ the "signature" of the file system }
	VolumeType							= OSType;

CONST
																{  the signature for AppleShare  }
	AppleShareMediaType			= 'afpm';

{
	VolMount stuff was once in FSM.≈
}

TYPE
	VolMountInfoHeaderPtr = ^VolMountInfoHeader;
	VolMountInfoHeader = RECORD
		length:					INTEGER;								{  length of location data (including self)  }
		media:					VolumeType;								{  type of media.  Variable length data follows  }
	END;

	VolMountInfoPtr						= ^VolMountInfoHeader;
{ The new volume mount info record.  The old one is included for compatibility. 
	the new record allows access by foriegn filesystems writers to the flags 
	portion of the record. This portion is now public.  
}
	VolumeMountInfoHeaderPtr = ^VolumeMountInfoHeader;
	VolumeMountInfoHeader = RECORD
		length:					INTEGER;								{  length of location data (including self)  }
		media:					VolumeType;								{  type of media (must be registered with Apple)  }
		flags:					INTEGER;								{  volume mount flags. Variable length data follows  }
	END;

{ volume mount flags }

CONST
	volMountNoLoginMsgFlagBit	= 0;							{  Input to VolumeMount: If set, the file system  }
	volMountNoLoginMsgFlagMask	= $0001;						{   should suppresss any log-in message/greeting dialog  }
	volMountExtendedFlagsBit	= 7;							{  Input to VolumeMount: If set, the mount info is a  }
	volMountExtendedFlagsMask	= $0080;						{   AFPXVolMountInfo record for 3.7 AppleShare Client  }
	volMountInteractBit			= 15;							{  Input to VolumeMount: If set, it's OK for the file system  }
	volMountInteractMask		= $8000;						{   to perform user interaction to mount the volume  }
	volMountChangedBit			= 14;							{  Output from VoumeMount: If set, the volume was mounted, but  }
	volMountChangedMask			= $4000;						{   the volume mounting information record needs to be updated.  }
	volMountFSReservedMask		= $00FF;						{  bits 0-7 are defined by each file system for its own use  }
	volMountSysReservedMask		= $FF00;						{  bits 8-15 are reserved for Apple system use  }




TYPE
	AFPVolMountInfoPtr = ^AFPVolMountInfo;
	AFPVolMountInfo = RECORD
		length:					INTEGER;								{  length of location data (including self)  }
		media:					VolumeType;								{  type of media  }
		flags:					INTEGER;								{  bits for no messages, no reconnect  }
		nbpInterval:			SInt8;									{  NBP Interval parameter (IM2, p.322)  }
		nbpCount:				SInt8;									{  NBP Interval parameter (IM2, p.322)  }
		uamType:				INTEGER;								{  User Authentication Method  }
		zoneNameOffset:			INTEGER;								{  short positive offset from start of struct to Zone Name  }
		serverNameOffset:		INTEGER;								{  offset to pascal Server Name string  }
		volNameOffset:			INTEGER;								{  offset to pascal Volume Name string  }
		userNameOffset:			INTEGER;								{  offset to pascal User Name string  }
		userPasswordOffset:		INTEGER;								{  offset to pascal User Password string  }
		volPasswordOffset:		INTEGER;								{  offset to pascal Volume Password string  }
		AFPData:				PACKED ARRAY [1..144] OF CHAR;			{  variable length data may follow  }
	END;



{ AFPXVolMountInfo is the new AFP volume mount info record, requires the 3.7 AppleShare Client }
	AFPXVolMountInfoPtr = ^AFPXVolMountInfo;
	AFPXVolMountInfo = RECORD
		length:					INTEGER;								{  length of location data (including self)  }
		media:					VolumeType;								{  type of media  }
		flags:					INTEGER;								{  bits for no messages, no reconnect  }
		nbpInterval:			SInt8;									{  NBP Interval parameter (IM2, p.322)  }
		nbpCount:				SInt8;									{  NBP Interval parameter (IM2, p.322)  }
		uamType:				INTEGER;								{  User Authentication Method type  }
		zoneNameOffset:			INTEGER;								{  short positive offset from start of struct to Zone Name  }
		serverNameOffset:		INTEGER;								{  offset to pascal Server Name string  }
		volNameOffset:			INTEGER;								{  offset to pascal Volume Name string  }
		userNameOffset:			INTEGER;								{  offset to pascal User Name string  }
		userPasswordOffset:		INTEGER;								{  offset to pascal User Password string  }
		volPasswordOffset:		INTEGER;								{  offset to pascal Volume Password string  }
		extendedFlags:			INTEGER;								{  extended flags word  }
		uamNameOffset:			INTEGER;								{  offset to a pascal UAM name string  }
		alternateAddressOffset:	INTEGER;								{  offset to Alternate Addresses in tagged format  }
		AFPData:				PACKED ARRAY [1..176] OF CHAR;			{  variable length data may follow  }
	END;


CONST
	kAFPExtendedFlagsAlternateAddressMask = 1;					{   bit in AFPXVolMountInfo.extendedFlags that means alternateAddressOffset is used }


																{  constants for use in AFPTagData.fType field }
	kAFPTagTypeIP				= $01;
	kAFPTagTypeIPPort			= $02;
	kAFPTagTypeDDP				= $03;							{  Currently unused }


																{  constants for use in AFPTagData.fLength field }
	kAFPTagLengthIP				= $06;
	kAFPTagLengthIPPort			= $08;
	kAFPTagLengthDDP			= $06;


TYPE
	AFPTagDataPtr = ^AFPTagData;
	AFPTagData = PACKED RECORD
		fLength:				UInt8;									{  length of this data tag including the fLength field  }
		fType:					UInt8;
		fData:					PACKED ARRAY [0..0] OF UInt8;			{  variable length data  }
	END;

	AFPAlternateAddressPtr = ^AFPAlternateAddress;
	AFPAlternateAddress = PACKED RECORD
		fAddressCount:			UInt8;
		fAddressList:			PACKED ARRAY [0..0] OF UInt8;			{  actually variable length packed set of AFPTagData  }
	END;



	DTPBRecPtr = ^DTPBRec;
	DTPBRec = RECORD
		qLink:					QElemPtr;								{ queue link in header }
		qType:					INTEGER;								{ type byte for safety check }
		ioTrap:					INTEGER;								{ FS: the Trap }
		ioCmdAddr:				Ptr;									{ FS: address to dispatch to }
		ioCompletion:			IOCompletionUPP;						{ completion routine addr (0 for synch calls) }
		ioResult:				OSErr;									{ result code }
		ioNamePtr:				StringPtr;								{ ptr to Vol:FileName string }
		ioVRefNum:				INTEGER;								{ volume refnum (DrvNum for Eject and MountVol) }
		ioDTRefNum:				INTEGER;								{  desktop refnum  }
		ioIndex:				INTEGER;
		ioTagInfo:				LONGINT;
		ioDTBuffer:				Ptr;
		ioDTReqCount:			LONGINT;
		ioDTActCount:			LONGINT;
		ioFiller1:				SInt8;
		ioIconType:				SInt8;
		ioFiller2:				INTEGER;
		ioDirID:				LONGINT;
		ioFileCreator:			OSType;
		ioFileType:				OSType;
		ioFiller3:				LONGINT;
		ioDTLgLen:				LONGINT;
		ioDTPyLen:				LONGINT;
		ioFiller4:				ARRAY [1..14] OF INTEGER;
		ioAPPLParID:			LONGINT;
	END;

	DTPBPtr								= ^DTPBRec;
	HIOParamPtr = ^HIOParam;
	HIOParam = RECORD
		qLink:					QElemPtr;								{ queue link in header }
		qType:					INTEGER;								{ type byte for safety check }
		ioTrap:					INTEGER;								{ FS: the Trap }
		ioCmdAddr:				Ptr;									{ FS: address to dispatch to }
		ioCompletion:			IOCompletionUPP;						{ completion routine addr (0 for synch calls) }
		ioResult:				OSErr;									{ result code }
		ioNamePtr:				StringPtr;								{ ptr to Vol:FileName string }
		ioVRefNum:				INTEGER;								{ volume refnum (DrvNum for Eject and MountVol) }
		ioRefNum:				INTEGER;
		ioVersNum:				SInt8;
		ioPermssn:				SInt8;
		ioMisc:					Ptr;
		ioBuffer:				Ptr;
		ioReqCount:				LONGINT;
		ioActCount:				LONGINT;
		ioPosMode:				INTEGER;
		ioPosOffset:			LONGINT;
	END;

	HFileParamPtr = ^HFileParam;
	HFileParam = RECORD
		qLink:					QElemPtr;								{ queue link in header }
		qType:					INTEGER;								{ type byte for safety check }
		ioTrap:					INTEGER;								{ FS: the Trap }
		ioCmdAddr:				Ptr;									{ FS: address to dispatch to }
		ioCompletion:			IOCompletionUPP;						{ completion routine addr (0 for synch calls) }
		ioResult:				OSErr;									{ result code }
		ioNamePtr:				StringPtr;								{ ptr to Vol:FileName string }
		ioVRefNum:				INTEGER;								{ volume refnum (DrvNum for Eject and MountVol) }
		ioFRefNum:				INTEGER;
		ioFVersNum:				SInt8;
		filler1:				SInt8;
		ioFDirIndex:			INTEGER;
		ioFlAttrib:				SInt8;
		ioFlVersNum:			SInt8;
		ioFlFndrInfo:			FInfo;
		ioDirID:				LONGINT;
		ioFlStBlk:				UInt16;
		ioFlLgLen:				LONGINT;
		ioFlPyLen:				LONGINT;
		ioFlRStBlk:				UInt16;
		ioFlRLgLen:				LONGINT;
		ioFlRPyLen:				LONGINT;
		ioFlCrDat:				UInt32;
		ioFlMdDat:				UInt32;
	END;

	HVolumeParamPtr = ^HVolumeParam;
	HVolumeParam = RECORD
		qLink:					QElemPtr;								{ queue link in header }
		qType:					INTEGER;								{ type byte for safety check }
		ioTrap:					INTEGER;								{ FS: the Trap }
		ioCmdAddr:				Ptr;									{ FS: address to dispatch to }
		ioCompletion:			IOCompletionUPP;						{ completion routine addr (0 for synch calls) }
		ioResult:				OSErr;									{ result code }
		ioNamePtr:				StringPtr;								{ ptr to Vol:FileName string }
		ioVRefNum:				INTEGER;								{ volume refnum (DrvNum for Eject and MountVol) }
		filler2:				LONGINT;
		ioVolIndex:				INTEGER;
		ioVCrDate:				UInt32;
		ioVLsMod:				UInt32;
		ioVAtrb:				INTEGER;
		ioVNmFls:				UInt16;
		ioVBitMap:				UInt16;
		ioAllocPtr:				UInt16;
		ioVNmAlBlks:			UInt16;
		ioVAlBlkSiz:			UInt32;
		ioVClpSiz:				UInt32;
		ioAlBlSt:				UInt16;
		ioVNxtCNID:				UInt32;
		ioVFrBlk:				UInt16;
		ioVSigWord:				UInt16;
		ioVDrvInfo:				INTEGER;
		ioVDRefNum:				INTEGER;
		ioVFSID:				INTEGER;
		ioVBkUp:				UInt32;
		ioVSeqNum:				INTEGER;
		ioVWrCnt:				UInt32;
		ioVFilCnt:				UInt32;
		ioVDirCnt:				UInt32;
		ioVFndrInfo:			ARRAY [1..8] OF LONGINT;
	END;


CONST
																{  Large Volume Constants  }
	kWidePosOffsetBit			= 8;
	kMaximumBlocksIn4GB			= $007FFFFF;


TYPE
	XIOParamPtr = ^XIOParam;
	XIOParam = RECORD
		qLink:					QElemPtr;
		qType:					INTEGER;
		ioTrap:					INTEGER;
		ioCmdAddr:				Ptr;
		ioCompletion:			IOCompletionUPP;
		ioResult:				OSErr;
		ioNamePtr:				StringPtr;
		ioVRefNum:				INTEGER;
		ioRefNum:				INTEGER;
		ioVersNum:				SInt8;
		ioPermssn:				SInt8;
		ioMisc:					Ptr;
		ioBuffer:				Ptr;
		ioReqCount:				LONGINT;
		ioActCount:				LONGINT;
		ioPosMode:				INTEGER;								{  must have kUseWidePositioning bit set  }
		ioWPosOffset:			wide;									{  wide positioning offset  }
	END;

	XVolumeParamPtr = ^XVolumeParam;
	XVolumeParam = RECORD
		qLink:					QElemPtr;
		qType:					INTEGER;
		ioTrap:					INTEGER;
		ioCmdAddr:				Ptr;
		ioCompletion:			IOCompletionUPP;
		ioResult:				OSErr;
		ioNamePtr:				StringPtr;
		ioVRefNum:				INTEGER;
		ioXVersion:				UInt32;									{  this XVolumeParam version (0)  }
		ioVolIndex:				INTEGER;
		ioVCrDate:				UInt32;
		ioVLsMod:				UInt32;
		ioVAtrb:				INTEGER;
		ioVNmFls:				UInt16;
		ioVBitMap:				UInt16;
		ioAllocPtr:				UInt16;
		ioVNmAlBlks:			UInt16;
		ioVAlBlkSiz:			UInt32;
		ioVClpSiz:				UInt32;
		ioAlBlSt:				UInt16;
		ioVNxtCNID:				UInt32;
		ioVFrBlk:				UInt16;
		ioVSigWord:				UInt16;
		ioVDrvInfo:				INTEGER;
		ioVDRefNum:				INTEGER;
		ioVFSID:				INTEGER;
		ioVBkUp:				UInt32;
		ioVSeqNum:				INTEGER;
		ioVWrCnt:				UInt32;
		ioVFilCnt:				UInt32;
		ioVDirCnt:				UInt32;
		ioVFndrInfo:			ARRAY [1..8] OF LONGINT;
		ioVTotalBytes:			UnsignedWide;							{  total number of bytes on volume  }
		ioVFreeBytes:			UnsignedWide;							{  number of free bytes on volume  }
	END;

	AccessParamPtr = ^AccessParam;
	AccessParam = RECORD
		qLink:					QElemPtr;								{ queue link in header }
		qType:					INTEGER;								{ type byte for safety check }
		ioTrap:					INTEGER;								{ FS: the Trap }
		ioCmdAddr:				Ptr;									{ FS: address to dispatch to }
		ioCompletion:			IOCompletionUPP;						{ completion routine addr (0 for synch calls) }
		ioResult:				OSErr;									{ result code }
		ioNamePtr:				StringPtr;								{ ptr to Vol:FileName string }
		ioVRefNum:				INTEGER;								{ volume refnum (DrvNum for Eject and MountVol) }
		filler3:				INTEGER;
		ioDenyModes:			INTEGER;								{ access rights data }
		filler4:				INTEGER;
		filler5:				SInt8;
		ioACUser:				SInt8;									{ access rights for directory only }
		filler6:				LONGINT;
		ioACOwnerID:			LONGINT;								{ owner ID }
		ioACGroupID:			LONGINT;								{ group ID }
		ioACAccess:				LONGINT;								{ access rights }
		ioDirID:				LONGINT;
	END;

	ObjParamPtr = ^ObjParam;
	ObjParam = RECORD
		qLink:					QElemPtr;								{ queue link in header }
		qType:					INTEGER;								{ type byte for safety check }
		ioTrap:					INTEGER;								{ FS: the Trap }
		ioCmdAddr:				Ptr;									{ FS: address to dispatch to }
		ioCompletion:			IOCompletionUPP;						{ completion routine addr (0 for synch calls) }
		ioResult:				OSErr;									{ result code }
		ioNamePtr:				StringPtr;								{ ptr to Vol:FileName string }
		ioVRefNum:				INTEGER;								{ volume refnum (DrvNum for Eject and MountVol) }
		filler7:				INTEGER;
		ioObjType:				INTEGER;								{ function code }
		ioObjNamePtr:			StringPtr;								{ ptr to returned creator/group name }
		ioObjID:				LONGINT;								{ creator/group ID }
	END;

	CopyParamPtr = ^CopyParam;
	CopyParam = RECORD
		qLink:					QElemPtr;								{ queue link in header }
		qType:					INTEGER;								{ type byte for safety check }
		ioTrap:					INTEGER;								{ FS: the Trap }
		ioCmdAddr:				Ptr;									{ FS: address to dispatch to }
		ioCompletion:			IOCompletionUPP;						{ completion routine addr (0 for synch calls) }
		ioResult:				OSErr;									{ result code }
		ioNamePtr:				StringPtr;								{ ptr to Vol:FileName string }
		ioVRefNum:				INTEGER;								{ volume refnum (DrvNum for Eject and MountVol) }
		ioDstVRefNum:			INTEGER;								{ destination vol identifier }
		filler8:				INTEGER;
		ioNewName:				StringPtr;								{ ptr to destination pathname }
		ioCopyName:				StringPtr;								{ ptr to optional name }
		ioNewDirID:				LONGINT;								{ destination directory ID }
		filler14:				LONGINT;
		filler15:				LONGINT;
		ioDirID:				LONGINT;
	END;

	WDParamPtr = ^WDParam;
	WDParam = RECORD
		qLink:					QElemPtr;								{ queue link in header }
		qType:					INTEGER;								{ type byte for safety check }
		ioTrap:					INTEGER;								{ FS: the Trap }
		ioCmdAddr:				Ptr;									{ FS: address to dispatch to }
		ioCompletion:			IOCompletionUPP;						{ completion routine addr (0 for synch calls) }
		ioResult:				OSErr;									{ result code }
		ioNamePtr:				StringPtr;								{ ptr to Vol:FileName string }
		ioVRefNum:				INTEGER;								{ volume refnum (DrvNum for Eject and MountVol) }
		filler9:				INTEGER;
		ioWDIndex:				INTEGER;
		ioWDProcID:				LONGINT;
		ioWDVRefNum:			INTEGER;
		filler10:				INTEGER;
		filler11:				LONGINT;
		filler12:				LONGINT;
		filler13:				LONGINT;
		ioWDDirID:				LONGINT;
	END;

	FIDParamPtr = ^FIDParam;
	FIDParam = RECORD
		qLink:					QElemPtr;								{ queue link in header }
		qType:					INTEGER;								{ type byte for safety check }
		ioTrap:					INTEGER;								{ FS: the Trap }
		ioCmdAddr:				Ptr;									{ FS: address to dispatch to }
		ioCompletion:			IOCompletionUPP;						{ completion routine addr (0 for synch calls) }
		ioResult:				OSErr;									{ result code }
		ioNamePtr:				StringPtr;								{ ptr to Vol:FileName string }
		ioVRefNum:				INTEGER;								{ volume refnum (DrvNum for Eject and MountVol) }
		filler14:				LONGINT;
		ioDestNamePtr:			StringPtr;								{  dest file name  }
		filler15:				LONGINT;
		ioDestDirID:			LONGINT;								{  dest file's directory id  }
		filler16:				LONGINT;
		filler17:				LONGINT;
		ioSrcDirID:				LONGINT;								{  source file's directory id  }
		filler18:				INTEGER;
		ioFileID:				LONGINT;								{  file ID  }
	END;

	ForeignPrivParamPtr = ^ForeignPrivParam;
	ForeignPrivParam = RECORD
		qLink:					QElemPtr;								{ queue link in header }
		qType:					INTEGER;								{ type byte for safety check }
		ioTrap:					INTEGER;								{ FS: the Trap }
		ioCmdAddr:				Ptr;									{ FS: address to dispatch to }
		ioCompletion:			IOCompletionUPP;						{ completion routine addr (0 for synch calls) }
		ioResult:				OSErr;									{ result code }
		ioNamePtr:				StringPtr;								{ ptr to Vol:FileName string }
		ioVRefNum:				INTEGER;								{ volume refnum (DrvNum for Eject and MountVol) }
		ioFiller21:				LONGINT;
		ioFiller22:				LONGINT;
		ioForeignPrivBuffer:	Ptr;
		ioForeignPrivActCount:	LONGINT;
		ioForeignPrivReqCount:	LONGINT;
		ioFiller23:				LONGINT;
		ioForeignPrivDirID:		LONGINT;
		ioForeignPrivInfo1:		LONGINT;
		ioForeignPrivInfo2:		LONGINT;
		ioForeignPrivInfo3:		LONGINT;
		ioForeignPrivInfo4:		LONGINT;
	END;

	CSParamPtr = ^CSParam;
	CSParam = RECORD
		qLink:					QElemPtr;								{ queue link in header }
		qType:					INTEGER;								{ type byte for safety check }
		ioTrap:					INTEGER;								{ FS: the Trap }
		ioCmdAddr:				Ptr;									{ FS: address to dispatch to }
		ioCompletion:			IOCompletionUPP;						{ completion routine addr (0 for synch calls) }
		ioResult:				OSErr;									{ result code }
		ioNamePtr:				StringPtr;								{ ptr to Vol:FileName string }
		ioVRefNum:				INTEGER;								{ volume refnum (DrvNum for Eject and MountVol) }
		ioMatchPtr:				FSSpecPtr;								{  match array  }
		ioReqMatchCount:		LONGINT;								{  maximum allowable matches  }
		ioActMatchCount:		LONGINT;								{  actual match count  }
		ioSearchBits:			LONGINT;								{  search criteria selector  }
		ioSearchInfo1:			CInfoPBPtr;								{  search values and range lower bounds  }
		ioSearchInfo2:			CInfoPBPtr;								{  search values and range upper bounds  }
		ioSearchTime:			LONGINT;								{  length of time to run search  }
		ioCatPosition:			CatPositionRec;							{  current position in the catalog  }
		ioOptBuffer:			Ptr;									{  optional performance enhancement buffer  }
		ioOptBufSize:			LONGINT;								{  size of buffer pointed to by ioOptBuffer  }
	END;



	HParamBlockRecPtr = ^HParamBlockRec;
	HParamBlockRec = RECORD
		qLink:					QElemPtr;								{ queue link in header }
		qType:					INTEGER;								{ type byte for safety check }
		ioTrap:					INTEGER;								{ FS: the Trap }
		ioCmdAddr:				Ptr;									{ FS: address to dispatch to }
		ioCompletion:			IOCompletionUPP;						{ completion routine addr (0 for synch calls) }
		ioResult:				OSErr;									{ result code }
		ioNamePtr:				StringPtr;								{ ptr to Vol:FileName string }
		ioVRefNum:				INTEGER;								{ volume refnum (DrvNum for Eject and MountVol) }
		CASE INTEGER OF
		0: (
			ioRefNum:			INTEGER;
			ioVersNum:			SInt8;
			ioPermssn:			SInt8;
			ioMisc:				Ptr;
			ioBuffer:			Ptr;
			ioReqCount:			LONGINT;
			ioActCount:			LONGINT;
			ioPosMode:			INTEGER;
			ioPosOffset:		LONGINT;
		   );
		1: (
			ioFRefNum:			INTEGER;
			ioFVersNum:			SInt8;
			filler1:			SInt8;
			ioFDirIndex:		INTEGER;
			ioFlAttrib:			SInt8;
			ioFlVersNum:		SInt8;
			ioFlFndrInfo:		FInfo;
			ioDirID:			LONGINT;
			ioFlStBlk:			UInt16;
			ioFlLgLen:			LONGINT;
			ioFlPyLen:			LONGINT;
			ioFlRStBlk:			UInt16;
			ioFlRLgLen:			LONGINT;
			ioFlRPyLen:			LONGINT;
			ioFlCrDat:			UInt32;
			ioFlMdDat:			UInt32;
		   );
		2: (
			filler2:			LONGINT;
			ioVolIndex:			INTEGER;
			ioVCrDate:			UInt32;
			ioVLsMod:			UInt32;
			ioVAtrb:			INTEGER;
			ioVNmFls:			UInt16;
			ioVBitMap:			UInt16;
			ioAllocPtr:			UInt16;
			ioVNmAlBlks:		UInt16;
			ioVAlBlkSiz:		UInt32;
			ioVClpSiz:			UInt32;
			ioAlBlSt:			UInt16;
			ioVNxtCNID:			UInt32;
			ioVFrBlk:			UInt16;
			ioVSigWord:			UInt16;
			ioVDrvInfo:			INTEGER;
			ioVDRefNum:			INTEGER;
			ioVFSID:			INTEGER;
			ioVBkUp:			UInt32;
			ioVSeqNum:			UInt16;
			ioVWrCnt:			UInt32;
			ioVFilCnt:			UInt32;
			ioVDirCnt:			UInt32;
			ioVFndrInfo:		ARRAY [1..8] OF LONGINT;
		   );
		3: (
			filler3:			INTEGER;
			ioDenyModes:		INTEGER;								{ access rights data }
			filler4:			INTEGER;
			filler5:			SInt8;
			ioACUser:			SInt8;									{ access rights for directory only }
			filler6:			LONGINT;
			ioACOwnerID:		LONGINT;								{ owner ID }
			ioACGroupID:		LONGINT;								{ group ID }
			ioACAccess:			LONGINT;								{ access rights }
		   );
		4: (
			filler7:			INTEGER;
			ioObjType:			INTEGER;								{ function code }
			ioObjNamePtr:		StringPtr;								{ ptr to returned creator/group name }
			ioObjID:			LONGINT;								{ creator/group ID }
		   );
		5: (
			ioDstVRefNum:		INTEGER;								{ destination vol identifier }
			filler8:			INTEGER;
			ioNewName:			StringPtr;								{ ptr to destination pathname }
			ioCopyName:			StringPtr;								{ ptr to optional name }
			ioNewDirID:			LONGINT;								{ destination directory ID }
		   );
		6: (
			filler9:			INTEGER;
			ioWDIndex:			INTEGER;
			ioWDProcID:			LONGINT;
			ioWDVRefNum:		INTEGER;
			filler10:			INTEGER;
			filler11:			LONGINT;
			filler12:			LONGINT;
			filler13:			LONGINT;
			ioWDDirID:			LONGINT;
		   );
		7: (
			filler14:			LONGINT;
			ioDestNamePtr:		StringPtr;								{  dest file name  }
			filler15:			LONGINT;
			ioDestDirID:		LONGINT;								{  dest file's directory id  }
			filler16:			LONGINT;
			filler17:			LONGINT;
			ioSrcDirID:			LONGINT;								{  source file's directory id  }
			filler18:			INTEGER;
			ioFileID:			LONGINT;								{  file ID  }
		   );
		8: (
			ioMatchPtr:			FSSpecPtr;								{  match array  }
			ioReqMatchCount:	LONGINT;								{  maximum allowable matches  }
			ioActMatchCount:	LONGINT;								{  actual match count  }
			ioSearchBits:		LONGINT;								{  search criteria selector  }
			ioSearchInfo1:		CInfoPBPtr;								{  search values and range lower bounds  }
			ioSearchInfo2:		CInfoPBPtr;								{  search values and range upper bounds  }
			ioSearchTime:		LONGINT;								{  length of time to run search  }
			ioCatPosition:		CatPositionRec;							{  current position in the catalog  }
			ioOptBuffer:		Ptr;									{  optional performance enhancement buffer  }
			ioOptBufSize:		LONGINT;								{  size of buffer pointed to by ioOptBuffer  }
		   );
		9: (
			ioFiller21:			LONGINT;
			ioFiller22:			LONGINT;
			ioForeignPrivBuffer: Ptr;
			ioForeignPrivActCount: LONGINT;
			ioForeignPrivReqCount: LONGINT;
			ioFiller23:			LONGINT;
			ioForeignPrivDirID:	LONGINT;
			ioForeignPrivInfo1:	LONGINT;
			ioForeignPrivInfo2:	LONGINT;
			ioForeignPrivInfo3:	LONGINT;
			ioForeignPrivInfo4:	LONGINT;
		   );
	END;

	HParmBlkPtr							= ^HParamBlockRec;
	HParmBlkPtrPtr 						= ^HParmBlkPtr;

	CMovePBRecPtr = ^CMovePBRec;
	CMovePBRec = RECORD
		qLink:					QElemPtr;
		qType:					INTEGER;
		ioTrap:					INTEGER;
		ioCmdAddr:				Ptr;
		ioCompletion:			IOCompletionUPP;
		ioResult:				OSErr;
		ioNamePtr:				StringPtr;
		ioVRefNum:				INTEGER;
		filler1:				LONGINT;
		ioNewName:				StringPtr;
		filler2:				LONGINT;
		ioNewDirID:				LONGINT;
		filler3:				ARRAY [1..2] OF LONGINT;
		ioDirID:				LONGINT;
	END;

	CMovePBPtr							= ^CMovePBRec;
	WDPBRecPtr = ^WDPBRec;
	WDPBRec = RECORD
		qLink:					QElemPtr;
		qType:					INTEGER;
		ioTrap:					INTEGER;
		ioCmdAddr:				Ptr;
		ioCompletion:			IOCompletionUPP;
		ioResult:				OSErr;
		ioNamePtr:				StringPtr;
		ioVRefNum:				INTEGER;
		filler1:				INTEGER;
		ioWDIndex:				INTEGER;
		ioWDProcID:				LONGINT;
		ioWDVRefNum:			INTEGER;
		filler2:				ARRAY [1..7] OF INTEGER;
		ioWDDirID:				LONGINT;
	END;

	WDPBPtr								= ^WDPBRec;
	FCBPBRecPtr = ^FCBPBRec;
	FCBPBRec = RECORD
		qLink:					QElemPtr;
		qType:					INTEGER;
		ioTrap:					INTEGER;
		ioCmdAddr:				Ptr;
		ioCompletion:			IOCompletionUPP;
		ioResult:				OSErr;
		ioNamePtr:				StringPtr;
		ioVRefNum:				INTEGER;
		ioRefNum:				INTEGER;
		filler:					INTEGER;
		ioFCBIndx:				INTEGER;
		filler1:				INTEGER;
		ioFCBFlNm:				LONGINT;
		ioFCBFlags:				INTEGER;
		ioFCBStBlk:				UInt16;
		ioFCBEOF:				LONGINT;
		ioFCBPLen:				LONGINT;
		ioFCBCrPs:				LONGINT;
		ioFCBVRefNum:			INTEGER;
		ioFCBClpSiz:			LONGINT;
		ioFCBParID:				LONGINT;
	END;

	FCBPBPtr							= ^FCBPBRec;
	VCBPtr = ^VCB;
	VCB = RECORD
		qLink:					QElemPtr;
		qType:					INTEGER;
		vcbFlags:				INTEGER;
		vcbSigWord:				UInt16;
		vcbCrDate:				UInt32;
		vcbLsMod:				UInt32;
		vcbAtrb:				INTEGER;
		vcbNmFls:				UInt16;
		vcbVBMSt:				INTEGER;
		vcbAllocPtr:			INTEGER;
		vcbNmAlBlks:			UInt16;
		vcbAlBlkSiz:			LONGINT;
		vcbClpSiz:				LONGINT;
		vcbAlBlSt:				INTEGER;
		vcbNxtCNID:				LONGINT;
		vcbFreeBks:				UInt16;
		vcbVN:					Str27;
		vcbDrvNum:				INTEGER;
		vcbDRefNum:				INTEGER;
		vcbFSID:				INTEGER;
		vcbVRefNum:				INTEGER;
		vcbMAdr:				Ptr;
		vcbBufAdr:				Ptr;
		vcbMLen:				INTEGER;
		vcbDirIndex:			INTEGER;
		vcbDirBlk:				INTEGER;
		vcbVolBkUp:				UInt32;
		vcbVSeqNum:				UInt16;
		vcbWrCnt:				LONGINT;
		vcbXTClpSiz:			LONGINT;
		vcbCTClpSiz:			LONGINT;
		vcbNmRtDirs:			UInt16;
		vcbFilCnt:				LONGINT;
		vcbDirCnt:				LONGINT;
		vcbFndrInfo:			ARRAY [1..8] OF LONGINT;
		vcbVCSize:				UInt16;
		vcbVBMCSiz:				UInt16;
		vcbCtlCSiz:				UInt16;
		vcbXTAlBlks:			UInt16;
		vcbCTAlBlks:			UInt16;
		vcbXTRef:				INTEGER;
		vcbCTRef:				INTEGER;
		vcbCtlBuf:				Ptr;
		vcbDirIDM:				LONGINT;
		vcbOffsM:				INTEGER;
	END;

	DrvQElPtr = ^DrvQEl;
	DrvQEl = RECORD
		qLink:					QElemPtr;
		qType:					INTEGER;
		dQDrive:				INTEGER;
		dQRefNum:				INTEGER;
		dQFSID:					INTEGER;
		dQDrvSz:				UInt16;
		dQDrvSz2:				UInt16;
	END;


CONST
	uppIOCompletionProcInfo = $00009802;

FUNCTION NewIOCompletionProc(userRoutine: IOCompletionProcPtr): IOCompletionUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallIOCompletionProc(paramBlock: ParmBlkPtr; userRoutine: IOCompletionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}
{$IFC OLDROUTINELOCATIONS }
FUNCTION PBOpenSync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A000, $3E80;
	{$ENDC}
FUNCTION PBOpenAsync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A400, $3E80;
	{$ENDC}
FUNCTION PBOpenImmed(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A200, $3E80;
	{$ENDC}
FUNCTION PBCloseSync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A001, $3E80;
	{$ENDC}
FUNCTION PBCloseAsync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A401, $3E80;
	{$ENDC}
FUNCTION PBCloseImmed(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A201, $3E80;
	{$ENDC}
FUNCTION PBReadSync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A002, $3E80;
	{$ENDC}
FUNCTION PBReadAsync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A402, $3E80;
	{$ENDC}
FUNCTION PBReadImmed(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A202, $3E80;
	{$ENDC}
FUNCTION PBWriteSync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A003, $3E80;
	{$ENDC}
FUNCTION PBWriteAsync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A403, $3E80;
	{$ENDC}
FUNCTION PBWriteImmed(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A203, $3E80;
	{$ENDC}
{$ENDC}  {OLDROUTINELOCATIONS}

FUNCTION PBGetVInfoSync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A007, $3E80;
	{$ENDC}
FUNCTION PBGetVInfoAsync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A407, $3E80;
	{$ENDC}
FUNCTION PBXGetVolInfoSync(paramBlock: XVolumeParamPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7012, $A060, $3E80;
	{$ENDC}
FUNCTION PBXGetVolInfoAsync(paramBlock: XVolumeParamPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7012, $A460, $3E80;
	{$ENDC}
FUNCTION PBGetVolSync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A014, $3E80;
	{$ENDC}
FUNCTION PBGetVolAsync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A414, $3E80;
	{$ENDC}
FUNCTION PBSetVolSync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A015, $3E80;
	{$ENDC}
FUNCTION PBSetVolAsync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A415, $3E80;
	{$ENDC}
FUNCTION PBFlushVolSync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A013, $3E80;
	{$ENDC}
FUNCTION PBFlushVolAsync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A413, $3E80;
	{$ENDC}

FUNCTION PBCreateSync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A008, $3E80;
	{$ENDC}
FUNCTION PBCreateAsync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A408, $3E80;
	{$ENDC}
FUNCTION PBDeleteSync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A009, $3E80;
	{$ENDC}
FUNCTION PBDeleteAsync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A409, $3E80;
	{$ENDC}
FUNCTION PBOpenDFSync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $701A, $A060, $3E80;
	{$ENDC}
FUNCTION PBOpenDFAsync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $701A, $A460, $3E80;
	{$ENDC}
FUNCTION PBOpenRFSync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A00A, $3E80;
	{$ENDC}
FUNCTION PBOpenRFAsync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A40A, $3E80;
	{$ENDC}
FUNCTION PBRenameSync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A00B, $3E80;
	{$ENDC}
FUNCTION PBRenameAsync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A40B, $3E80;
	{$ENDC}
FUNCTION PBGetFInfoSync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A00C, $3E80;
	{$ENDC}
FUNCTION PBGetFInfoAsync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A40C, $3E80;
	{$ENDC}
FUNCTION PBSetFInfoSync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A00D, $3E80;
	{$ENDC}
FUNCTION PBSetFInfoAsync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A40D, $3E80;
	{$ENDC}
FUNCTION PBSetFLockSync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A041, $3E80;
	{$ENDC}
FUNCTION PBSetFLockAsync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A441, $3E80;
	{$ENDC}
FUNCTION PBRstFLockSync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A042, $3E80;
	{$ENDC}
FUNCTION PBRstFLockAsync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A442, $3E80;
	{$ENDC}
FUNCTION PBSetFVersSync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A043, $3E80;
	{$ENDC}
FUNCTION PBSetFVersAsync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A443, $3E80;
	{$ENDC}
FUNCTION PBAllocateSync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A010, $3E80;
	{$ENDC}
FUNCTION PBAllocateAsync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A410, $3E80;
	{$ENDC}
FUNCTION PBGetEOFSync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A011, $3E80;
	{$ENDC}
FUNCTION PBGetEOFAsync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A411, $3E80;
	{$ENDC}
FUNCTION PBSetEOFSync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A012, $3E80;
	{$ENDC}
FUNCTION PBSetEOFAsync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A412, $3E80;
	{$ENDC}
FUNCTION PBGetFPosSync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A018, $3E80;
	{$ENDC}
FUNCTION PBGetFPosAsync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A418, $3E80;
	{$ENDC}
FUNCTION PBSetFPosSync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A044, $3E80;
	{$ENDC}
FUNCTION PBSetFPosAsync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A444, $3E80;
	{$ENDC}
FUNCTION PBFlushFileSync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A045, $3E80;
	{$ENDC}
FUNCTION PBFlushFileAsync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A445, $3E80;
	{$ENDC}
FUNCTION PBMountVol(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A00F, $3E80;
	{$ENDC}
FUNCTION PBUnmountVol(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A00E, $3E80;
	{$ENDC}
FUNCTION PBUnmountVolImmed(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A20E, $3E80;
	{$ENDC}
FUNCTION PBEject(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A017, $3E80;
	{$ENDC}
FUNCTION PBOffLine(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A035, $3E80;
	{$ENDC}
FUNCTION PBCatSearchSync(paramBlock: CSParamPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7018, $A260, $3E80;
	{$ENDC}
FUNCTION PBCatSearchAsync(paramBlock: CSParamPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7018, $A660, $3E80;
	{$ENDC}
FUNCTION SetVol(volName: StringPtr; vRefNum: INTEGER): OSErr;
FUNCTION UnmountVol(volName: StringPtr; vRefNum: INTEGER): OSErr;
FUNCTION Eject(volName: StringPtr; vRefNum: INTEGER): OSErr;
FUNCTION FlushVol(volName: StringPtr; vRefNum: INTEGER): OSErr;
FUNCTION HSetVol(volName: StringPtr; vRefNum: INTEGER; dirID: LONGINT): OSErr;
{$IFC OLDROUTINELOCATIONS }
PROCEDURE AddDrive(drvrRefNum: INTEGER; drvNum: INTEGER; qEl: DrvQElPtr);
{$ENDC}  {OLDROUTINELOCATIONS}

FUNCTION FSOpen(fileName: Str255; vRefNum: INTEGER; VAR refNum: INTEGER): OSErr;
FUNCTION OpenDF(fileName: Str255; vRefNum: INTEGER; VAR refNum: INTEGER): OSErr;
FUNCTION FSClose(refNum: INTEGER): OSErr;
FUNCTION FSRead(refNum: INTEGER; VAR count: LONGINT; buffPtr: UNIV Ptr): OSErr;
FUNCTION FSWrite(refNum: INTEGER; VAR count: LONGINT; buffPtr: UNIV Ptr): OSErr;
FUNCTION GetVInfo(drvNum: INTEGER; volName: StringPtr; VAR vRefNum: INTEGER; VAR freeBytes: LONGINT): OSErr;
FUNCTION GetFInfo(fileName: Str255; vRefNum: INTEGER; VAR fndrInfo: FInfo): OSErr;
FUNCTION GetVol(volName: StringPtr; VAR vRefNum: INTEGER): OSErr;
FUNCTION Create(fileName: Str255; vRefNum: INTEGER; creator: OSType; fileType: OSType): OSErr;
FUNCTION FSDelete(fileName: Str255; vRefNum: INTEGER): OSErr;
FUNCTION OpenRF(fileName: Str255; vRefNum: INTEGER; VAR refNum: INTEGER): OSErr;
FUNCTION Rename(oldName: Str255; vRefNum: INTEGER; newName: Str255): OSErr;
FUNCTION SetFInfo(fileName: Str255; vRefNum: INTEGER; {CONST}VAR fndrInfo: FInfo): OSErr;
FUNCTION SetFLock(fileName: Str255; vRefNum: INTEGER): OSErr;
FUNCTION RstFLock(fileName: Str255; vRefNum: INTEGER): OSErr;
FUNCTION Allocate(refNum: INTEGER; VAR count: LONGINT): OSErr;
FUNCTION GetEOF(refNum: INTEGER; VAR logEOF: LONGINT): OSErr;
FUNCTION SetEOF(refNum: INTEGER; logEOF: LONGINT): OSErr;
FUNCTION GetFPos(refNum: INTEGER; VAR filePos: LONGINT): OSErr;
FUNCTION SetFPos(refNum: INTEGER; posMode: INTEGER; posOff: LONGINT): OSErr;
FUNCTION GetVRefNum(fileRefNum: INTEGER; VAR vRefNum: INTEGER): OSErr;
FUNCTION PBOpenWDSync(paramBlock: WDPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7001, $A260, $3E80;
	{$ENDC}
FUNCTION PBOpenWDAsync(paramBlock: WDPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7001, $A660, $3E80;
	{$ENDC}
FUNCTION PBCloseWDSync(paramBlock: WDPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7002, $A260, $3E80;
	{$ENDC}
FUNCTION PBCloseWDAsync(paramBlock: WDPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7002, $A660, $3E80;
	{$ENDC}
FUNCTION PBHSetVolSync(paramBlock: WDPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A215, $3E80;
	{$ENDC}
FUNCTION PBHSetVolAsync(paramBlock: WDPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A615, $3E80;
	{$ENDC}
FUNCTION PBHGetVolSync(paramBlock: WDPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A214, $3E80;
	{$ENDC}
FUNCTION PBHGetVolAsync(paramBlock: WDPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A614, $3E80;
	{$ENDC}
FUNCTION PBCatMoveSync(paramBlock: CMovePBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7005, $A260, $3E80;
	{$ENDC}
FUNCTION PBCatMoveAsync(paramBlock: CMovePBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7005, $A660, $3E80;
	{$ENDC}
FUNCTION PBDirCreateSync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7006, $A260, $3E80;
	{$ENDC}
FUNCTION PBDirCreateAsync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7006, $A660, $3E80;
	{$ENDC}
FUNCTION PBGetWDInfoSync(paramBlock: WDPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7007, $A260, $3E80;
	{$ENDC}
FUNCTION PBGetWDInfoAsync(paramBlock: WDPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7007, $A660, $3E80;
	{$ENDC}
FUNCTION PBGetFCBInfoSync(paramBlock: FCBPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7008, $A260, $3E80;
	{$ENDC}
FUNCTION PBGetFCBInfoAsync(paramBlock: FCBPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7008, $A660, $3E80;
	{$ENDC}
FUNCTION PBGetCatInfoSync(paramBlock: CInfoPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7009, $A260, $3E80;
	{$ENDC}
FUNCTION PBGetCatInfoAsync(paramBlock: CInfoPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7009, $A660, $3E80;
	{$ENDC}
FUNCTION PBSetCatInfoSync(paramBlock: CInfoPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $700A, $A260, $3E80;
	{$ENDC}
FUNCTION PBSetCatInfoAsync(paramBlock: CInfoPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $700A, $A660, $3E80;
	{$ENDC}
FUNCTION PBAllocContigSync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A210, $3E80;
	{$ENDC}
FUNCTION PBAllocContigAsync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A610, $3E80;
	{$ENDC}
FUNCTION PBLockRangeSync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7010, $A260, $3E80;
	{$ENDC}
FUNCTION PBLockRangeAsync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7010, $A660, $3E80;
	{$ENDC}
FUNCTION PBUnlockRangeSync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7011, $A260, $3E80;
	{$ENDC}
FUNCTION PBUnlockRangeAsync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7011, $A660, $3E80;
	{$ENDC}
FUNCTION PBSetVInfoSync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $700B, $A260, $3E80;
	{$ENDC}
FUNCTION PBSetVInfoAsync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $700B, $A660, $3E80;
	{$ENDC}
FUNCTION PBHGetVInfoSync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A207, $3E80;
	{$ENDC}
FUNCTION PBHGetVInfoAsync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A607, $3E80;
	{$ENDC}
FUNCTION PBHOpenSync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A200, $3E80;
	{$ENDC}
FUNCTION PBHOpenAsync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A600, $3E80;
	{$ENDC}
FUNCTION PBHOpenRFSync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A20A, $3E80;
	{$ENDC}
FUNCTION PBHOpenRFAsync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A60A, $3E80;
	{$ENDC}
FUNCTION PBHOpenDFSync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $701A, $A260, $3E80;
	{$ENDC}
FUNCTION PBHOpenDFAsync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $701A, $A660, $3E80;
	{$ENDC}
FUNCTION PBHCreateSync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A208, $3E80;
	{$ENDC}
FUNCTION PBHCreateAsync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A608, $3E80;
	{$ENDC}
FUNCTION PBHDeleteSync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A209, $3E80;
	{$ENDC}
FUNCTION PBHDeleteAsync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A609, $3E80;
	{$ENDC}
FUNCTION PBHRenameSync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A20B, $3E80;
	{$ENDC}
FUNCTION PBHRenameAsync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A60B, $3E80;
	{$ENDC}
FUNCTION PBHRstFLockSync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A242, $3E80;
	{$ENDC}
FUNCTION PBHRstFLockAsync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A642, $3E80;
	{$ENDC}
FUNCTION PBHSetFLockSync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A241, $3E80;
	{$ENDC}
FUNCTION PBHSetFLockAsync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A641, $3E80;
	{$ENDC}
FUNCTION PBHGetFInfoSync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A20C, $3E80;
	{$ENDC}
FUNCTION PBHGetFInfoAsync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A60C, $3E80;
	{$ENDC}
FUNCTION PBHSetFInfoSync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A20D, $3E80;
	{$ENDC}
FUNCTION PBHSetFInfoAsync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A60D, $3E80;
	{$ENDC}
FUNCTION PBMakeFSSpecSync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $701B, $A260, $3E80;
	{$ENDC}
FUNCTION PBMakeFSSpecAsync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $701B, $A660, $3E80;
	{$ENDC}
PROCEDURE FInitQueue;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A016;
	{$ENDC}

FUNCTION GetFSQHdr: QHdrPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2EBC, $0000, $0360;
	{$ENDC}
FUNCTION GetVCBQHdr: QHdrPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2EBC, $0000, $0356;
	{$ENDC}
{$IFC OLDROUTINELOCATIONS }
FUNCTION GetDrvQHdr: QHdrPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2EBC, $0000, $0308;
	{$ENDC}
{$ENDC}  {OLDROUTINELOCATIONS}

FUNCTION HGetVol(volName: StringPtr; VAR vRefNum: INTEGER; VAR dirID: LONGINT): OSErr;
FUNCTION HOpen(vRefNum: INTEGER; dirID: LONGINT; fileName: Str255; permission: SInt8; VAR refNum: INTEGER): OSErr;
FUNCTION HOpenDF(vRefNum: INTEGER; dirID: LONGINT; fileName: Str255; permission: SInt8; VAR refNum: INTEGER): OSErr;
FUNCTION HOpenRF(vRefNum: INTEGER; dirID: LONGINT; fileName: Str255; permission: SInt8; VAR refNum: INTEGER): OSErr;
FUNCTION AllocContig(refNum: INTEGER; VAR count: LONGINT): OSErr;
FUNCTION HCreate(vRefNum: INTEGER; dirID: LONGINT; fileName: Str255; creator: OSType; fileType: OSType): OSErr;
FUNCTION DirCreate(vRefNum: INTEGER; parentDirID: LONGINT; directoryName: Str255; VAR createdDirID: LONGINT): OSErr;
FUNCTION HDelete(vRefNum: INTEGER; dirID: LONGINT; fileName: Str255): OSErr;
FUNCTION HGetFInfo(vRefNum: INTEGER; dirID: LONGINT; fileName: Str255; VAR fndrInfo: FInfo): OSErr;
FUNCTION HSetFInfo(vRefNum: INTEGER; dirID: LONGINT; fileName: Str255; {CONST}VAR fndrInfo: FInfo): OSErr;
FUNCTION HSetFLock(vRefNum: INTEGER; dirID: LONGINT; fileName: Str255): OSErr;
FUNCTION HRstFLock(vRefNum: INTEGER; dirID: LONGINT; fileName: Str255): OSErr;
FUNCTION HRename(vRefNum: INTEGER; dirID: LONGINT; oldName: Str255; newName: Str255): OSErr;
FUNCTION CatMove(vRefNum: INTEGER; dirID: LONGINT; oldName: Str255; newDirID: LONGINT; newName: Str255): OSErr;
FUNCTION OpenWD(vRefNum: INTEGER; dirID: LONGINT; procID: LONGINT; VAR wdRefNum: INTEGER): OSErr;
FUNCTION CloseWD(wdRefNum: INTEGER): OSErr;
FUNCTION GetWDInfo(wdRefNum: INTEGER; VAR vRefNum: INTEGER; VAR dirID: LONGINT; VAR procID: LONGINT): OSErr;
{  shared environment  }
FUNCTION PBHGetVolParmsSync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7030, $A260, $3E80;
	{$ENDC}
FUNCTION PBHGetVolParmsAsync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7030, $A660, $3E80;
	{$ENDC}
FUNCTION PBHGetLogInInfoSync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7031, $A260, $3E80;
	{$ENDC}
FUNCTION PBHGetLogInInfoAsync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7031, $A660, $3E80;
	{$ENDC}
FUNCTION PBHGetDirAccessSync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7032, $A260, $3E80;
	{$ENDC}
FUNCTION PBHGetDirAccessAsync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7032, $A660, $3E80;
	{$ENDC}
FUNCTION PBHSetDirAccessSync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7033, $A260, $3E80;
	{$ENDC}
FUNCTION PBHSetDirAccessAsync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7033, $A660, $3E80;
	{$ENDC}
FUNCTION PBHMapIDSync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7034, $A260, $3E80;
	{$ENDC}
FUNCTION PBHMapIDAsync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7034, $A660, $3E80;
	{$ENDC}
FUNCTION PBHMapNameSync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7035, $A260, $3E80;
	{$ENDC}
FUNCTION PBHMapNameAsync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7035, $A660, $3E80;
	{$ENDC}
FUNCTION PBHCopyFileSync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7036, $A260, $3E80;
	{$ENDC}
FUNCTION PBHCopyFileAsync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7036, $A660, $3E80;
	{$ENDC}
FUNCTION PBHMoveRenameSync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7037, $A260, $3E80;
	{$ENDC}
FUNCTION PBHMoveRenameAsync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7037, $A660, $3E80;
	{$ENDC}
FUNCTION PBHOpenDenySync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7038, $A260, $3E80;
	{$ENDC}
FUNCTION PBHOpenDenyAsync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7038, $A660, $3E80;
	{$ENDC}
FUNCTION PBHOpenRFDenySync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7039, $A260, $3E80;
	{$ENDC}
FUNCTION PBHOpenRFDenyAsync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7039, $A660, $3E80;
	{$ENDC}
FUNCTION PBGetXCatInfoSync(paramBlock: XCInfoPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $703A, $A260, $3E80;
	{$ENDC}
FUNCTION PBGetXCatInfoAsync(paramBlock: XCInfoPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $703A, $A660, $3E80;
	{$ENDC}
FUNCTION PBExchangeFilesSync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7017, $A260, $3E80;
	{$ENDC}
FUNCTION PBExchangeFilesAsync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7017, $A660, $3E80;
	{$ENDC}
FUNCTION PBCreateFileIDRefSync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7014, $A260, $3E80;
	{$ENDC}
FUNCTION PBCreateFileIDRefAsync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7014, $A660, $3E80;
	{$ENDC}
FUNCTION PBResolveFileIDRefSync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7016, $A260, $3E80;
	{$ENDC}
FUNCTION PBResolveFileIDRefAsync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7016, $A660, $3E80;
	{$ENDC}
FUNCTION PBDeleteFileIDRefSync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7015, $A260, $3E80;
	{$ENDC}
FUNCTION PBDeleteFileIDRefAsync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7015, $A660, $3E80;
	{$ENDC}
FUNCTION PBGetForeignPrivsSync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7060, $A260, $3E80;
	{$ENDC}
FUNCTION PBGetForeignPrivsAsync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7060, $A660, $3E80;
	{$ENDC}
FUNCTION PBSetForeignPrivsSync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7061, $A260, $3E80;
	{$ENDC}
FUNCTION PBSetForeignPrivsAsync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7061, $A660, $3E80;
	{$ENDC}
{  Desktop Manager  }
FUNCTION PBDTGetPath(paramBlock: DTPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7020, $A260, $3E80;
	{$ENDC}
FUNCTION PBDTCloseDown(paramBlock: DTPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7021, $A260, $3E80;
	{$ENDC}
FUNCTION PBDTAddIconSync(paramBlock: DTPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7022, $A260, $3E80;
	{$ENDC}
FUNCTION PBDTAddIconAsync(paramBlock: DTPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7022, $A660, $3E80;
	{$ENDC}
FUNCTION PBDTGetIconSync(paramBlock: DTPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7023, $A260, $3E80;
	{$ENDC}
FUNCTION PBDTGetIconAsync(paramBlock: DTPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7023, $A660, $3E80;
	{$ENDC}
FUNCTION PBDTGetIconInfoSync(paramBlock: DTPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7024, $A260, $3E80;
	{$ENDC}
FUNCTION PBDTGetIconInfoAsync(paramBlock: DTPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7024, $A660, $3E80;
	{$ENDC}
FUNCTION PBDTAddAPPLSync(paramBlock: DTPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7025, $A260, $3E80;
	{$ENDC}
FUNCTION PBDTAddAPPLAsync(paramBlock: DTPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7025, $A660, $3E80;
	{$ENDC}
FUNCTION PBDTRemoveAPPLSync(paramBlock: DTPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7026, $A260, $3E80;
	{$ENDC}
FUNCTION PBDTRemoveAPPLAsync(paramBlock: DTPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7026, $A660, $3E80;
	{$ENDC}
FUNCTION PBDTGetAPPLSync(paramBlock: DTPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7027, $A260, $3E80;
	{$ENDC}
FUNCTION PBDTGetAPPLAsync(paramBlock: DTPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7027, $A660, $3E80;
	{$ENDC}
FUNCTION PBDTSetCommentSync(paramBlock: DTPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7028, $A260, $3E80;
	{$ENDC}
FUNCTION PBDTSetCommentAsync(paramBlock: DTPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7028, $A660, $3E80;
	{$ENDC}
FUNCTION PBDTRemoveCommentSync(paramBlock: DTPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7029, $A260, $3E80;
	{$ENDC}
FUNCTION PBDTRemoveCommentAsync(paramBlock: DTPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7029, $A660, $3E80;
	{$ENDC}
FUNCTION PBDTGetCommentSync(paramBlock: DTPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $702A, $A260, $3E80;
	{$ENDC}
FUNCTION PBDTGetCommentAsync(paramBlock: DTPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $702A, $A660, $3E80;
	{$ENDC}
FUNCTION PBDTFlushSync(paramBlock: DTPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $702B, $A260, $3E80;
	{$ENDC}
FUNCTION PBDTFlushAsync(paramBlock: DTPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $702B, $A660, $3E80;
	{$ENDC}
FUNCTION PBDTResetSync(paramBlock: DTPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $702C, $A260, $3E80;
	{$ENDC}
FUNCTION PBDTResetAsync(paramBlock: DTPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $702C, $A660, $3E80;
	{$ENDC}
FUNCTION PBDTGetInfoSync(paramBlock: DTPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $702D, $A260, $3E80;
	{$ENDC}
FUNCTION PBDTGetInfoAsync(paramBlock: DTPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $702D, $A660, $3E80;
	{$ENDC}
FUNCTION PBDTOpenInform(paramBlock: DTPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $702E, $A060, $3E80;
	{$ENDC}
FUNCTION PBDTDeleteSync(paramBlock: DTPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $702F, $A060, $3E80;
	{$ENDC}
FUNCTION PBDTDeleteAsync(paramBlock: DTPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $702F, $A460, $3E80;
	{$ENDC}
{  VolumeMount traps  }
FUNCTION PBGetVolMountInfoSize(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $703F, $A260, $3E80;
	{$ENDC}
FUNCTION PBGetVolMountInfo(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7040, $A260, $3E80;
	{$ENDC}
FUNCTION PBVolumeMount(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7041, $A260, $3E80;
	{$ENDC}
{  FSp traps  }
FUNCTION FSMakeFSSpec(vRefNum: INTEGER; dirID: LONGINT; fileName: Str255; VAR spec: FSSpec): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7001, $AA52;
	{$ENDC}
FUNCTION FSpOpenDF({CONST}VAR spec: FSSpec; permission: SInt8; VAR refNum: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7002, $AA52;
	{$ENDC}
FUNCTION FSpOpenRF({CONST}VAR spec: FSSpec; permission: SInt8; VAR refNum: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7003, $AA52;
	{$ENDC}
FUNCTION FSpCreate({CONST}VAR spec: FSSpec; creator: OSType; fileType: OSType; scriptTag: ScriptCode): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7004, $AA52;
	{$ENDC}
FUNCTION FSpDirCreate({CONST}VAR spec: FSSpec; scriptTag: ScriptCode; VAR createdDirID: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7005, $AA52;
	{$ENDC}
FUNCTION FSpDelete({CONST}VAR spec: FSSpec): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7006, $AA52;
	{$ENDC}
FUNCTION FSpGetFInfo({CONST}VAR spec: FSSpec; VAR fndrInfo: FInfo): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7007, $AA52;
	{$ENDC}
FUNCTION FSpSetFInfo({CONST}VAR spec: FSSpec; {CONST}VAR fndrInfo: FInfo): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7008, $AA52;
	{$ENDC}
FUNCTION FSpSetFLock({CONST}VAR spec: FSSpec): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7009, $AA52;
	{$ENDC}
FUNCTION FSpRstFLock({CONST}VAR spec: FSSpec): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700A, $AA52;
	{$ENDC}
FUNCTION FSpRename({CONST}VAR spec: FSSpec; newName: Str255): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700B, $AA52;
	{$ENDC}
FUNCTION FSpCatMove({CONST}VAR source: FSSpec; {CONST}VAR dest: FSSpec): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700C, $AA52;
	{$ENDC}
FUNCTION FSpExchangeFiles({CONST}VAR source: FSSpec; {CONST}VAR dest: FSSpec): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700F, $AA52;
	{$ENDC}

FUNCTION PBShareSync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7042, $A260, $3E80;
	{$ENDC}
FUNCTION PBShareAsync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7042, $A660, $3E80;
	{$ENDC}
FUNCTION PBUnshareSync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7043, $A260, $3E80;
	{$ENDC}
FUNCTION PBUnshareAsync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7043, $A660, $3E80;
	{$ENDC}
FUNCTION PBGetUGEntrySync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7044, $A260, $3E80;
	{$ENDC}
FUNCTION PBGetUGEntryAsync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7044, $A660, $3E80;
	{$ENDC}



{$IFC TARGET_CPU_68K }
{
	PBGetAltAccess and PBSetAltAccess are obsolete and will not be supported 
	on PowerPC. Equivalent functionality is provided by the routines 
	PBGetForeignPrivs and PBSetForeignPrivs.
}
FUNCTION PBGetAltAccessSync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7060, $A060, $3E80;
	{$ENDC}
FUNCTION PBGetAltAccessAsync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7060, $A460, $3E80;
	{$ENDC}
FUNCTION PBSetAltAccessSync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7061, $A060, $3E80;
	{$ENDC}
FUNCTION PBSetAltAccessAsync(paramBlock: HParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7061, $A460, $3E80;
	{$ENDC}
FUNCTION PBGetAltAccess(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBSetAltAccess(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;
{$ENDC}  {TARGET_CPU_68K}


{
	The PBxxx() routines are obsolete.  
	
	Use the PBxxxSync() or PBxxxAsync() version instead.
}
{$IFC OLDROUTINENAMES }
FUNCTION PBGetVInfo(paramBlock: ParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBXGetVolInfo(paramBlock: XVolumeParamPtr; async: BOOLEAN): OSErr;
FUNCTION PBGetVol(paramBlock: ParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBSetVol(paramBlock: ParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBFlushVol(paramBlock: ParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBCreate(paramBlock: ParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBDelete(paramBlock: ParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBOpenDF(paramBlock: ParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBOpenRF(paramBlock: ParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBRename(paramBlock: ParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBGetFInfo(paramBlock: ParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBSetFInfo(paramBlock: ParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBSetFLock(paramBlock: ParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBRstFLock(paramBlock: ParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBSetFVers(paramBlock: ParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBAllocate(paramBlock: ParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBGetEOF(paramBlock: ParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBSetEOF(paramBlock: ParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBGetFPos(paramBlock: ParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBSetFPos(paramBlock: ParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBFlushFile(paramBlock: ParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBCatSearch(paramBlock: CSParamPtr; async: BOOLEAN): OSErr;
FUNCTION PBOpenWD(paramBlock: WDPBPtr; async: BOOLEAN): OSErr;
FUNCTION PBCloseWD(paramBlock: WDPBPtr; async: BOOLEAN): OSErr;
FUNCTION PBHSetVol(paramBlock: WDPBPtr; async: BOOLEAN): OSErr;
FUNCTION PBHGetVol(paramBlock: WDPBPtr; async: BOOLEAN): OSErr;
FUNCTION PBCatMove(paramBlock: CMovePBPtr; async: BOOLEAN): OSErr;
FUNCTION PBDirCreate(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBGetWDInfo(paramBlock: WDPBPtr; async: BOOLEAN): OSErr;
FUNCTION PBGetFCBInfo(paramBlock: FCBPBPtr; async: BOOLEAN): OSErr;
FUNCTION PBGetCatInfo(paramBlock: CInfoPBPtr; async: BOOLEAN): OSErr;
FUNCTION PBSetCatInfo(paramBlock: CInfoPBPtr; async: BOOLEAN): OSErr;
FUNCTION PBAllocContig(paramBlock: ParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBLockRange(paramBlock: ParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBUnlockRange(paramBlock: ParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBSetVInfo(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBHGetVInfo(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBHOpen(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBHOpenRF(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBHOpenDF(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBHCreate(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBHDelete(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBHRename(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBHRstFLock(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBHSetFLock(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBHGetFInfo(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBHSetFInfo(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBMakeFSSpec(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBHGetVolParms(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBHGetLogInInfo(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBHGetDirAccess(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBHSetDirAccess(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBHMapID(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBHMapName(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBHCopyFile(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBHMoveRename(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBHOpenDeny(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBHOpenRFDeny(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBExchangeFiles(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBCreateFileIDRef(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBResolveFileIDRef(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBDeleteFileIDRef(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBGetForeignPrivs(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBSetForeignPrivs(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBDTAddIcon(paramBlock: DTPBPtr; async: BOOLEAN): OSErr;
FUNCTION PBDTGetIcon(paramBlock: DTPBPtr; async: BOOLEAN): OSErr;
FUNCTION PBDTGetIconInfo(paramBlock: DTPBPtr; async: BOOLEAN): OSErr;
FUNCTION PBDTAddAPPL(paramBlock: DTPBPtr; async: BOOLEAN): OSErr;
FUNCTION PBDTRemoveAPPL(paramBlock: DTPBPtr; async: BOOLEAN): OSErr;
FUNCTION PBDTGetAPPL(paramBlock: DTPBPtr; async: BOOLEAN): OSErr;
FUNCTION PBDTSetComment(paramBlock: DTPBPtr; async: BOOLEAN): OSErr;
FUNCTION PBDTRemoveComment(paramBlock: DTPBPtr; async: BOOLEAN): OSErr;
FUNCTION PBDTGetComment(paramBlock: DTPBPtr; async: BOOLEAN): OSErr;
FUNCTION PBDTFlush(paramBlock: DTPBPtr; async: BOOLEAN): OSErr;
FUNCTION PBDTReset(paramBlock: DTPBPtr; async: BOOLEAN): OSErr;
FUNCTION PBDTGetInfo(paramBlock: DTPBPtr; async: BOOLEAN): OSErr;
FUNCTION PBDTDelete(paramBlock: DTPBPtr; async: BOOLEAN): OSErr;
{$ENDC}  {OLDROUTINENAMES}

{$IFC OLDROUTINELOCATIONS }
FUNCTION PBOpen(paramBlock: ParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBClose(paramBlock: ParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBRead(paramBlock: ParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBWrite(paramBlock: ParmBlkPtr; async: BOOLEAN): OSErr;
{$ENDC}  {OLDROUTINELOCATIONS}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := FilesIncludes}

{$ENDC} {__FILES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
