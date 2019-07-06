/*
 	File:		Components.h
 
 	Contains:	Component Manager Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1991-1997 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
*/
#ifndef __COMPONENTS__
#define __COMPONENTS__

#ifndef __ERRORS__
#include <Errors.h>
#endif
#ifndef __TYPES__
#include <Types.h>
#endif
#ifndef __MIXEDMODE__
#include <MixedMode.h>
#endif



#if PRAGMA_ONCE
#pragma once
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_IMPORT
#pragma import on
#endif

#if PRAGMA_STRUCT_ALIGN
	#pragma options align=mac68k
#elif PRAGMA_STRUCT_PACKPUSH
	#pragma pack(push, 2)
#elif PRAGMA_STRUCT_PACK
	#pragma pack(2)
#endif


enum {
	kAppleManufacturer			= FOUR_CHAR_CODE('appl'),		/* Apple supplied components */
	kComponentResourceType		= FOUR_CHAR_CODE('thng')		/* a components resource type */
};


enum {
	kAnyComponentType			= 0,
	kAnyComponentSubType		= 0,
	kAnyComponentManufacturer	= 0,
	kAnyComponentFlagsMask		= 0
};


enum {
	cmpWantsRegisterMessage		= 1L << 31
};


enum {
	kComponentOpenSelect		= -1,							/* ComponentInstance for this open */
	kComponentCloseSelect		= -2,							/* ComponentInstance for this close */
	kComponentCanDoSelect		= -3,							/* selector # being queried */
	kComponentVersionSelect		= -4,							/* no params */
	kComponentRegisterSelect	= -5,							/* no params */
	kComponentTargetSelect		= -6,							/* ComponentInstance for top of call chain */
	kComponentUnregisterSelect	= -7,							/* no params */
	kComponentGetMPWorkFunctionSelect = -8						/* some params */
};

/* Component Resource Extension flags */

enum {
	componentDoAutoVersion		= (1 << 0),
	componentWantsUnregister	= (1 << 1),
	componentAutoVersionIncludeFlags = (1 << 2),
	componentHasMultiplePlatforms = (1 << 3)
};



/* Set Default Component flags */

enum {
	defaultComponentIdentical	= 0,
	defaultComponentAnyFlags	= 1,
	defaultComponentAnyManufacturer = 2,
	defaultComponentAnySubType	= 4,
	defaultComponentAnyFlagsAnyManufacturer = (defaultComponentAnyFlags + defaultComponentAnyManufacturer),
	defaultComponentAnyFlagsAnyManufacturerAnySubType = (defaultComponentAnyFlags + defaultComponentAnyManufacturer + defaultComponentAnySubType)
};

/* RegisterComponentResource flags */

enum {
	registerComponentGlobal		= 1,
	registerComponentNoDuplicates = 2,
	registerComponentAfterExisting = 4
};


struct ComponentDescription {
	OSType 							componentType;				/* A unique 4-byte code indentifying the command set */
	OSType 							componentSubType;			/* Particular flavor of this instance */
	OSType 							componentManufacturer;		/* Vendor indentification */
	unsigned long 					componentFlags;				/* 8 each for Component,Type,SubType,Manuf/revision */
	unsigned long 					componentFlagsMask;			/* Mask for specifying which flags to consider in search, zero during registration */
};
typedef struct ComponentDescription ComponentDescription;


struct ResourceSpec {
	OSType 							resType;					/* 4-byte code  */
	short 							resID;						/*  			*/
};
typedef struct ResourceSpec ResourceSpec;

struct ComponentResource {
	ComponentDescription 			cd;							/* Registration parameters */
	ResourceSpec 					component;					/* resource where Component code is found */
	ResourceSpec 					componentName;				/* name string resource */
	ResourceSpec 					componentInfo;				/* info string resource */
	ResourceSpec 					componentIcon;				/* icon resource */
};
typedef struct ComponentResource ComponentResource;

typedef ComponentResource *				ComponentResourcePtr;
typedef ComponentResourcePtr *			ComponentResourceHandle;
struct ComponentPlatformInfo {
	long 							componentFlags;				/* flags of Component */
	ResourceSpec 					component;					/* resource where Component code is found */
	short 							platformType;				/* gestaltSysArchitecture result */
};
typedef struct ComponentPlatformInfo ComponentPlatformInfo;

