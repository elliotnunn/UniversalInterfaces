{
     File:       QD3DString.p
 
     Contains:   Q3CString methods
 
     Version:    Technology: Quickdraw 3D 1.6
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1995-2000 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT QD3DString;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QD3DSTRING__}
{$SETC __QD3DSTRING__ := 1}

{$I+}
{$SETC QD3DStringIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __QD3D__}
{$I QD3D.p}
{$ENDC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{*****************************************************************************
 **                                                                          **
 **                             String Routines                              **
 **                                                                          **
 ****************************************************************************}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION Q3String_GetType(stringObj: TQ3StringObject): TQ3ObjectType; C;

{*****************************************************************************
 **                                                                          **
 **                     C String Routines                                    **
 **                                                                          **
 ****************************************************************************}
FUNCTION Q3CString_New(str: ConstCStringPtr): TQ3StringObject; C;
FUNCTION Q3CString_GetLength(stringObj: TQ3StringObject; VAR length: UInt32): TQ3Status; C;
FUNCTION Q3CString_SetString(stringObj: TQ3StringObject; str: ConstCStringPtr): TQ3Status; C;
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
FUNCTION Q3CString_GetString(stringObj: TQ3StringObject; VAR str: CStringPtr): TQ3Status; C;
FUNCTION Q3CString_EmptyData(VAR str: CStringPtr): TQ3Status; C;
{$ENDC}  {CALL_NOT_IN_CARBON}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DStringIncludes}

{$ENDC} {__QD3DSTRING__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
