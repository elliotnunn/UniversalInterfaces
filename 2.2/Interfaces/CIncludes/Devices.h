/*
 	File:		Devices.h
 
 	Contains:	Device Manager Interfaces.
 
 	Version:	Technology:	PowerSurge 1.0.2.
 				Package:	Universal Interfaces 2.1.2 on ETO #20
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __DEVICES__
#define __DEVICES__


#ifndef __OSUTILS__
#include <OSUtils.h>
#endif
/*	#include <Types.h>											*/
/*		#include <ConditionalMacros.h>							*/
/*	#include <MixedMode.h>										*/
/*	#include <Memory.h>											*/

#ifndef __FILES__
#include <Files.h>
#endif
/*	#include <Finder.h>											*/

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif
/*	#include <QuickdrawText.h>									*/

#ifndef __EVENTS__
#include <Events.h>
#endif

#ifndef __DIALOGS__
#include <Dialogs.h>
#endif
/*	#include <Errors.h>											*/
/*	#include <Menus.h>											*/
/*	#include <Controls.h>										*/
/*	#include <Windows.h>										*/
/*	#include <TextEdit.h>										*/

#ifndef __KERNEL__
#include <Kernel.h>
#endif

#ifndef __NAMEREGISTRY__
#include <NameRegistry.h>
#endif

#ifndef __CODEFRAGMENTS__
#include <CodeFragments.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif


enum {
	chooserInitMsg				= 11,							/* the user selected this device package */
	newSelMsg					= 12,							/* the user made new device selections */
	fillListMsg					= 13,							/* fill the device list with choices */
	getSelMsg					= 14,							/* mark one or more choices as selected */
	selectMsg					= 15,							/* the user made a selection */
	deselectMsg					= 16,							/* the user canceled a selection */
	terminateMsg				= 17,							/* allows device package to clean up */
	buttonMsg					= 19							/* the user selected a button */
};

/* Values of the 'caller' parameter to a Chooser device package */
enum {
	chooserID					= 1
};

/* Values of the 'message' parameter to a Control Panel 'cdev' */
enum {
	initDev						= 0,							/*Time for cdev to initialize itself*/
	hitDev						= 1,							/*Hit on one of my items*/
	closeDev					= 2,							/*Close yourself*/
	nulDev						= 3,							/*Null event*/
	updateDev					= 4,							/*Update event*/
	activDev					= 5,							/*Activate event*/
	deactivDev					= 6,							/*Deactivate event*/
	keyEvtDev					= 7,							/*Key down/auto key*/
	macDev						= 8,							/*Decide whether or not to show up*/
	undoDev						= 9,
	cutDev						= 10,
	copyDev						= 11,
	pasteDev					= 12,
	clearDev					= 13,
	cursorDev					= 14
};

/* Special values a Control Panel 'cdev' can return */
enum {
	cdevGenErr					= -1,							/*General error; gray cdev w/o alert*/
	cdevMemErr					= 0,							/*Memory shortfall; alert user please*/
	cdevResErr					= 1,							/*Couldn't get a needed resource; alert*/
	cdevUnset					= 3								/* cdevValue is initialized to this*/
};

/* Values of the 'message' parameter to a Monitor 'mntr' */
enum {
	initMsg						= 1,							/*initialization*/
	okMsg						= 2,							/*user clicked OK button*/
	cancelMsg					= 3,							/*user clicked Cancel button*/
	hitMsg						= 4,							/*user clicked control in Options dialog*/
	nulMsg						= 5,							/*periodic event*/
	updateMsg					= 6,							/*update event*/
	activateMsg					= 7,							/*not used*/
	deactivateMsg				= 8,							/*not used*/
	keyEvtMsg					= 9,							/*keyboard event*/
	superMsg					= 10,							/*show superuser controls*/
	normalMsg					= 11,							/*show only normal controls*/
	startupMsg					= 12							/*code has been loaded*/
};

/* control codes for DeskAccessories */
enum {
	goodbye						= -1,							/* heap being reinitialized */
	killCode					= 1,							/* KillIO requested */
	accEvent					= 64,							/* handle an event */
	accRun						= 65,							/* time for periodic action */
	accCursor					= 66,							/* change cursor shape */
	accMenu						= 67,							/* handle menu item */
	accUndo						= 68,							/* handle undo command */
	accCut						= 70,							/* handle cut command */
	accCopy						= 71,							/* handle copy command */
	accPaste					= 72,							/* handle paste command */
	accClear					= 73							/* handle clear command */
};