struct ComponentResourceExtension {
	long 							componentVersion;			/* version of Component */
	long 							componentRegisterFlags;		/* flags for registration */
	short 							componentIconFamily;		/* resource id of Icon Family */
};
typedef struct ComponentResourceExtension ComponentResourceExtension;

struct ComponentPlatformInfoArray {
	long 							count;
	ComponentPlatformInfo 			platformArray[1];
};
typedef struct ComponentPlatformInfoArray ComponentPlatformInfoArray;

struct ExtComponentResource {
	ComponentDescription 			cd;							/* registration parameters */
	ResourceSpec 					component;					/* resource where Component code is found */
	ResourceSpec 					componentName;				/* name string resource */
	ResourceSpec 					componentInfo;				/* info string resource */
	ResourceSpec 					componentIcon;				/* icon resource */
	long 							componentVersion;			/* version of Component */
	long 							componentRegisterFlags;		/* flags for registration */
	short 							componentIconFamily;		/* resource id of Icon Family */
	long 							count;						/* elements in platformArray */
	ComponentPlatformInfo 			platformArray[1];
};
typedef struct ExtComponentResource ExtComponentResource;

/*  Structure received by Component:		*/
struct ComponentParameters {
	UInt8 							flags;						/* call modifiers: sync/async, deferred, immed, etc */
	UInt8 							paramSize;					/* size in bytes of actual parameters passed to this call */
	short 							what;						/* routine selector, negative for Component management calls */
	long 							params[1];					/* actual parameters for the indicated routine */
};
typedef struct ComponentParameters ComponentParameters;

struct ComponentRecord {
	long 							data[1];
};
typedef struct ComponentRecord ComponentRecord;

typedef ComponentRecord *				Component;
struct ComponentInstanceRecord {
	long 							data[1];
};
typedef struct ComponentInstanceRecord ComponentInstanceRecord;

typedef ComponentInstanceRecord *		ComponentInstance;
struct RegisteredComponentRecord {
	long 							data[1];
};
typedef struct RegisteredComponentRecord RegisteredComponentRecord;

struct RegisteredComponentInstanceRecord {
	long 							data[1];
};
typedef struct RegisteredComponentInstanceRecord RegisteredComponentInstanceRecord;

typedef RegisteredComponentInstanceRecord * RegisteredComponentInstanceRecordPtr;
typedef long 							ComponentResult;

enum {
	mpWorkFlagDoWork			= (1 << 0),
	mpWorkFlagDoCompletion		= (1 << 1),
	mpWorkFlagCopyWorkBlock		= (1 << 2),
	mpWorkFlagDontBlock			= (1 << 3),
	mpWorkFlagGetProcessorCount	= (1 << 4),
	mpWorkFlagGetIsRunning		= (1 << 6)
};

struct ComponentMPWorkFunctionHeaderRecord {
	UInt32 							headerSize;
	UInt32 							recordSize;
	UInt32 							workFlags;
	UInt16 							processorCount;
	UInt8 							unused;
	UInt8 							isRunning;
};
typedef struct ComponentMPWorkFunctionHeaderRecord ComponentMPWorkFunctionHeaderRecord;

typedef ComponentMPWorkFunctionHeaderRecord * ComponentMPWorkFunctionHeaderRecordPtr;
typedef CALLBACK_API( ComponentResult , ComponentMPWorkFunctionProcPtr )(void *globalRefCon, ComponentMPWorkFunctionHeaderRecordPtr header);
typedef CALLBACK_API( ComponentResult , ComponentRoutineProcPtr )(ComponentParameters *cp, Handle componentStorage);
typedef STACK_UPP_TYPE(ComponentMPWorkFunctionProcPtr) 			ComponentMPWorkFunctionUPP;
typedef STACK_UPP_TYPE(ComponentRoutineProcPtr) 				ComponentRoutineUPP;
/*
	The parameter list for each ComponentFunction is unique. It is
	therefore up to users to create the appropriate procInfo for their
	own ComponentFunctions where necessary.
*/
typedef UniversalProcPtr 				ComponentFunctionUPP;
#if TARGET_RT_MAC_CFM
/* 
	CallComponentUPP is a global variable exported from InterfaceLib.
	It is the ProcPtr passed to CallUniversalProc to manually call a component function.
*/
extern UniversalProcPtr CallComponentUPP;
#endif

