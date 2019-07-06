{
 	File:		CommResources.p
 
 	Contains:	Communications Toolbox Resource Manager Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1988-1993, 1995-1999 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CommResources;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __COMMRESOURCES__}
{$SETC __COMMRESOURCES__ := 1}

{$I+}
{$SETC CommResourcesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __OSUTILS__}
{$I OSUtils.p}
{$ENDC}
{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
																{ 	tool classes (also the tool file types)	 }
	classCM						= 'cbnd';
	classFT						= 'fbnd';
	classTM						= 'tbnd';

																{ 	version of the Comm Resource Manager	 }
	curCRMVersion				= 2;							{  constants general to the use of the Communications Resource Manager  }
	crmType						= 9;							{  queue type	 }
	crmRecVersion				= 1;							{  version of queue structure  }
																{ 	error codes  }
	crmGenericError				= -1;
	crmNoErr					= 0;

{ data structures general to the use of the Communications Resource Manager }

TYPE
	CRMErr								= OSErr;
	CRMRecPtr = ^CRMRec;
	CRMRec = RECORD
		qLink:					QElemPtr;								{ reserved }
		qType:					INTEGER;								{ queue type -- ORD(crmType) = 9 }
		crmVersion:				INTEGER;								{ version of queue element data structure }
		crmPrivate:				LONGINT;								{ reserved }
		crmReserved:			INTEGER;								{ reserved }
		crmDeviceType:			LONGINT;								{ type of device, assigned by DTS }
		crmDeviceID:			LONGINT;								{ device ID; assigned when CRMInstall is called }
		crmAttributes:			LONGINT;								{ pointer to attribute block }
		crmStatus:				LONGINT;								{ status variable - device specific }
		crmRefCon:				LONGINT;								{ for device private use }
	END;

{$IFC CALL_NOT_IN_CARBON }
FUNCTION InitCRM: CRMErr;
FUNCTION CRMGetHeader: QHdrPtr;
PROCEDURE CRMInstall(crmReqPtr: CRMRecPtr);
FUNCTION CRMRemove(crmReqPtr: CRMRecPtr): OSErr;
FUNCTION CRMSearch(crmReqPtr: CRMRecPtr): CRMRecPtr;
FUNCTION CRMGetCRMVersion: INTEGER;
FUNCTION CRMGetResource(theType: ResType; theID: INTEGER): Handle;
FUNCTION CRMGet1Resource(theType: ResType; theID: INTEGER): Handle;
FUNCTION CRMGetIndResource(theType: ResType; index: INTEGER): Handle;
FUNCTION CRMGet1IndResource(theType: ResType; index: INTEGER): Handle;
FUNCTION CRMGetNamedResource(theType: ResType; name: Str255): Handle;
FUNCTION CRMGet1NamedResource(theType: ResType; name: Str255): Handle;
PROCEDURE CRMReleaseResource(theHandle: Handle);
FUNCTION CRMGetToolResource(procID: INTEGER; theType: ResType; theID: INTEGER): Handle;
FUNCTION CRMGetToolNamedResource(procID: INTEGER; theType: ResType; name: Str255): Handle;
PROCEDURE CRMReleaseToolResource(procID: INTEGER; theHandle: Handle);
FUNCTION CRMGetIndex(theHandle: Handle): LONGINT;
FUNCTION CRMLocalToRealID(bundleType: ResType; toolID: INTEGER; theType: ResType; localID: INTEGER): INTEGER;
FUNCTION CRMRealToLocalID(bundleType: ResType; toolID: INTEGER; theType: ResType; realID: INTEGER): INTEGER;
FUNCTION CRMGetIndToolName(bundleType: OSType; index: INTEGER; VAR toolName: Str255): OSErr;
FUNCTION CRMFindCommunications(VAR vRefNum: INTEGER; VAR dirID: LONGINT): OSErr;
FUNCTION CRMIsDriverOpen(driverName: Str255): BOOLEAN;
FUNCTION CRMParseCAPSResource(theHandle: Handle; selector: ResType; VAR value: UInt32): CRMErr;
FUNCTION CRMReserveRF(refNum: INTEGER): OSErr;
FUNCTION CRMReleaseRF(refNum: INTEGER): OSErr;
{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CommResourcesIncludes}

{$ENDC} {__COMMRESOURCES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
