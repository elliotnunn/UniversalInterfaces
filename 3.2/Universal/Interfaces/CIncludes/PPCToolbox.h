/*
 	File:		PPCToolbox.h
 
 	Contains:	Program-Program Communications Toolbox Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.2
 
 	Copyright:	© 1989-1993, 1995-1998 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
*/
#ifndef __PPCTOOLBOX__
#define __PPCTOOLBOX__

#ifndef __MACTYPES__
#include <MacTypes.h>
#endif
#ifndef __APPLETALK__
#include <AppleTalk.h>
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

typedef unsigned char 					PPCServiceType;

enum {
	ppcServiceRealTime			= 1
};

typedef short 							PPCLocationKind;

enum {
	ppcNoLocation				= 0,							/* There is no PPCLocName */
	ppcNBPLocation				= 1,							/* Use AppleTalk NBP      */
	ppcNBPTypeLocation			= 2								/* Used for specifying a location name type during PPCOpen only */
};

typedef short 							PPCPortKinds;

enum {
	ppcByCreatorAndType			= 1,							/* Port type is specified as colloquial Mac creator and type */
	ppcByString					= 2								/* Port type is in pascal string format */
};

/* Values returned for request field in PPCInform call */
typedef unsigned char 					PPCSessionOrigin;

enum {
																/* Values returned for requestType field in PPCInform call */
	ppcLocalOrigin				= 1,							/* session originated from this machine */
	ppcRemoteOrigin				= 2								/* session originated from remote machine */
};

typedef short 							PPCPortRefNum;
typedef long 							PPCSessRefNum;

struct PPCPortRec {
	ScriptCode 						nameScript;					/* script of name */
	Str32Field 						name;						/* name of port as seen in browser */
	PPCPortKinds 					portKindSelector;			/* which variant */
	union {
		Str32 							portTypeStr;			/* pascal type string */
		struct {
			OSType 							portCreator;
			OSType 							portType;
		} 								port;
	} 								u;
};
typedef struct PPCPortRec				PPCPortRec;

typedef PPCPortRec *					PPCPortPtr;

struct LocationNameRec {
	PPCLocationKind 				locationKindSelector;		/* which variant */
	union {
		EntityName 						nbpEntity;				/* NBP name entity */
		Str32 							nbpType;				/* just the NBP type string, for PPCOpen */
	} 								u;
};
typedef struct LocationNameRec			LocationNameRec;

typedef LocationNameRec *				LocationNamePtr;

struct PortInfoRec {
	SInt8 							filler1;
	Boolean 						authRequired;
	PPCPortRec 						name;
};
typedef struct PortInfoRec				PortInfoRec;

typedef PortInfoRec *					PortInfoPtr;
typedef PortInfoRec *					PortInfoArrayPtr;
typedef union PPCParamBlockRec 			PPCParamBlockRec;
typedef PPCParamBlockRec *				PPCParamBlockPtr;
typedef CALLBACK_API( void , PPCCompProcPtr )(PPCParamBlockPtr pb);
typedef STACK_UPP_TYPE(PPCCompProcPtr) 							PPCCompUPP;
#define PPCHeader \
     Ptr    		qLink;   				/* PPC's Internal Use */\
     unsigned short csCode;   				/* Requested PPC command */\
     unsigned short intUse;   				/* Internal Use */\
     Ptr    		intUsePtr;  			/* Internal Use */\
	 PPCCompUPP 	ioCompletion;			/* 12 --> Completion Routine */\
	 OSErr   		ioResult;  				/* 16 <-- Command Result Code */\
     unsigned long	Reserved[5]; 			/* Reserved for PPC, Don't use */