#define ComponentCallNow( callNumber, paramSize ) \
	FIVEWORDINLINE( 0x2F3C,paramSize,callNumber,0x7000,0xA82A )

/********************************************************
*														*
*  				APPLICATION LEVEL CALLS					*
*														*
********************************************************/
/********************************************************
* Component Database Add, Delete, and Query Routines
********************************************************/
EXTERN_API( Component )
RegisterComponent				(ComponentDescription *	cd,
								 ComponentRoutineUPP 	componentEntryPoint,
								 short 					global,
								 Handle 				componentName,
								 Handle 				componentInfo,
								 Handle 				componentIcon)						TWOWORDINLINE(0x7001, 0xA82A);

EXTERN_API( Component )
RegisterComponentResource		(ComponentResourceHandle  cr,
								 short 					global)								TWOWORDINLINE(0x7012, 0xA82A);

EXTERN_API( OSErr )
UnregisterComponent				(Component 				aComponent)							TWOWORDINLINE(0x7002, 0xA82A);

EXTERN_API( Component )
FindNextComponent				(Component 				aComponent,
								 ComponentDescription *	looking)							TWOWORDINLINE(0x7004, 0xA82A);

EXTERN_API( long )
CountComponents					(ComponentDescription *	looking)							TWOWORDINLINE(0x7003, 0xA82A);

EXTERN_API( OSErr )
GetComponentInfo				(Component 				aComponent,
								 ComponentDescription *	cd,
								 Handle 				componentName,
								 Handle 				componentInfo,
								 Handle 				componentIcon)						TWOWORDINLINE(0x7005, 0xA82A);

EXTERN_API( long )
GetComponentListModSeed			(void)														TWOWORDINLINE(0x7006, 0xA82A);

EXTERN_API( long )
GetComponentTypeModSeed			(OSType 				componentType)						TWOWORDINLINE(0x702C, 0xA82A);

/********************************************************
* Component Instance Allocation and dispatch routines
********************************************************/
EXTERN_API( OSErr )
OpenAComponent					(Component 				aComponent,
								 ComponentInstance *	ci)									TWOWORDINLINE(0x702D, 0xA82A);

EXTERN_API( ComponentInstance )
OpenComponent					(Component 				aComponent)							TWOWORDINLINE(0x7007, 0xA82A);

EXTERN_API( OSErr )
CloseComponent					(ComponentInstance 		aComponentInstance)					TWOWORDINLINE(0x7008, 0xA82A);

EXTERN_API( OSErr )
GetComponentInstanceError		(ComponentInstance 		aComponentInstance)					TWOWORDINLINE(0x700A, 0xA82A);

/********************************************************
*														*
*  					CALLS MADE BY COMPONENTS	  		*
*														*
********************************************************/
/********************************************************
* Component Management routines
********************************************************/
EXTERN_API( void )
SetComponentInstanceError		(ComponentInstance 		aComponentInstance,
								 OSErr 					theError)							TWOWORDINLINE(0x700B, 0xA82A);

EXTERN_API( long )
GetComponentRefcon				(Component 				aComponent)							TWOWORDINLINE(0x7010, 0xA82A);

EXTERN_API( void )
SetComponentRefcon				(Component 				aComponent,
								 long 					theRefcon)							TWOWORDINLINE(0x7011, 0xA82A);

EXTERN_API( short )
OpenComponentResFile			(Component 				aComponent)							TWOWORDINLINE(0x7015, 0xA82A);

EXTERN_API( OSErr )
OpenAComponentResFile			(Component 				aComponent,
								 short *				resRef)								TWOWORDINLINE(0x702F, 0xA82A);

