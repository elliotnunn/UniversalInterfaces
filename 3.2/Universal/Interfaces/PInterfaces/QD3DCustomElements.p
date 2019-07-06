{
 	File:		QD3DCustomElements.p
 
 	Contains:	Custom QuickTime Elements in QuickDraw 3D							
 
 	Version:	Technology:	Quickdraw 3D 1.5.4
 				Release:	Universal Interfaces 3.2
 
 	Copyright:	© 1995-1998 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT QD3DCustomElements;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QD3DCUSTOMELEMENTS__}
{$SETC __QD3DCUSTOMELEMENTS__ := 1}

{$I+}
{$SETC QD3DCustomElementsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __QD3D__}
{$I QD3D.p}
{$ENDC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}


{*****************************************************************************
 **																			 **
 **						Custom Name Element Functions						 **
 **																			 **
 ****************************************************************************}
FUNCTION CENameElement_SetData(object: TQ3Object; name: ConstCStringPtr): TQ3Status; C;
FUNCTION CENameElement_GetData(object: TQ3Object; name: CStringPtrPtr): TQ3Status; C;
FUNCTION CENameElement_EmptyData(name: CStringPtrPtr): TQ3Status; C;

{*****************************************************************************
 **																			 **
 **							URL Data Structure Definitions					 **
 **																			 **
 ****************************************************************************}

TYPE
	TCEUrlOptions 				= LONGINT;
CONST
	kCEUrlOptionNone			= {TCEUrlOptions}0;
	kCEUrlOptionUseMap			= {TCEUrlOptions}1;


TYPE
	TCEUrlDataPtr = ^TCEUrlData;
	TCEUrlData = RECORD
		url:					CStringPtr;
		description:			CStringPtr;
		options:				TCEUrlOptions;
	END;

{*****************************************************************************
 **																			 **
 **						Custom URL Element Functions						 **
 **																			 **
 ****************************************************************************}
FUNCTION CEUrlElement_SetData(object: TQ3Object; VAR urlData: TCEUrlData): TQ3Status; C;
FUNCTION CEUrlElement_GetData(object: TQ3Object; VAR urlData: TCEUrlDataPtr): TQ3Status; C;
FUNCTION CEUrlElement_EmptyData(VAR urlData: TCEUrlDataPtr): TQ3Status; C;


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DCustomElementsIncludes}

{$ENDC} {__QD3DCUSTOMELEMENTS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