/* Control/Status Call Codes */
enum {
	drvStsCode					= 8,							/* status call code for drive status */
	ejectCode					= 7,							/* control call eject code */
	tgBuffCode					= 8								/* set tag buffer code */
};

/* miscellaneous Device Manager constants */
enum {
	ioInProgress				= 1,							/* predefined value of ioResult while I/O is pending */
	aRdCmd						= 2,							/* low byte of ioTrap for Read calls */
	aWrCmd						= 3,							/* low byte of ioTrap for Write calls */
	asyncTrpBit					= 10,							/* trap word modifier */
	noQueueBit					= 9								/* trap word modifier */
};

/* flags used in the driver header and device control entry */
enum {
	dReadEnable					= 0,							/* set if driver responds to read requests */
	dWritEnable					= 1,							/* set if driver responds to write requests */
	dCtlEnable					= 2,							/* set if driver responds to control requests */
	dStatEnable					= 3,							/* set if driver responds to status requests */
	dNeedGoodBye				= 4,							/* set if driver needs time for performing periodic tasks */
	dNeedTime					= 5,							/* set if driver needs time for performing periodic tasks */
	dNeedLock					= 6,							/* set if driver must be locked in memory as soon as it is opened */
	dNeedLockMask				= 0x4000,						/* set if driver must be locked in memory as soon as it is opened */
	dNeedTimeMask				= 0x2000,						/* set if driver needs time for performing periodic tasks */
	dNeedGoodByeMask			= 0x1000,						/* set if driver needs to be called before the application heap is initialized */
	dStatEnableMask				= 0x0800,						/* set if driver responds to status requests */
	dCtlEnableMask				= 0x0400,						/* set if driver responds to control requests */
	dWritEnableMask				= 0x0200,						/* set if driver responds to write requests */
	dReadEnableMask				= 0x0100						/* set if driver responds to read requests */
};

/* run-time flags used in the device control entry */
enum {
	dOpened						= 5,							/* driver is open */
	dRAMBased					= 6,							/* dCtlDriver is a handle (1) or pointer (0) */
	drvrActive					= 7,							/* driver is currently processing a request */
	drvrActiveMask				= 0x0080,						/* driver is currently processing a request */
	dRAMBasedMask				= 0x0040,						/* dCtlDriver is a handle (1) or pointer (0) */
	dOpenedMask					= 0x0020						/* driver is open */
};

struct DRVRHeader {
	short							drvrFlags;
	short							drvrDelay;
	short							drvrEMask;
	short							drvrMenu;
	short							drvrOpen;
	short							drvrPrime;
	short							drvrCtl;
	short							drvrStatus;
	short							drvrClose;
	unsigned char					drvrName[1];
};
typedef struct DRVRHeader DRVRHeader;

typedef DRVRHeader *DRVRHeaderPtr, **DRVRHeaderHandle;

struct DCtlEntry {
	Ptr								dCtlDriver;
	short							dCtlFlags;
	QHdr							dCtlQHdr;
	long							dCtlPosition;
	Handle							dCtlStorage;
	short							dCtlRefNum;
	long							dCtlCurTicks;
	WindowPtr						dCtlWindow;
	short							dCtlDelay;
	short							dCtlEMask;
	short							dCtlMenu;
};
typedef struct DCtlEntry DCtlEntry;

typedef DCtlEntry *DCtlPtr, **DCtlHandle;

struct AuxDCE {
	Ptr								dCtlDriver;
	short							dCtlFlags;
	QHdr							dCtlQHdr;
	long							dCtlPosition;
	Handle							dCtlStorage;
	short							dCtlRefNum;
	long							dCtlCurTicks;
	GrafPtr							dCtlWindow;
	short							dCtlDelay;
	short							dCtlEMask;
	short							dCtlMenu;
	SInt8							dCtlSlot;
	SInt8							dCtlSlotId;
	long							dCtlDevBase;
	Ptr								dCtlOwner;
	SInt8							dCtlExtDev;
	SInt8							fillByte;
	UInt32							dCtlNodeID;
};
typedef struct AuxDCE AuxDCE;