EXTERN_API( OSErr )
CloseComponentResFile			(short 					refnum)								TWOWORDINLINE(0x7018, 0xA82A);

/********************************************************
* Component Instance Management routines
********************************************************/
EXTERN_API( Handle )
GetComponentInstanceStorage		(ComponentInstance 		aComponentInstance)					TWOWORDINLINE(0x700C, 0xA82A);

EXTERN_API( void )
SetComponentInstanceStorage		(ComponentInstance 		aComponentInstance,
								 Handle 				theStorage)							TWOWORDINLINE(0x700D, 0xA82A);

EXTERN_API( long )
GetComponentInstanceA5			(ComponentInstance 		aComponentInstance)					TWOWORDINLINE(0x700E, 0xA82A);

EXTERN_API( void )
SetComponentInstanceA5			(ComponentInstance 		aComponentInstance,
								 long 					theA5)								TWOWORDINLINE(0x700F, 0xA82A);

EXTERN_API( long )
CountComponentInstances			(Component 				aComponent)							TWOWORDINLINE(0x7013, 0xA82A);

/* useful helper routines for convenient method dispatching */
EXTERN_API( long )
CallComponentFunction			(ComponentParameters *	params,
								 ComponentFunctionUPP 	func)								TWOWORDINLINE(0x70FF, 0xA82A);

EXTERN_API( long )
CallComponentFunctionWithStorage (Handle 				storage,
								 ComponentParameters *	params,
								 ComponentFunctionUPP 	func)								TWOWORDINLINE(0x70FF, 0xA82A);

#if TARGET_CPU_PPC
EXTERN_API( long )
CallComponentFunctionWithStorageProcInfo (Handle 		storage,
								 ComponentParameters *	params,
								 ProcPtr 				func,
								 long 					funcProcInfo);

#else
#define CallComponentFunctionWithStorageProcInfo(storage, params, func, funcProcInfo ) CallComponentFunctionWithStorage(storage, params, func)

#endif  /* TARGET_CPU_PPC */

EXTERN_API( long )
DelegateComponentCall			(ComponentParameters *	originalParams,
								 ComponentInstance 		ci)									TWOWORDINLINE(0x7024, 0xA82A);

EXTERN_API( OSErr )
SetDefaultComponent				(Component 				aComponent,
								 short 					flags)								TWOWORDINLINE(0x701E, 0xA82A);

EXTERN_API( ComponentInstance )
OpenDefaultComponent			(OSType 				componentType,
								 OSType 				componentSubType)					TWOWORDINLINE(0x7021, 0xA82A);

EXTERN_API( OSErr )
OpenADefaultComponent			(OSType 				componentType,
								 OSType 				componentSubType,
								 ComponentInstance *	ci)									TWOWORDINLINE(0x702E, 0xA82A);

EXTERN_API( Component )
CaptureComponent				(Component 				capturedComponent,
								 Component 				capturingComponent)					TWOWORDINLINE(0x701C, 0xA82A);

EXTERN_API( OSErr )
UncaptureComponent				(Component 				aComponent)							TWOWORDINLINE(0x701D, 0xA82A);

EXTERN_API( long )
RegisterComponentResourceFile	(short 					resRefNum,
								 short 					global)								TWOWORDINLINE(0x7014, 0xA82A);

EXTERN_API( OSErr )
GetComponentIconSuite			(Component 				aComponent,
								 Handle *				iconSuite)							TWOWORDINLINE(0x7029, 0xA82A);


/********************************************************
*														*
*  			Direct calls to the Components				*
*														*
********************************************************/
/* Old style names*/

EXTERN_API( long )
ComponentFunctionImplemented	(ComponentInstance 		ci,
								 short 					ftnNumber)							FIVEWORDINLINE(0x2F3C, 0x0002, 0xFFFD, 0x7000, 0xA82A);

EXTERN_API( long )
GetComponentVersion				(ComponentInstance 		ci)									FIVEWORDINLINE(0x2F3C, 0x0000, 0xFFFC, 0x7000, 0xA82A);

EXTERN_API( long )
ComponentSetTarget				(ComponentInstance 		ci,
								 ComponentInstance 		target)								FIVEWORDINLINE(0x2F3C, 0x0004, 0xFFFA, 0x7000, 0xA82A);