struct PPCOpenPBRec {
	Ptr 							qLink;						/* PPC's Internal Use */
	unsigned short 					csCode;						/* Requested PPC command */
	unsigned short 					intUse;						/* Internal Use */
	Ptr 							intUsePtr;					/* Internal Use */
	PPCCompUPP 						ioCompletion;				/* 12 -->	Completion Routine */
	OSErr 							ioResult;					/* 16 <-- 	Command Result Code */
	unsigned long 					Reserved[5];				/* Reserved for PPC, Don't use */
	PPCPortRefNum 					portRefNum;					/* 38 <--   Port Reference */
	long 							filler1;
	PPCServiceType 					serviceType;				/* 44 -->    Bit field describing the requested port service */
	UInt8 							resFlag;					/* Must be set to 0 */
	PPCPortPtr 						portName;					/* 46 -->   PortName for PPC */
	LocationNamePtr 				locationName;				/* 50 -->   If NBP Registration is required */
	Boolean 						networkVisible;				/* 54 -->   make this network visible on network */
	Boolean 						nbpRegistered;				/* 55 <--   The given location name was registered on the network */
};
typedef struct PPCOpenPBRec				PPCOpenPBRec;

typedef PPCOpenPBRec *					PPCOpenPBPtr;

struct PPCInformPBRec {
	Ptr 							qLink;						/* PPC's Internal Use */
	unsigned short 					csCode;						/* Requested PPC command */
	unsigned short 					intUse;						/* Internal Use */
	Ptr 							intUsePtr;					/* Internal Use */
	PPCCompUPP 						ioCompletion;				/* 12 -->	Completion Routine */
	OSErr 							ioResult;					/* 16 <-- 	Command Result Code */
	unsigned long 					Reserved[5];				/* Reserved for PPC, Don't use */
	PPCPortRefNum 					portRefNum;					/* 38 -->   Port Identifier */
	PPCSessRefNum 					sessRefNum;					/* 40 <--   Session Reference */
	PPCServiceType 					serviceType;				/* 44 <--   Status Flags for type of session, local, remote */
	Boolean 						autoAccept;					/* 45 -->   if true session will be accepted automatically */
	PPCPortPtr 						portName;					/* 46 -->   Buffer for Source PPCPortRec */
	LocationNamePtr 				locationName;				/* 50 -->   Buffer for Source LocationNameRec */
	StringPtr 						userName;					/* 54 -->   Buffer for Soure user's name trying to link. */
	unsigned long 					userData;					/* 58 <--   value included in PPCStart's userData */
	PPCSessionOrigin 				requestType;				/* 62 <--   Local or Network */
	SInt8 							filler;
};
typedef struct PPCInformPBRec			PPCInformPBRec;

typedef PPCInformPBRec *				PPCInformPBPtr;

struct PPCStartPBRec {
	Ptr 							qLink;						/* PPC's Internal Use */
	unsigned short 					csCode;						/* Requested PPC command */
	unsigned short 					intUse;						/* Internal Use */
	Ptr 							intUsePtr;					/* Internal Use */
	PPCCompUPP 						ioCompletion;				/* 12 -->	Completion Routine */
	OSErr 							ioResult;					/* 16 <-- 	Command Result Code */
	unsigned long 					Reserved[5];				/* Reserved for PPC, Don't use */
	PPCPortRefNum 					portRefNum;					/* 38 -->   Port Identifier */
	PPCSessRefNum 					sessRefNum;					/* 40 <--   Session Reference */
	PPCServiceType 					serviceType;				/* 44 <--   Actual service method (realTime) */
	UInt8 							resFlag;					/* 45 -->   Must be set to 0  */
	PPCPortPtr 						portName;					/* 46 -->   Destination portName */
	LocationNamePtr 				locationName;				/* 50 -->   NBP or NAS style service location name */
	unsigned long 					rejectInfo;					/* 54 <--   reason for rejecting the session request */
	unsigned long 					userData;					/* 58 -->   Copied to destination PPCInform parameter block */
	unsigned long 					userRefNum;					/* 62 -->   userRefNum (obtained during login process)  */
};
typedef struct PPCStartPBRec			PPCStartPBRec;

typedef PPCStartPBRec *					PPCStartPBPtr;

