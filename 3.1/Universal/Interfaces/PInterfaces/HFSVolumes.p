{
 	File:		HFSVolumes.p
 
 	Contains:	On-disk data structures for HFS and HFS Plus volumes.
 
 	Version:	Technology:	
 				Release:	Universal Interfaces 3.1
 
 	Copyright:	© 1984-1998 by Apple Computer, Inc.  All rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT HFSVolumes;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __HFSVOLUMES__}
{$SETC __HFSVOLUMES__ := 1}

{$I+}
{$SETC HFSVolumesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __FINDER__}
{$I Finder.p}
{$ENDC}



{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ Signatures used to differentiate between HFS and HFS Plus volumes }

CONST
	kHFSSigWord					= $4244;						{  'BD' in ASCII  }
	kHFSPlusSigWord				= $482B;						{  'H+' in ASCII  }
	kHFSPlusVersion				= $0004;						{  will change as format changes (version 4 shipped with Mac OS 8.1)  }
	kHFSPlusMountVersion		= '8.10';						{  will change as implementations change ('8.10' in Mac OS 8.1)  }


{ CatalogNodeID is used to track catalog objects }

TYPE
	HFSCatalogNodeID					= UInt32;
{ Unicode strings are used for file and folder names (HFS Plus only) }
	HFSUniStr255Ptr = ^HFSUniStr255;
	HFSUniStr255 = RECORD
		length:					UInt16;									{  number of unicode characters  }
		unicode:				ARRAY [0..254] OF UniChar;				{  unicode characters  }
	END;

	ConstHFSUniStr255Param				= ^HFSUniStr255;

CONST
	kHFSMaxVolumeNameChars		= 27;
	kHFSMaxFileNameChars		= 31;
	kHFSPlusMaxFileNameChars	= 255;


{ Extent overflow file data structures }
{ HFS Extent key }

TYPE
	HFSExtentKeyPtr = ^HFSExtentKey;
	HFSExtentKey = RECORD
		keyLength:				SInt8;									{  length of key, excluding this field  }
		forkType:				SInt8;									{  0 = data fork, FF = resource fork  }
		fileID:					HFSCatalogNodeID;						{  file ID  }
		startBlock:				UInt16;									{  first file allocation block number in this extent  }
	END;

{ HFS Plus Extent key }
	HFSPlusExtentKeyPtr = ^HFSPlusExtentKey;
	HFSPlusExtentKey = RECORD
		keyLength:				UInt16;									{  length of key, excluding this field  }
		forkType:				SInt8;									{  0 = data fork, FF = resource fork  }
		pad:					SInt8;									{  make the other fields align on 32-bit boundary  }
		fileID:					HFSCatalogNodeID;						{  file ID  }
		startBlock:				UInt32;									{  first file allocation block number in this extent  }
	END;

{ Number of extent descriptors per extent record }

CONST
	kHFSExtentDensity			= 3;
	kHFSPlusExtentDensity		= 8;

{ HFS extent descriptor }

TYPE
	HFSExtentDescriptorPtr = ^HFSExtentDescriptor;
	HFSExtentDescriptor = RECORD
		startBlock:				UInt16;									{  first allocation block  }
		blockCount:				UInt16;									{  number of allocation blocks  }
	END;

{ HFS Plus extent descriptor }
	HFSPlusExtentDescriptorPtr = ^HFSPlusExtentDescriptor;
	HFSPlusExtentDescriptor = RECORD
		startBlock:				UInt32;									{  first allocation block  }
		blockCount:				UInt32;									{  number of allocation blocks  }
	END;

{ HFS extent record }
	HFSExtentRecord						= ARRAY [0..2] OF HFSExtentDescriptor;
{ HFS Plus extent record }
	HFSPlusExtentRecord					= ARRAY [0..7] OF HFSPlusExtentDescriptor;

