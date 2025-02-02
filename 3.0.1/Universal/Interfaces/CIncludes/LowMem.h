/*
 	File:		LowMem.h
 
 	Contains:	Low Memory Accessor Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1993-1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
*/
#ifndef __LOWMEM__
#define __LOWMEM__

#ifndef __TYPES__
#include <Types.h>
#endif
#ifndef __CONTROLS__
#include <Controls.h>
#endif
#ifndef __EVENTS__
#include <Events.h>
#endif
#ifndef __FILES__
#include <Files.h>
#endif
#ifndef __FONTS__
#include <Fonts.h>
#endif
#ifndef __MACMEMORY__
#include <MacMemory.h>
#endif
#ifndef __MENUS__
#include <Menus.h>
#endif
#ifndef __OSUTILS__
#include <OSUtils.h>
#endif
#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif
#ifndef __RESOURCES__
#include <Resources.h>
#endif
#ifndef __MACWINDOWS__
#include <MacWindows.h>
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

/**************************************************************************************

	SIMPLE LOWMEM ACCESSORS

**************************************************************************************/
EXTERN_API( SInt16 ) LMGetScrVRes(void)																						TWOWORDINLINE(0x3EB8, 0x0102);

EXTERN_API( void ) LMSetScrVRes(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x0102);

EXTERN_API( SInt16 ) LMGetScrHRes(void)																						TWOWORDINLINE(0x3EB8, 0x0104);

EXTERN_API( void ) LMSetScrHRes(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x0104);

EXTERN_API( Ptr ) LMGetMemTop(void)																						TWOWORDINLINE(0x2EB8, 0x0108);

EXTERN_API( void ) LMSetMemTop(Ptr value)																							TWOWORDINLINE(0x21DF, 0x0108);

EXTERN_API( Ptr ) LMGetBufPtr(void)																						TWOWORDINLINE(0x2EB8, 0x010C);

EXTERN_API( void ) LMSetBufPtr(Ptr value)																							TWOWORDINLINE(0x21DF, 0x010C);

EXTERN_API( Ptr ) LMGetHeapEnd(void)																						TWOWORDINLINE(0x2EB8, 0x0114);

EXTERN_API( void ) LMSetHeapEnd(Ptr value)																							TWOWORDINLINE(0x21DF, 0x0114);

EXTERN_API( THz ) LMGetTheZone(void)																						TWOWORDINLINE(0x2EB8, 0x0118);

EXTERN_API( void ) LMSetTheZone(THz value)																							TWOWORDINLINE(0x21DF, 0x0118);

EXTERN_API( Ptr ) LMGetUTableBase(void)																						TWOWORDINLINE(0x2EB8, 0x011C);

EXTERN_API( void ) LMSetUTableBase(Ptr value)																							TWOWORDINLINE(0x21DF, 0x011C);

EXTERN_API( UInt8 ) LMGetCPUFlag(void)																						TWOWORDINLINE(0x1EB8, 0x012F);

EXTERN_API( void ) LMSetCPUFlag(UInt8 value)																							TWOWORDINLINE(0x11DF, 0x012F);

EXTERN_API( Ptr ) LMGetApplLimit(void)																						TWOWORDINLINE(0x2EB8, 0x0130);

EXTERN_API( void ) LMSetApplLimit(Ptr value)																							TWOWORDINLINE(0x21DF, 0x0130);

EXTERN_API( SInt16 ) LMGetSysEvtMask(void)																						TWOWORDINLINE(0x3EB8, 0x0144);

EXTERN_API( void ) LMSetSysEvtMask(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x0144);

EXTERN_API( SInt32 ) LMGetRndSeed(void)																						TWOWORDINLINE(0x2EB8, 0x0156);

EXTERN_API( void ) LMSetRndSeed(SInt32 value)																							TWOWORDINLINE(0x21DF, 0x0156);

EXTERN_API( UInt8 ) LMGetSEvtEnb(void)																						TWOWORDINLINE(0x1EB8, 0x015C);

EXTERN_API( void ) LMSetSEvtEnb(UInt8 value)																							TWOWORDINLINE(0x11DF, 0x015C);

EXTERN_API( UInt32 ) LMGetTicks(void)																						TWOWORDINLINE(0x2EB8, 0x016A);

EXTERN_API( void ) LMSetTicks(UInt32 value)																							TWOWORDINLINE(0x21DF, 0x016A);

EXTERN_API( SInt16 ) LMGetKeyThresh(void)																						TWOWORDINLINE(0x3EB8, 0x018E);

EXTERN_API( void ) LMSetKeyThresh(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x018E);

EXTERN_API( SInt16 ) LMGetKeyRepThresh(void)																						TWOWORDINLINE(0x3EB8, 0x0190);

EXTERN_API( void ) LMSetKeyRepThresh(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x0190);

EXTERN_API( Ptr ) LMGetVIA(void)																						TWOWORDINLINE(0x2EB8, 0x01D4);

EXTERN_API( void ) LMSetVIA(Ptr value)																							TWOWORDINLINE(0x21DF, 0x01D4);

EXTERN_API( Ptr ) LMGetSCCRd(void)																						TWOWORDINLINE(0x2EB8, 0x01D8);

EXTERN_API( void ) LMSetSCCRd(Ptr value)																							TWOWORDINLINE(0x21DF, 0x01D8);

EXTERN_API( Ptr ) LMGetSCCWr(void)																						TWOWORDINLINE(0x2EB8, 0x01DC);

EXTERN_API( void ) LMSetSCCWr(Ptr value)																							TWOWORDINLINE(0x21DF, 0x01DC);

EXTERN_API( UInt8 ) LMGetSPValid(void)																						TWOWORDINLINE(0x1EB8, 0x01F8);

EXTERN_API( void ) LMSetSPValid(UInt8 value)																							TWOWORDINLINE(0x11DF, 0x01F8);

EXTERN_API( UInt8 ) LMGetSPATalkA(void)																						TWOWORDINLINE(0x1EB8, 0x01F9);

EXTERN_API( void ) LMSetSPATalkA(UInt8 value)																							TWOWORDINLINE(0x11DF, 0x01F9);

EXTERN_API( UInt8 ) LMGetSPATalkB(void)																						TWOWORDINLINE(0x1EB8, 0x01FA);

EXTERN_API( void ) LMSetSPATalkB(UInt8 value)																							TWOWORDINLINE(0x11DF, 0x01FA);

EXTERN_API( UInt8 ) LMGetSPConfig(void)																						TWOWORDINLINE(0x1EB8, 0x01FB);

EXTERN_API( void ) LMSetSPConfig(UInt8 value)																							TWOWORDINLINE(0x11DF, 0x01FB);

EXTERN_API( SInt16 ) LMGetSPPortA(void)																						TWOWORDINLINE(0x3EB8, 0x01FC);

EXTERN_API( void ) LMSetSPPortA(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x01FC);

EXTERN_API( SInt16 ) LMGetSPPortB(void)																						TWOWORDINLINE(0x3EB8, 0x01FE);

EXTERN_API( void ) LMSetSPPortB(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x01FE);

EXTERN_API( SInt32 ) LMGetSPAlarm(void)																						TWOWORDINLINE(0x2EB8, 0x0200);

EXTERN_API( void ) LMSetSPAlarm(SInt32 value)																							TWOWORDINLINE(0x21DF, 0x0200);