typedef AuxDCE *AuxDCEPtr, **AuxDCEHandle;

typedef UInt16 UnitNumber;

typedef UInt32 DriverOpenCount;

typedef SInt16 DriverRefNum;

typedef SInt16 DriverFlags;

typedef UInt32 IOCommandCode;


enum {
	kOpenCommand				= 0,
	kCloseCommand				= 1,
	kReadCommand				= 2,
	kWriteCommand				= 3,
	kControlCommand				= 4,
	kStatusCommand				= 5,
	kKillIOCommand				= 6,
	kInitializeCommand			= 7,							/* init driver and device*/
	kFinalizeCommand			= 8,							/* shutdown driver and device*/
	kReplaceCommand				= 9,							/* replace an old driver*/
	kSupersededCommand			= 10							/* prepare to be replaced by a new driver*/
};

typedef KernelID IOCommandID;

typedef UInt32 IOCommandKind;


enum {
	kSynchronousIOCommandKind	= 0x00000001,
	kAsynchronousIOCommandKind	= 0x00000002,
	kImmediateIOCommandKind		= 0x00000004
};

struct DriverInitInfo {
	DriverRefNum					refNum;
	RegEntryID						deviceEntry;
};
struct DriverFinalInfo {
	DriverRefNum					refNum;
	RegEntryID						deviceEntry;
};
typedef struct DriverInitInfo DriverInitInfo, *DriverInitInfoPtr;

typedef struct DriverInitInfo DriverReplaceInfo, *DriverReplaceInfoPtr;

typedef struct DriverFinalInfo DriverFinalInfo, *DriverFinalInfoPtr;

typedef struct DriverFinalInfo DriverSupersededInfo, *DriverSupersededInfoPtr;

/* Contents are command specific*/
union IOCommandContents {
	ParmBlkPtr						pb;
	DriverInitInfoPtr				initialInfo;
	DriverFinalInfoPtr				finalInfo;
	DriverReplaceInfoPtr			replaceInfo;
	DriverSupersededInfoPtr			supersededInfo;
};
typedef union IOCommandContents IOCommandContents;

typedef OSErr (DriverEntryPoint)(AddressSpaceID SpaceID, IOCommandID CommandID, IOCommandContents Contents, IOCommandCode Code, IOCommandKind Kind);
typedef DriverEntryPoint *DriverEntryPointPtr;

/* Driver Typing Information Used to Match Drivers With Devices */
struct DriverType {
	Str31							nameInfoStr;				/* Driver Name/Info String*/
	NumVersion						version;					/* Driver Version Number*/
};
typedef struct DriverType DriverType, *DriverTypePtr;

/* OS Runtime Information Used to Setup and Maintain a Driver's Runtime Environment */
typedef OptionBits RuntimeOptions;


enum {
	kDriverIsLoadedUponDiscovery = 0x00000001,					/* auto-load driver when discovered*/
	kDriverIsOpenedUponLoad		= 0x00000002,					/* auto-open driver when loaded*/
	kDriverIsUnderExpertControl	= 0x00000004,					/* I/O expert handles loads/opens*/
	kDriverIsConcurrent			= 0x00000008,					/* supports concurrent requests*/
	kDriverQueuesIOPB			= 0x00000010					/* device manager doesn't queue IOPB*/
};

struct DriverOSRuntime {
	RuntimeOptions					driverRuntime;				/* Options for OS Runtime*/
	Str31							driverName;					/* Driver's name to the OS*/
	UInt32							driverDescReserved[8];		/* Reserved area*/
};
typedef struct DriverOSRuntime DriverOSRuntime, *DriverOSRuntimePtr;

/* OS Service Information Used To Declare What APIs a Driver Supports */
typedef UInt32 ServiceCount;

struct DriverServiceInfo {
	OSType							serviceCategory;			/* Service Category Name*/
	OSType							serviceType;				/* Type within Category*/
	NumVersion						serviceVersion;				/* Version of service*/
};
typedef struct DriverServiceInfo DriverServiceInfo, *DriverServiceInfoPtr;