{ Fork data info (HFS Plus only) - 80 bytes }
	HFSPlusForkDataPtr = ^HFSPlusForkData;
	HFSPlusForkData = RECORD
		logicalSize:			UInt64;									{  fork's logical size in bytes  }
		clumpSize:				UInt32;									{  fork's clump size in bytes  }
		totalBlocks:			UInt32;									{  total blocks used by this fork  }
		extents:				HFSPlusExtentRecord;					{  initial set of extents  }
	END;

{ Permissions info (HFS Plus only) - 16 bytes }
	HFSPlusPermissionsPtr = ^HFSPlusPermissions;
	HFSPlusPermissions = RECORD
		ownerID:				UInt32;									{  user or group ID of file/folder owner  }
		groupID:				UInt32;									{  additional user of group ID  }
		permissions:			UInt32;									{  permissions (bytes: unused, owner, group, everyone)  }
		specialDevice:			UInt32;									{  UNIX: device for character or block special file  }
	END;

{ Catalog file data structures }

CONST
	kHFSRootParentID			= 1;							{  Parent ID of the root folder  }
	kHFSRootFolderID			= 2;							{  Folder ID of the root folder  }
	kHFSExtentsFileID			= 3;							{  File ID of the extents file  }
	kHFSCatalogFileID			= 4;							{  File ID of the catalog file  }
	kHFSBadBlockFileID			= 5;							{  File ID of the bad allocation block file  }
	kHFSAllocationFileID		= 6;							{  File ID of the allocation file (HFS Plus only)  }
	kHFSStartupFileID			= 7;							{  File ID of the startup file (HFS Plus only)  }
	kHFSAttributesFileID		= 8;							{  File ID of the attribute file (HFS Plus only)  }
	kHFSBogusExtentFileID		= 15;							{  Used for exchanging extents in extents file  }
	kHFSFirstUserCatalogNodeID	= 16;


{ HFS catalog key }

TYPE
	HFSCatalogKeyPtr = ^HFSCatalogKey;
	HFSCatalogKey = RECORD
		keyLength:				SInt8;									{  key length (in bytes)  }
		reserved:				SInt8;									{  reserved (set to zero)  }
		parentID:				HFSCatalogNodeID;						{  parent folder ID  }
		nodeName:				Str31;									{  catalog node name  }
	END;

{ HFS Plus catalog key }
	HFSPlusCatalogKeyPtr = ^HFSPlusCatalogKey;
	HFSPlusCatalogKey = RECORD
		keyLength:				UInt16;									{  key length (in bytes)  }
		parentID:				HFSCatalogNodeID;						{  parent folder ID  }
		nodeName:				HFSUniStr255;							{  catalog node name  }
	END;


{ Catalog record types }

CONST
																{  HFS Catalog Records  }
	kHFSFolderRecord			= $0100;						{  Folder record  }
	kHFSFileRecord				= $0200;						{  File record  }
	kHFSFolderThreadRecord		= $0300;						{  Folder thread record  }
	kHFSFileThreadRecord		= $0400;						{  File thread record  }
																{  HFS Plus Catalog Records  }
	kHFSPlusFolderRecord		= 1;							{  Folder record  }
	kHFSPlusFileRecord			= 2;							{  File record  }
	kHFSPlusFolderThreadRecord	= 3;							{  Folder thread record  }
	kHFSPlusFileThreadRecord	= 4;							{  File thread record  }


{ Catalog file record flags }
	kHFSFileLockedBit			= $0000;						{  file is locked and cannot be written to  }
	kHFSFileLockedMask			= $0001;
	kHFSThreadExistsBit			= $0001;						{  a file thread record exists for this file  }
	kHFSThreadExistsMask		= $0002;


{ HFS catalog folder record - 70 bytes }

TYPE
	HFSCatalogFolderPtr = ^HFSCatalogFolder;
	HFSCatalogFolder = RECORD
		recordType:				SInt16;									{  record type  }
		flags:					UInt16;									{  folder flags  }
		valence:				UInt16;									{  folder valence  }
		folderID:				HFSCatalogNodeID;						{  folder ID  }
		createDate:				UInt32;									{  date and time of creation  }
		modifyDate:				UInt32;									{  date and time of last modification  }
		backupDate:				UInt32;									{  date and time of last backup  }
		userInfo:				DInfo;									{  Finder information  }
		finderInfo:				DXInfo;									{  additional Finder information  }
		reserved:				ARRAY [0..3] OF UInt32;					{  reserved - set to zero  }
	END;

{ HFS Plus catalog folder record - 88 bytes }
	HFSPlusCatalogFolderPtr = ^HFSPlusCatalogFolder;
	HFSPlusCatalogFolder = RECORD
		recordType:				SInt16;									{  record type = HFS Plus folder record  }
		flags:					UInt16;									{  file flags  }
		valence:				UInt32;									{  folder's valence (limited to 2^16 in Mac OS)  }
		folderID:				HFSCatalogNodeID;						{  folder ID  }
		createDate:				UInt32;									{  date and time of creation  }
		contentModDate:			UInt32;									{  date and time of last content modification  }
		attributeModDate:		UInt32;									{  date and time of last attribute modification  }
		accessDate:				UInt32;									{  date and time of last access (Rhapsody only)  }
		backupDate:				UInt32;									{  date and time of last backup  }
		permissions:			HFSPlusPermissions;						{  permissions (for Rhapsody)  }
		userInfo:				DInfo;									{  Finder information  }
		finderInfo:				DXInfo;									{  additional Finder information  }
		textEncoding:			UInt32;									{  hint for name conversions  }
		reserved:				UInt32;									{  reserved - set to zero  }
	END;

{ HFS catalog file record - 102 bytes }
	HFSCatalogFilePtr = ^HFSCatalogFile;
	HFSCatalogFile = RECORD
		recordType:				SInt16;									{  record type  }
		flags:					SInt8;									{  file flags  }
		fileType:				SInt8;									{  file type (unused ?)  }
		userInfo:				FInfo;									{  Finder information  }
		fileID:					HFSCatalogNodeID;						{  file ID  }
		dataStartBlock:			UInt16;									{  not used - set to zero  }
		dataLogicalSize:		SInt32;									{  logical EOF of data fork  }
		dataPhysicalSize:		SInt32;									{  physical EOF of data fork  }
		rsrcStartBlock:			UInt16;									{  not used - set to zero  }
		rsrcLogicalSize:		SInt32;									{  logical EOF of resource fork  }
		rsrcPhysicalSize:		SInt32;									{  physical EOF of resource fork  }
		createDate:				UInt32;									{  date and time of creation  }
		modifyDate:				UInt32;									{  date and time of last modification  }
		backupDate:				UInt32;									{  date and time of last backup  }
		finderInfo:				FXInfo;									{  additional Finder information  }
		clumpSize:				UInt16;									{  file clump size (not used)  }
		dataExtents:			HFSExtentRecord;						{  first data fork extent record  }
		rsrcExtents:			HFSExtentRecord;						{  first resource fork extent record  }
		reserved:				UInt32;									{  reserved - set to zero  }
	END;

{ HFS Plus catalog file record - 248 bytes }
	HFSPlusCatalogFilePtr = ^HFSPlusCatalogFile;
	HFSPlusCatalogFile = RECORD
		recordType:				SInt16;									{  record type = HFS Plus file record  }
		flags:					UInt16;									{  file flags  }
		reserved1:				UInt32;									{  reserved - set to zero  }
		fileID:					HFSCatalogNodeID;						{  file ID  }
		createDate:				UInt32;									{  date and time of creation  }
		contentModDate:			UInt32;									{  date and time of last content modification  }
		attributeModDate:		UInt32;									{  date and time of last attribute modification  }
		accessDate:				UInt32;									{  date and time of last access (Rhapsody only)  }
		backupDate:				UInt32;									{  date and time of last backup  }
		permissions:			HFSPlusPermissions;						{  permissions (for Rhapsody)  }
		userInfo:				FInfo;									{  Finder information  }
		finderInfo:				FXInfo;									{  additional Finder information  }
		textEncoding:			UInt32;									{  hint for name conversions  }
		reserved2:				UInt32;									{  reserved - set to zero  }
																		{  start on double long (64 bit) boundry  }
		dataFork:				HFSPlusForkData;						{  size and block data for data fork  }
		resourceFork:			HFSPlusForkData;						{  size and block data for resource fork  }
	END;

{ HFS catalog thread record - 46 bytes }
	HFSCatalogThreadPtr = ^HFSCatalogThread;
	HFSCatalogThread = RECORD
		recordType:				SInt16;									{  record type  }
		reserved:				ARRAY [0..1] OF SInt32;					{  reserved - set to zero  }
		parentID:				HFSCatalogNodeID;						{  parent ID for this catalog node  }
		nodeName:				Str31;									{  name of this catalog node  }
	END;

{ HFS Plus catalog thread record -- 264 bytes }
	HFSPlusCatalogThreadPtr = ^HFSPlusCatalogThread;
	HFSPlusCatalogThread = RECORD
		recordType:				SInt16;									{  record type  }
		reserved:				SInt16;									{  reserved - set to zero  }
		parentID:				HFSCatalogNodeID;						{  parent ID for this catalog node  }
		nodeName:				HFSUniStr255;							{  name of this catalog node (variable length)  }
	END;


{
  	These are the types of records in the attribute B-tree.  The values were chosen
  	so that they wouldn't conflict with the catalog record types.
}

CONST
	kHFSPlusAttrInlineData		= $10;							{  if size <  kAttrOverflowSize  }
	kHFSPlusAttrForkData		= $20;							{  if size >= kAttrOverflowSize  }
	kHFSPlusAttrExtents			= $30;							{  overflow extents for large attributes  }


{
  	HFSPlusAttrInlineData
  	For small attributes, whose entire value is stored within this one
  	B-tree record.
  	There would not be any other records for this attribute.
}

TYPE
	HFSPlusAttrInlineDataPtr = ^HFSPlusAttrInlineData;
	HFSPlusAttrInlineData = RECORD
		recordType:				UInt32;									{ 	= kHFSPlusAttrInlineData }
		reserved:				UInt32;
		logicalSize:			UInt32;									{ 	size in bytes of userData }
		userData:				PACKED ARRAY [0..1] OF Byte;			{ 	variable length; space allocated is a multiple of 2 bytes }
	END;

{
  	HFSPlusAttrForkData
  	For larger attributes, whose value is stored in allocation blocks.
  	If the attribute has more than 8 extents, there will be additonal
  	records (of type HFSPlusAttrExtents) for this attribute.
}
	HFSPlusAttrForkDataPtr = ^HFSPlusAttrForkData;
	HFSPlusAttrForkData = RECORD
		recordType:				UInt32;									{ 	= kHFSPlusAttrForkData }
		reserved:				UInt32;
		theFork:				HFSPlusForkData;						{ 	size and first extents of value }
	END;

{
  	HFSPlusAttrExtents
  	This record contains information about overflow extents for large,
  	fragmented attributes.
}
	HFSPlusAttrExtentsPtr = ^HFSPlusAttrExtents;
	HFSPlusAttrExtents = RECORD
		recordType:				UInt32;									{ 	= kHFSPlusAttrExtents }
		reserved:				UInt32;
		extents:				HFSPlusExtentRecord;					{ 	additional extents }
	END;

{ 	A generic Attribute Record }
	HFSPlusAttrRecordPtr = ^HFSPlusAttrRecord;
	HFSPlusAttrRecord = RECORD
		CASE INTEGER OF
		0: (
			recordType:			UInt32;
			);
		1: (
			inlineData:			HFSPlusAttrInlineData;
			);
		2: (
			forkData:			HFSPlusAttrForkData;
			);
		3: (
			overflowExtents:	HFSPlusAttrExtents;
			);
	END;

{ Key and node lengths }

CONST
	kHFSPlusExtentKeyMaximumLength = 10;
	kHFSExtentKeyMaximumLength	= 7;
	kHFSPlusCatalogKeyMaximumLength = 516;
	kHFSPlusCatalogKeyMinimumLength = 6;
	kHFSCatalogKeyMaximumLength	= 37;
	kHFSCatalogKeyMinimumLength	= 6;
	kHFSPlusCatalogMinNodeSize	= 4096;
	kHFSPlusExtentMinNodeSize	= 512;
	kHFSPlusAttrMinNodeSize		= 4096;


{ HFS and HFS Plus volume attribute bits }
																{  Bits 0-6 are reserved (always cleared by MountVol call)  }
	kHFSVolumeHardwareLockBit	= 7;							{  volume is locked by hardware  }
	kHFSVolumeUnmountedBit		= 8;							{  volume was successfully unmounted  }
	kHFSVolumeSparedBlocksBit	= 9;							{  volume has bad blocks spared  }
	kHFSVolumeNoCacheRequiredBit = 10;							{  don't cache volume blocks (i.e. RAM or ROM disk)  }
	kHFSBootVolumeInconsistentBit = 11;							{  boot volume is inconsistent (System 7.6 and later)  }
																{  Bits 12-14 are reserved for future use  }
	kHFSVolumeSoftwareLockBit	= 15;							{  volume is locked by software  }
	kHFSVolumeHardwareLockMask	= $80;
	kHFSVolumeUnmountedMask		= $0100;
	kHFSVolumeSparedBlocksMask	= $0200;
	kHFSVolumeNoCacheRequiredMask = $0400;
	kHFSBootVolumeInconsistentMask = $0800;
	kHFSVolumeSoftwareLockMask	= $8000;
	kHFSMDBAttributesMask		= $8380;


{ Master Directory Block (HFS only) - 162 bytes }
{ Stored at sector #2 (3rd sector) }

TYPE
	HFSMasterDirectoryBlockPtr = ^HFSMasterDirectoryBlock;
	HFSMasterDirectoryBlock = RECORD
																		{  These first fields are also used by MFS  }
		drSigWord:				UInt16;									{  volume signature  }
		drCrDate:				UInt32;									{  date and time of volume creation  }
		drLsMod:				UInt32;									{  date and time of last modification  }
		drAtrb:					UInt16;									{  volume attributes  }
		drNmFls:				SInt16;									{  number of files in root folder  }
		drVBMSt:				UInt16;									{  first block of volume bitmap  }
		drAllocPtr:				UInt16;									{  start of next allocation search  }
		drNmAlBlks:				UInt16;									{  number of allocation blocks in volume  }
		drAlBlkSiz:				SInt32;									{  size (in bytes) of allocation blocks  }
		drClpSiz:				SInt32;									{  default clump size  }
		drAlBlSt:				SInt16;									{  first allocation block in volume  }
		drNxtCNID:				UInt32;									{  next unused catalog node ID  }
		drFreeBks:				SInt16;									{  number of unused allocation blocks  }
		drVN:					Str27;									{  volume name  }
																		{  Master Directory Block extensions for HFS  }
		drVolBkUp:				UInt32;									{  date and time of last backup  }
		drVSeqNum:				UInt16;									{  volume backup sequence number  }
		drWrCnt:				SInt32;									{  volume write count  }
		drXTClpSiz:				SInt32;									{  clump size for extents overflow file  }
		drCTClpSiz:				SInt32;									{  clump size for catalog file  }
		drNmRtDirs:				SInt16;									{  number of directories in root folder  }
		drFilCnt:				SInt32;									{  number of files in volume  }
		drDirCnt:				SInt32;									{  number of directories in volume  }
		drFndrInfo:				ARRAY [0..7] OF SInt32;					{  information used by the Finder  }
		drEmbedSigWord:			UInt16;									{  embedded volume signature (formerly drVCSize)  }
		drEmbedExtent:			HFSExtentDescriptor;					{  embedded volume location and size (formerly drVBMCSize and drCtlCSize)  }
		drXTFlSize:				SInt32;									{  size of extents overflow file  }
		drXTExtRec:				HFSExtentRecord;						{  extent record for extents overflow file  }
		drCTFlSize:				SInt32;									{  size of catalog file  }
		drCTExtRec:				HFSExtentRecord;						{  extent record for catalog file  }
	END;

{ HFSPlusVolumeHeader (HFS Plus only) - 512 bytes }
{ Stored at sector #0 (1st sector) and last sector }
	HFSPlusVolumeHeaderPtr = ^HFSPlusVolumeHeader;
	HFSPlusVolumeHeader = RECORD
		signature:				UInt16;									{  volume signature == 'H+'  }
		version:				UInt16;									{  current version is kHFSPlusVersion  }
		attributes:				UInt32;									{  volume attributes  }
		lastMountedVersion:		UInt32;									{  implementation version which last mounted volume  }
		reserved:				UInt32;									{  reserved - set to zero  }
		createDate:				UInt32;									{  date and time of volume creation  }
		modifyDate:				UInt32;									{  date and time of last modification  }
		backupDate:				UInt32;									{  date and time of last backup  }
		checkedDate:			UInt32;									{  date and time of last disk check  }
		fileCount:				UInt32;									{  number of files in volume  }
		folderCount:			UInt32;									{  number of directories in volume  }
		blockSize:				UInt32;									{  size (in bytes) of allocation blocks  }
		totalBlocks:			UInt32;									{  number of allocation blocks in volume (includes this header and VBM }
		freeBlocks:				UInt32;									{  number of unused allocation blocks  }
		nextAllocation:			UInt32;									{  start of next allocation search  }
		rsrcClumpSize:			UInt32;									{  default resource fork clump size  }
		dataClumpSize:			UInt32;									{  default data fork clump size  }
		nextCatalogID:			HFSCatalogNodeID;						{  next unused catalog node ID  }
		writeCount:				UInt32;									{  volume write count  }
		encodingsBitmap:		UInt64;									{  which encodings have been use  on this volume  }
		finderInfo:				PACKED ARRAY [0..31] OF UInt8;			{  information used by the Finder  }
		allocationFile:			HFSPlusForkData;						{  allocation bitmap file  }
		extentsFile:			HFSPlusForkData;						{  extents B-tree file  }
		catalogFile:			HFSPlusForkData;						{  catalog B-tree file  }
		attributesFile:			HFSPlusForkData;						{  extended attributes B-tree file  }
		startupFile:			HFSPlusForkData;						{  boot file  }
	END;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := HFSVolumesIncludes}

{$ENDC} {__HFSVOLUMES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