struct PPCAcceptPBRec {
	Ptr 							qLink;						/* PPC's Internal Use */
	unsigned short 					csCode;						/* Requested PPC command */
	unsigned short 					intUse;						/* Internal Use */
	Ptr 							intUsePtr;					/* Internal Use */
	PPCCompUPP 						ioCompletion;				/* 12 -->	Completion Routine */
	OSErr 							ioResult;					/* 16 <-- 	Command Result Code */
	unsigned long 					Reserved[5];				/* Reserved for PPC, Don't use */
	short 							filler1;
	PPCSessRefNum 					sessRefNum;					/* 40 -->   Session Reference */
};
typedef struct PPCAcceptPBRec			PPCAcceptPBRec;

typedef PPCAcceptPBRec *				PPCAcceptPBPtr;

struct PPCRejectPBRec {
	Ptr 							qLink;						/* PPC's Internal Use */
	unsigned short 					csCode;						/* Requested PPC command */
	unsigned short 					intUse;						/* Internal Use */
	Ptr 							intUsePtr;					/* Internal Use */
	PPCCompUPP 						ioCompletion;				/* 12 -->	Completion Routine */
	OSErr 							ioResult;					/* 16 <-- 	Command Result Code */
	unsigned long 					Reserved[5];				/* Reserved for PPC, Don't use */
	short 							filler1;
	PPCSessRefNum 					sessRefNum;					/* 40 -->   Session Reference */
	short 							filler2;
	long 							filler3;
	long 							filler4;
	unsigned long 					rejectInfo;					/* 54 -->   reason for rejecting the session request  */
};
typedef struct PPCRejectPBRec			PPCRejectPBRec;

typedef PPCRejectPBRec *				PPCRejectPBPtr;

struct PPCWritePBRec {
	Ptr 							qLink;						/* PPC's Internal Use */
	unsigned short 					csCode;						/* Requested PPC command */
	unsigned short 					intUse;						/* Internal Use */
	Ptr 							intUsePtr;					/* Internal Use */
	PPCCompUPP 						ioCompletion;				/* 12 -->	Completion Routine */
	OSErr 							ioResult;					/* 16 <-- 	Command Result Code */
	unsigned long 					Reserved[5];				/* Reserved for PPC, Don't use */
	short 							filler1;
	PPCSessRefNum 					sessRefNum;					/* 40 -->   Session Reference */
	Size 							bufferLength;				/* 44 -->   Length of the message buffer */
	Size 							actualLength;				/* 48 <--   Actual Length Written */
	Ptr 							bufferPtr;					/* 52 -->   Pointer to message buffer */
	Boolean 						more;						/* 56 -->   if more data in this block will be written */
	SInt8 							filler2;
	unsigned long 					userData;					/* 58 -->   Message block userData Uninterpreted by PPC */
	OSType 							blockCreator;				/* 62 -->   Message block creator Uninterpreted by PPC */
	OSType 							blockType;					/* 66 -->   Message block type Uninterpreted by PPC */
};
typedef struct PPCWritePBRec			PPCWritePBRec;

typedef PPCWritePBRec *					PPCWritePBPtr;

struct PPCReadPBRec {
	Ptr 							qLink;						/* PPC's Internal Use */
	unsigned short 					csCode;						/* Requested PPC command */
	unsigned short 					intUse;						/* Internal Use */
	Ptr 							intUsePtr;					/* Internal Use */
	PPCCompUPP 						ioCompletion;				/* 12 -->	Completion Routine */
	OSErr 							ioResult;					/* 16 <-- 	Command Result Code */
	unsigned long 					Reserved[5];				/* Reserved for PPC, Don't use */
	short 							filler1;
	PPCSessRefNum 					sessRefNum;					/* 40 -->   Session Reference */
	Size 							bufferLength;				/* 44 -->   Length of the message buffer */
	Size 							actualLength;				/* 48 <--   Actual length read */
	Ptr 							bufferPtr;					/* 52 -->   Pointer to message buffer */
	Boolean 						more;						/* 56 <--   if true more data in this block to be read */
	SInt8 							filler2;
	unsigned long 					userData;					/* 58 <--   Message block userData Uninterpreted by PPC */
	OSType 							blockCreator;				/* 62 <--   Message block creator Uninterpreted by PPC */
	OSType 							blockType;					/* 66 <--   Message block type Uninterpreted by PPC */
};
typedef struct PPCReadPBRec				PPCReadPBRec;