struct DriverOSService {
	ServiceCount					nServices;					/* Number of Services Supported*/
	DriverServiceInfo				service[1];					/* The List of Services (at least one)*/
};
typedef struct DriverOSService DriverOSService, *DriverOSServicePtr;

/* Categories */

enum {
	kServiceCategoryDisplay		= 'disp',						/* Display Manager*/
	kServiceCategoryOpenTransport = 'otan',						/* Open Transport*/
	kServiceCategoryBlockStorage = 'blok',						/* Block Storage*/
	kServiceCategoryNdrvDriver	= 'ndrv',						/* Generic Native Driver*/
	kServiceCategoryScsiSIM		= 'scsi'
};

/* Ndrv ServiceCategory Types */
enum {
	kNdrvTypeIsGeneric			= 'genr',						/* generic*/
	kNdrvTypeIsVideo			= 'vido',						/* video*/
	kNdrvTypeIsBlockStorage		= 'blok',						/* block storage*/
	kNdrvTypeIsNetworking		= 'netw',						/* networking*/
	kNdrvTypeIsSerial			= 'serl',						/* serial*/
	kNdrvTypeIsSound			= 'sond',						/* sound*/
	kNdrvTypeIsBusBridge		= 'brdg'
};

/*	The Driver Description */
enum {
	kTheDescriptionSignature	= 'mtej'
};

typedef UInt32 DriverDescVersion;


enum {
	kInitialDriverDescriptor	= 0
};

struct DriverDescription {
	OSType							driverDescSignature;		/* Signature field of this structure*/
	DriverDescVersion				driverDescVersion;			/* Version of this data structure*/
	DriverType						driverType;					/* Type of Driver*/
	DriverOSRuntime					driverOSRuntimeInfo;		/* OS Runtime Requirements of Driver*/
	DriverOSService					driverServices;				/* Apple Service API Membership*/
};
typedef struct DriverDescription DriverDescription, *DriverDescriptionPtr;

/* Record to describe a file-based driver candidate */
struct FileBasedDriverRecord {
	FSSpec							theSpec;					/* file specification*/
	DriverType						theType;					/* nameInfoStr + version number*/
	Boolean							compatibleProp;				/* true if matched using a compatible name*/
	UInt8							pad[3];						/* alignment*/
};
typedef struct FileBasedDriverRecord FileBasedDriverRecord, *FileBasedDriverRecordPtr;

/* Driver Loader API */
#define DECLARE_DRIVERDESCRIPTION(N_ADDITIONAL_SERVICES)  \
	struct {					\
	DriverDescription	fixed;	\
	DriverServiceInfo	additional_service[N_ADDITIONAL_SERVICES-1]; \
	};
