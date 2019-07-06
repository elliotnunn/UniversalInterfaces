{
 	File:		PCCardAdapterPlugin.p
 
 	Contains:	PC Card Socket Service Plug-In Programming Interface
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1996-1997 by Apple Computer, Inc. and SystemSoft Corporation. All rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT PCCardAdapterPlugin;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __PCCARDADAPTERPLUGIN__}
{$SETC __PCCARDADAPTERPLUGIN__ := 1}

{$I+}
{$SETC PCCardAdapterPluginIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{$IFC UNDEFINED __NAMEREGISTRY__}
{$I NameRegistry.p}
{$ENDC}
{$IFC UNDEFINED __INTERRUPTS__}
{$I Interrupts.p}
{$ENDC}
{$IFC UNDEFINED __PCCARD__}
{$I PCCard.p}
{$ENDC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}


{------------------------------------------------------------------------------------
  Types
------------------------------------------------------------------------------------}
{ 	Interrupt Status Change bits }


CONST
	kSCBatteryDead				= $01;							{  Battery Dead Status Change }
	kSCBatteryLow				= $02;							{  Battery Warning Status Change }
	kSCReady					= $04;							{  Ready Status Change }
	kSCCardDetect				= $08;							{  Card Detect Status Change }
	kSCCardEjected				= $10;							{  Card Ejected }
	kSCStatusChange				= $20;							{  PC Card Status Change Signal Asserted }
	kSCRingIndicate				= $40;							{  PC Card Ring Indicate Signal Asserted }


{	IRQ bits }
	kIRQLevelMask				= $1F;
	kIRQInvalid					= $20;
	kIRQHigh					= $40;
	kIRQEnable					= $80;


{ 	bits for adapter characteristics flags }

	SS_ADPT_FLG_IND				= $01;							{  indicators for write-protect, card lock, }
																{  battery status, busy status, and XIP }
																{  are shared for all sockets }
	SS_ADPT_FLG_PWR				= $02;							{  if set indicates that the sockets }
																{  share the same power control }
	SS_ADPT_FLG_DBW				= $04;							{  all windows on the adapter must use }
																{  the same Data Bus Width }
	SS_ADPT_FLG_CARDBUS			= $08;							{  all sockets are CardBus PC Card capable }
	SS_ADPT_FLG_DMA				= $10;							{  the adapter has DMA capability }
																{ 	bits for adapter power characteristics }
	SS_ADPT_FLG_V33				= $20;							{  adapter supports 3.3 volt power to socket }
	SS_ADPT_FLG_V50				= $40;							{  adapter supports 5.0 volt power to socket }
	SS_ADPT_FLG_V12				= $80;							{  adapter supports 12.0 volt power to socket }


{------------------------------------------------------------------------------------
  Calls exported by the Family
------------------------------------------------------------------------------------}
FUNCTION CSReportStatusChange({CONST}VAR adapterRef: RegEntryID; whichSocket: PCCardSocket; statusChange: PCCardSCEvents; socketStatus: PCCardSocketStatus): OSStatus; C;
{------------------------------------------------------------------------------------
  Plugin Dispatch Table
------------------------------------------------------------------------------------}

TYPE
	SSValidateHardwareProc = ProcPtr;  { FUNCTION SSValidateHardwareProc((CONST)VAR deviceID: RegEntryID): OSStatus; C; }

	SSInitializeProc = ProcPtr;  { FUNCTION SSInitializeProc((CONST)VAR deviceID: RegEntryID; replacingOldDriver: BOOLEAN): OSStatus; C; }

	SSSuspendProc = ProcPtr;  { FUNCTION SSSuspendProc((CONST)VAR deviceID: RegEntryID): OSStatus; C; }

	SSResumeProc = ProcPtr;  { FUNCTION SSResumeProc((CONST)VAR deviceID: RegEntryID): OSStatus; C; }

	SSFinalizeProc = ProcPtr;  { FUNCTION SSFinalizeProc((CONST)VAR deviceID: RegEntryID; beingReplaced: BOOLEAN): OSStatus; C; }

	SSInquireAdapterProc = ProcPtr;  { FUNCTION SSInquireAdapterProc(VAR numberOfSockets: ItemCount; VAR numberOfWindows: ItemCount; VAR numberOfBridgeWindow: ItemCount; VAR capabilities: PCCardAdapterCapabilities): OSStatus; C; }

	SSInquireSocketProc = ProcPtr;  { FUNCTION SSInquireSocketProc(socket: PCCardSocket; VAR numberOfWindows: ItemCount; VAR supportedSocketStatus: PCCardSocketStatus; VAR supportedStatusChange: PCCardSCEvents): OSStatus; C; }

	SSGetSocketProc = ProcPtr;  { FUNCTION SSGetSocketProc(socket: PCCardSocket; VAR Vcc: PCCardVoltage; VAR Vpp: PCCardVoltage; VAR Vs: PCCardVoltage; VAR socketIF: PCCardInterfaceType; VAR customIFID: PCCardCustomInterfaceID; VAR socketStatus: PCCardSocketStatus; VAR SCEventsMask: PCCardSCEvents; VAR IRQ: PCCardIRQ; VAR DMA: PCCardDMA): OSStatus; C; }

	SSSetSocketProc = ProcPtr;  { FUNCTION SSSetSocketProc(socket: PCCardSocket; Vcc: PCCardVoltage; Vpp: PCCardVoltage; socketIF: PCCardInterfaceType; customIFID: PCCardCustomInterfaceID; statusReset: PCCardSocketStatus; SCEventsMask: PCCardSCEvents; IRQ: PCCardIRQ; DMA: PCCardDMA): OSStatus; C; }

	SSResetSocketProc = ProcPtr;  { FUNCTION SSResetSocketProc(socket: PCCardSocket): OSStatus; C; }

	SSGetStatusProc = ProcPtr;  { FUNCTION SSGetStatusProc(socket: PCCardSocket; VAR currentStatus: PCCardSocketStatus; VAR changedStatus: PCCardSocketStatus): OSStatus; C; }

	SSInquireWindowProc = ProcPtr;  { FUNCTION SSInquireWindowProc(VAR socket: PCCardSocket; window: PCCardWindow; VAR windowState: PCCardWindowState; VAR windowSize: PCCardWindowSize; VAR windowAlign: PCCardWindowAlign): OSStatus; C; }

	SSGetWindowProc = ProcPtr;  { FUNCTION SSGetWindowProc(VAR socket: PCCardSocket; window: PCCardWindow; VAR windowState: PCCardWindowState; VAR startAddress: PhysicalAddress; VAR windowSize: PCCardWindowSize; VAR windowOffset: PCCardWindowOffset; VAR memSpeed: PCCardAccessSpeed): OSStatus; C; }

	SSSetWindowProc = ProcPtr;  { FUNCTION SSSetWindowProc(socket: PCCardSocket; window: PCCardWindow; windowState: PCCardWindowState; startAddress: PhysicalAddress; windowSize: PCCardWindowSize; windowOffset: PCCardWindowOffset; memSpeed: PCCardAccessSpeed): OSStatus; C; }

	SSGetWindowOffsetProc = ProcPtr;  { FUNCTION SSGetWindowOffsetProc(VAR socket: PCCardSocket; window: PCCardWindow; VAR windowState: PCCardWindowState; VAR windowOffset: PCCardWindowOffset): OSStatus; C; }

	SSSetWindowOffsetProc = ProcPtr;  { FUNCTION SSSetWindowOffsetProc(socket: PCCardSocket; window: PCCardWindow; windowState: PCCardWindowState; windowOffset: PCCardWindowOffset): OSStatus; C; }

	SSInquireBridgeWindowProc = ProcPtr;  { FUNCTION SSInquireBridgeWindowProc(VAR socket: PCCardSocket; window: PCCardWindow; VAR windowState: PCCardWindowState; VAR windowSize: PCCardWindowSize; VAR windowAlign: PCCardWindowAlign): OSStatus; C; }

	SSGetBridgeWindowProc = ProcPtr;  { FUNCTION SSGetBridgeWindowProc(VAR socket: PCCardSocket; window: PCCardWindow; VAR windowState: PCCardWindowState; VAR startAddress: PhysicalAddress; VAR windowSize: PCCardWindowSize): OSStatus; C; }

	SSSetBridgeWindowProc = ProcPtr;  { FUNCTION SSSetBridgeWindowProc(socket: PCCardSocket; window: PCCardWindow; windowState: PCCardWindowState; startAddress: PhysicalAddress; windowSize: PCCardWindowSize): OSStatus; C; }

	SSGetInterruptSetMemberProc = ProcPtr;  { FUNCTION SSGetInterruptSetMemberProc(socket: PCCardSocket; VAR interruptSetMember: InterruptSetMember): OSStatus; C; }

	SSEjectCardProc = ProcPtr;  { FUNCTION SSEjectCardProc(socket: PCCardSocket): OSStatus; C; }


CONST
	kServiceTypePCCardAdapter	= 'sock';
	kPCCardAdapterPluginVersion	= $00000001;
	kPCCardAdapterPluginCurrentVersion = $00000001;


TYPE
	PCCardAdapterPluginHeaderPtr = ^PCCardAdapterPluginHeader;
	PCCardAdapterPluginHeader = RECORD
		version:				UInt32;
		reserved1:				UInt32;
		reserved2:				UInt32;
		reserved3:				UInt32;
	END;

	PCCardAdapterPluginDispatchTablePtr = ^PCCardAdapterPluginDispatchTable;
	PCCardAdapterPluginDispatchTable = RECORD
		header:					PCCardAdapterPluginHeader;
		validateHardware:		SSValidateHardwareProc;
		initialize:				SSInitializeProc;
		suspend:				SSSuspendProc;
		resume:					SSResumeProc;
		finalize:				SSFinalizeProc;
		inquireAdapter:			SSInquireAdapterProc;
		inquireSocket:			SSInquireSocketProc;
		getSocket:				SSGetSocketProc;
		setSocket:				SSSetSocketProc;
		resetSocket:			SSResetSocketProc;
		getStatus:				SSGetStatusProc;
		inquireWindow:			SSInquireWindowProc;
		getWindow:				SSGetWindowProc;
		setWindow:				SSSetWindowProc;
		getWindowOffset:		SSGetWindowOffsetProc;
		setWindowOffset:		SSSetWindowOffsetProc;
		inquireBridgeWindow:	SSInquireBridgeWindowProc;
		getBridgeWindow:		SSGetBridgeWindowProc;
		setBridgeWindow:		SSSetBridgeWindowProc;
		getInterruptSetMember:	SSGetInterruptSetMemberProc;
		ejectCard:				SSEjectCardProc;
	END;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := PCCardAdapterPluginIncludes}

{$ENDC} {__PCCARDADAPTERPLUGIN__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
