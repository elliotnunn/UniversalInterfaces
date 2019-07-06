{
     File:       Files.p
 
     Contains:   File Manager (MFS, HFS, and HFS+) Interfaces.
 
     Version:    Technology: Mac OS 8.5
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1985-2000 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
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
{$IFC UNDEFINED __TEXTCOMMON__}
{$I TextCommon.p}
{$ENDC}
{$IFC UNDEFINED __UTCUTILS__}
{$I UTCUtils.p}
{$ENDC}

{ Finder constants were moved to Finder.≈ }
{$IFC UNDEFINED __FINDER__}
{$I Finder.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ HFSUniStr255 is the Unicode equivalent of Str255 }

TYPE
	HFSUniStr255Ptr = ^HFSUniStr255;
	HFSUniStr255 = RECORD
		length:					UInt16;									{  number of unicode characters  }
		unicode:				ARRAY [0..254] OF UniChar;				{  unicode characters  }
	END;

	ConstHFSUniStr255Param				= ^HFSUniStr255;

CONST
	fsCurPerm					= $00;							{  open access permissions in ioPermssn  }
	fsRdPerm					= $01;
	fsWrPerm					= $02;
	fsRdWrPerm					= $03;
	fsRdWrShPerm				= $04;
	fsRdDenyPerm				= $10;							{  for use with OpenDeny and OpenRFDeny  }
	fsWrDenyPerm				= $20;							{  for use with OpenDeny and OpenRFDeny  }

	fsRtParID					= 1;
	fsRtDirID					= 2;

	fsAtMark					= 0;							{  positioning modes in ioPosMode  }
	fsFromStart					= 1;
	fsFromLEOF					= 2;
	fsFromMark					= 3;

																{  ioPosMode flags  }
	pleaseCacheBit				= 4;							{  please cache this request  }
	pleaseCacheMask				= $0010;
	noCacheBit					= 5;							{  please don't cache this request  }
	noCacheMask					= $0020;
	rdVerifyBit					= 6;							{  read verify mode  }
	rdVerifyMask				= $0040;
	rdVerify					= 64;							{  old name of rdVerifyMask  }
	forceReadBit				= 6;
	forceReadMask				= $0040;
	newLineBit					= 7;							{  newline mode  }
	newLineMask					= $0080;
	newLineCharMask				= $FF00;						{  newline character  }


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

																{  vMExtendedAttributes (GetVolParms) bit position constants  }
	bIsEjectable				= 0;							{  volume is in an ejectable disk drive  }
	bSupportsHFSPlusAPIs		= 1;							{  volume supports HFS Plus APIs directly (not through compatibility layer)  }
	bSupportsFSCatalogSearch	= 2;							{  volume supports FSCatalogSearch  }
	bSupportsFSExchangeObjects	= 3;							{  volume supports FSExchangeObjects  }
	bSupports2TBFiles			= 4;							{  volume supports supports 2 terabyte files  }
	bSupportsLongNames			= 5;							{  volume supports file/directory/volume names longer than 31 characters  }
	bSupportsMultiScriptNames	= 6;							{  volume supports file/directory/volume names with characters from multiple script systems  }
	bSupportsNamedForks			= 7;							{  volume supports forks beyond the data and resource forks  }
	bSupportsSubtreeIterators	= 8;							{  volume supports recursive iterators not at the volume root  }
	bL2PCanMapFileBlocks		= 9;							{  volume supports Lg2Phys SPI correctly  }

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

																{  Large Volume Constants  }
	kWidePosOffsetBit			= 8;
	kUseWidePositioning			= $0100;
	kMaximumBlocksIn4GB			= $007FFFFF;

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

{ vcbFlags bits }
	kVCBFlagsIdleFlushBit		= 3;							{  Set if volume should be flushed at idle time  }
	kVCBFlagsIdleFlushMask		= $0008;
	kVCBFlagsHFSPlusAPIsBit		= 4;							{  Set if volume implements HFS Plus APIs itself (not via emulation)  }
	kVCBFlagsHFSPlusAPIsMask	= $0010;
	kVCBFlagsHardwareGoneBit	= 5;							{  Set if disk driver returned a hardwareGoneErr to Read or Write  }
	kVCBFlagsHardwareGoneMask	= $0020;
	kVCBFlagsVolumeDirtyBit		= 15;							{  Set if volume information has changed since the last FlushVol  }
	kVCBFlagsVolumeDirtyMask	= $8000;

{ ioFlAttrib bits returned by PBGetCatInfo }
																{  file and directory attributes in ioFlAttrib  }
	kioFlAttribLockedBit		= 0;							{  Set if file or directory is locked  }
	kioFlAttribLockedMask		= $01;
	kioFlAttribResOpenBit		= 2;							{  Set if resource fork is open  }
	kioFlAttribResOpenMask		= $04;
	kioFlAttribDataOpenBit		= 3;							{  Set if data fork is open  }
	kioFlAttribDataOpenMask		= $08;
	kioFlAttribDirBit			= 4;							{  Set if this is a directory  }
	kioFlAttribDirMask			= $10;
	ioDirFlg					= 4;							{  Set if this is a directory (old name)  }
	ioDirMask					= $10;
	kioFlAttribCopyProtBit		= 6;							{  Set if AppleShare server "copy-protects" the file  }
	kioFlAttribCopyProtMask		= $40;
	kioFlAttribFileOpenBit		= 7;							{  Set if file (either fork) is open  }
	kioFlAttribFileOpenMask		= $80;							{  ioFlAttrib for directories only  }
	kioFlAttribInSharedBit		= 2;							{  Set if the directory is within a shared area of the directory hierarchy  }
	kioFlAttribInSharedMask		= $04;
	kioFlAttribMountedBit		= 3;							{  Set if the directory is a share point that is mounted by some user  }
	kioFlAttribMountedMask		= $08;
	kioFlAttribSharePointBit	= 5;							{  Set if the directory is a share point  }
	kioFlAttribSharePointMask	= $20;

{ ioFCBFlags bits returned by PBGetFCBInfo }
	kioFCBWriteBit				= 8;							{  Data can be written to this file  }
	kioFCBWriteMask				= $0100;
	kioFCBResourceBit			= 9;							{  This file is a resource fork  }
	kioFCBResourceMask			= $0200;
	kioFCBWriteLockedBit		= 10;							{  File has a locked byte range  }
	kioFCBWriteLockedMask		= $0400;
	kioFCBLargeFileBit			= 11;							{  File may grow beyond 2GB; cache uses file blocks, not bytes  }
	kioFCBLargeFileMask			= $0800;
	kioFCBSharedWriteBit		= 12;							{  File is open for shared write access  }
	kioFCBSharedWriteMask		= $1000;
	kioFCBFileLockedBit			= 13;							{  File is locked (write-protected)  }
	kioFCBFileLockedMask		= $2000;
	kioFCBOwnClumpBit			= 14;							{  File has clump size specified in FCB  }
	kioFCBOwnClumpMask			= $4000;
	kioFCBModifiedBit			= 15;							{  File has changed since it was last flushed  }
	kioFCBModifiedMask			= $8000;

{ ioACUser bits returned by PBGetCatInfo }
{ Note: you must clear ioACUser before calling PBGetCatInfo because some file systems do not use this field }
	kioACUserNoSeeFolderBit		= 0;							{  Set if user does not have See Folder privileges  }
	kioACUserNoSeeFolderMask	= $01;
	kioACUserNoSeeFilesBit		= 1;							{  Set if user does not have See Files privileges  }
	kioACUserNoSeeFilesMask		= $02;
	kioACUserNoMakeChangesBit	= 2;							{  Set if user does not have Make Changes privileges  }
	kioACUserNoMakeChangesMask	= $04;
	kioACUserNotOwnerBit		= 7;							{  Set if user is not owner of the directory  }
	kioACUserNotOwnerMask		= $80;

{ Folder and File values of access privileges in ioACAccess }
	kioACAccessOwnerBit			= 31;							{  User is owner of directory  }
	kioACAccessOwnerMask		= $80000000;
	kioACAccessBlankAccessBit	= 28;							{  Directory has blank access privileges  }
	kioACAccessBlankAccessMask	= $10000000;
	kioACAccessUserWriteBit		= 26;							{  User has write privileges  }
	kioACAccessUserWriteMask	= $04000000;
	kioACAccessUserReadBit		= 25;							{  User has read privileges  }
	kioACAccessUserReadMask		= $02000000;
	kioACAccessUserSearchBit	= 24;							{  User has search privileges  }
	kioACAccessUserSearchMask	= $01000000;
	kioACAccessEveryoneWriteBit	= 18;							{  Everyone has write privileges  }
	kioACAccessEveryoneWriteMask = $00040000;
	kioACAccessEveryoneReadBit	= 17;							{  Everyone has read privileges  }
	kioACAccessEveryoneReadMask	= $00020000;
	kioACAccessEveryoneSearchBit = 16;							{  Everyone has search privileges  }
	kioACAccessEveryoneSearchMask = $00010000;
	kioACAccessGroupWriteBit	= 10;							{  Group has write privileges  }
	kioACAccessGroupWriteMask	= $00000400;
	kioACAccessGroupReadBit		= 9;							{  Group has read privileges  }
	kioACAccessGroupReadMask	= $00000200;
	kioACAccessGroupSearchBit	= 8;							{  Group has search privileges  }
	kioACAccessGroupSearchMask	= $00000100;
	kioACAccessOwnerWriteBit	= 2;							{  Owner has write privileges  }
	kioACAccessOwnerWriteMask	= $00000004;
	kioACAccessOwnerReadBit		= 1;							{  Owner has read privileges  }
	kioACAccessOwnerReadMask	= $00000002;
	kioACAccessOwnerSearchBit	= 0;							{  Owner has search privileges  }
	kioACAccessOwnerSearchMask	= $00000001;
	kfullPrivileges				= $00070007;					{  all privileges for everybody and owner }
	kownerPrivileges			= $00000007;					{  all privileges for owner only }

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
																		{        vMVersion 1 GetVolParmsInfoBuffer ends here  }
		vMVolumeGrade:			LONGINT;								{ approx. speed rating or zero if unrated }
		vMForeignPrivID:		INTEGER;								{ foreign privilege model supported or zero if none }
																		{        vMVersion 2 GetVolParmsInfoBuffer ends here  }
		vMExtendedAttributes:	LONGINT;								{ extended attribute bits (see vMExtendedAttributes constants) }
																		{        vMVersion 3 GetVolParmsInfoBuffer ends here  }
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
	ConstFSSpecPtr						= FSSpecPtr;
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
	kAFPTagTypeIP				= $01;							{  4 byte IP address (MSB first)             }
	kAFPTagTypeIPPort			= $02;							{  4 byte IP address, 2 byte port (MSB first)      }
	kAFPTagTypeDDP				= $03;							{  Net,Node,Socket Sent by the server, currently unused by the client  }
	kAFPTagTypeDNS				= $04;							{  DNS name in  address:port format   (total length variable up to 254 chars of dns name)           }


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
																		{  ••• NOTE: fVersion was missing in 3.2 Universal Interfaces }
		fVersion:				UInt8;									{  version of the structure (currently 0x00) }
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
		ioVTotalBytes:			UInt64;									{  total number of bytes on volume  }
		ioVFreeBytes:			UInt64;									{  number of free bytes on volume  }
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

FUNCTION NewIOCompletionUPP(userRoutine: IOCompletionProcPtr): IOCompletionUPP; { old name was NewIOCompletionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeIOCompletionUPP(userUPP: IOCompletionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE InvokeIOCompletionUPP(paramBlock: ParmBlkPtr; userRoutine: IOCompletionUPP); { old name was CallIOCompletionProc }

{
   PBOpenSync(), PBOpenAsync(), PBOpenImmed() were moved to Devices.h
   PBCloseSync(), PBCloseAsync(), PBCloseImmed() were moved to Devices.h
   PBReadSync(), PBReadAsync(), PBReadImmed() were moved to Devices.h
   PBWriteSync(), PBWriteAsync(), PBWriteImmed() were moved to Devices.h
}


{$IFC CALL_NOT_IN_CARBON }
FUNCTION PBGetVInfoSync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A007, $3E80;
	{$ENDC}
FUNCTION PBGetVInfoAsync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A407, $3E80;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION PBXGetVolInfoSync(paramBlock: XVolumeParamPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7012, $A060, $3E80;
	{$ENDC}
FUNCTION PBXGetVolInfoAsync(paramBlock: XVolumeParamPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7012, $A460, $3E80;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }
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
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION PBFlushVolSync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A013, $3E80;
	{$ENDC}
FUNCTION PBFlushVolAsync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A413, $3E80;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION PBHTrashVolumeCachesSync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A213, $3E80;
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
{$ENDC}  {CALL_NOT_IN_CARBON}

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
{$IFC CALL_NOT_IN_CARBON }
FUNCTION PBMountVol(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A00F, $3E80;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION PBUnmountVol(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A00E, $3E80;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }
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
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION PBCatSearchSync(paramBlock: CSParamPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7018, $A260, $3E80;
	{$ENDC}
FUNCTION PBCatSearchAsync(paramBlock: CSParamPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7018, $A660, $3E80;
	{$ENDC}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION SetVol(volName: ConstStringPtr; vRefNum: INTEGER): OSErr;
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION UnmountVol(volName: ConstStringPtr; vRefNum: INTEGER): OSErr;
{$IFC CALL_NOT_IN_CARBON }
FUNCTION Eject(volName: ConstStringPtr; vRefNum: INTEGER): OSErr;
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION FlushVol(volName: ConstStringPtr; vRefNum: INTEGER): OSErr;
FUNCTION HSetVol(volName: ConstStringPtr; vRefNum: INTEGER; dirID: LONGINT): OSErr;
{  AddDrive() was moved to Devices.h }

{$IFC CALL_NOT_IN_CARBON }
FUNCTION FSOpen(fileName: Str255; vRefNum: INTEGER; VAR refNum: INTEGER): OSErr;
FUNCTION OpenDF(fileName: Str255; vRefNum: INTEGER; VAR refNum: INTEGER): OSErr;
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION FSClose(refNum: INTEGER): OSErr;
FUNCTION FSRead(refNum: INTEGER; VAR count: LONGINT; buffPtr: UNIV Ptr): OSErr;
FUNCTION FSWrite(refNum: INTEGER; VAR count: LONGINT; buffPtr: UNIV Ptr): OSErr;
{$IFC CALL_NOT_IN_CARBON }
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
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION Allocate(refNum: INTEGER; VAR count: LONGINT): OSErr;
FUNCTION GetEOF(refNum: INTEGER; VAR logEOF: LONGINT): OSErr;
FUNCTION SetEOF(refNum: INTEGER; logEOF: LONGINT): OSErr;
FUNCTION GetFPos(refNum: INTEGER; VAR filePos: LONGINT): OSErr;
FUNCTION SetFPos(refNum: INTEGER; posMode: INTEGER; posOff: LONGINT): OSErr;
FUNCTION GetVRefNum(fileRefNum: INTEGER; VAR vRefNum: INTEGER): OSErr;
{$IFC CALL_NOT_IN_CARBON }
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
{$ENDC}  {CALL_NOT_IN_CARBON}

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
{$IFC CALL_NOT_IN_CARBON }
FUNCTION PBGetWDInfoSync(paramBlock: WDPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7007, $A260, $3E80;
	{$ENDC}
FUNCTION PBGetWDInfoAsync(paramBlock: WDPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7007, $A660, $3E80;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

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
{$IFC CALL_NOT_IN_CARBON }
PROCEDURE FInitQueue;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A016;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
FUNCTION GetFSQHdr: QHdrPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2EBC, $0000, $0360;
	{$ENDC}
FUNCTION GetVCBQHdr: QHdrPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2EBC, $0000, $0356;
	{$ENDC}
{  GetDrvQHdr was moved to Devices.h }

{$ENDC}  {CALL_NOT_IN_CARBON}

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
{$IFC CALL_NOT_IN_CARBON }
FUNCTION OpenWD(vRefNum: INTEGER; dirID: LONGINT; procID: LONGINT; VAR wdRefNum: INTEGER): OSErr;
FUNCTION CloseWD(wdRefNum: INTEGER): OSErr;
FUNCTION GetWDInfo(wdRefNum: INTEGER; VAR vRefNum: INTEGER; VAR dirID: LONGINT; VAR procID: LONGINT): OSErr;
{  shared environment  }
{$ENDC}  {CALL_NOT_IN_CARBON}

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
{$IFC CALL_NOT_IN_CARBON }
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
{$ENDC}  {CALL_NOT_IN_CARBON}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION PBGetAltAccess(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PBSetAltAccess(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TARGET_CPU_68K}


{
    The PBxxx() routines are obsolete.  
    
    Use the PBxxxSync() or PBxxxAsync() version instead.
}
{$IFC OLDROUTINENAMES }
{$IFC CALL_NOT_IN_CARBON }
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
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {OLDROUTINENAMES}



TYPE
	FSVolumeRefNum						= SInt16;

CONST
	kFSInvalidVolumeRefNum		= 0;


TYPE
	FSRefPtr = ^FSRef;
	FSRef = RECORD
		hidden:					PACKED ARRAY [0..79] OF UInt8;			{  private to File Manager; •• need symbolic constant  }
	END;

{   CatalogInfoBitmap describes which fields of the CatalogInfo you wish to get or set. }
	FSCatalogInfoBitmap					= UInt32;

CONST
	kFSCatInfoNone				= $00000000;
	kFSCatInfoTextEncoding		= $00000001;
	kFSCatInfoNodeFlags			= $00000002;					{  Locked (bit 0) and directory (bit 4) only  }
	kFSCatInfoVolume			= $00000004;
	kFSCatInfoParentDirID		= $00000008;
	kFSCatInfoNodeID			= $00000010;
	kFSCatInfoCreateDate		= $00000020;
	kFSCatInfoContentMod		= $00000040;
	kFSCatInfoAttrMod			= $00000080;
	kFSCatInfoAccessDate		= $00000100;
	kFSCatInfoBackupDate		= $00000200;
	kFSCatInfoPermissions		= $00000400;					{  Should this be finer granularity?  }
	kFSCatInfoFinderInfo		= $00000800;
	kFSCatInfoFinderXInfo		= $00001000;
	kFSCatInfoValence			= $00002000;					{  Folders only, zero for files  }
	kFSCatInfoDataSizes			= $00004000;					{  Data fork logical and physical size  }
	kFSCatInfoRsrcSizes			= $00008000;					{  Resource fork logical and physical size  }
	kFSCatInfoSharingFlags		= $00010000;					{  sharingFlags: kioFlAttribMountedBit, kioFlAttribSharePointBit  }
	kFSCatInfoUserPrivs			= $00020000;					{  userPrivileges  }
	kFSCatInfoAllDates			= $000003E0;
	kFSCatInfoGettableInfo		= $0003FFFF;
	kFSCatInfoSettableInfo		= $00001FE3;					{  flags, dates, permissions, Finder info, text encoding  }
	kFSCatInfoReserved			= $FFFC0000;					{  bits that are currently reserved  }

{   Constants for nodeFlags field of FSCatalogInfo }
	kFSNodeLockedBit			= 0;
	kFSNodeLockedMask			= $0001;
	kFSNodeIsDirectoryBit		= 4;
	kFSNodeIsDirectoryMask		= $0010;


TYPE
	FSCatalogInfoPtr = ^FSCatalogInfo;
	FSCatalogInfo = RECORD
		nodeFlags:				UInt16;									{  node flags  }
		volume:					FSVolumeRefNum;							{  object's volume ref  }
		parentDirID:			UInt32;									{  parent directory's ID  }
		nodeID:					UInt32;									{  file/directory ID  }
		sharingFlags:			SInt8;									{  kioFlAttribMountedBit and kioFlAttribSharePointBit  }
		userPrivileges:			SInt8;									{  user's effective AFP privileges (same as ioACUser)  }
		reserved1:				SInt8;
		reserved2:				SInt8;
		createDate:				UTCDateTime;							{  date and time of creation  }
		contentModDate:			UTCDateTime;							{  date and time of last fork modification  }
		attributeModDate:		UTCDateTime;							{  date and time of last attribute modification  }
		accessDate:				UTCDateTime;							{  date and time of last access (for Mac OS X)  }
		backupDate:				UTCDateTime;							{  date and time of last backup  }
		permissions:			ARRAY [0..3] OF UInt32;					{  permissions (for Mac OS X)  }
		finderInfo:				PACKED ARRAY [0..15] OF UInt8;			{  Finder information part 1  }
		extFinderInfo:			PACKED ARRAY [0..15] OF UInt8;			{  Finder information part 2  }
		dataLogicalSize:		UInt64;									{  files only  }
		dataPhysicalSize:		UInt64;									{  files only  }
		rsrcLogicalSize:		UInt64;									{  files only  }
		rsrcPhysicalSize:		UInt64;									{  files only  }
		valence:				UInt32;									{  folders only  }
		textEncodingHint:		TextEncoding;
	END;

	FSRefParamPtr = ^FSRefParam;
	FSRefParam = RECORD
		qLink:					QElemPtr;								{ queue link in header }
		qType:					INTEGER;								{ type byte for safety check }
		ioTrap:					INTEGER;								{ FS: the Trap }
		ioCmdAddr:				Ptr;									{ FS: address to dispatch to }
		ioCompletion:			IOCompletionUPP;						{ completion routine addr (0 for synch calls) }
		ioResult:				OSErr;									{ result code }
		ioNamePtr:				ConstStringPtr;							{ ptr to Vol:FileName string }
		ioVRefNum:				INTEGER;								{ volume refnum (DrvNum for Eject and MountVol) }
		reserved1:				SInt16;									{  was ioRefNum  }
		reserved2:				SInt8;									{  was ioVersNum  }
		reserved3:				SInt8;									{  was ioPermssn  }
		ref:					FSRefPtr;								{  Input ref; the target of the call  }
		whichInfo:				FSCatalogInfoBitmap;
		catInfo:				FSCatalogInfoPtr;
		nameLength:				UniCharCount;							{  input name length for create/rename  }
		name:					UniCharPtr;								{  input name for create/rename  }
		ioDirID:				LONGINT;
		spec:					FSSpecPtr;
		parentRef:				FSRefPtr;								{  ref of directory to move another ref to  }
		newRef:					FSRefPtr;								{  Output ref  }
		textEncodingHint:		TextEncoding;							{  for Rename, MakeFSRefUnicode  }
		outName:				HFSUniStr255Ptr;						{  Output name for GetCatalogInfo  }
	END;

	FSIterator = ^LONGINT; { an opaque 32-bit type }

CONST
	kFSIterateFlat				= 0;							{  Immediate children of container only  }
	kFSIterateSubtree			= 1;							{  Entire subtree rooted at container  }
	kFSIterateReserved			= $FFFFFFFE;


TYPE
	FSIteratorFlags						= OptionBits;

CONST
																{  CatalogSearch constants  }
	fsSBNodeID					= $00008000;					{  search by range of nodeID  }
	fsSBAttributeModDate		= $00010000;					{  search by range of attributeModDate  }
	fsSBAccessDate				= $00020000;					{  search by range of accessDate  }
	fsSBPermissions				= $00040000;					{  search by value/mask of permissions  }
	fsSBNodeIDBit				= 15;
	fsSBAttributeModDateBit		= 16;
	fsSBAccessDateBit			= 17;
	fsSBPermissionsBit			= 18;


TYPE
	FSSearchParamsPtr = ^FSSearchParams;
	FSSearchParams = RECORD
		searchTime:				Duration;								{  a Time Manager duration  }
		searchBits:				OptionBits;								{  which fields to search on  }
		searchNameLength:		UniCharCount;
		searchName:				UniCharPtr;
		searchInfo1:			FSCatalogInfoPtr;						{  values and lower bounds  }
		searchInfo2:			FSCatalogInfoPtr;						{  masks and upper bounds  }
	END;

	FSCatalogBulkParamPtr = ^FSCatalogBulkParam;
	FSCatalogBulkParam = RECORD
		qLink:					QElemPtr;								{ queue link in header }
		qType:					INTEGER;								{ type byte for safety check }
		ioTrap:					INTEGER;								{ FS: the Trap }
		ioCmdAddr:				Ptr;									{ FS: address to dispatch to }
		ioCompletion:			IOCompletionUPP;						{ completion routine addr (0 for synch calls) }
		ioResult:				OSErr;									{ result code }
		containerChanged:		BOOLEAN;								{  true if container changed since last iteration  }
		reserved:				SInt8;									{  make following fields 4-byte aligned  }
		iteratorFlags:			FSIteratorFlags;
		iterator:				FSIterator;
		container:				FSRefPtr;								{  directory/volume to iterate  }
		maximumItems:			ItemCount;
		actualItems:			ItemCount;
		whichInfo:				FSCatalogInfoBitmap;
		catalogInfo:			FSCatalogInfoPtr;						{  returns an array  }
		refs:					FSRefPtr;								{  returns an array  }
		specs:					FSSpecPtr;								{  returns an array  }
		names:					HFSUniStr255Ptr;						{  returns an array  }
		searchParams:			FSSearchParamsPtr;
	END;

	FSAllocationFlags					= UInt16;

CONST
	kFSAllocDefaultFlags		= $0000;						{  as much as possible, not contiguous  }
	kFSAllocAllOrNothingMask	= $0001;						{  allocate all of the space, or nothing  }
	kFSAllocContiguousMask		= $0002;						{  new space must be one contiguous piece  }
	kFSAllocNoRoundUpMask		= $0004;						{  don't round up allocation to clump size  }
	kFSAllocReservedMask		= $FFF8;						{  these bits are reserved and must not be set  }


TYPE
	FSForkIOParamPtr = ^FSForkIOParam;
	FSForkIOParam = RECORD
		qLink:					QElemPtr;								{ queue link in header }
		qType:					INTEGER;								{ type byte for safety check }
		ioTrap:					INTEGER;								{ FS: the Trap }
		ioCmdAddr:				Ptr;									{ FS: address to dispatch to }
		ioCompletion:			IOCompletionUPP;						{ completion routine addr (0 for synch calls) }
		ioResult:				OSErr;									{ result code }
		reserved1:				Ptr;									{  was ioNamePtr  }
		reserved2:				SInt16;									{  was ioVRefNum  }
		forkRefNum:				SInt16;									{  same as ioRefNum  }
		reserved3:				SInt8;									{  was ioVersNum  }
		permissions:			SInt8;									{  desired access to the fork  }
		ref:					FSRefPtr;								{  which object to open  }
		buffer:					Ptr;									{ data buffer Ptr }
		requestCount:			UInt32;									{ requested byte count }
		actualCount:			UInt32;									{ actual byte count completed }
		positionMode:			UInt16;									{ initial file positioning }
		positionOffset:			SInt64;									{ file position offset }
		allocationFlags:		FSAllocationFlags;
		allocationAmount:		UInt64;
		forkNameLength:			UniCharCount;							{  input; length of fork name  }
		forkName:				UniCharPtr;								{  input; name of fork  }
		forkIterator:			CatPositionRec;
		outForkName:			HFSUniStr255Ptr;						{  output; name of fork  }
	END;

	FSForkInfoPtr = ^FSForkInfo;
	FSForkInfo = RECORD
		flags:					SInt8;									{  copy of FCB flags  }
		permissions:			SInt8;
		volume:					FSVolumeRefNum;
		reserved2:				UInt32;
		nodeID:					UInt32;									{  file or directory ID  }
		forkID:					UInt32;									{  fork ID  }
		currentPosition:		UInt64;
		logicalEOF:				UInt64;
		physicalEOF:			UInt64;
		process:				UInt64;									{  should be ProcessSerialNumber  }
	END;

	FSForkCBInfoParamPtr = ^FSForkCBInfoParam;
	FSForkCBInfoParam = RECORD
		qLink:					QElemPtr;								{ queue link in header }
		qType:					INTEGER;								{ type byte for safety check }
		ioTrap:					INTEGER;								{ FS: the Trap }
		ioCmdAddr:				Ptr;									{ FS: address to dispatch to }
		ioCompletion:			IOCompletionUPP;						{ completion routine addr (0 for synch calls) }
		ioResult:				OSErr;									{ result code }
		desiredRefNum:			SInt16;									{  0 to iterate, non-0 for specific refnum  }
		volumeRefNum:			SInt16;									{  volume to match, or 0 for all volumes  }
		iterator:				SInt16;									{  0 to start iteration  }
		actualRefNum:			SInt16;									{  actual refnum found  }
		ref:					FSRefPtr;
		forkInfo:				FSForkInfoPtr;
		forkName:				HFSUniStr255Ptr;
	END;

	FSVolumeInfoBitmap					= UInt32;

CONST
	kFSVolInfoNone				= $0000;
	kFSVolInfoCreateDate		= $0001;
	kFSVolInfoModDate			= $0002;
	kFSVolInfoBackupDate		= $0004;
	kFSVolInfoCheckedDate		= $0008;
	kFSVolInfoFileCount			= $0010;
	kFSVolInfoDirCount			= $0020;
	kFSVolInfoSizes				= $0040;						{  totalBytes and freeBytes  }
	kFSVolInfoBlocks			= $0080;						{  blockSize, totalBlocks, freeBlocks  }
	kFSVolInfoNextAlloc			= $0100;
	kFSVolInfoRsrcClump			= $0200;
	kFSVolInfoDataClump			= $0400;
	kFSVolInfoNextID			= $0800;
	kFSVolInfoFinderInfo		= $1000;
	kFSVolInfoFlags				= $2000;
	kFSVolInfoFSInfo			= $4000;						{  filesystemID, signature  }
	kFSVolInfoDriveInfo			= $8000;						{  driveNumber, driverRefNum  }
	kFSVolInfoGettableInfo		= $FFFF;						{  This seems like it is here just for completeness  }
	kFSVolInfoSettableInfo		= $3004;						{  backup date, Finder info, flags  }



TYPE
	FSVolumeInfoPtr = ^FSVolumeInfo;
	FSVolumeInfo = RECORD
																		{  Dates -- zero means "never" or "unknown"  }
		createDate:				UTCDateTime;
		modifyDate:				UTCDateTime;
		backupDate:				UTCDateTime;
		checkedDate:			UTCDateTime;
																		{  File/Folder counts -- return zero if unknown  }
		fileCount:				UInt32;									{  total files on volume  }
		folderCount:			UInt32;									{  total folders on volume  }
																		{  Note: no root directory counts  }
		totalBytes:				UInt64;									{  total number of bytes on volume  }
		freeBytes:				UInt64;									{  number of free bytes on volume  }
																		{  HFS and HFS Plus specific.  Set fields to zero if not appropriate  }
		blockSize:				UInt32;									{  size (in bytes) of allocation blocks  }
		totalBlocks:			UInt32;									{  number of allocation blocks in volume  }
		freeBlocks:				UInt32;									{  number of unused allocation blocks  }
		nextAllocation:			UInt32;									{  start of next allocation search  }
		rsrcClumpSize:			UInt32;									{  default resource fork clump size  }
		dataClumpSize:			UInt32;									{  default data fork clump size  }
		nextCatalogID:			UInt32;									{  next unused catalog node ID ••• OYG ••• need to make HFSVolumes.h work Should be HFSCatalogNodeID }
		finderInfo:				PACKED ARRAY [0..31] OF UInt8;			{  information used by Finder  }
																		{  Identifying information  }
		flags:					UInt16;									{  ioVAtrb  }
		filesystemID:			UInt16;									{  ioVFSID  }
		signature:				UInt16;									{  ioVSigWord, unique within an FSID  }
		driveNumber:			UInt16;									{  ioVDrvInfo  }
		driverRefNum:			INTEGER;								{  ioVDRefNum  }
	END;

	FSVolumeInfoParamPtr = ^FSVolumeInfoParam;
	FSVolumeInfoParam = RECORD
		qLink:					QElemPtr;								{ queue link in header }
		qType:					INTEGER;								{ type byte for safety check }
		ioTrap:					INTEGER;								{ FS: the Trap }
		ioCmdAddr:				Ptr;									{ FS: address to dispatch to }
		ioCompletion:			IOCompletionUPP;						{ completion routine addr (0 for synch calls) }
		ioResult:				OSErr;									{ result code }
		ioNamePtr:				StringPtr;								{  unused  }
		ioVRefNum:				FSVolumeRefNum;							{  volume refnum  }
		volumeIndex:			UInt32;									{  index, or 0 to use ioVRefNum  }
		whichInfo:				FSVolumeInfoBitmap;						{  which volumeInfo fields to get/set  }
		volumeInfo:				FSVolumeInfoPtr;						{  information about the volume  }
		volumeName:				HFSUniStr255Ptr;						{  output; pointer to volume name  }
		ref:					FSRefPtr;								{  volume's FSRef  }
	END;

{
    MakeFSRef
    Create an FSRef for an existing object specified by a combination
    of volume refnum, parent directory, and pathname.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  ioNamePtr       A pointer to a pathname
    ->  ioVRefNum       A volume specification
    ->  ioDirID         A directory ID
    <-  newRef          A pointer to an FSRef
}
FUNCTION FSpMakeFSRef({CONST}VAR source: FSSpec; VAR newRef: FSRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $041A, $AA52;
	{$ENDC}
FUNCTION PBMakeFSRefSync(VAR paramBlock: FSRefParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $706E, $A260, $3E80;
	{$ENDC}
PROCEDURE PBMakeFSRefAsync(VAR paramBlock: FSRefParam);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $706E, $A660;
	{$ENDC}

{
    MakeFSRefUnicode
    Create an FSRef for an existing object specified by 
    Parent FSRef and Unicode name.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  ref             A pointer to the parent directory FSRef
    ->  name            A pointer to Unicde name
    ->  nameLength      The length of the Unicode Name
    ->  textEncodingHint A suggested text encoding to use for the name
    <-  newRef          A pointer to an FSRef
}
FUNCTION FSMakeFSRefUnicode({CONST}VAR parentRef: FSRef; nameLength: UniCharCount; {CONST}VAR name: UniChar; textEncodingHint: TextEncoding; VAR newRef: FSRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0A1B, $AA52;
	{$ENDC}
FUNCTION PBMakeFSRefUnicodeSync(VAR paramBlock: FSRefParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $707A, $A260, $3E80;
	{$ENDC}
PROCEDURE PBMakeFSRefUnicodeAsync(VAR paramBlock: FSRefParam);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $707A, $A660;
	{$ENDC}

{
    CompareFSRefs
    Test whether two FSRefs refer to the same file or directory.
    If they do, noErr is returned.  Otherwise, an appropriate error
    (such as errFSRefsDifferent) is returned.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  ref             A pointer to the first FSRef
    ->  parentRef       A pointer to the second FSRef
}
FUNCTION FSCompareFSRefs({CONST}VAR ref1: FSRef; {CONST}VAR ref2: FSRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0435, $AA52;
	{$ENDC}
FUNCTION PBCompareFSRefsSync(VAR paramBlock: FSRefParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $707C, $A260, $3E80;
	{$ENDC}
PROCEDURE PBCompareFSRefsAsync(VAR paramBlock: FSRefParam);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $707C, $A660;
	{$ENDC}

{
    CreateFileUnicode
    Creates a new file.  The input filename is in Unicode.
    You can optionally set catalog info for the file.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  ref             The directory where the file is to be created
    ->  whichInfo       Which catalog info fields to set
    ->  catInfo         The values for catalog info fields to set; may be NULL
    ->  nameLength      Number of Unicode characters in the file's name
    ->  name            A pointer to the Unicode name
    <-  spec            A pointer to the FSSpec for the new directory; may be NULL
    <-  newRef          A pointer to the FSRef for the new file; may be NULL
}
FUNCTION FSCreateFileUnicode({CONST}VAR parentRef: FSRef; nameLength: UniCharCount; {CONST}VAR name: UniChar; whichInfo: FSCatalogInfoBitmap; catalogInfo: {Const}FSCatalogInfoPtr; newRef: FSRefPtr; newSpec: FSSpecPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0E1C, $AA52;
	{$ENDC}
FUNCTION PBCreateFileUnicodeSync(VAR paramBlock: FSRefParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7070, $A260, $3E80;
	{$ENDC}
PROCEDURE PBCreateFileUnicodeAsync(VAR paramBlock: FSRefParam);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7070, $A660;
	{$ENDC}

{
    CreateDirectoryUnicode
    Creates a new directory.  The input directory name is in Unicode.
    You can optionally set catalog info for the directory.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  ref             The parent directory where the directory is to be created
    ->  whichInfo       Which catalog info fields to set
    ->  catInfo         The values for catalog info fields to set; may be NULL
    ->  nameLength      Number of Unicode characters in the directory's name
    ->  name            A pointer to the Unicode name
    <-  ioDirID         The DirID of the new directory
    <-  spec            A pointer to the FSSpec for the new directory; may be NULL
    <-  newRef          A pointer to the FSRef for the new directory; may be NULL
}
FUNCTION FSCreateDirectoryUnicode({CONST}VAR parentRef: FSRef; nameLength: UniCharCount; {CONST}VAR name: UniChar; whichInfo: FSCatalogInfoBitmap; catalogInfo: {Const}FSCatalogInfoPtr; newRef: FSRefPtr; newSpec: FSSpecPtr; VAR newDirID: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $101D, $AA52;
	{$ENDC}
FUNCTION PBCreateDirectoryUnicodeSync(VAR paramBlock: FSRefParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7071, $A260, $3E80;
	{$ENDC}
PROCEDURE PBCreateDirectoryUnicodeAsync(VAR paramBlock: FSRefParam);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7071, $A660;
	{$ENDC}

{
    DeleteObject
    Deletes an existing file or directory.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  ref             The file or directory to be deleted
}
FUNCTION FSDeleteObject({CONST}VAR ref: FSRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $021E, $AA52;
	{$ENDC}
FUNCTION PBDeleteObjectSync(VAR paramBlock: FSRefParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7072, $A260, $3E80;
	{$ENDC}
PROCEDURE PBDeleteObjectAsync(VAR paramBlock: FSRefParam);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7072, $A660;
	{$ENDC}

{
    MoveObject
    Move an existing file or directory into a different directory.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  ref             The file or directory to be moved
    ->  parentRef       The file or directory will be moved into this directory
    <-  newRef          A new FSRef for the file or directory in its new location;
                        optional, may be NULL
    NOTE: Moving an object may change its FSRef.  If you want to continue to
    refer to the object, you should pass a non-NULL pointer in newRef and use
    that returned FSRef to access the object after the move.  The FSRef passed
    in "ref" may or may not be usable to access the object after it is moved.
    "newRef" may point to the same storage as "parentRef" or "ref".
}
FUNCTION FSMoveObject({CONST}VAR ref: FSRef; {CONST}VAR destDirectory: FSRef; newRef: FSRefPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $061F, $AA52;
	{$ENDC}
FUNCTION PBMoveObjectSync(VAR paramBlock: FSRefParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7073, $A260, $3E80;
	{$ENDC}
PROCEDURE PBMoveObjectAsync(VAR paramBlock: FSRefParam);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7073, $A660;
	{$ENDC}

{
    ExchangeObjects
    swap the contents of two files.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  ref             The first file 
    ->  parentRef       The second file 
}
FUNCTION FSExchangeObjects({CONST}VAR ref: FSRef; {CONST}VAR destRef: FSRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0421, $AA52;
	{$ENDC}
FUNCTION PBExchangeObjectsSync(VAR paramBlock: FSRefParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7075, $A260, $3E80;
	{$ENDC}
PROCEDURE PBExchangeObjectsAsync(VAR paramBlock: FSRefParam);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7075, $A660;
	{$ENDC}

{
    RenameUnicode
    Change the name of an existing file or directory.  The new name is in
    Unicode.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  ref             The file or directory to be moved
    ->  nameLength      Number of Unicode characters in the new name
    ->  name            A pointer to the new Unicode name
    ->  textEncodingHint A suggested text encoding to use for the name
    <-  newRef          A new FSRef for the file or directory; may be NULL
    NOTE: Renaming an object may change its FSRef.  If you want to continue to
    refer to the object, you should pass a non-NULL pointer in newRef and use
    that returned FSRef to access the object after the rename.  The FSRef passed
    in "ref" may or may not be usable to access the object after it is renamed.
    "newRef" may point to the same storage as "ref".
}
FUNCTION FSRenameUnicode({CONST}VAR ref: FSRef; nameLength: UniCharCount; {CONST}VAR name: UniChar; textEncodingHint: TextEncoding; newRef: FSRefPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0A20, $AA52;
	{$ENDC}
FUNCTION PBRenameUnicodeSync(VAR paramBlock: FSRefParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7074, $A260, $3E80;
	{$ENDC}
PROCEDURE PBRenameUnicodeAsync(VAR paramBlock: FSRefParam);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7074, $A660;
	{$ENDC}

{
    GetCatalogInfo
    Returns various information about a given file or directory.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  ref             The file or directory whose information is to be returned
    ->  whichInfo       Which catalog info fields to get
    <-  catInfo         The returned values of catalog info fields; may be NULL
    <-  spec            A pointer to the FSSpec for the object; may be NULL
    <-  parentRef       A pointer to the FSRef for the object's parent directory; may be NULL
    <-  outName         The Unicode name is returned here.  This pointer may be NULL.
    Note: All of the outputs are optional; if you don't want that particular output, just
    set its pointer to NULL.  This is the call to use to map from an FSRef to an FSSpec.
}
FUNCTION FSGetCatalogInfo({CONST}VAR ref: FSRef; whichInfo: FSCatalogInfoBitmap; catalogInfo: FSCatalogInfoPtr; outName: HFSUniStr255Ptr; fsSpec: FSSpecPtr; parentRef: FSRefPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0C22, $AA52;
	{$ENDC}
FUNCTION PBGetCatalogInfoSync(VAR paramBlock: FSRefParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7076, $A260, $3E80;
	{$ENDC}
PROCEDURE PBGetCatalogInfoAsync(VAR paramBlock: FSRefParam);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7076, $A660;
	{$ENDC}

{
    SetCatalogInfo
    Set catalog information about a given file or directory.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  ref             The file or directory whose information is to be changed
    ->  whichInfo       Which catalog info fields to set
    ->  catInfo         The new values of catalog info fields
    Note: Only some of the catalog info fields may be set.  The settable fields
    are given by the constant kFSCatInfoSettableInfo; no other bits may be set in
    whichInfo.
}
FUNCTION FSSetCatalogInfo({CONST}VAR ref: FSRef; whichInfo: FSCatalogInfoBitmap; {CONST}VAR catalogInfo: FSCatalogInfo): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0623, $AA52;
	{$ENDC}
FUNCTION PBSetCatalogInfoSync(VAR paramBlock: FSRefParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7077, $A260, $3E80;
	{$ENDC}
PROCEDURE PBSetCatalogInfoAsync(VAR paramBlock: FSRefParam);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7077, $A660;
	{$ENDC}

{
    OpenIterator
    Creates an FSIterator to iterate over a directory or subtree.  The
    iterator can then be passed to GetCatalogInfoBulk or CatalogSearch.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    <-  iterator        The returned FSIterator
    ->  iteratorFlags   Controls whether the iterator iterates over subtrees
                        or just the immediate children of the container.
    ->  container       An FSRef for the directory to iterate (or root of
                        the subtree to iterate).
}
FUNCTION FSOpenIterator({CONST}VAR container: FSRef; iteratorFlags: FSIteratorFlags; VAR iterator: FSIterator): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0624, $AA52;
	{$ENDC}
FUNCTION PBOpenIteratorSync(VAR paramBlock: FSCatalogBulkParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7078, $A260, $3E80;
	{$ENDC}
PROCEDURE PBOpenIteratorAsync(VAR paramBlock: FSCatalogBulkParam);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7078, $A660;
	{$ENDC}

{
    CloseIterator
    Invalidates and disposes an FSIterator.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  iterator        The returned FSIterator
}
FUNCTION FSCloseIterator(iterator: FSIterator): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0225, $AA52;
	{$ENDC}
FUNCTION PBCloseIteratorSync(VAR paramBlock: FSCatalogBulkParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $705B, $A260, $3E80;
	{$ENDC}
PROCEDURE PBCloseIteratorAsync(VAR paramBlock: FSCatalogBulkParam);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $705B, $A660;
	{$ENDC}

{
    GetCatalogInfoBulk
    Iterates over catalog objects and returns information about them.
    For now, iterator must have been created with kFSIterateFlat option.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  iterator        The iterator
    ->  maximumItems    The maximum number of items to return
    <-  actualItems     The actual number of items returned
    <-  containerChanged Set to true if the container's contents changed
    ->  whichInfo       The catalog information fields to return for each item
    <-  catalogInfo     An array of catalog information; one for each returned item
    <-  refs            An array of FSRefs; one for each returned item
    <-  specs           An array of FSSpecs; one for each returned item
    <-  names           An array of filenames; one for each returned item
    Note: The catalogInfo, refs, specs, names, and containerChanged are all optional outputs;
    if you don't want that particular output, set its pointer to NULL.
}
FUNCTION FSGetCatalogInfoBulk(iterator: FSIterator; maximumObjects: ItemCount; VAR actualObjects: ItemCount; VAR containerChanged: BOOLEAN; whichInfo: FSCatalogInfoBitmap; catalogInfos: FSCatalogInfoPtr; refs: FSRefPtr; specs: FSSpecPtr; names: HFSUniStr255Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $1226, $AA52;
	{$ENDC}
FUNCTION PBGetCatalogInfoBulkSync(VAR paramBlock: FSCatalogBulkParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $705C, $A260, $3E80;
	{$ENDC}
PROCEDURE PBGetCatalogInfoBulkAsync(VAR paramBlock: FSCatalogBulkParam);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $705C, $A660;
	{$ENDC}
{
    CatalogSearch
    Iterates over catalog objects, searching for objects that match given
    search criteria.  Returns various information about matching objects.
    For now, iterator must have been created with kFSIterateSubtree option
    and the container must have been the root directory of a volume.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  iterator        The iterator
    ->  maximumItems    The maximum number of items to return
    <-  actualItems     The actual number of items returned
    <-  containerChanged Set to true if the container's contents changed
    ->  whichInfo       The catalog information fields to return for each item
    <-  catalogInfo     An array of catalog information; one for each returned item
    <-  refs            An array of FSRefs; one for each returned item
    <-  specs           An array of FSSpecs; one for each returned item
    <-  names           An array of filenames; one for each returned item
    ->  searchParams    The criteria that controls the matching, including timeout, a bitmap
                        controlling the fields to compare, and the (Unicode) name to compare.
    Note: The catalogInfo, refs, specs, and names are all optional outputs; if you don't want
    that particular output, set its pointer to NULL.
}
FUNCTION FSCatalogSearch(iterator: FSIterator; {CONST}VAR searchCriteria: FSSearchParams; maximumObjects: ItemCount; VAR actualObjects: ItemCount; VAR containerChanged: BOOLEAN; whichInfo: FSCatalogInfoBitmap; catalogInfos: FSCatalogInfoPtr; refs: FSRefPtr; specs: FSSpecPtr; names: HFSUniStr255Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $1427, $AA52;
	{$ENDC}
FUNCTION PBCatalogSearchSync(VAR paramBlock: FSCatalogBulkParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $705D, $A260, $3E80;
	{$ENDC}
PROCEDURE PBCatalogSearchAsync(VAR paramBlock: FSCatalogBulkParam);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $705D, $A660;
	{$ENDC}

{
    CreateFork
    Create a named fork for a file or directory.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  ref             The file or directory
    ->  forkNameLength  The length of the fork name (in Unicode characters)
    ->  forkName        The name of the fork to open (in Unicode)
}
FUNCTION FSCreateFork({CONST}VAR ref: FSRef; forkNameLength: UniCharCount; {CONST}VAR forkName: UniChar): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0636, $AA52;
	{$ENDC}
FUNCTION PBCreateForkSync(VAR paramBlock: FSForkIOParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $707D, $A260, $3E80;
	{$ENDC}
PROCEDURE PBCreateForkAsync(VAR paramBlock: FSForkIOParam);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $707D, $A660;
	{$ENDC}

{
    DeleteFork
    Delete a named fork of a file or directory.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  ref             The file or directory
    ->  forkNameLength  The length of the fork name (in Unicode characters)
    ->  forkName        The name of the fork to open (in Unicode)
}
FUNCTION FSDeleteFork({CONST}VAR ref: FSRef; forkNameLength: UniCharCount; {CONST}VAR forkName: UniChar): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0637, $AA52;
	{$ENDC}
FUNCTION PBDeleteForkSync(VAR paramBlock: FSForkIOParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $707E, $A260, $3E80;
	{$ENDC}
PROCEDURE PBDeleteForkAsync(VAR paramBlock: FSForkIOParam);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $707E, $A660;
	{$ENDC}

{
    IterateForks
    Return the names and sizes of the forks of a file or directory.
    One fork is returned per call.
    ->  ioCompletion    A pointer to a completion routine.
    <-  ioResult        The result code of the function.
    ->  ref             The file or directory containing the forks.
    <-  positionOffset  The length of the fork, in bytes.
    <-  allocationAmount The space allocated to the fork (physical length).
    <-  outForkName     The name of the fork in Unicode.
    <>  forkIterator    Maintains state between calls for a given FSRef.
                        Before the first call, set the initialize field to zero.
}
FUNCTION FSIterateForks({CONST}VAR ref: FSRef; VAR forkIterator: CatPositionRec; forkName: HFSUniStr255Ptr; forkSize: SInt64Ptr; forkPhysicalSize: UInt64Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0A38, $AA52;
	{$ENDC}
FUNCTION PBIterateForksSync(VAR paramBlock: FSForkIOParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $707F, $A260, $3E80;
	{$ENDC}
PROCEDURE PBIterateForksAsync(VAR paramBlock: FSForkIOParam);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $707F, $A660;
	{$ENDC}

{
    OpenFork
    Open a fork for reading and/or writing.  Allows the opened fork
    to grow beyond 2GB in size.  All volumes should support data and
    resource forks.  Other named forks may be supported by some
    volumes.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  ref             The file or directory containing the fork to open
    ->  forkNameLength  The length of the fork name (in Unicode characters)
    ->  forkName        The name of the fork to open (in Unicode)
    ->  permissions     The access (read and/or write) you want
    <-  forkRefNum      The reference number for accessing the open fork
}
FUNCTION FSOpenFork({CONST}VAR ref: FSRef; forkNameLength: UniCharCount; {CONST}VAR forkName: UniChar; permissions: SInt8; VAR forkRefNum: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0928, $AA52;
	{$ENDC}
FUNCTION PBOpenForkSync(VAR paramBlock: FSForkIOParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7079, $A260, $3E80;
	{$ENDC}
PROCEDURE PBOpenForkAsync(VAR paramBlock: FSForkIOParam);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7079, $A660;
	{$ENDC}

{
    ReadFork
    Read data from a fork opened via OpenFork.  The first byte to read is
    indicated by a combination of positionMode and positionOffset.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  forkRefNum      The reference number of the fork to read from
    <-  buffer          Pointer to buffer where data will be returned
    ->  requestCount    The number of bytes to read
    <-  actualCount     The number of bytes actually read
    ->  positionMode    The base location for start of read
    ->  positionOffset  The offset from base location for start of read
}
FUNCTION FSReadFork(forkRefNum: SInt16; positionMode: UInt16; positionOffset: SInt64; requestCount: ByteCount; buffer: UNIV Ptr; VAR actualCount: ByteCount): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0A29, $AA52;
	{$ENDC}
FUNCTION PBReadForkSync(VAR paramBlock: FSForkIOParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7051, $A2A8, $3E80;
	{$ENDC}
PROCEDURE PBReadForkAsync(VAR paramBlock: FSForkIOParam);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7051, $A6A8;
	{$ENDC}

{
    WriteFork
    Write data to a fork opened via OpenFork.  The first byte to write is
    indicated by a combination of positionMode and positionOffset.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  forkRefNum      The reference number of the fork to write to
    ->  buffer          Pointer to data to write
    ->  requestCount    The number of bytes to write
    <-  actualCount     The number of bytes actually written
    ->  positionMode    The base location for start of write
    ->  positionOffset  The offset from base location for start of write
}
FUNCTION FSWriteFork(forkRefNum: SInt16; positionMode: UInt16; positionOffset: SInt64; requestCount: ByteCount; buffer: UNIV Ptr; VAR actualCount: ByteCount): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0A2A, $AA52;
	{$ENDC}
FUNCTION PBWriteForkSync(VAR paramBlock: FSForkIOParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7052, $A2A8, $3E80;
	{$ENDC}
PROCEDURE PBWriteForkAsync(VAR paramBlock: FSForkIOParam);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7052, $A6A8;
	{$ENDC}

{
    GetForkPosition
    Get the current (default) position of a fork that was
    opened via OpenFork.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  forkRefNum      The reference number of the fork
    <-  positionOffset  The current position of the fork
}
FUNCTION FSGetForkPosition(forkRefNum: SInt16; VAR position: SInt64): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $032B, $AA52;
	{$ENDC}
FUNCTION PBGetForkPositionSync(VAR paramBlock: FSForkIOParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7053, $A260, $3E80;
	{$ENDC}
PROCEDURE PBGetForkPositionAsync(VAR paramBlock: FSForkIOParam);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7053, $A660;
	{$ENDC}

{
    SetForkPosition
    Set the current (default) position of a fork that was
    opened via OpenFork.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  forkRefNum      The reference number of the fork
    ->  positionMode    The base location for the new position
    ->  positionOffset  The offset of the new position from the base
}
FUNCTION FSSetForkPosition(forkRefNum: SInt16; positionMode: UInt16; positionOffset: SInt64): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $042C, $AA52;
	{$ENDC}
FUNCTION PBSetForkPositionSync(VAR paramBlock: FSForkIOParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7054, $A260, $3E80;
	{$ENDC}
PROCEDURE PBSetForkPositionAsync(VAR paramBlock: FSForkIOParam);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7054, $A660;
	{$ENDC}

{
    GetForkSize
    Get the current logical size (end-of-file) of an open fork.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  forkRefNum      The reference number of the fork
    <-  positionOffset  The logical size of the fork, in bytes
}
FUNCTION FSGetForkSize(forkRefNum: SInt16; VAR forkSize: SInt64): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $032D, $AA52;
	{$ENDC}
FUNCTION PBGetForkSizeSync(VAR paramBlock: FSForkIOParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7055, $A260, $3E80;
	{$ENDC}
PROCEDURE PBGetForkSizeAsync(VAR paramBlock: FSForkIOParam);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7055, $A660;
	{$ENDC}

{
    SetForkSize
    Set the logical size (end-of-file) of an open fork.  This
    may cause space to be allocated or deallocated.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  forkRefNum      The reference number of the fork
    ->  positionMode    The base location for the new size
    ->  positionOffset  The offset of the new size from the base
}
FUNCTION FSSetForkSize(forkRefNum: SInt16; positionMode: UInt16; positionOffset: SInt64): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $042E, $AA52;
	{$ENDC}
FUNCTION PBSetForkSizeSync(VAR paramBlock: FSForkIOParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7056, $A260, $3E80;
	{$ENDC}
PROCEDURE PBSetForkSizeAsync(VAR paramBlock: FSForkIOParam);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7056, $A660;
	{$ENDC}

{
    AllocateFork
    Allocate space to an open fork.  Typically, the space to be
    allocated is beyond the current size of the fork, to reserve
    space so the file will be able to grow later.  Some volume
    formats are unable to allocate space beyond the logical size
    of the fork.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  forkRefNum      The reference number of the fork
    ->  positionMode    The base location for start of allocation
    ->  positionOffset  The offset of the start of allocation
    ->  allocationFlags Zero or more of the following flags:
        kFSAllocContiguousMask
                Any newly allocated space must be one contiguous piece.
        kFSAllocAllOrNothingMask
                All of the request space must be available, or the call
                will fail.  (If not set, the call may succeed even though
                some of the requested space wasn't allocated.)
        kFSAllocNoRoundUpMask
                Do not allocate additional space.  (If not set, a volume
                may allocate additional space in order to reduce fragmentation.)
    <>  allocationAmount    The number of bytes to allocate
                            On output, the number of bytes actually added
}
FUNCTION FSAllocateFork(forkRefNum: SInt16; flags: FSAllocationFlags; positionMode: UInt16; positionOffset: SInt64; requestCount: UInt64; actualCount: UInt64Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $092F, $AA52;
	{$ENDC}
FUNCTION PBAllocateForkSync(VAR paramBlock: FSForkIOParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7057, $A260, $3E80;
	{$ENDC}
PROCEDURE PBAllocateForkAsync(VAR paramBlock: FSForkIOParam);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7057, $A660;
	{$ENDC}

{
    FlushFork
    Flush a fork.  Any data written to this fork refnum is flushed to the device.
    The volume's control structures are also flushed to the device.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  forkRefNum      The reference number of the fork to flush
}
FUNCTION FSFlushFork(forkRefNum: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0130, $AA52;
	{$ENDC}
FUNCTION PBFlushForkSync(VAR paramBlock: FSForkIOParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7058, $A260, $3E80;
	{$ENDC}
PROCEDURE PBFlushForkAsync(VAR paramBlock: FSForkIOParam);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7058, $A660;
	{$ENDC}

{
    CloseFork
    Flush and close a fork.  Any data written to this fork refnum is flushed
    to the device.  The volume's control structures are also flushed to the device.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  forkRefNum      The reference number of the fork to close
}
FUNCTION FSCloseFork(forkRefNum: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0131, $AA52;
	{$ENDC}
FUNCTION PBCloseForkSync(VAR paramBlock: FSForkIOParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7059, $A260, $3E80;
	{$ENDC}
PROCEDURE PBCloseForkAsync(VAR paramBlock: FSForkIOParam);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7059, $A660;
	{$ENDC}

{
    GetForkCBInfo
    Return information about an open fork.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    <>  desiredRefNum   If non-zero on input, then get information for this refnum;
                        unchanged on output.  If zero on input, iterate over all open
                        forks (possibly limited to a single volume); on output, contains
                        the fork's refnum.
    ->  volumeRefNum    Used when desiredRefNum is zero on input.  Set to 0 to iterate over all
                        volumes, or set to a FSVolumeRefNum to limit iteration to that volume.
    <>  iterator        Used when desiredRefNum is zero on input.  Set to 0 before iterating.
                        Pass the iterator returned by the previous call to continue iterating.
    <-  actualRefNum    The refnum of the open fork.
    <-  ref             The FSRef for the file or directory that contains the fork.
    <-  forkInfo        Various information about the open fork.
    <-  outForkName     The name of the fork
    Note: the foundRefNum, ref, forkInfo, and fork name outputs are all optional; if you don't want
    a particular output, then set its pointer to NULL.  If forkName is NULL, then forkNameLength
    will be undefined.
    Note: Returning the forkInfo generally does not require a disk access.  Returning the
    ref or forkName may cause disk access for some volume formats.
}
FUNCTION FSGetForkCBInfo(desiredRefNum: SInt16; volume: FSVolumeRefNum; VAR iterator: SInt16; VAR actualRefNum: SInt16; forkInfo: FSForkInfoPtr; ref: FSRefPtr; outForkName: HFSUniStr255Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0C32, $AA52;
	{$ENDC}
FUNCTION PBGetForkCBInfoSync(VAR paramBlock: FSForkCBInfoParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $705A, $A260, $3E80;
	{$ENDC}
PROCEDURE PBGetForkCBInfoAsync(VAR paramBlock: FSForkCBInfoParam);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $705A, $A660;
	{$ENDC}

{
    GetVolumeInfo
    Returns various information about a given volume, or indexing over all volumes.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    <>  ioVRefNum       On input, the volume reference number or drive number whose
                        information is to be returned (if volumeIndex is 0); same
                        as "volume" input to FSGetVolumeInfo.
                        On output, the actual volume reference number; same as
                        "actualVolume" output of FSGetVolumeInfo.
    ->  volumeIndex     The index of the desired volume, or 0 to use ioVRefNum
    ->  whichInfo       Which volInfo info fields to get
    <-  volumeInfo      The returned values of Volume info fields; may be NULL
    <-  name            The Unicode name is returned here.  This pointer may be NULL.
    Note: All of the outputs are optional; if you don't want that particular output, just
    set it's pointer to NULL.
}
FUNCTION FSGetVolumeInfo(volume: FSVolumeRefNum; volumeIndex: ItemCount; VAR actualVolume: FSVolumeRefNum; whichInfo: FSVolumeInfoBitmap; info: FSVolumeInfoPtr; volumeName: HFSUniStr255Ptr; rootDirectory: FSRefPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0D33, $AA52;
	{$ENDC}
FUNCTION PBGetVolumeInfoSync(VAR paramBlock: FSVolumeInfoParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $701D, $A260, $3E80;
	{$ENDC}
PROCEDURE PBGetVolumeInfoAsync(VAR paramBlock: FSVolumeInfoParam);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $701D, $A660;
	{$ENDC}

{
    SetVolumeInfo
    Set information about a given volume.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  ioVRefNum       The volume whose information is to be changed
    ->  whichInfo       Which catalog info fields to set
    ->  volumeInfo      The new values of volume info fields
    Note: Only some of the volume info fields may be set.  The settable fields
    are given by the constant kFSVolInfoSettableInfo; no other bits may be set in
    whichInfo.
}
FUNCTION FSSetVolumeInfo(volume: FSVolumeRefNum; whichInfo: FSVolumeInfoBitmap; {CONST}VAR info: FSVolumeInfo): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0534, $AA52;
	{$ENDC}
FUNCTION PBSetVolumeInfoSync(VAR paramBlock: FSVolumeInfoParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $701E, $A260, $3E80;
	{$ENDC}
PROCEDURE PBSetVolumeInfoAsync(VAR paramBlock: FSVolumeInfoParam);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $701E, $A660;
	{$ENDC}
{
    FSGetDataForkName
    Returns the constant for the name of the data fork (the empty string)
}
FUNCTION FSGetDataForkName(VAR dataForkName: HFSUniStr255): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0218, $AA52;
	{$ENDC}
{
    FSGetResourceForkName
    Returns the constant for the name of the resource fork
    (currently "RESOURCE_FORK").
}
FUNCTION FSGetResourceForkName(VAR resourceForkName: HFSUniStr255): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0219, $AA52;
	{$ENDC}
{
    FSRefMakePath/FSPathMakeRef
    These calls are only implemented on OS X, and are available through the Carbon API.
    The path arguments can be used by POSIX-style calls.
}
FUNCTION FSRefMakePath({CONST}VAR ref: FSRef; VAR path: UInt8; pathSize: UInt32): OSStatus;
FUNCTION FSPathMakeRef({CONST}VAR path: UInt8; VAR ref: FSRef; VAR isDirectory: BOOLEAN): OSStatus;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := FilesIncludes}

{$ENDC} {__FILES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