EXTERN_API( SInt16 ) LMGetSPFont(void)																						TWOWORDINLINE(0x3EB8, 0x0204);

EXTERN_API( void ) LMSetSPFont(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x0204);

EXTERN_API( UInt8 ) LMGetSPKbd(void)																						TWOWORDINLINE(0x1EB8, 0x0206);

EXTERN_API( void ) LMSetSPKbd(UInt8 value)																							TWOWORDINLINE(0x11DF, 0x0206);

EXTERN_API( UInt8 ) LMGetSPPrint(void)																						TWOWORDINLINE(0x1EB8, 0x0207);

EXTERN_API( void ) LMSetSPPrint(UInt8 value)																							TWOWORDINLINE(0x11DF, 0x0207);

EXTERN_API( UInt8 ) LMGetSPVolCtl(void)																						TWOWORDINLINE(0x1EB8, 0x0208);

EXTERN_API( void ) LMSetSPVolCtl(UInt8 value)																							TWOWORDINLINE(0x11DF, 0x0208);

EXTERN_API( UInt8 ) LMGetSPClikCaret(void)																						TWOWORDINLINE(0x1EB8, 0x0209);

EXTERN_API( void ) LMSetSPClikCaret(UInt8 value)																							TWOWORDINLINE(0x11DF, 0x0209);

EXTERN_API( UInt8 ) LMGetSPMisc2(void)																						TWOWORDINLINE(0x1EB8, 0x020B);

EXTERN_API( void ) LMSetSPMisc2(UInt8 value)																							TWOWORDINLINE(0x11DF, 0x020B);

EXTERN_API( SInt32 ) LMGetTime(void)																						TWOWORDINLINE(0x2EB8, 0x020C);

EXTERN_API( void ) LMSetTime(SInt32 value)																							TWOWORDINLINE(0x21DF, 0x020C);

EXTERN_API( SInt16 ) LMGetBootDrive(void)																						TWOWORDINLINE(0x3EB8, 0x0210);

EXTERN_API( void ) LMSetBootDrive(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x0210);

EXTERN_API( SInt16 ) LMGetSFSaveDisk(void)																						TWOWORDINLINE(0x3EB8, 0x0214);

EXTERN_API( void ) LMSetSFSaveDisk(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x0214);

EXTERN_API( UInt8 ) LMGetKbdLast(void)																						TWOWORDINLINE(0x1EB8, 0x0218);

EXTERN_API( void ) LMSetKbdLast(UInt8 value)																							TWOWORDINLINE(0x11DF, 0x0218);

EXTERN_API( UInt8 ) LMGetKbdType(void)																						TWOWORDINLINE(0x1EB8, 0x021E);

EXTERN_API( void ) LMSetKbdType(UInt8 value)																							TWOWORDINLINE(0x11DF, 0x021E);

EXTERN_API( SInt16 ) LMGetMemErr(void)																						TWOWORDINLINE(0x3EB8, 0x0220);

EXTERN_API( void ) LMSetMemErr(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x0220);

EXTERN_API( UInt8 ) LMGetSdVolume(void)																						TWOWORDINLINE(0x1EB8, 0x0260);

EXTERN_API( void ) LMSetSdVolume(UInt8 value)																							TWOWORDINLINE(0x11DF, 0x0260);

EXTERN_API( Ptr ) LMGetSoundPtr(void)																						TWOWORDINLINE(0x2EB8, 0x0262);

EXTERN_API( void ) LMSetSoundPtr(Ptr value)																							TWOWORDINLINE(0x21DF, 0x0262);

EXTERN_API( Ptr ) LMGetSoundBase(void)																						TWOWORDINLINE(0x2EB8, 0x0266);

EXTERN_API( void ) LMSetSoundBase(Ptr value)																							TWOWORDINLINE(0x21DF, 0x0266);

EXTERN_API( UInt8 ) LMGetSoundLevel(void)																						TWOWORDINLINE(0x1EB8, 0x027F);

EXTERN_API( void ) LMSetSoundLevel(UInt8 value)																							TWOWORDINLINE(0x11DF, 0x027F);

EXTERN_API( SInt16 ) LMGetCurPitch(void)																						TWOWORDINLINE(0x3EB8, 0x0280);

EXTERN_API( void ) LMSetCurPitch(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x0280);

EXTERN_API( SInt16 ) LMGetROM85(void)																						TWOWORDINLINE(0x3EB8, 0x028E);

EXTERN_API( void ) LMSetROM85(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x028E);

EXTERN_API( UInt8 ) LMGetPortBUse(void)																						TWOWORDINLINE(0x1EB8, 0x0291);

EXTERN_API( void ) LMSetPortBUse(UInt8 value)																							TWOWORDINLINE(0x11DF, 0x0291);

EXTERN_API( GNEFilterUPP ) LMGetGNEFilter(void)																						TWOWORDINLINE(0x2EB8, 0x029A);

EXTERN_API( void ) LMSetGNEFilter(GNEFilterUPP value)																							TWOWORDINLINE(0x21DF, 0x029A);

EXTERN_API( THz ) LMGetSysZone(void)																						TWOWORDINLINE(0x2EB8, 0x02A6);

EXTERN_API( void ) LMSetSysZone(THz value)																							TWOWORDINLINE(0x21DF, 0x02A6);

EXTERN_API( THz ) LMGetApplZone(void)																						TWOWORDINLINE(0x2EB8, 0x02AA);

EXTERN_API( void ) LMSetApplZone(THz value)																							TWOWORDINLINE(0x21DF, 0x02AA);

EXTERN_API( Ptr ) LMGetROMBase(void)																						TWOWORDINLINE(0x2EB8, 0x02AE);

EXTERN_API( void ) LMSetROMBase(Ptr value)																							TWOWORDINLINE(0x21DF, 0x02AE);

EXTERN_API( Ptr ) LMGetRAMBase(void)																						TWOWORDINLINE(0x2EB8, 0x02B2);

EXTERN_API( void ) LMSetRAMBase(Ptr value)																							TWOWORDINLINE(0x21DF, 0x02B2);

EXTERN_API( Ptr ) LMGetDSAlertTab(void)																						TWOWORDINLINE(0x2EB8, 0x02BA);

EXTERN_API( void ) LMSetDSAlertTab(Ptr value)																							TWOWORDINLINE(0x21DF, 0x02BA);

EXTERN_API( Ptr ) LMGetABusVars(void)																						TWOWORDINLINE(0x2EB8, 0x02D8);

EXTERN_API( void ) LMSetABusVars(Ptr value)																							TWOWORDINLINE(0x21DF, 0x02D8);

EXTERN_API( Ptr ) LMGetABusDCE(void)																						TWOWORDINLINE(0x2EB8, 0x02DC);

EXTERN_API( void ) LMSetABusDCE(Ptr value)																							TWOWORDINLINE(0x21DF, 0x02DC);

EXTERN_API( UInt32 ) LMGetDoubleTime(void)																						TWOWORDINLINE(0x2EB8, 0x02F0);

EXTERN_API( void ) LMSetDoubleTime(UInt32 value)																							TWOWORDINLINE(0x21DF, 0x02F0);

EXTERN_API( UInt32 ) LMGetCaretTime(void)																						TWOWORDINLINE(0x2EB8, 0x02F4);