typedef PPCReadPBRec *					PPCReadPBPtr;

struct PPCEndPBRec {
	Ptr 							qLink;						/* PPC's Internal Use */
	unsigned short 					csCode;						/* Requested PPC command */
	unsigned short 					intUse;						/* Internal Use */
	Ptr 							intUsePtr;					/* Internal Use */
	PPCCompUPP 						ioCompletion;				/* 12 -->	Completion Routine */
	OSErr 							ioResult;					/* 16 <-- 	Command Result Code */
	unsigned long 					Reserved[5];				/* Reserved for PPC, Don't use */
	short 							filler1;
	PPCSessRefNum 					sessRefNum;					/* 40 -->   Session Reference */
};
typedef struct PPCEndPBRec				PPCEndPBRec;

typedef PPCEndPBRec *					PPCEndPBPtr;

struct PPCClosePBRec {
	Ptr 							qLink;						/* PPC's Internal Use */
	unsigned short 					csCode;						/* Requested PPC command */
	unsigned short 					intUse;						/* Internal Use */
	Ptr 							intUsePtr;					/* Internal Use */
	PPCCompUPP 						ioCompletion;				/* 12 -->	Completion Routine */
	OSErr 							ioResult;					/* 16 <-- 	Command Result Code */
	unsigned long 					Reserved[5];				/* Reserved for PPC, Don't use */
	PPCPortRefNum 					portRefNum;					/* 38 -->   Port Identifier */
};
typedef struct PPCClosePBRec			PPCClosePBRec;

typedef PPCClosePBRec *					PPCClosePBPtr;

struct IPCListPortsPBRec {
	Ptr 							qLink;						/* PPC's Internal Use */
	unsigned short 					csCode;						/* Requested PPC command */
	unsigned short 					intUse;						/* Internal Use */
	Ptr 							intUsePtr;					/* Internal Use */
	PPCCompUPP 						ioCompletion;				/* 12 -->	Completion Routine */
	OSErr 							ioResult;					/* 16 <-- 	Command Result Code */
	unsigned long 					Reserved[5];				/* Reserved for PPC, Don't use */
	short 							filler1;
	unsigned short 					startIndex;					/* 40 -->   Start Index */
	unsigned short 					requestCount;				/* 42 -->   Number of entries to be returned */
	unsigned short 					actualCount;				/* 44 <--   Actual Number of entries to be returned */
	PPCPortPtr 						portName;					/* 46 -->   PortName Match */
	LocationNamePtr 				locationName;				/* 50 -->   NBP or NAS type name to locate the Port Location */
	PortInfoArrayPtr 				bufferPtr;					/* 54 -->   Pointer to a buffer requestCount*sizeof(PortInfo) bytes big */
};
typedef struct IPCListPortsPBRec		IPCListPortsPBRec;

typedef IPCListPortsPBRec *				IPCListPortsPBPtr;

union PPCParamBlockRec {
	PPCOpenPBRec 					openParam;
	PPCInformPBRec 					informParam;
	PPCStartPBRec 					startParam;
	PPCAcceptPBRec 					acceptParam;
	PPCRejectPBRec 					rejectParam;
	PPCWritePBRec 					writeParam;
	PPCReadPBRec 					readParam;
	PPCEndPBRec 					endParam;
	PPCClosePBRec 					closeParam;
	IPCListPortsPBRec 				listPortsParam;
};

/*  PPC Calling Conventions  */
																							#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
																							#pragma parameter __D0 PPCInit
																							#endif
EXTERN_API( OSErr )
PPCInit							(void)														TWOWORDINLINE(0x7000, 0xA0DD);


																							#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
																							#pragma parameter __D0 PPCOpenSync(__A0)
																							#endif
EXTERN_API( OSErr )
PPCOpenSync						(PPCOpenPBPtr 			pb)									TWOWORDINLINE(0x7001, 0xA0DD);

																							#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
																							#pragma parameter __D0 PPCOpenAsync(__A0)
																							#endif
