{
 	File:		OpenTptSerial.p
 
 	Contains:	Definitions for Serial Port
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT OpenTptSerial;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OPENTPTSERIAL__}
{$SETC __OPENTPTSERIAL__ := 1}

{$I+}
{$SETC OpenTptSerialIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __OPENTRANSPORT__}
{$I OpenTransport.p}
{$ENDC}
{	Types.p														}
{		ConditionalMacros.p										}
{	MixedMode.p													}
{	Strings.p													}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	COM_SERIAL					= 'SERL';

{}
{ Version Number}
{}
	kSerialABVersion	=	'1.0';
{}
{ Module Names}
{}
	kSerialABName	=	'serialAB';
	kSerialName		=	'serial';
	kSerialPortAName	=	'serialA';
	kSerialPortBName	=	'serialB';
	kSerialABModuleID			= 7200;

	kOTSerialFramingAsync		= $01;							{ Support Async serial mode 			}
	kOTSerialFramingHDLC		= $02;							{ Support HDLC synchronous serial mode	}
	kOTSerialFramingSDLC		= $04;							{ Support SDLC synchronous serial mode	}
	kOTSerialFramingAsyncPackets = $08;							{ Support Async "packet" serial mode	}

{******************************************************************************
** IOCTL Calls for Serial Drivers
*******************************************************************************}
{ 
	 * Set DTR (0 = off, 1 = on)
	 }
	I_SetSerialDTR				= 0+(MIOC_SRL_HIGH + 0);
	kOTSerialSetDTROff			= 0;
	kOTSerialSetDTROn			= 1;
{
	 * Send a break on the line - kOTSerialSetBreakOff = off, kOTSerialSetBreakOn = on,
	 * Any other number is the number of milliseconds to leave break on, then
	 * auto shutoff
	 }
	I_SetSerialBreak			= 0+(MIOC_SRL_HIGH + 1);
	kOTSerialSetBreakOn			= $ffffffff;
	kOTSerialSetBreakOff		= 0;
{
	 * Force XOFF state - 0 = Unconditionally clear XOFF state, 1 = unconditionally set it
	 }
	I_SetSerialXOffState		= 0+(MIOC_SRL_HIGH + 2);
	kOTSerialForceXOffTrue		= 1;
	kOTSerialForceXOffFalse		= 0;
{
	 * Send an XON character
	 * 0 = send only if in XOFF state, 1 = send always
	 }
	I_SetSerialXOn				= 0+(MIOC_SRL_HIGH + 3);
	kOTSerialSendXOnAlways		= 1;
	kOTSerialSendXOnIfXOffTrue	= 0;
{
	 * Send an XOFF character
	 * 0 = send only if in XON state, 1 = send always
	 }
	I_SetSerialXOff				= 0+(MIOC_SRL_HIGH + 4);
	kOTSerialSendXOffAlways		= 1;
	kOTSerialSendXOffIfXOnTrue	= 0;

{******************************************************************************
** Option Management for Serial Drivers
*******************************************************************************}
{
** These options are all 4-byte values.
** BaudRate is the baud rate.
** DataBits is the number of data bits.
** StopBits is the number of stop bits times 10.
** Parity is an enum
}
	SERIAL_OPT_BAUDRATE			= $0100;						{ UInt32	}
	SERIAL_OPT_DATABITS			= $0101;						{ UInt32	}
	SERIAL_OPT_STOPBITS			= $0102;						{ UInt32 10, 15 or 20 for 1, 1.5 or 2	}
	SERIAL_OPT_PARITY			= $0103;						{ UInt32	}

	kOTSerialNoParity			= 0;
	kOTSerialOddParity			= 1;
	kOTSerialEvenParity			= 2;

{}
{ The "Status" option is a 4-byte value option that is ReadOnly}
{ It returns a bitmap of the current serial status}
{}
	SERIAL_OPT_STATUS			= $0104;
	kOTSerialSwOverRunErr		= $01;
	kOTSerialBreakOn			= $08;
	kOTSerialParityErr			= $10;
	kOTSerialOverrunErr			= $20;
	kOTSerialFramingErr			= $40;
	kOTSerialXOffSent			= $0010000;
	kOTSerialDTRNegated			= $0020000;
	kOTSerialCTLHold			= $0040000;
	kOTSerialXOffHold			= $0080000;
	kOTSerialOutputBreakOn		= $1000000;

{}
{ The "Handshake" option defines what kind of handshaking the serial port}
{ will do for line flow control.  The value is a 32-bit value defined by}
{ the function or macro SerialHandshakeData below.}
{ For no handshake, or CTS handshake, the onChar and offChar parameters}
{ are ignored.}
{}
	SERIAL_OPT_HANDSHAKE		= $0105;

{}
{ These are bits to enable specific types of handshaking}
{}
	kOTSerialXOnOffInputHandshake = 1;							{ Want XOn/XOff handshake for incoming characters	}
	kOTSerialXOnOffOutputHandshake = 2;							{ Want XOn/XOff handshake for outgoing characters	}
	kOTSerialCTSInputHandshake	= 4;							{ Want CTS handshake for incoming characters		}
	kOTSerialDTROutputHandshake	= 8;							{ Want DTR handshake for outoing characters		}

	SERIAL_OPT_RCVTIMEOUT		= $0106;

{}
{ This option defines how characters with parity errors are handled.}
{ A 0 value will disable all replacement.  A single character value in the low}
{ byte designates the replacement character.  When characters are received with a }
{ parity error, they are replaced by this specified character.  If a valid incoming}
{ character matches the replacement character, then the received character's msb is}
{ cleared. For this situation, the alternate character is used, if specified in bits}
{ 8 through 15 of the option long, with 0xff being place in bits 16 through 23.}
{ Whenever a valid character is received that matches the first replacement character,}
{ it is replaced with this alternate character.}
{}
	SERIAL_OPT_ERRORCHARACTER	= $0107;

	SERIAL_OPT_EXTCLOCK			= $0108;

{}
{ The "BurstMode" option informs the serial driver that it should continue looping,}
{ reading incoming characters, rather than waiting for an interrupt for each character.}
{ This option may not be supported by all Serial driver}
{}
	SERIAL_OPT_BURSTMODE		= $0109;

{}
{ Default attributes for the serial ports}
{}
	kOTSerialDefaultBaudRate	= 19200;
	kOTSerialDefaultDataBits	= 8;
	kOTSerialDefaultStopBits	= 10;
	kOTSerialDefaultParity		= kOTSerialNoParity;
	kOTSerialDefaultHandshake	= 0;
	kOTSerialDefaultOnChar		= $11;							{ Control-Q}
	kOTSerialDefaultOffChar		= $13;							{ Control-S}
	kOTSerialDefaultSndBufSize	= 128;
	kOTSerialDefaultRcvBufSize	= 128;
	kOTSerialDefaultSndLoWat	= 96;
	kOTSerialDefaultRcvLoWat	= 1;
	kOTSerialDefaultRcvTimeout	= 4;


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := OpenTptSerialIncludes}

{$ENDC} {__OPENTPTSERIAL__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