EXTERN_API( void ) LMSetCaretTime(UInt32 value)																							TWOWORDINLINE(0x21DF, 0x02F4);

EXTERN_API( UInt8 ) LMGetScrDmpEnb(void)																						TWOWORDINLINE(0x1EB8, 0x02F8);

EXTERN_API( void ) LMSetScrDmpEnb(UInt8 value)																							TWOWORDINLINE(0x11DF, 0x02F8);

EXTERN_API( SInt32 ) LMGetBufTgFNum(void)																						TWOWORDINLINE(0x2EB8, 0x02FC);

EXTERN_API( void ) LMSetBufTgFNum(SInt32 value)																							TWOWORDINLINE(0x21DF, 0x02FC);

EXTERN_API( SInt16 ) LMGetBufTgFFlg(void)																						TWOWORDINLINE(0x3EB8, 0x0300);

EXTERN_API( void ) LMSetBufTgFFlg(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x0300);

EXTERN_API( SInt16 ) LMGetBufTgFBkNum(void)																						TWOWORDINLINE(0x3EB8, 0x0302);

EXTERN_API( void ) LMSetBufTgFBkNum(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x0302);

EXTERN_API( SInt32 ) LMGetBufTgDate(void)																						TWOWORDINLINE(0x2EB8, 0x0304);

EXTERN_API( void ) LMSetBufTgDate(SInt32 value)																							TWOWORDINLINE(0x21DF, 0x0304);

EXTERN_API( SInt32 ) LMGetLo3Bytes(void)																						TWOWORDINLINE(0x2EB8, 0x031A);

EXTERN_API( void ) LMSetLo3Bytes(SInt32 value)																							TWOWORDINLINE(0x21DF, 0x031A);

EXTERN_API( SInt32 ) LMGetMinStack(void)																						TWOWORDINLINE(0x2EB8, 0x031E);

EXTERN_API( void ) LMSetMinStack(SInt32 value)																							TWOWORDINLINE(0x21DF, 0x031E);

EXTERN_API( SInt32 ) LMGetDefltStack(void)																						TWOWORDINLINE(0x2EB8, 0x0322);

EXTERN_API( void ) LMSetDefltStack(SInt32 value)																							TWOWORDINLINE(0x21DF, 0x0322);

EXTERN_API( Handle ) LMGetGZRootHnd(void)																						TWOWORDINLINE(0x2EB8, 0x0328);

EXTERN_API( void ) LMSetGZRootHnd(Handle value)																							TWOWORDINLINE(0x21DF, 0x0328);

EXTERN_API( Handle ) LMGetGZMoveHnd(void)																						TWOWORDINLINE(0x2EB8, 0x0330);

EXTERN_API( void ) LMSetGZMoveHnd(Handle value)																							TWOWORDINLINE(0x21DF, 0x0330);

EXTERN_API( Ptr ) LMGetFCBSPtr(void)																						TWOWORDINLINE(0x2EB8, 0x034E);

EXTERN_API( void ) LMSetFCBSPtr(Ptr value)																							TWOWORDINLINE(0x21DF, 0x034E);

EXTERN_API( Ptr ) LMGetDefVCBPtr(void)																						TWOWORDINLINE(0x2EB8, 0x0352);

EXTERN_API( void ) LMSetDefVCBPtr(Ptr value)																							TWOWORDINLINE(0x21DF, 0x0352);

EXTERN_API( SInt32 ) LMGetCurDirStore(void)																						TWOWORDINLINE(0x2EB8, 0x0398);

EXTERN_API( void ) LMSetCurDirStore(SInt32 value)																							TWOWORDINLINE(0x21DF, 0x0398);

EXTERN_API( UniversalProcPtr ) LMGetToExtFS(void)																						TWOWORDINLINE(0x2EB8, 0x03F2);

EXTERN_API( void ) LMSetToExtFS(UniversalProcPtr value)																							TWOWORDINLINE(0x21DF, 0x03F2);

EXTERN_API( SInt16 ) LMGetFSFCBLen(void)																						TWOWORDINLINE(0x3EB8, 0x03F6);

EXTERN_API( void ) LMSetFSFCBLen(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x03F6);

EXTERN_API( Ptr ) LMGetScrnBase(void)																						TWOWORDINLINE(0x2EB8, 0x0824);

EXTERN_API( void ) LMSetScrnBase(Ptr value)																							TWOWORDINLINE(0x21DF, 0x0824);

EXTERN_API( GDHandle ) LMGetMainDevice(void)																						TWOWORDINLINE(0x2EB8, 0x08A4);

EXTERN_API( void ) LMSetMainDevice(GDHandle value)																							TWOWORDINLINE(0x21DF, 0x08A4);

EXTERN_API( GDHandle ) LMGetDeviceList(void)																						TWOWORDINLINE(0x2EB8, 0x08A8);

EXTERN_API( void ) LMSetDeviceList(GDHandle value)																							TWOWORDINLINE(0x21DF, 0x08A8);

EXTERN_API( Handle ) LMGetQDColors(void)																						TWOWORDINLINE(0x2EB8, 0x08B0);

EXTERN_API( void ) LMSetQDColors(Handle value)																							TWOWORDINLINE(0x21DF, 0x08B0);

EXTERN_API( UInt8 ) LMGetCrsrBusy(void)																						TWOWORDINLINE(0x1EB8, 0x08CD);

EXTERN_API( void ) LMSetCrsrBusy(UInt8 value)																							TWOWORDINLINE(0x11DF, 0x08CD);

EXTERN_API( Handle ) LMGetWidthListHand(void)																						TWOWORDINLINE(0x2EB8, 0x08E4);

EXTERN_API( void ) LMSetWidthListHand(Handle value)																							TWOWORDINLINE(0x21DF, 0x08E4);

EXTERN_API( SInt16 ) LMGetJournalRef(void)																						TWOWORDINLINE(0x3EB8, 0x08E8);

EXTERN_API( void ) LMSetJournalRef(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x08E8);

EXTERN_API( SInt16 ) LMGetCrsrThresh(void)																						TWOWORDINLINE(0x3EB8, 0x08EC);

EXTERN_API( void ) LMSetCrsrThresh(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x08EC);

EXTERN_API( UniversalProcPtr ) LMGetJFetch(void)																						TWOWORDINLINE(0x2EB8, 0x08F4);

EXTERN_API( void ) LMSetJFetch(UniversalProcPtr value)																							TWOWORDINLINE(0x21DF, 0x08F4);

EXTERN_API( UniversalProcPtr ) LMGetJStash(void)																						TWOWORDINLINE(0x2EB8, 0x08F8);

EXTERN_API( void ) LMSetJStash(UniversalProcPtr value)																							TWOWORDINLINE(0x21DF, 0x08F8);

EXTERN_API( UniversalProcPtr ) LMGetJIODone(void)																						TWOWORDINLINE(0x2EB8, 0x08FC);

EXTERN_API( void ) LMSetJIODone(UniversalProcPtr value)																							TWOWORDINLINE(0x21DF, 0x08FC);

EXTERN_API( SInt16 ) LMGetCurApRefNum(void)																						TWOWORDINLINE(0x3EB8, 0x0900);

EXTERN_API( void ) LMSetCurApRefNum(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x0900);

EXTERN_API( Ptr ) LMGetCurrentA5(void)																						TWOWORDINLINE(0x2EB8, 0x0904);