EXTERN_API( OSErr )
PPCOpenAsync					(PPCOpenPBPtr 			pb)									TWOWORDINLINE(0x7001, 0xA4DD);

																							#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
																							#pragma parameter __D0 PPCInformSync(__A0)
																							#endif
EXTERN_API( OSErr )
PPCInformSync					(PPCInformPBPtr 		pb)									TWOWORDINLINE(0x7003, 0xA0DD);

																							#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
																							#pragma parameter __D0 PPCInformAsync(__A0)
																							#endif
EXTERN_API( OSErr )
PPCInformAsync					(PPCInformPBPtr 		pb)									TWOWORDINLINE(0x7003, 0xA4DD);

																							#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
																							#pragma parameter __D0 PPCStartSync(__A0)
																							#endif
EXTERN_API( OSErr )
PPCStartSync					(PPCStartPBPtr 			pb)									TWOWORDINLINE(0x7002, 0xA0DD);

																							#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
																							#pragma parameter __D0 PPCStartAsync(__A0)
																							#endif
EXTERN_API( OSErr )
PPCStartAsync					(PPCStartPBPtr 			pb)									TWOWORDINLINE(0x7002, 0xA4DD);

																							#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
																							#pragma parameter __D0 PPCAcceptSync(__A0)
																							#endif
EXTERN_API( OSErr )
PPCAcceptSync					(PPCAcceptPBPtr 		pb)									TWOWORDINLINE(0x7004, 0xA0DD);

																							#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
																							#pragma parameter __D0 PPCAcceptAsync(__A0)
																							#endif
EXTERN_API( OSErr )
PPCAcceptAsync					(PPCAcceptPBPtr 		pb)									TWOWORDINLINE(0x7004, 0xA4DD);

																							#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
																							#pragma parameter __D0 PPCRejectSync(__A0)
																							#endif
EXTERN_API( OSErr )
PPCRejectSync					(PPCRejectPBPtr 		pb)									TWOWORDINLINE(0x7005, 0xA0DD);

																							#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
																							#pragma parameter __D0 PPCRejectAsync(__A0)
																							#endif
EXTERN_API( OSErr )
PPCRejectAsync					(PPCRejectPBPtr 		pb)									TWOWORDINLINE(0x7005, 0xA4DD);

																							#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
																							#pragma parameter __D0 PPCWriteSync(__A0)
																							#endif
EXTERN_API( OSErr )
PPCWriteSync					(PPCWritePBPtr 			pb)									TWOWORDINLINE(0x7006, 0xA0DD);

																							#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
																							#pragma parameter __D0 PPCWriteAsync(__A0)
																							#endif
EXTERN_API( OSErr )
PPCWriteAsync					(PPCWritePBPtr 			pb)									TWOWORDINLINE(0x7006, 0xA4DD);

																							#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
																							#pragma parameter __D0 PPCReadSync(__A0)
																							#endif
EXTERN_API( OSErr )
PPCReadSync						(PPCReadPBPtr 			pb)									TWOWORDINLINE(0x7007, 0xA0DD);

																							#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
																							#pragma parameter __D0 PPCReadAsync(__A0)
																							#endif
EXTERN_API( OSErr )
PPCReadAsync					(PPCReadPBPtr 			pb)									TWOWORDINLINE(0x7007, 0xA4DD);

																							#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
																							#pragma parameter __D0 PPCEndSync(__A0)
																							#endif
EXTERN_API( OSErr )
PPCEndSync						(PPCEndPBPtr 			pb)									TWOWORDINLINE(0x7008, 0xA0DD);

																							#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
																							#pragma parameter __D0 PPCEndAsync(__A0)
																							#endif
EXTERN_API( OSErr )
PPCEndAsync						(PPCEndPBPtr 			pb)									TWOWORDINLINE(0x7008, 0xA4DD);

																							#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
																							#pragma parameter __D0 PPCCloseSync(__A0)
																							#endif
EXTERN_API( OSErr )
PPCCloseSync					(PPCClosePBPtr 			pb)									TWOWORDINLINE(0x7009, 0xA0DD);

																							#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
																							#pragma parameter __D0 PPCCloseAsync(__A0)
																							#endif
