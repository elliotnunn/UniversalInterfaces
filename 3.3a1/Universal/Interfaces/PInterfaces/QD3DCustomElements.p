{
 	File:		QD3DCustomElements.p
 
 	Contains:	Custom QuickTime Elements in QuickDraw 3D							
 
 	Version:	Technology:	Quickdraw 3D 1.6
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1995-1999 by Apple Computer, Inc., all rights reserved.
 
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
{$IFC UNDEFINED __MOVIES__}
{$I Movies.p}
{$ENDC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}


{*****************************************************************************
 **																			 **
 **						Custom Name Element Functions						 **
 **																			 **
 ****************************************************************************}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION CENameElement_SetData(object: TQ3Object; name: ConstCStringPtr): TQ3Status; C;
FUNCTION CENameElement_GetData(object: TQ3Object; VAR name: CStringPtr): TQ3Status; C;
FUNCTION CENameElement_EmptyData(VAR name: CStringPtr): TQ3Status; C;

{*****************************************************************************
 **																			 **
 **							URL Data Structure Definitions					 **
 **																			 **
 ****************************************************************************}
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	TCEUrlOptions 				= SInt32;
CONST
	kCEUrlOptionNone			= 0;
	kCEUrlOptionUseMap			= 1;


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
{$IFC CALL_NOT_IN_CARBON }
FUNCTION CEUrlElement_SetData(object: TQ3Object; VAR urlData: TCEUrlData): TQ3Status; C;
FUNCTION CEUrlElement_GetData(object: TQ3Object; VAR urlData: TCEUrlDataPtr): TQ3Status; C;
FUNCTION CEUrlElement_EmptyData(VAR urlData: TCEUrlDataPtr): TQ3Status; C;
{*****************************************************************************
 **																			 **
 **							Wire Data Definitions							 **
 **																			 **
 ****************************************************************************}

{*****************************************************************************
 **																			 **
 **						Wire Custom Element Functions						 **
 **																			 **
 ****************************************************************************}
FUNCTION CEWireElement_SetData(object: TQ3Object; wireData: QTAtomContainer): TQ3Status; C;
FUNCTION CEWireElement_GetData(object: TQ3Object; VAR wireData: QTAtomContainer): TQ3Status; C;
FUNCTION CEWireElement_EmptyData(VAR wireData: QTAtomContainer): TQ3Status; C;


{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DCustomElementsIncludes}

{$ENDC} {__QD3DCUSTOMELEMENTS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