EXTERN_API( void ) LMSetCurrentA5(Ptr value)																							TWOWORDINLINE(0x21DF, 0x0904);

EXTERN_API( Ptr ) LMGetCurStackBase(void)																						TWOWORDINLINE(0x2EB8, 0x0908);

EXTERN_API( void ) LMSetCurStackBase(Ptr value)																							TWOWORDINLINE(0x21DF, 0x0908);

EXTERN_API( SInt16 ) LMGetCurJTOffset(void)																						TWOWORDINLINE(0x3EB8, 0x0934);

EXTERN_API( void ) LMSetCurJTOffset(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x0934);

EXTERN_API( SInt16 ) LMGetCurPageOption(void)																						TWOWORDINLINE(0x3EB8, 0x0936);

EXTERN_API( void ) LMSetCurPageOption(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x0936);

EXTERN_API( UInt8 ) LMGetHiliteMode(void)																						TWOWORDINLINE(0x1EB8, 0x0938);

EXTERN_API( void ) LMSetHiliteMode(UInt8 value)																							TWOWORDINLINE(0x11DF, 0x0938);

EXTERN_API( SInt16 ) LMGetPrintErr(void)																						TWOWORDINLINE(0x3EB8, 0x0944);

EXTERN_API( void ) LMSetPrintErr(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x0944);

EXTERN_API( SInt32 ) LMGetScrapSize(void)																						TWOWORDINLINE(0x2EB8, 0x0960);

EXTERN_API( void ) LMSetScrapSize(SInt32 value)																							TWOWORDINLINE(0x21DF, 0x0960);

EXTERN_API( Handle ) LMGetScrapHandle(void)																						TWOWORDINLINE(0x2EB8, 0x0964);

EXTERN_API( void ) LMSetScrapHandle(Handle value)																							TWOWORDINLINE(0x21DF, 0x0964);

EXTERN_API( SInt16 ) LMGetScrapCount(void)																						TWOWORDINLINE(0x3EB8, 0x0968);

EXTERN_API( void ) LMSetScrapCount(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x0968);

EXTERN_API( SInt16 ) LMGetScrapState(void)																						TWOWORDINLINE(0x3EB8, 0x096A);

EXTERN_API( void ) LMSetScrapState(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x096A);

EXTERN_API( StringPtr ) LMGetScrapName(void)																						TWOWORDINLINE(0x2EB8, 0x096C);

EXTERN_API( void ) LMSetScrapName(StringPtr value)																							TWOWORDINLINE(0x21DF, 0x096C);

EXTERN_API( Handle ) LMGetROMFont0(void)																						TWOWORDINLINE(0x2EB8, 0x0980);

EXTERN_API( void ) LMSetROMFont0(Handle value)																							TWOWORDINLINE(0x21DF, 0x0980);

EXTERN_API( SInt16 ) LMGetApFontID(void)																						TWOWORDINLINE(0x3EB8, 0x0984);

EXTERN_API( void ) LMSetApFontID(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x0984);


EXTERN_API( WindowPtr ) LMGetWindowList(void)																						TWOWORDINLINE(0x2EB8, 0x09D6);

EXTERN_API( SInt16 ) LMGetSaveUpdate(void)																						TWOWORDINLINE(0x3EB8, 0x09DA);

EXTERN_API( void ) LMSetSaveUpdate(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x09DA);

EXTERN_API( SInt16 ) LMGetPaintWhite(void)																						TWOWORDINLINE(0x3EB8, 0x09DC);

EXTERN_API( void ) LMSetPaintWhite(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x09DC);

EXTERN_API( GrafPtr ) LMGetWMgrPort(void)																						TWOWORDINLINE(0x2EB8, 0x09DE);

EXTERN_API( void ) LMSetWMgrPort(GrafPtr value)																							TWOWORDINLINE(0x21DF, 0x09DE);

EXTERN_API( RgnHandle ) LMGetGrayRgn(void)																						TWOWORDINLINE(0x2EB8, 0x09EE);

EXTERN_API( DragGrayRgnUPP ) LMGetDragHook(void)																						TWOWORDINLINE(0x2EB8, 0x09F6);

EXTERN_API( void ) LMSetDragHook(DragGrayRgnUPP value)																							TWOWORDINLINE(0x21DF, 0x09F6);

/*
 There is no reason to set the window list directly.
 Use BringToFront and SendBehind.

 If you need to do floating windows, avoid using GhostWindow 
 and especially avoid patching the window manager.

 See Dean Yu's article in Develop 15 about how to implement floating
 windows using low-level window manager calls.  The next generation
 Macintosh Window Manager will have built-in support for floating
 and modal windows.
*/
EXTERN_API( void ) LMSetWindowList(WindowPtr value)																							TWOWORDINLINE(0x21DF, 0x09D6);

EXTERN_API( WindowPtr ) LMGetGhostWindow(void)																						TWOWORDINLINE(0x2EB8, 0x0A84);

EXTERN_API( void ) LMSetGhostWindow(WindowPtr value)																							TWOWORDINLINE(0x21DF, 0x0A84);

EXTERN_API( AuxWinHandle ) LMGetAuxWinHead(void)																						TWOWORDINLINE(0x2EB8, 0x0CD0);

EXTERN_API( void ) LMSetAuxWinHead(AuxWinHandle value)																							TWOWORDINLINE(0x21DF, 0x0CD0);

EXTERN_API( WindowPtr ) LMGetCurActivate(void)																						TWOWORDINLINE(0x2EB8, 0x0A64);

EXTERN_API( void ) LMSetCurActivate(WindowPtr value)																							TWOWORDINLINE(0x21DF, 0x0A64);

EXTERN_API( WindowPtr ) LMGetCurDeactive(void)																						TWOWORDINLINE(0x2EB8, 0x0A68);

EXTERN_API( void ) LMSetCurDeactive(WindowPtr value)																							TWOWORDINLINE(0x21DF, 0x0A68);

EXTERN_API( RgnHandle ) LMGetOldStructure(void)																						TWOWORDINLINE(0x2EB8, 0x09E6);

EXTERN_API( void ) LMSetOldStructure(RgnHandle value)																							TWOWORDINLINE(0x21DF, 0x09E6);

EXTERN_API( RgnHandle ) LMGetOldContent(void)																						TWOWORDINLINE(0x2EB8, 0x09EA);

EXTERN_API( void ) LMSetOldContent(RgnHandle value)																							TWOWORDINLINE(0x21DF, 0x09EA);

/*
 Please don't mess with the gray region.  There has
 to be a better way.  If not, please manipulate the
 existing region, don't change the value of the lowmem.
*/
EXTERN_API( void ) LMSetGrayRgn(RgnHandle value)																							TWOWORDINLINE(0x21DF, 0x09EE);


EXTERN_API( RgnHandle ) LMGetSaveVisRgn(void)																						TWOWORDINLINE(0x2EB8, 0x09F2);

EXTERN_API( void ) LMSetSaveVisRgn(RgnHandle value)																							TWOWORDINLINE(0x21DF, 0x09F2);



EXTERN_API( SInt32 ) LMGetOneOne(void)																						TWOWORDINLINE(0x2EB8, 0x0A02);

EXTERN_API( void ) LMSetOneOne(SInt32 value)																							TWOWORDINLINE(0x21DF, 0x0A02);

