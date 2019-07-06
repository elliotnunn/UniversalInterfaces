{
 	File:		FileTransferTools.p
 
 	Contains:	CommToolbox File Transfer Tools Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1988-1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT FileTransferTools;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __FILETRANSFERTOOLS__}
{$SETC __FILETRANSFERTOOLS__ := 1}

{$I+}
{$SETC FileTransferToolsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}
{$IFC UNDEFINED __FILETRANSFERS__}
{$I FileTransfers.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
																{  DEFs  }
	fdefType					= 'fdef';
	fsetType					= 'fset';
	fvalType					= 'fval';
	flocType					= 'floc';
	fscrType					= 'fscr';
	fbndType					= 'fbnd';
	fverType					= 'vers';

																{  control  }
	ftInitMsg					= 0;
	ftDisposeMsg				= 1;
	ftSuspendMsg				= 2;
	ftResumeMsg					= 3;
	ftMenuMsg					= 4;
	ftEventMsg					= 5;
	ftActivateMsg				= 6;
	ftDeactivateMsg				= 7;
	ftGetErrorStringMsg			= 8;
	ftAbortMsg					= 52;
	ftStartMsg					= 100;
	ftExecMsg					= 102;
	ftSendMsg					= 103;
	ftReceiveMsg				= 104;

																{  setup  }
	ftSpreflightMsg				= 0;
	ftSsetupMsg					= 1;
	ftSitemMsg					= 2;
	ftSfilterMsg				= 3;
	ftScleanupMsg				= 4;

																{  validate  }
	ftValidateMsg				= 0;
	ftDefaultMsg				= 1;

																{  scripting  }
	ftMgetMsg					= 0;
	ftMsetMsg					= 1;

																{  localization  }
	ftL2English					= 0;
	ftL2Intl					= 1;


TYPE
	FTSetupStructPtr = ^FTSetupStruct;
	FTSetupStruct = RECORD
		theDialog:				DialogPtr;								{  the dialog form the application  }
		count:					INTEGER;								{  first appended item  }
		theConfig:				Ptr;									{  the config record to setup  }
		procID:					INTEGER;								{  procID of the tool  }
	END;

	FTSetupPtr							= ^FTSetupStruct;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := FileTransferToolsIncludes}

{$ENDC} {__FILETRANSFERTOOLS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}