EXTERN_API( OSErr )
PPCCloseAsync					(PPCClosePBPtr 			pb)									TWOWORDINLINE(0x7009, 0xA4DD);

																							#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
																							#pragma parameter __D0 IPCListPortsSync(__A0)
																							#endif
EXTERN_API( OSErr )
IPCListPortsSync				(IPCListPortsPBPtr 		pb)									TWOWORDINLINE(0x700A, 0xA0DD);

																							#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
																							#pragma parameter __D0 IPCListPortsAsync(__A0)
																							#endif
EXTERN_API( OSErr )
IPCListPortsAsync				(IPCListPortsPBPtr 		pb)									TWOWORDINLINE(0x700A, 0xA4DD);

EXTERN_API( OSErr )
DeleteUserIdentity				(unsigned long 			userRef);

EXTERN_API( OSErr )
GetDefaultUser					(unsigned long *		userRef,
								 Str32 					userName);

EXTERN_API( OSErr )
StartSecureSession				(PPCStartPBPtr 			pb,
								 Str32 					userName,
								 Boolean 				useDefault,
								 Boolean 				allowGuest,
								 Boolean *				guestSelected,
								 ConstStr255Param 		prompt);

typedef CALLBACK_API( Boolean , PPCFilterProcPtr )(LocationNamePtr name, PortInfoPtr port);
typedef STACK_UPP_TYPE(PPCFilterProcPtr) 						PPCFilterUPP;
enum { uppPPCCompProcInfo = 0x000000C0 }; 						/* pascal no_return_value Func(4_bytes) */
enum { uppPPCFilterProcInfo = 0x000003D0 }; 					/* pascal 1_byte Func(4_bytes, 4_bytes) */
#define NewPPCCompProc(userRoutine) 							(PPCCompUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPPCCompProcInfo, GetCurrentArchitecture())
#define NewPPCFilterProc(userRoutine) 							(PPCFilterUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPPCFilterProcInfo, GetCurrentArchitecture())
#define CallPPCCompProc(userRoutine, pb) 						CALL_ONE_PARAMETER_UPP((userRoutine), uppPPCCompProcInfo, (pb))
#define CallPPCFilterProc(userRoutine, name, port) 				CALL_TWO_PARAMETER_UPP((userRoutine), uppPPCFilterProcInfo, (name), (port))
EXTERN_API( OSErr )
PPCBrowser						(ConstStr255Param 		prompt,
								 ConstStr255Param 		applListLabel,
								 Boolean 				defaultSpecified,
								 LocationNameRec *		theLocation,
								 PortInfoRec *			thePortInfo,
								 PPCFilterUPP 			portFilter,
								 ConstStr32Param 		theLocNBPType)						THREEWORDINLINE(0x303C, 0x0D00, 0xA82B);


/*
  The ParamBlock calls with the "Sync" or "Async" suffix are being phased out.
*/
#define PPCOpen(pb, async)      ((async) ? PPCOpenAsync(pb)      : PPCOpenSync(pb))
#define PPCInform(pb, async)    ((async) ? PPCInformAsync(pb)    : PPCInformSync(pb))
#define PPCStart(pb, async)     ((async) ? PPCStartAsync(pb)     : PPCStartSync(pb))
#define PPCAccept(pb, async)    ((async) ? PPCAcceptAsync(pb)    : PPCAcceptSync(pb))
#define PPCReject(pb, async)    ((async) ? PPCRejectAsync(pb)    : PPCRejectSync(pb))
#define PPCWrite(pb, async)     ((async) ? PPCWriteAsync(pb)     : PPCWriteSync(pb))
#define PPCRead(pb, async)      ((async) ? PPCReadAsync(pb)      : PPCReadSync(pb))
#define PPCEnd(pb, async)       ((async) ? PPCEndAsync(pb)       : PPCEndSync(pb))
#define PPCClose(pb, async)     ((async) ? PPCCloseAsync(pb)     : PPCCloseSync(pb))
#define IPCListPorts(pb, async) ((async) ? IPCListPortsAsync(pb) : IPCListPortsSync(pb))



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

#endif /* __PPCTOOLBOX__ */