EXTERN_API( SInt32 ) LMGetMinusOne(void)																						TWOWORDINLINE(0x2EB8, 0x0A06);

EXTERN_API( void ) LMSetMinusOne(SInt32 value)																							TWOWORDINLINE(0x21DF, 0x0A06);

EXTERN_API( SInt16 ) LMGetTopMenuItem(void)																						TWOWORDINLINE(0x3EB8, 0x0A0A);

EXTERN_API( void ) LMSetTopMenuItem(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x0A0A);

EXTERN_API( SInt16 ) LMGetAtMenuBottom(void)																						TWOWORDINLINE(0x3EB8, 0x0A0C);

EXTERN_API( void ) LMSetAtMenuBottom(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x0A0C);

EXTERN_API( Handle ) LMGetMenuList(void)																						TWOWORDINLINE(0x2EB8, 0x0A1C);

EXTERN_API( void ) LMSetMenuList(Handle value)																							TWOWORDINLINE(0x21DF, 0x0A1C);

EXTERN_API( SInt16 ) LMGetMBarEnable(void)																						TWOWORDINLINE(0x3EB8, 0x0A20);

EXTERN_API( void ) LMSetMBarEnable(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x0A20);

EXTERN_API( SInt16 ) LMGetMenuFlash(void)																						TWOWORDINLINE(0x3EB8, 0x0A24);

EXTERN_API( void ) LMSetMenuFlash(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x0A24);

EXTERN_API( SInt16 ) LMGetTheMenu(void)																						TWOWORDINLINE(0x3EB8, 0x0A26);

EXTERN_API( void ) LMSetTheMenu(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x0A26);

EXTERN_API( MBarHookUPP ) LMGetMBarHook(void)																						TWOWORDINLINE(0x2EB8, 0x0A2C);

EXTERN_API( void ) LMSetMBarHook(MBarHookUPP value)																							TWOWORDINLINE(0x21DF, 0x0A2C);

EXTERN_API( MenuHookUPP ) LMGetMenuHook(void)																						TWOWORDINLINE(0x2EB8, 0x0A30);

EXTERN_API( void ) LMSetMenuHook(MenuHookUPP value)																							TWOWORDINLINE(0x21DF, 0x0A30);

EXTERN_API( Handle ) LMGetTopMapHndl(void)																						TWOWORDINLINE(0x2EB8, 0x0A50);

EXTERN_API( void ) LMSetTopMapHndl(Handle value)																							TWOWORDINLINE(0x21DF, 0x0A50);

EXTERN_API( Handle ) LMGetSysMapHndl(void)																						TWOWORDINLINE(0x2EB8, 0x0A54);

EXTERN_API( void ) LMSetSysMapHndl(Handle value)																							TWOWORDINLINE(0x21DF, 0x0A54);

EXTERN_API( SInt16 ) LMGetSysMap(void)																						TWOWORDINLINE(0x3EB8, 0x0A58);

EXTERN_API( void ) LMSetSysMap(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x0A58);

EXTERN_API( SInt16 ) LMGetCurMap(void)																						TWOWORDINLINE(0x3EB8, 0x0A5A);

EXTERN_API( void ) LMSetCurMap(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x0A5A);

EXTERN_API( UInt8 ) LMGetResLoad(void)																						TWOWORDINLINE(0x1EB8, 0x0A5E);

EXTERN_API( void ) LMSetResLoad(UInt8 value)																							TWOWORDINLINE(0x11DF, 0x0A5E);

EXTERN_API( SInt16 ) LMGetResErr(void)																						TWOWORDINLINE(0x3EB8, 0x0A60);

EXTERN_API( void ) LMSetResErr(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x0A60);

EXTERN_API( UInt8 ) LMGetFScaleDisable(void)																						TWOWORDINLINE(0x1EB8, 0x0A63);

EXTERN_API( void ) LMSetFScaleDisable(UInt8 value)																							TWOWORDINLINE(0x11DF, 0x0A63);

EXTERN_API( UniversalProcPtr ) LMGetDeskHook(void)																						TWOWORDINLINE(0x2EB8, 0x0A6C);

EXTERN_API( void ) LMSetDeskHook(UniversalProcPtr value)																							TWOWORDINLINE(0x21DF, 0x0A6C);

EXTERN_API( UniversalProcPtr ) LMGetTEDoText(void)																						TWOWORDINLINE(0x2EB8, 0x0A70);

EXTERN_API( void ) LMSetTEDoText(UniversalProcPtr value)																							TWOWORDINLINE(0x21DF, 0x0A70);

EXTERN_API( UniversalProcPtr ) LMGetTERecal(void)																						TWOWORDINLINE(0x2EB8, 0x0A74);

EXTERN_API( void ) LMSetTERecal(UniversalProcPtr value)																							TWOWORDINLINE(0x21DF, 0x0A74);

EXTERN_API( UniversalProcPtr ) LMGetResumeProc(void)																						TWOWORDINLINE(0x2EB8, 0x0A8C);

EXTERN_API( void ) LMSetResumeProc(UniversalProcPtr value)																							TWOWORDINLINE(0x21DF, 0x0A8C);

EXTERN_API( SInt16 ) LMGetANumber(void)																						TWOWORDINLINE(0x3EB8, 0x0A98);

EXTERN_API( void ) LMSetANumber(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x0A98);

EXTERN_API( SInt16 ) LMGetACount(void)																						TWOWORDINLINE(0x3EB8, 0x0A9A);

EXTERN_API( void ) LMSetACount(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x0A9A);

EXTERN_API( UniversalProcPtr ) LMGetDABeeper(void)																						TWOWORDINLINE(0x2EB8, 0x0A9C);

EXTERN_API( void ) LMSetDABeeper(UniversalProcPtr value)																							TWOWORDINLINE(0x21DF, 0x0A9C);

EXTERN_API( UInt16 ) LMGetTEScrpLength(void)																						TWOWORDINLINE(0x3EB8, 0x0AB0);

EXTERN_API( void ) LMSetTEScrpLength(UInt16 value)																							TWOWORDINLINE(0x31DF, 0x0AB0);

EXTERN_API( Handle ) LMGetTEScrpHandle(void)																						TWOWORDINLINE(0x2EB8, 0x0AB4);

EXTERN_API( void ) LMSetTEScrpHandle(Handle value)																							TWOWORDINLINE(0x21DF, 0x0AB4);

EXTERN_API( Handle ) LMGetAppParmHandle(void)																						TWOWORDINLINE(0x2EB8, 0x0AEC);

EXTERN_API( void ) LMSetAppParmHandle(Handle value)																							TWOWORDINLINE(0x21DF, 0x0AEC);

EXTERN_API( SInt16 ) LMGetDSErrCode(void)																						TWOWORDINLINE(0x3EB8, 0x0AF0);

EXTERN_API( void ) LMSetDSErrCode(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x0AF0);

EXTERN_API( ResErrUPP ) LMGetResErrProc(void)																						TWOWORDINLINE(0x2EB8, 0x0AF2);

EXTERN_API( void ) LMSetResErrProc(ResErrUPP value)																							TWOWORDINLINE(0x21DF, 0x0AF2);

EXTERN_API( SInt16 ) LMGetDlgFont(void)																						TWOWORDINLINE(0x3EB8, 0x0AFA);

