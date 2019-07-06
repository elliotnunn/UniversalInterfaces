{
 	File:		QD3DSet.p
 
 	Contains:	Q3Set types and routines											
 
 	Version:	Technology:	Quickdraw 3D 1.5.1
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1995-1997 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT QD3DSet;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QD3DSET__}
{$SETC __QD3DSET__ := 1}

{$I+}
{$SETC QD3DSetIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __QD3D__}
{$I QD3D.p}
{$ENDC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{*****************************************************************************
 **																			 **
 **								Set Routines								 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3Set_New: TQ3SetObject; C;
FUNCTION Q3Set_GetType(theSet: TQ3SetObject): LONGINT; C;
FUNCTION Q3Set_Add(theSet: TQ3SetObject; theType: TQ3ElementType; data: UNIV Ptr): TQ3Status; C;
FUNCTION Q3Set_Get(theSet: TQ3SetObject; theType: TQ3ElementType; data: UNIV Ptr): TQ3Status; C;
FUNCTION Q3Set_Contains(theSet: TQ3SetObject; theType: TQ3ElementType): TQ3Boolean; C;
FUNCTION Q3Set_Clear(theSet: TQ3SetObject; theType: TQ3ElementType): TQ3Status; C;
FUNCTION Q3Set_Empty(target: TQ3SetObject): TQ3Status; C;
{
 *  Iterating through all elements in a set
 *
 *  Pass in kQ3ElementTypeNone to get first type
 *  kQ3ElementTypeNone is returned when end of list is reached
 }
FUNCTION Q3Set_GetNextElementType(theSet: TQ3SetObject; VAR theType: TQ3ElementType): TQ3Status; C;

{*****************************************************************************
 **																			 **
 **								Attribute Types								 **
 **																			 **
 ****************************************************************************}
{ 
 *	For the data types listed below, pass in a pointer to it in the _Add 
 *	and _Get calls.
 *
 *	For surface shader attributes, reference counts are incremented on 
 *	the _Add and _Get 
 }

TYPE
	TQ3AttributeTypes 			= LONGINT;
CONST
																{  Data Type				 }
	kQ3AttributeTypeNone		= {TQ3AttributeTypes}0;			{  ---------				 }
	kQ3AttributeTypeSurfaceUV	= {TQ3AttributeTypes}1;			{  TQ3Param2D				 }
	kQ3AttributeTypeShadingUV	= {TQ3AttributeTypes}2;			{  TQ3Param2D 				 }
	kQ3AttributeTypeNormal		= {TQ3AttributeTypes}3;			{  TQ3Vector3D 				 }
	kQ3AttributeTypeAmbientCoefficient = {TQ3AttributeTypes}4;	{  float 					 }
	kQ3AttributeTypeDiffuseColor = {TQ3AttributeTypes}5;		{  TQ3ColorRGB				 }
	kQ3AttributeTypeSpecularColor = {TQ3AttributeTypes}6;		{  TQ3ColorRGB				 }
	kQ3AttributeTypeSpecularControl = {TQ3AttributeTypes}7;		{  float					 }
	kQ3AttributeTypeTransparencyColor = {TQ3AttributeTypes}8;	{  TQ3ColorRGB				 }
	kQ3AttributeTypeSurfaceTangent = {TQ3AttributeTypes}9;		{  TQ3Tangent2D  			 }
	kQ3AttributeTypeHighlightState = {TQ3AttributeTypes}10;		{  TQ3Switch 				 }
	kQ3AttributeTypeSurfaceShader = {TQ3AttributeTypes}11;		{  TQ3SurfaceShaderObject	 }
	kQ3AttributeTypeNumTypes	= {TQ3AttributeTypes}12;


TYPE
	TQ3AttributeType					= TQ3ElementType;
{*****************************************************************************
 **																			 **
 **								Attribute Drawing							 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3Attribute_Submit(attributeType: TQ3AttributeType; data: UNIV Ptr; view: TQ3ViewObject): TQ3Status; C;

{*****************************************************************************
 **																			 **
 **							AttributeSet Routines							 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3AttributeSet_New: TQ3AttributeSet; C;
FUNCTION Q3AttributeSet_Add(attributeSet: TQ3AttributeSet; theType: TQ3AttributeType; data: UNIV Ptr): TQ3Status; C;
FUNCTION Q3AttributeSet_Contains(attributeSet: TQ3AttributeSet; attributeType: TQ3AttributeType): TQ3Boolean; C;
FUNCTION Q3AttributeSet_Get(attributeSet: TQ3AttributeSet; theType: TQ3AttributeType; data: UNIV Ptr): TQ3Status; C;
FUNCTION Q3AttributeSet_Clear(attributeSet: TQ3AttributeSet; theType: TQ3AttributeType): TQ3Status; C;
FUNCTION Q3AttributeSet_Empty(target: TQ3AttributeSet): TQ3Status; C;
{
 * Q3AttributeSet_GetNextAttributeType
 *
 * Pass in kQ3AttributeTypeNone to get first type
 * kQ3AttributeTypeNone is returned when end of list is reached
 }
FUNCTION Q3AttributeSet_GetNextAttributeType(source: TQ3AttributeSet; VAR theType: TQ3AttributeType): TQ3Status; C;
FUNCTION Q3AttributeSet_Submit(attributeSet: TQ3AttributeSet; view: TQ3ViewObject): TQ3Status; C;
{
 * Inherit from parent->child into result
 *	Result attributes are:
 *		all child attributes + all parent attributes NOT in the child
 }
FUNCTION Q3AttributeSet_Inherit(parent: TQ3AttributeSet; child: TQ3AttributeSet; result: TQ3AttributeSet): TQ3Status; C;

{*****************************************************************************
 **																			 **
 **							Custom Element Registration						 **
 **																			 **
 ****************************************************************************}
{
 * Element Methods - 
 *
 * 		When you create a custom element, you control what structures are 
 *		passed around the API. For example, you may allow the Q3Set_Add call 
 *		take one type of argument, store your element internally in some 
 *		abstract data type, and have the Q3Set_Get call take a different 
 *		argument.
 *
 *		For example:
 *			
 *		There are four calls which at some point will copy an element:
 *
 *		Q3Set_Add (copied from Application memory to QuickDraw3D memory)
 *		Q3Set_Get (copied from QuickDraw3D memory to Application memory)
 *		Q3Object_Duplicate (all elements are copied internally)
 *		Q3AttributeSet_Inherit (all elements are copied internally)
 *
 * 		Either CopyAdd or CopyReplace is called during the "_Add" call.
 *			- CopyAdd is destructive and should assume "toElement" is garbage
 *			- CopyReplace is replacing an existing element.
 *
 * 		CopyGet is called during the "_Get" call.
 *
 * 		CopyDuplicate is called to duplicate an element's internal structure.
 *
 * Attributes Methods - 
 *
 *		For copying data while Inheriting. Element methods are used
 *		at all other times.
 *	
 * 		CopyInherit is called to duplicate an element's internal structure 
 *			during inheritance. You should make this as fast as possible.
 *			(for example, if your custom element contains objects, you
 *			 should do a Q3Shared_GetReference instead of a Q3Object_Duplicate)
 *			
 *		The ElementDelete method will be called for all of your elements copied 
 *		around via CopyAdd, CopyReplace, CopyDuplicate, and CopyInherit.
 *		If CopyGet allocates any memory in it's destination, it is up to the app 
 *		to delete it on its side.
 }

TYPE
	TQ3ElementCopyAddMethod = ProcPtr;  { FUNCTION TQ3ElementCopyAddMethod(fromAPIElement: UNIV Ptr; toInternalElement: UNIV Ptr): TQ3Status; C; }

	TQ3ElementCopyReplaceMethod = ProcPtr;  { FUNCTION TQ3ElementCopyReplaceMethod(fromAPIElement: UNIV Ptr; ontoInternalElement: UNIV Ptr): TQ3Status; C; }

	TQ3ElementCopyGetMethod = ProcPtr;  { FUNCTION TQ3ElementCopyGetMethod(fromInternalElement: UNIV Ptr; toAPIElement: UNIV Ptr): TQ3Status; C; }

	TQ3ElementCopyDuplicateMethod = ProcPtr;  { FUNCTION TQ3ElementCopyDuplicateMethod(fromInternalElement: UNIV Ptr; toInternalElement: UNIV Ptr): TQ3Status; C; }

	TQ3ElementDeleteMethod = ProcPtr;  { FUNCTION TQ3ElementDeleteMethod(internalElement: UNIV Ptr): TQ3Status; C; }

FUNCTION Q3ElementClass_Register(elementType: TQ3ElementType; name: ConstCStringPtr; sizeOfElement: LONGINT; metaHandler: TQ3MetaHandler): TQ3ObjectClass; C;
FUNCTION Q3ElementType_GetElementSize(elementType: TQ3ElementType; VAR sizeOfElement: LONGINT): TQ3Status; C;

{*****************************************************************************
 **																			 **
 **						Custom Attribute Registration						 **
 **																			 **
 ****************************************************************************}

TYPE
	TQ3AttributeInheritMethod			= TQ3Boolean;
{ return kQ3True or kQ3False in your metahandler }
	TQ3AttributeCopyInheritMethod = ProcPtr;  { FUNCTION TQ3AttributeCopyInheritMethod(fromInternalAttribute: UNIV Ptr; toInternalAttribute: UNIV Ptr): TQ3Status; C; }

FUNCTION Q3AttributeClass_Register(attributeType: TQ3AttributeType; creatorName: ConstCStringPtr; sizeOfElement: LONGINT; metaHandler: TQ3MetaHandler): TQ3ObjectClass; C;
{
 *	Version 1.1
 }

TYPE
	TQ3AttributeDefaultMethod = ProcPtr;  { FUNCTION TQ3AttributeDefaultMethod(internalElement: UNIV Ptr): TQ3Status; C; }

	TQ3AttributeIsDefaultMethod = ProcPtr;  { FUNCTION TQ3AttributeIsDefaultMethod(internalElement: UNIV Ptr): TQ3Boolean; C; }



CONST
	kQ3XMethodTypeElementCopyAdd = 'ecpa';


TYPE
	TQ3XElementCopyAddMethod = ProcPtr;  { FUNCTION TQ3XElementCopyAddMethod(fromAPIElement: UNIV Ptr; toInternalElement: UNIV Ptr): TQ3Status; C; }


CONST
	kQ3XMethodTypeElementCopyReplace = 'ecpr';


TYPE
	TQ3XElementCopyReplaceMethod = ProcPtr;  { FUNCTION TQ3XElementCopyReplaceMethod(fromAPIElement: UNIV Ptr; ontoInternalElement: UNIV Ptr): TQ3Status; C; }


CONST
	kQ3XMethodTypeElementCopyGet = 'ecpg';


TYPE
	TQ3XElementCopyGetMethod = ProcPtr;  { FUNCTION TQ3XElementCopyGetMethod(fromInternalElement: UNIV Ptr; toAPIElement: UNIV Ptr): TQ3Status; C; }


CONST
	kQ3XMethodTypeElementCopyDuplicate = 'ecpd';


TYPE
	TQ3XElementCopyDuplicateMethod = ProcPtr;  { FUNCTION TQ3XElementCopyDuplicateMethod(fromInternalElement: UNIV Ptr; toInternalElement: UNIV Ptr): TQ3Status; C; }


CONST
	kQ3XMethodTypeElementDelete	= 'edel';


TYPE
	TQ3XElementDeleteMethod = ProcPtr;  { FUNCTION TQ3XElementDeleteMethod(internalElement: UNIV Ptr): TQ3Status; C; }

FUNCTION Q3XElementClass_Register(VAR elementType: TQ3ElementType; name: ConstCStringPtr; sizeOfElement: LONGINT; metaHandler: TQ3XMetaHandler): TQ3XObjectClass; C;
FUNCTION Q3XElementType_GetElementSize(elementType: TQ3ElementType; VAR sizeOfElement: LONGINT): TQ3Status; C;

{*****************************************************************************
 **																			 **
 **						Custom Attribute Registration						 **
 **																			 **
 ****************************************************************************}

CONST
	kQ3XMethodTypeAttributeInherit = 'inht';


TYPE
	TQ3XAttributeInheritMethod			= TQ3Boolean;
{ return kQ3True or kQ3False in your metahandler }

CONST
	kQ3XMethodTypeAttributeCopyInherit = 'acpi';


TYPE
	TQ3XAttributeCopyInheritMethod = ProcPtr;  { FUNCTION TQ3XAttributeCopyInheritMethod(fromInternalAttribute: UNIV Ptr; toInternalAttribute: UNIV Ptr): TQ3Status; C; }

FUNCTION Q3XAttributeClass_Register(VAR attributeType: TQ3AttributeType; creatorName: ConstCStringPtr; sizeOfElement: LONGINT; metaHandler: TQ3XMetaHandler): TQ3XObjectClass; C;
{
 *	Version 1.1
 }

CONST
	kQ3XMethodTypeAttributeDefault = 'asdf';


TYPE
	TQ3XAttributeDefaultMethod = ProcPtr;  { FUNCTION TQ3XAttributeDefaultMethod(internalElement: UNIV Ptr): TQ3Status; C; }


CONST
	kQ3XMethodTypeAttributeIsDefault = 'aidf';


TYPE
	TQ3XAttributeIsDefaultMethod = ProcPtr;  { FUNCTION TQ3XAttributeIsDefaultMethod(internalElement: UNIV Ptr): TQ3Boolean; C; }






{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DSetIncludes}

{$ENDC} {__QD3DSET__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