extern SInt16 HigherDriverVersion(NumVersion *driverVersion1, NumVersion *driverVersion2);
extern OSErr VerifyFragmentAsDriver(CFragConnectionID fragmentConnID, DriverEntryPointPtr *fragmentMain, DriverDescriptionPtr *driverDesc);
extern OSErr GetDriverMemoryFragment(Ptr memAddr, long length, ConstStr63Param fragName, CFragConnectionID *fragmentConnID, DriverEntryPointPtr *fragmentMain, DriverDescriptionPtr *driverDesc);
extern OSErr GetDriverDiskFragment(FSSpecPtr fragmentSpec, CFragConnectionID *fragmentConnID, DriverEntryPointPtr *fragmentMain, DriverDescriptionPtr *driverDesc);
extern OSErr InstallDriverFromFragment(CFragConnectionID fragmentConnID, RegEntryIDPtr device, UnitNumber beginningUnit, UnitNumber endingUnit, DriverRefNum *refNum);
extern OSErr InstallDriverFromFile(FSSpecPtr fragmentSpec, RegEntryIDPtr device, UnitNumber beginningUnit, UnitNumber endingUnit, DriverRefNum *refNum);
extern OSErr InstallDriverFromMemory(Ptr memory, long length, ConstStr63Param fragName, RegEntryIDPtr device, UnitNumber beginningUnit, UnitNumber endingUnit, DriverRefNum *refNum);
extern OSErr InstallDriverFromDisk(Ptr theDriverName, RegEntryIDPtr theDevice, UnitNumber theBeginningUnit, UnitNumber theEndingUnit, DriverRefNum *theRefNum);
extern OSErr FindDriversForDevice(RegEntryIDPtr device, FSSpec *fragmentSpec, DriverDescription *fileDriverDesc, Ptr *memAddr, long *length, StringPtr fragName, DriverDescription *memDriverDesc);
extern OSErr FindDriverCandidates(RegEntryIDPtr deviceID, Ptr *propBasedDriver, RegPropertyValueSize *propBasedDriverSize, StringPtr deviceName, DriverType *propBasedDriverType, Boolean *gotPropBasedDriver, FileBasedDriverRecordPtr fileBasedDrivers, ItemCount *nFileBasedDrivers);
extern OSErr ScanDriverCandidates(RegEntryIDPtr deviceID, FileBasedDriverRecordPtr fileBasedDrivers, ItemCount nFileBasedDrivers, FileBasedDriverRecordPtr matchingDrivers, ItemCount *nMatchingDrivers);
extern OSErr GetDriverForDevice(RegEntryIDPtr device, CFragConnectionID *fragmentConnID, DriverEntryPointPtr *fragmentMain, DriverDescriptionPtr *driverDesc);
extern OSErr InstallDriverForDevice(RegEntryIDPtr device, UnitNumber beginningUnit, UnitNumber endingUnit, DriverRefNum *refNum);
extern OSErr SetDriverClosureMemory(CFragConnectionID fragmentConnID, Boolean holdDriverMemory);
extern OSErr ReplaceDriverWithFragment(DriverRefNum theRefNum, CFragConnectionID fragmentConnID);
extern OSErr GetDriverInformation(DriverRefNum refNum, UnitNumber *unitNum, DriverFlags *flags, DriverOpenCount *count, StringPtr name, RegEntryID *device, CFragHFSLocator *driverLoadLocation, CFragConnectionID *fragmentConnID, DriverEntryPointPtr *fragmentMain, DriverDescription *driverDesc);
extern OSErr OpenInstalledDriver(DriverRefNum refNum, SInt8 ioPermission);
extern OSErr RenameDriver(DriverRefNum refNum, StringPtr newDriverName);
extern OSErr RemoveDriver(DriverRefNum refNum, Boolean immediate);
extern OSErr LookupDrivers(UnitNumber beginningUnit, UnitNumber endingUnit, Boolean emptyUnits, ItemCount *returnedRefNums, DriverRefNum *refNums);
extern UnitNumber HighestUnitNumber(void);
extern OSErr DriverGestaltOn(DriverRefNum refNum);
extern OSErr DriverGestaltOff(DriverRefNum refNum);
extern Boolean DriverGestaltIsOn(DriverFlags flags);

#if !OLDROUTINELOCATIONS

#if !GENERATINGCFM
#pragma parameter __D0 PBOpenSync(__A0)
#endif
extern pascal OSErr PBOpenSync(ParmBlkPtr paramBlock)
 ONEWORDINLINE(0xA000);

#if !GENERATINGCFM
#pragma parameter __D0 PBOpenAsync(__A0)
#endif
extern pascal OSErr PBOpenAsync(ParmBlkPtr paramBlock)
 ONEWORDINLINE(0xA400);

#if !GENERATINGCFM
#pragma parameter __D0 PBOpenImmed(__A0)
#endif
extern pascal OSErr PBOpenImmed(ParmBlkPtr paramBlock)
 ONEWORDINLINE(0xA200);

#if !GENERATINGCFM
#pragma parameter __D0 PBCloseSync(__A0)
#endif
extern pascal OSErr PBCloseSync(ParmBlkPtr paramBlock)
 ONEWORDINLINE(0xA001);

#if !GENERATINGCFM
#pragma parameter __D0 PBCloseAsync(__A0)
#endif
extern pascal OSErr PBCloseAsync(ParmBlkPtr paramBlock)
 ONEWORDINLINE(0xA401);

#if !GENERATINGCFM
#pragma parameter __D0 PBCloseImmed(__A0)
#endif
extern pascal OSErr PBCloseImmed(ParmBlkPtr paramBlock)
 ONEWORDINLINE(0xA201);