EXTERN_API( void ) LMSetDlgFont(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x0AFA);

EXTERN_API( Ptr ) LMGetWidthPtr(void)																						TWOWORDINLINE(0x2EB8, 0x0B10);

EXTERN_API( void ) LMSetWidthPtr(Ptr value)																							TWOWORDINLINE(0x21DF, 0x0B10);

EXTERN_API( Ptr ) LMGetATalkHk2(void)																						TWOWORDINLINE(0x2EB8, 0x0B18);

EXTERN_API( void ) LMSetATalkHk2(Ptr value)																							TWOWORDINLINE(0x21DF, 0x0B18);

EXTERN_API( SInt16 ) LMGetHWCfgFlags(void)																						TWOWORDINLINE(0x3EB8, 0x0B22);

EXTERN_API( void ) LMSetHWCfgFlags(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x0B22);

EXTERN_API( Handle ) LMGetWidthTabHandle(void)																						TWOWORDINLINE(0x2EB8, 0x0B2A);

EXTERN_API( void ) LMSetWidthTabHandle(Handle value)																							TWOWORDINLINE(0x21DF, 0x0B2A);

EXTERN_API( SInt32 ) LMGetLastSPExtra(void)																						TWOWORDINLINE(0x2EB8, 0x0B4C);

EXTERN_API( void ) LMSetLastSPExtra(SInt32 value)																							TWOWORDINLINE(0x21DF, 0x0B4C);

EXTERN_API( SInt32 ) LMGetMenuDisable(void)																						TWOWORDINLINE(0x2EB8, 0x0B54);

EXTERN_API( void ) LMSetMenuDisable(SInt32 value)																							TWOWORDINLINE(0x21DF, 0x0B54);

EXTERN_API( UInt8 ) LMGetROMMapInsert(void)																						TWOWORDINLINE(0x1EB8, 0x0B9E);

EXTERN_API( void ) LMSetROMMapInsert(UInt8 value)																							TWOWORDINLINE(0x11DF, 0x0B9E);

EXTERN_API( UInt8 ) LMGetTmpResLoad(void)																						TWOWORDINLINE(0x1EB8, 0x0B9F);

EXTERN_API( void ) LMSetTmpResLoad(UInt8 value)																							TWOWORDINLINE(0x11DF, 0x0B9F);

EXTERN_API( Ptr ) LMGetIntlSpec(void)																						TWOWORDINLINE(0x2EB8, 0x0BA0);

EXTERN_API( void ) LMSetIntlSpec(Ptr value)																							TWOWORDINLINE(0x21DF, 0x0BA0);

EXTERN_API( UInt8 ) LMGetWordRedraw(void)																						TWOWORDINLINE(0x1EB8, 0x0BA5);

EXTERN_API( void ) LMSetWordRedraw(UInt8 value)																							TWOWORDINLINE(0x11DF, 0x0BA5);

EXTERN_API( SInt16 ) LMGetSysFontFam(void)																						TWOWORDINLINE(0x3EB8, 0x0BA6);

EXTERN_API( void ) LMSetSysFontFam(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x0BA6);

EXTERN_API( SInt16 ) LMGetSysFontSize(void)																						TWOWORDINLINE(0x3EB8, 0x0BA8);

EXTERN_API( void ) LMSetSysFontSize(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x0BA8);

EXTERN_API( SInt16 ) LMGetMBarHeight(void)																						TWOWORDINLINE(0x3EB8, 0x0BAA);

EXTERN_API( void ) LMSetMBarHeight(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x0BAA);

EXTERN_API( SInt16 ) LMGetTESysJust(void)																						TWOWORDINLINE(0x3EB8, 0x0BAC);

EXTERN_API( void ) LMSetTESysJust(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x0BAC);

EXTERN_API( Handle ) LMGetLastFOND(void)																						TWOWORDINLINE(0x2EB8, 0x0BC2);

EXTERN_API( void ) LMSetLastFOND(Handle value)																							TWOWORDINLINE(0x21DF, 0x0BC2);

EXTERN_API( UInt8 ) LMGetFractEnable(void)																						TWOWORDINLINE(0x1EB8, 0x0BF4);

EXTERN_API( void ) LMSetFractEnable(UInt8 value)																							TWOWORDINLINE(0x11DF, 0x0BF4);

EXTERN_API( UInt8 ) LMGetMMU32Bit(void)																						TWOWORDINLINE(0x1EB8, 0x0CB2);

EXTERN_API( void ) LMSetMMU32Bit(UInt8 value)																							TWOWORDINLINE(0x11DF, 0x0CB2);

EXTERN_API( GDHandle ) LMGetTheGDevice(void)																						TWOWORDINLINE(0x2EB8, 0x0CC8);

EXTERN_API( void ) LMSetTheGDevice(GDHandle value)																							TWOWORDINLINE(0x21DF, 0x0CC8);

EXTERN_API( PixPatHandle ) LMGetDeskCPat(void)																						TWOWORDINLINE(0x2EB8, 0x0CD8);

EXTERN_API( void ) LMSetDeskCPat(PixPatHandle value)																							TWOWORDINLINE(0x21DF, 0x0CD8);

EXTERN_API( SInt16 ) LMGetTimeDBRA(void)																						TWOWORDINLINE(0x3EB8, 0x0D00);

EXTERN_API( void ) LMSetTimeDBRA(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x0D00);

EXTERN_API( SInt16 ) LMGetTimeSCCDB(void)																						TWOWORDINLINE(0x3EB8, 0x0D02);

EXTERN_API( void ) LMSetTimeSCCDB(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x0D02);

EXTERN_API( UniversalProcPtr ) LMGetJVBLTask(void)																						TWOWORDINLINE(0x2EB8, 0x0D28);

EXTERN_API( void ) LMSetJVBLTask(UniversalProcPtr value)																							TWOWORDINLINE(0x21DF, 0x0D28);

EXTERN_API( Handle ) LMGetSynListHandle(void)																						TWOWORDINLINE(0x2EB8, 0x0D32);

EXTERN_API( void ) LMSetSynListHandle(Handle value)																							TWOWORDINLINE(0x21DF, 0x0D32);

EXTERN_API( MCTableHandle ) LMGetMenuCInfo(void)																						TWOWORDINLINE(0x2EB8, 0x0D50);

EXTERN_API( void ) LMSetMenuCInfo(MCTableHandle value)																							TWOWORDINLINE(0x21DF, 0x0D50);

EXTERN_API( UniversalProcPtr ) LMGetJDTInstall(void)																						TWOWORDINLINE(0x2EB8, 0x0D9C);

EXTERN_API( void ) LMSetJDTInstall(UniversalProcPtr value)																							TWOWORDINLINE(0x21DF, 0x0D9C);

EXTERN_API( SInt16 ) LMGetTimeSCSIDB(void)																						TWOWORDINLINE(0x3EB8, 0x0B24);

EXTERN_API( void ) LMSetTimeSCSIDB(SInt16 value)																							TWOWORDINLINE(0x31DF, 0x0B24);


