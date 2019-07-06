{
 	File:		CryptoMessageSyntax.p
 
 	Contains:	CMS Interfaces.
 
 	Version:	Technology:	1.0
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1999 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CryptoMessageSyntax;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CRYPTOMESSAGESYNTAX__}
{$SETC __CRYPTOMESSAGESYNTAX__ := 1}

{$I+}
{$SETC CryptoMessageSyntaxIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __CFARRAY__}
{$I CFArray.p}
{$ENDC}
{$IFC UNDEFINED __CFBAG__}
{$I CFBag.p}
{$ENDC}
{$IFC UNDEFINED __CFDATA__}
{$I CFData.p}
{$ENDC}
{$IFC UNDEFINED __CFDATE__}
{$I CFDate.p}
{$ENDC}
{$IFC UNDEFINED __CFSET__}
{$I CFSet.p}
{$ENDC}
{$IFC UNDEFINED __CFSTRING__}
{$I CFString.p}
{$ENDC}
{$IFC UNDEFINED __KEYCHAIN__}
{$I Keychain.p}
{$ENDC}

{
	Data structures and types
}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	SecTypeRef = ^LONGINT; { an opaque 32-bit type }
	SecSignerRef = ^LONGINT; { an opaque 32-bit type }
{ Signer object manipulation }
FUNCTION SecSignerGetStatus(signer: SecSignerRef): OSStatus;
FUNCTION SecRetain(sec: SecTypeRef): SecTypeRef;
PROCEDURE SecRelease(sec: SecTypeRef);
FUNCTION SecRetainCount(sec: SecTypeRef): UInt32;
{ Errors Codes  }

CONST
	errSecUnsupported			= -13843;
	errSecInvalidData			= -13844;
	errSecTooMuchData			= -13845;
	errSecMissingData			= -13846;
	errSecNoSigners				= -13847;
	errSecSignerFailed			= -13848;
	errSecInvalidPolicy			= -13849;
	errSecUnknownPolicy			= -13850;
	errSecInvalidStopOn			= -13851;
	errSecMissingCert			= -13852;
	errSecInvalidCert			= -13853;
	errSecNotSigner				= -13854;
	errSecNotTrusted			= -13855;
	errSecMissingAttribute		= -13856;
	errSecMissingDigest			= -13857;
	errSecDigestMismatch		= -13858;
	errSecInvalidSignature		= -13859;
	errSecAlgMismatch			= -13860;
	errSecUnsupportedAlgorithm	= -13864;
	errSecContentTypeMismatch	= -13865;
	errSecDebugRoot				= -13866;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CryptoMessageSyntaxIncludes}

{$ENDC} {__CRYPTOMESSAGESYNTAX__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