/* New style names*/

EXTERN_API( ComponentResult )
CallComponentOpen				(ComponentInstance 		ci,
								 ComponentInstance 		self)								FIVEWORDINLINE(0x2F3C, 0x0004, 0xFFFF, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
CallComponentClose				(ComponentInstance 		ci,
								 ComponentInstance 		self)								FIVEWORDINLINE(0x2F3C, 0x0004, 0xFFFE, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
CallComponentCanDo				(ComponentInstance 		ci,
								 short 					ftnNumber)							FIVEWORDINLINE(0x2F3C, 0x0002, 0xFFFD, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
CallComponentVersion			(ComponentInstance 		ci)									FIVEWORDINLINE(0x2F3C, 0x0000, 0xFFFC, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
CallComponentRegister			(ComponentInstance 		ci)									FIVEWORDINLINE(0x2F3C, 0x0000, 0xFFFB, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
CallComponentTarget				(ComponentInstance 		ci,
								 ComponentInstance 		target)								FIVEWORDINLINE(0x2F3C, 0x0004, 0xFFFA, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
CallComponentUnregister			(ComponentInstance 		ci)									FIVEWORDINLINE(0x2F3C, 0x0000, 0xFFF9, 0x7000, 0xA82A);

EXTERN_API( ComponentResult )
CallComponentGetMPWorkFunction	(ComponentInstance 		ci,
								 ComponentMPWorkFunctionUPP * workFunction,
								 void **				refCon)								FIVEWORDINLINE(0x2F3C, 0x0008, 0xFFF8, 0x7000, 0xA82A);


/* UPP call backs */
enum { uppComponentMPWorkFunctionProcInfo = 0x000003F0 }; 		/* pascal 4_bytes Func(4_bytes, 4_bytes) */
enum { uppComponentRoutineProcInfo = 0x000003F0 }; 				/* pascal 4_bytes Func(4_bytes, 4_bytes) */
#define NewComponentMPWorkFunctionProc(userRoutine) 			(ComponentMPWorkFunctionUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppComponentMPWorkFunctionProcInfo, GetCurrentArchitecture())
#define NewComponentRoutineProc(userRoutine) 					(ComponentRoutineUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppComponentRoutineProcInfo, GetCurrentArchitecture())
#define CallComponentMPWorkFunctionProc(userRoutine, globalRefCon, header)  CALL_TWO_PARAMETER_UPP((userRoutine), uppComponentMPWorkFunctionProcInfo, (globalRefCon), (header))
#define CallComponentRoutineProc(userRoutine, cp, componentStorage)  CALL_TWO_PARAMETER_UPP((userRoutine), uppComponentRoutineProcInfo, (cp), (componentStorage))
/* ProcInfos */

/* MixedMode ProcInfo constants for component calls */
enum {
	uppComponentFunctionImplementedProcInfo			= 0x000002F0,
	uppGetComponentVersionProcInfo					= 0x000000F0,
	uppComponentSetTargetProcInfo					= 0x000003F0,
	uppCallComponentOpenProcInfo					= 0x000003F0,
	uppCallComponentCloseProcInfo					= 0x000003F0,
	uppCallComponentCanDoProcInfo					= 0x000002F0,
	uppCallComponentVersionProcInfo					= 0x000000F0,
	uppCallComponentRegisterProcInfo				= 0x000000F0,
	uppCallComponentTargetProcInfo					= 0x000003F0,
	uppCallComponentUnregisterProcInfo				= 0x000000F0,
	uppCallComponentGetMPWorkFunctionProcInfo		= 0x00000FF0
};







#if PRAGMA_STRUCT_ALIGN
	#pragma options align=reset
#elif PRAGMA_STRUCT_PACKPUSH
	#pragma pack(pop)
#elif PRAGMA_STRUCT_PACK
	#pragma pack()
#endif

#ifdef PRAGMA_IMPORT_OFF
#pragma import off
#elif PRAGMA_IMPORT
#pragma import reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __COMPONENTS__ */