/**************************************************************************************

	MORE COMPLEX LOWMEM ACCESSORS

**************************************************************************************/
#if TARGET_CPU_68K && !TARGET_RT_MAC_CFM
/**************************************************************************************
	"BIG DATA"
	
		These lowmem accessors access big (> 4 bytes) values.
**************************************************************************************/
#define LMGetDSAlertRect(dsAlertRectValue)	(*(dsAlertRectValue) = * (Rect*) 0x03F8)
#define LMSetDSAlertRect(dsAlertRectValue)	((* (Rect *) 0x03F8) = *(dsAlertRectValue))
#define LMGetDragPattern(dragPatternValue)	(*(dragPatternValue) = * (Pattern *) 0x0A34)
#define LMSetDragPattern(dragPatternValue)	((* (Pattern *) 0x0A34) = *(dragPatternValue))
#define LMGetDeskPattern(deskPatternValue)	(*(deskPatternValue) = * (Pattern *) 0x0A3C)
#define LMSetDeskPattern(deskPatternValue)	((* (Pattern *) 0x0A3C) = *(deskPatternValue))
#define LMGetHiliteRGB(hiliteRGBValue)	(*(hiliteRGBValue) = *(RGBColor*)0x0DA0)
#define LMSetHiliteRGB(hiliteRGBValue)	((* (RGBColor *) 0x0DA0) = *(hiliteRGBValue))
#define LMGetEventQueue()	( (QHdrPtr) 0x014A)
#define LMSetEventQueue(eventQueueValue)	((* (QHdrPtr) 0x014A) = *(QHdrPtr)(eventQueueValue))
#define LMGetVBLQueue()	( (QHdrPtr) 0x0160)
#define LMSetVBLQueue(vblQueueValue)	((* (QHdrPtr) 0x0160) = *(QHdrPtr)(vblQueueValue))
#define LMGetDrvQHdr()	( (QHdrPtr) 0x0308)
#define LMSetDrvQHdr(drvQHdrValue)	((* (QHdrPtr) 0x0308) = *(QHdrPtr)(drvQHdrValue))
#define LMGetVCBQHdr()	( (QHdrPtr) 0x0356)
#define LMSetVCBQHdr(vcbQHdrValue)	((* (QHdrPtr) 0x0356) = *(QHdrPtr)(vcbQHdrValue))
#define LMGetDTQueue()	( (QHdrPtr) 0x0D92)
#define LMSetDTQueue(dtQueueValue)	((* (QHdrPtr) 0x0D92) = *(QHdrPtr)(dtQueueValue))
#define LMGetFSQHdr()	( (QHdrPtr) 0x0360)
/**************************************************************************************
	"BLOCKMOVE ACCESSORS"
	
		These lowmem accessors use the BlockMove trap
**************************************************************************************/
#define LMGetCurApName()	((StringPtr) 0x0910)
#define LMSetCurApName(curApNameValue)	(BlockMoveData((Ptr)(curApNameValue), (Ptr)0x0910, sizeof(Str31)))
#define LMGetSysResName()	( (StringPtr) 0x0AD8)
#define LMSetSysResName(sysResNameValue)	(BlockMoveData((Ptr)(sysResNameValue), (Ptr)0x0AD8, sizeof(Str15)))
#define LMGetFinderName()	((StringPtr)0x02E0)
#define LMSetFinderName(finderName)	(BlockMoveData((Ptr)(finderName), (Ptr)0x02E0, sizeof(Str15)))
#define LMGetScratch20()	((Ptr) 0x01E4)
#define LMSetScratch20(scratch20Value)	(BlockMoveData((Ptr) (scratch20Value), (Ptr) 0x01E4, 20))
#define LMGetToolScratch()	((Ptr) 0x09CE)
#define LMSetToolScratch(toolScratchValue)	(BlockMoveData((Ptr)(toolScratchValue), (Ptr) 0x09CE, 8))
#define LMGetApplScratch()	((Ptr) 0x0A78)
#define LMSetApplScratch(applScratchValue)	(BlockMoveData((Ptr) (applScratchValue), (Ptr) 0x0A78, 12))
/**************************************************************************************
	"INDEXED ACCESSORS"
	
		These lowmem accessors take an index parameter to get/set an indexed
		lowmem global.
**************************************************************************************/
#define LMGetDAStrings(whichString) ( ((StringHandle*)0x0AA0)[whichString] )
#define LMSetDAStrings(stringsValue, whichString) ( ((StringHandle*)0x0AA0)[whichString] = (stringsValue) )
#define LMGetLvl2DT(vectorNumber)	( ((UniversalProcPtr*)0x01B2)[vectorNumber] )
#define LMSetLvl2DT(lvl2DTValue, vectorNumber)	( ((UniversalProcPtr*)0x01B2)[vectorNumber] = (lvl2DTValue) )
#define LMGetExtStsDT(vectorNumber)	( ((UniversalProcPtr*)0x02BE)[vectorNumber] )
#define LMSetExtStsDT(extStsDTValue, vectorNumber)	( ((UniversalProcPtr*)0x02BE)[vectorNumber] = (extStsDTValue) )
#else
/**************************************************************************************
	"BIG DATA"
	
		These lowmem accessors access big (> 4 bytes) values.
**************************************************************************************/
EXTERN_API( void ) LMGetDSAlertRect(Rect *dsAlertRectValue);

EXTERN_API( void ) LMSetDSAlertRect(const Rect *dsAlertRectValue);

EXTERN_API( void ) LMGetDragPattern(Pattern *dragPatternValue);

EXTERN_API( void ) LMSetDragPattern(const Pattern *dragPatternValue);

EXTERN_API( void ) LMGetDeskPattern(Pattern *deskPatternValue);

EXTERN_API( void ) LMSetDeskPattern(const Pattern *deskPatternValue);

EXTERN_API( void ) LMGetHiliteRGB(RGBColor *hiliteRGBValue);

EXTERN_API( void ) LMSetHiliteRGB(const RGBColor *hiliteRGBValue);

EXTERN_API( QHdrPtr ) LMGetEventQueue(void );

EXTERN_API( void ) LMSetEventQueue(QHdrPtr eventQueueValue);

EXTERN_API( QHdrPtr ) LMGetVBLQueue(void );

EXTERN_API( void ) LMSetVBLQueue(QHdrPtr vblQueueValue);

EXTERN_API( QHdrPtr ) LMGetDrvQHdr(void );

EXTERN_API( void ) LMSetDrvQHdr(QHdrPtr drvQHdrValue);

EXTERN_API( QHdrPtr ) LMGetVCBQHdr(void );

EXTERN_API( void ) LMSetVCBQHdr(QHdrPtr vcbQHdrValue);

EXTERN_API( QHdrPtr ) LMGetDTQueue(void );

EXTERN_API( void ) LMSetDTQueue(QHdrPtr dtQueueValue);

EXTERN_API( QHdrPtr ) LMGetFSQHdr(void );

/**************************************************************************************
	"BLOCKMOVE ACCESSORS"
	
		These lowmem accessors use the BlockMove trap
**************************************************************************************/
EXTERN_API( StringPtr ) LMGetCurApName(void );

EXTERN_API( void ) LMSetCurApName(ConstStr31Param curApNameValue);

EXTERN_API( StringPtr ) LMGetSysResName(void );

EXTERN_API( void ) LMSetSysResName(ConstStr15Param sysResNameValue);

EXTERN_API( StringPtr ) LMGetFinderName(void );

EXTERN_API( void ) LMSetFinderName(ConstStr15Param finderNameValue);