#if !GENERATINGCFM
#pragma parameter __D0 PBReadSync(__A0)
#endif
extern pascal OSErr PBReadSync(ParmBlkPtr paramBlock)
 ONEWORDINLINE(0xA002);

#if !GENERATINGCFM
#pragma parameter __D0 PBReadAsync(__A0)
#endif
extern pascal OSErr PBReadAsync(ParmBlkPtr paramBlock)
 ONEWORDINLINE(0xA402);

#if !GENERATINGCFM
#pragma parameter __D0 PBReadImmed(__A0)
#endif
extern pascal OSErr PBReadImmed(ParmBlkPtr paramBlock)
 ONEWORDINLINE(0xA202);

#if !GENERATINGCFM
#pragma parameter __D0 PBWriteSync(__A0)
#endif
extern pascal OSErr PBWriteSync(ParmBlkPtr paramBlock)
 ONEWORDINLINE(0xA003);

#if !GENERATINGCFM
#pragma parameter __D0 PBWriteAsync(__A0)
#endif
extern pascal OSErr PBWriteAsync(ParmBlkPtr paramBlock)
 ONEWORDINLINE(0xA403);

#if !GENERATINGCFM
#pragma parameter __D0 PBWriteImmed(__A0)
#endif
extern pascal OSErr PBWriteImmed(ParmBlkPtr paramBlock)
 ONEWORDINLINE(0xA203);
extern pascal void AddDrive(short drvrRefNum, short drvNum, DrvQElPtr qEl);
extern pascal QHdrPtr GetDrvQHdr(void)
 THREEWORDINLINE(0x2EBC, 0x0000, 0x0308);
#endif
/* Control Panel Default Proc */
typedef pascal long (*ControlPanelDefProcPtr)(short message, short item, short numItems, short cPanelID, EventRecord *theEvent, long cdevValue, DialogPtr cpDialog);

#if GENERATINGCFM
typedef UniversalProcPtr ControlPanelDefUPP;
#else
typedef ControlPanelDefProcPtr ControlPanelDefUPP;
#endif