EXTERN_API( Ptr ) LMGetScratch20(void );

EXTERN_API( void ) LMSetScratch20(const void *scratch20Value);

EXTERN_API( Ptr ) LMGetToolScratch(void );

EXTERN_API( void ) LMSetToolScratch(const void *toolScratchValue);

EXTERN_API( Ptr ) LMGetApplScratch(void );

EXTERN_API( void ) LMSetApplScratch(const void *applScratchValue);


/**************************************************************************************
	"INDEXED ACCESSORS"
	
		These lowmem accessors take an index parameter to get/set an indexed
		lowmem global.
**************************************************************************************/
EXTERN_API( StringHandle ) LMGetDAStrings(short whichString);

EXTERN_API( void ) LMSetDAStrings(StringHandle stringsValue, short whichString);

EXTERN_API( UniversalProcPtr ) LMGetLvl2DT(short vectorNumber);

EXTERN_API( void ) LMSetLvl2DT(UniversalProcPtr Lvl2DTValue, short vectorNumber);

EXTERN_API( UniversalProcPtr ) LMGetExtStsDT(short vectorNumber);

EXTERN_API( void ) LMSetExtStsDT(UniversalProcPtr ExtStsDTValue, short vectorNumber);

#endif  /* TARGET_CPU_68K &&  !TARGET_RT_MAC_CFM */

/**************************************************************************************
	"Missing Accessors"
	
		These lowmem accessors are not in InterfaceLib and were missing from
		previous versions of LowMem.h.  Because they are not in InterfaceLib,
		C macros were added to directly inline the accessors.
	
**************************************************************************************/
/* accesses "CrsrNew"*/
EXTERN_API( Boolean ) LMGetCursorNew(void)																						TWOWORDINLINE(0x1EB8, 0x08CE);

EXTERN_API( void ) LMSetCursorNew(Boolean value)																							TWOWORDINLINE(0x11DF, 0x08CE);

#define LMGetCursorNew()			(*((Boolean*)0x08CE))
#define LMSetCursorNew(changed)		((*(Boolean*)0x08CE) = (changed))

/* accesses "MBState"*/
EXTERN_API( UInt8 ) LMGetMouseButtonState(void)																						TWOWORDINLINE(0x1EB8, 0x0172);

EXTERN_API( void ) LMSetMouseButtonState(UInt8 value)																							TWOWORDINLINE(0x11DF, 0x0172);

#define LMGetMouseButtonState()			(*((UInt8*)0x0172))
#define LMSetMouseButtonState(state)	((*(UInt8*)0x0172) = (state))

/* accesses "MTemp"*/
EXTERN_API( Point ) LMGetMouseTemp(void)																						TWOWORDINLINE(0x2EB8, 0x0828);

EXTERN_API( void ) LMSetMouseTemp(Point value)																							TWOWORDINLINE(0x21DF, 0x0828);

#define LMGetMouseTemp()				(*((Point*)0x0828))
#define LMSetMouseTemp(location)		((*(Point*)0x0828) = (location))

/* accesses "RawMouse"*/
EXTERN_API( Point ) LMGetRawMouseLocation(void)																						TWOWORDINLINE(0x2EB8, 0x082C);

EXTERN_API( void ) LMSetRawMouseLocation(Point value)																							TWOWORDINLINE(0x21DF, 0x082C);

#define LMGetRawMouseLocation()				(*((Point*)0x082C))
#define LMSetRawMouseLocation(location)		((*(Point*)0x082C) = (location))

/* accesses "Mouse"*/
EXTERN_API( Point ) LMGetMouseLocation(void)																						TWOWORDINLINE(0x2EB8, 0x0830);

EXTERN_API( void ) LMSetMouseLocation(Point value)																							TWOWORDINLINE(0x21DF, 0x0830);

#define LMGetMouseLocation()				(*((Point*)0x0830))
#define LMSetMouseLocation(location)		((*(Point*)0x0830) = (location))

/* accesses "TheCrsr"*/
EXTERN_API_C( void ) LMGetTheCursor(Cursor *currentCursor);

EXTERN_API_C( void ) LMSetTheCursor(const Cursor *newCursor);

#define LMGetTheCursor(currentCursor)		((*currentCursor) = (*(Cursor*)0x0844))
#define LMSetTheCursor(newCursor)			((*(Cursor*)0x0844) = *(newCursor))

/* accesses "HiHeapMark"*/
EXTERN_API( Ptr ) LMGetHighHeapMark(void)																						TWOWORDINLINE(0x2EB8, 0x0BAE);

EXTERN_API( void ) LMSetHighHeapMark(Ptr value)																							TWOWORDINLINE(0x21DF, 0x0BAE);

#define LMGetHighHeapMark()			(*((Ptr*)0x0BAE))
#define LMSetHighHeapMark(mark)		((*(Ptr*)0x0BAE) = (mark))

/* accesses "StkLowPt"*/
EXTERN_API( Ptr ) LMGetStackLowPoint(void)																						TWOWORDINLINE(0x2EB8, 0x0110);

EXTERN_API( void ) LMSetStackLowPoint(Ptr value)																							TWOWORDINLINE(0x21DF, 0x0110);

#define LMGetStackLowPoint()		(*((Ptr*)0x0110))
#define LMSetStackLowPoint(p)		((*(Ptr*)0x0110) = (p))

/* accesses "ROMMapHndl"*/
EXTERN_API( Handle ) LMGetROMMapHandle(void)																						TWOWORDINLINE(0x2EB8, 0x0B06);

EXTERN_API( void ) LMSetROMMapHandle(Handle value)																							TWOWORDINLINE(0x21DF, 0x0B06);

#define LMGetROMMapHandle()			(*((Handle*)0x0B06))
#define LMSetROMMapHandle(h)		((*(Handle*)0x0B06) = (h))

/* accesses "UnitNtryCnt"*/
EXTERN_API( short ) LMGetUnitTableEntryCount(void)																						TWOWORDINLINE(0x3EB8, 0x01D2);

EXTERN_API( void ) LMSetUnitTableEntryCount(short value)																							TWOWORDINLINE(0x31DF, 0x01D2);

#define LMGetUnitTableEntryCount()		(*((short*)0x01D2))
#define LMSetUnitTableEntryCount(count)	((*(short*)0x01D2) = (count))

/* accesses "FmtDefaults"*/
EXTERN_API( Ptr ) LMGetDiskFormatingHFSDefaults(void)																						TWOWORDINLINE(0x2EB8, 0x039E);

EXTERN_API( void ) LMSetDiskFormatingHFSDefaults(Ptr value)																							TWOWORDINLINE(0x21DF, 0x039E);

#define LMGetDiskFormatingHFSDefaults()			(*((Ptr*)0x039E))
#define LMSetDiskFormatingHFSDefaults(default)	((*(Ptr*)0x039E) = (default))

/* accesses "PortAUse"*/
EXTERN_API( UInt8 ) LMGetPortAInfo(void)																						TWOWORDINLINE(0x1EB8, 0x0290);

EXTERN_API( void ) LMSetPortAInfo(UInt8 value)																							TWOWORDINLINE(0x11DF, 0x0290);

#define LMGetPortAInfo()		(*((UInt8*)0x0290))
#define LMSetPortAInfo(info)	((*(UInt8*)0x0290) = (info))





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

#endif /* __LOWMEM__ */