enum {
	uppControlPanelDefProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(5, SIZE_CODE(sizeof(EventRecord*)))
		 | STACK_ROUTINE_PARAMETER(6, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(7, SIZE_CODE(sizeof(DialogPtr)))
};

#if GENERATINGCFM
#define NewControlPanelDefProc(userRoutine)		\
		(ControlPanelDefUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppControlPanelDefProcInfo, GetCurrentArchitecture())
#else
#define NewControlPanelDefProc(userRoutine)		\
		((ControlPanelDefUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallControlPanelDefProc(userRoutine, message, item, numItems, cPanelID, theEvent, cdevValue, cpDialog)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppControlPanelDefProcInfo, (message), (item), (numItems), (cPanelID), (theEvent), (cdevValue), (cpDialog))
#else
#define CallControlPanelDefProc(userRoutine, message, item, numItems, cPanelID, theEvent, cdevValue, cpDialog)		\
		(*(userRoutine))((message), (item), (numItems), (cPanelID), (theEvent), (cdevValue), (cpDialog))
#endif

extern pascal DCtlHandle GetDCtlEntry(short refNum);
/*
	SetChooserAlert used to simply set a bit in a low-mem global
	to tell the Chooser not to display its warning message when
	the printer is changed. However, under MultiFinder and System 7,
	this low-mem is swapped out when a layer change occurs, and the
	Chooser never sees the change. It is obsolete, and completely
	unsupported on the PowerPC. 68K apps can still call it if they
	wish.
*/
#if OLDROUTINENAMES && !GENERATINGCFM
extern pascal Boolean SetChooserAlert(Boolean f);
#endif

#if !GENERATINGCFM
#pragma parameter __D0 DriverInstall(__A0, __D0)
#endif
extern pascal OSErr DriverInstall(DRVRHeaderPtr drvrPtr, short refNum)
 ONEWORDINLINE(0xA03D);

#if !GENERATINGCFM
#pragma parameter __D0 DriverInstallReserveMem(__A0, __D0)
#endif
extern pascal OSErr DriverInstallReserveMem(DRVRHeaderPtr drvrPtr, short refNum)
 ONEWORDINLINE(0xA43D);

#if !GENERATINGCFM
#pragma parameter __D0 DrvrRemove(__D0)
#endif
extern pascal OSErr DrvrRemove(short refNum)
 ONEWORDINLINE(0xA03E);
#define DriverRemove(refNum) DrvrRemove(refNum)
extern pascal OSErr OpenDriver(ConstStr255Param name, short *drvrRefNum);
extern pascal OSErr CloseDriver(short refNum);
extern pascal OSErr Control(short refNum, short csCode, const void *csParamPtr);
extern pascal OSErr Status(short refNum, short csCode, void *csParamPtr);
extern pascal OSErr KillIO(short refNum);

#if !GENERATINGCFM
#pragma parameter __D0 PBControlSync(__A0)
#endif
extern pascal OSErr PBControlSync(ParmBlkPtr paramBlock)
 ONEWORDINLINE(0xA004);

#if !GENERATINGCFM
#pragma parameter __D0 PBControlAsync(__A0)
#endif
extern pascal OSErr PBControlAsync(ParmBlkPtr paramBlock)
 ONEWORDINLINE(0xA404);

#if !GENERATINGCFM
#pragma parameter __D0 PBControlImmed(__A0)
#endif
extern pascal OSErr PBControlImmed(ParmBlkPtr paramBlock)
 ONEWORDINLINE(0xA204);

#if !GENERATINGCFM
#pragma parameter __D0 PBStatusSync(__A0)
#endif
extern pascal OSErr PBStatusSync(ParmBlkPtr paramBlock)
 ONEWORDINLINE(0xA005);

#if !GENERATINGCFM
#pragma parameter __D0 PBStatusAsync(__A0)
#endif
extern pascal OSErr PBStatusAsync(ParmBlkPtr paramBlock)
 ONEWORDINLINE(0xA405);

#if !GENERATINGCFM
#pragma parameter __D0 PBStatusImmed(__A0)
#endif
extern pascal OSErr PBStatusImmed(ParmBlkPtr paramBlock)
 ONEWORDINLINE(0xA205);

#if !GENERATINGCFM
#pragma parameter __D0 PBKillIOSync(__A0)
#endif
extern pascal OSErr PBKillIOSync(ParmBlkPtr paramBlock)
 ONEWORDINLINE(0xA006);

#if !GENERATINGCFM
#pragma parameter __D0 PBKillIOAsync(__A0)
#endif
extern pascal OSErr PBKillIOAsync(ParmBlkPtr paramBlock)
 ONEWORDINLINE(0xA406);

#if !GENERATINGCFM
#pragma parameter __D0 PBKillIOImmed(__A0)
#endif
extern pascal OSErr PBKillIOImmed(ParmBlkPtr paramBlock)
 ONEWORDINLINE(0xA206);
extern pascal short OpenDeskAcc(ConstStr255Param deskAccName)
 ONEWORDINLINE(0xA9B6);
extern pascal void CloseDeskAcc(short refNum)
 ONEWORDINLINE(0xA9B7);
#if CGLUESUPPORTED
extern short opendeskacc(const char *deskAccName);
extern OSErr opendriver(const char *driverName, short *refNum);
#endif
#if OLDROUTINENAMES
/*
	The PBxxx() routines are obsolete.  
	
	Use the PBxxxSync(), PBxxxAsync(), or PBxxxImmed version instead.
*/
#define PBControl(pb, async) ((async) ? PBControlAsync(pb) : PBControlSync(pb))
#define PBStatus(pb, async) ((async) ? PBStatusAsync(pb) : PBStatusSync(pb))
#define PBKillIO(pb, async) ((async) ? PBKillIOAsync(pb) : PBKillIOSync(pb))
#if !OLDROUTINELOCATIONS
#define PBOpen(pb, async) ((async) ? PBOpenAsync(pb) : PBOpenSync(pb))
#define PBClose(pb, async) ((async) ? PBCloseAsync(pb) : PBCloseSync(pb))
#define PBRead(pb, async) ((async) ? PBReadAsync(pb) : PBReadSync(pb))
#define PBWrite(pb, async) ((async) ? PBWriteAsync(pb) : PBWriteSync(pb))
#endif
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __DEVICES__ */
