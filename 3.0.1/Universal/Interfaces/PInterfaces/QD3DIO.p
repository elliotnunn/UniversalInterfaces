{
 	File:		QD3DIO.p
 
 	Contains:	QuickDraw 3D IO API												
 
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
 UNIT QD3DIO;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QD3DIO__}
{$SETC __QD3DIO__ := 1}

{$I+}
{$SETC QD3DIOIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __QD3D__}
{$I QD3D.p}
{$ENDC}

{$IFC UNDEFINED __QD3DDRAWCONTEXT__}
{$I QD3DDrawContext.p}
{$ENDC}
{$IFC UNDEFINED __QD3DVIEW__}
{$I QD3DView.p}
{$ENDC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{*****************************************************************************
 **									 										 **
 **									Basic Types								 **													
 **									 										 **
 ****************************************************************************}

TYPE
	TQ3Uns8								= UInt8;
	TQ3Int8								= SInt8;
	TQ3Uns16							= INTEGER;
	TQ3Int16							= INTEGER;
	TQ3Uns32							= LONGINT;
	TQ3Int32							= LONGINT;
{$IFC TARGET_OS_MAC }
	TQ3Uns64Ptr = ^TQ3Uns64;
	TQ3Uns64 = RECORD
		hi:						LONGINT;
		lo:						LONGINT;
	END;

	TQ3Int64Ptr = ^TQ3Int64;
	TQ3Int64 = RECORD
		hi:						LONGINT;
		lo:						LONGINT;
	END;

{$ELSEC}
	TQ3Uns64 = RECORD
		lo:						LONGINT;
		hi:						LONGINT;
	END;

	TQ3Int64 = RECORD
		lo:						LONGINT;
		hi:						LONGINT;
	END;

{$ENDC}  {TARGET_OS_MAC}

	TQ3Float32							= Single;
	TQ3Float64							= Double;
	TQ3Size								= TQ3Uns32;
{*****************************************************************************
 **									 										 **
 **									File Types								 **
 **									 										 **
 ****************************************************************************}
	TQ3FileModeMasks 			= LONGINT;
CONST
	kQ3FileModeNormal			= {TQ3FileModeMasks}0;
	kQ3FileModeStream			= {TQ3FileModeMasks}$01;
	kQ3FileModeDatabase			= {TQ3FileModeMasks}$02;
	kQ3FileModeText				= {TQ3FileModeMasks}$04;


TYPE
	TQ3FileMode							= LONGINT;
{*****************************************************************************
 **									 										 **
 **									Method Types							 **
 **									 										 **
 ****************************************************************************}
{
 *	IO Methods
 *
 *	The IO system treats all objects as groups of typed information.
 *	When you register your element or attribute, the "elementType" is the 
 *	binary type of your object, the "elementName" the ascii type.
 *	
 *	All objects in the metafile are made up of a "root" or parent object which
 *	defines the instantiated object type. You may define the format of your 
 *	data any way you wish as long as you use the primitives types above and the
 *	routines below.
 *
 *	Root Objects are often appended with additional child objects, called 
 *	subobjects. You may append your object with other QuickDraw 3D objects.
 *	
 *	Writing is straightforward: an object traverses itself any other objects 
 *	that make it up, then writes its own data. Writing uses two methods: 
 *	TQ3ObjectTraverseMethod and TQ3ObjectWriteMethod.
 *
 *	The TQ3ObjectTraverseMethod method should:
 *	+ First, Determine if the data should be written 
 *		- if you don't want to write out your object after examining your
 *			data, return kQ3Success in your Traverse method without calling
 *			any other submit calls.
 * 	+ Next, calculate the size of your object on disk
 * 	+ Gather whatever state from the view you need to preserve
 * 		- you may access the view state NOW, as the state of the
 * 			view duing your TQ3ObjectWriteMethod will not be valid. You may
 * 			pass a temporary buffer to your write method.
 * 	+ Submit your view write data using Q3View_SubmitWriteData
 * 		- note that you MUST call this before any other "_Submit" call.
 * 		- you may pass in a "deleteMethod" for your data. This method
 * 			will be called whether or not your write method succeeds or fails.
 * 	+ Submit your subobjects to the view
 * 	
 * 	The TQ3ObjectWriteMethod method should:
 * 	+ Write your data format to the file using the primitives routines below.
 * 		- If you passed a "deleteMethod" in your Q3View_SubmitWriteData, that
 *	 		method will be called upon exit of your write method.
 *
 *	Reading is less straightforward because your root object and
 *	any subobjects must be read inside of your TQ3ObjectReadDataMethod. There 
 *	is an implicit state contained in the file while reading, which you must 
 *	be aware of. When you first enter the read method, you must physically 
 *	read in your data format using the primitives routines until
 *	
 *	Q3File_IsEndOfData(file) == kQ3True
 *	
 *	Generally, your data format should be self-descriptive such that you do not
 *	need to call Q3File_IsEndOfData to determine if you are done reading. 
 *	However, this call is useful for determining zero-sized object or 
 *	determining the end of an object's data.
 *	
 *	Once you have read in all the data, you may collect subobjects. A metafile
 *	object ONLY has subobjects if it is in a container. The call
 *	
 *	Q3File_IsEndOfContainer(file)
 *	
 *	returns kQ3False if subobjects exist, and kQ3True if subobjects do not 
 *	exist.
 *	
 *	At this point, you may use
 *	
 *	Q3File_GetNextObjectType
 *	Q3File_IsNextObjectOfType
 *	Q3File_ReadObject
 *	Q3File_SkipObject
 *	
 *	to iterate through the subobjects until Q3File_IsEndOfContainer(file) 
 *	is kQ3True.
 * 
 }
{
 *	TQ3ObjectTraverseMethod
 *
 *	For "elements" (meaning "attributes, too), you will be passed NULL for 
 *	object. Sorry, custom objects will be available in the next major revision.
 *
 *	The "data" is a pointer to your internal element data.
 *
 *	The view is the current traversal view.
 }
	TQ3ObjectTraverseMethod = ProcPtr;  { FUNCTION TQ3ObjectTraverseMethod(object: TQ3Object; data: UNIV Ptr; view: TQ3ViewObject): TQ3Status; C; }

	TQ3ObjectWriteMethod = ProcPtr;  { FUNCTION TQ3ObjectWriteMethod(object: UNIV Ptr; theFile: TQ3FileObject): TQ3Status; C; }

{
 *  Use Q3XView_SubmitWriteData instead...
 }
	TQ3DataDeleteMethod = ProcPtr;  { PROCEDURE TQ3DataDeleteMethod(data: UNIV Ptr); C; }

FUNCTION Q3View_SubmitWriteData(view: TQ3ViewObject; size: TQ3Size; data: UNIV Ptr; deleteData: TQ3DataDeleteMethod): TQ3Status; C;
{
 *	TQ3ObjectReadDataMethod
 *
 *  For "elements" (meaning "attributes", too), you must allocate stack space 
 *	and call Q3Set_Add on "parentObject", which is an TQ3SetObject.
 *
 *	Otherwise, parentObject is whatever object your element is a subobject of...
 }

TYPE
	TQ3ObjectReadDataMethod = ProcPtr;  { FUNCTION TQ3ObjectReadDataMethod(parentObject: TQ3Object; theFile: TQ3FileObject): TQ3Status; C; }

{
 * IO Methods
 }

CONST
	kQ3XMethodTypeObjectFileVersion = 'vers';					{  version  }
	kQ3XMethodTypeObjectTraverse = 'trvs';						{  byte count  }
	kQ3XMethodTypeObjectTraverseData = 'trvd';					{  byte count  }
	kQ3XMethodTypeObjectWrite	= 'writ';						{  Dump info to file  }
	kQ3XMethodTypeObjectReadData = 'rddt';						{  Read info from file into buffer or, attach read data to parent  }
	kQ3XMethodTypeObjectRead	= 'read';
	kQ3XMethodTypeObjectAttach	= 'attc';

{
 *	TQ3XObjectTraverseMethod
 *
 *	For "elements" (meaning "attributes, too), you will be passed NULL for 
 *	object. Sorry, custom objects will be available in the next major revision.
 *
 *	The "data" is a pointer to your internal element data.
 *
 *	The view is the current traversal view.
 }

TYPE
	TQ3XObjectTraverseMethod = ProcPtr;  { FUNCTION TQ3XObjectTraverseMethod(object: TQ3Object; data: UNIV Ptr; view: TQ3ViewObject): TQ3Status; C; }

{
 *  TQ3XObjectTraverseDataMethod
 }
	TQ3XObjectTraverseDataMethod = ProcPtr;  { FUNCTION TQ3XObjectTraverseDataMethod(object: TQ3Object; data: UNIV Ptr; view: TQ3ViewObject): TQ3Status; C; }

{
 *  TQ3XObjectWriteMethod
 }
	TQ3XObjectWriteMethod = ProcPtr;  { FUNCTION TQ3XObjectWriteMethod(object: UNIV Ptr; theFile: TQ3FileObject): TQ3Status; C; }

{
 *  Custom object writing 
 }
	TQ3XDataDeleteMethod = ProcPtr;  { PROCEDURE TQ3XDataDeleteMethod(data: UNIV Ptr); C; }

FUNCTION Q3XView_SubmitWriteData(view: TQ3ViewObject; size: TQ3Size; data: UNIV Ptr; deleteData: TQ3XDataDeleteMethod): TQ3Status; C;
FUNCTION Q3XView_SubmitSubObjectData(view: TQ3ViewObject; objectClass: TQ3XObjectClass; size: LONGINT; data: UNIV Ptr; deleteData: TQ3XDataDeleteMethod): TQ3Status; C;
{
 *  TQ3XObjectReadMethod
 }

TYPE
	TQ3XObjectReadMethod = ProcPtr;  { FUNCTION TQ3XObjectReadMethod(theFile: TQ3FileObject): TQ3Object; C; }

{
 *	TQ3XObjectReadDataMethod
 *
 *  For "elements" (meaning "attributes", too), you must allocate stack space 
 *	and call Q3Set_Add on "parentObject", which is an TQ3SetObject.
 *
 *	Otherwise, parentObject is whatever object your element is a subobject of...
 }
	TQ3XObjectReadDataMethod = ProcPtr;  { FUNCTION TQ3XObjectReadDataMethod(parentObject: TQ3Object; theFile: TQ3FileObject): TQ3Status; C; }

{
 *  TQ3XObjectAttachMethod
 }
	TQ3XObjectAttachMethod = ProcPtr;  { FUNCTION TQ3XObjectAttachMethod(childObject: TQ3Object; parentObject: TQ3Object): TQ3Status; C; }



{*****************************************************************************
 **									 										 **
 **								Versioning									 **
 **									 										 **
 ****************************************************************************}
	TQ3FileVersion						= LONGINT;
{*****************************************************************************
 **									 										 **
 **								String Constants							 **
 **									 										 **
 ****************************************************************************}
{*****************************************************************************
 **									 										 **
 **								File Routines								 **
 **									 										 **
 ****************************************************************************}
{
 * Creation and accessors
 }
FUNCTION Q3File_New: TQ3FileObject; C;
FUNCTION Q3File_GetStorage(theFile: TQ3FileObject; VAR storage: TQ3StorageObject): TQ3Status; C;
FUNCTION Q3File_SetStorage(theFile: TQ3FileObject; storage: TQ3StorageObject): TQ3Status; C;
{
 * Opening, and accessing "open" state, closing/cancelling
 }
FUNCTION Q3File_OpenRead(theFile: TQ3FileObject; VAR mode: TQ3FileMode): TQ3Status; C;
FUNCTION Q3File_OpenWrite(theFile: TQ3FileObject; mode: TQ3FileMode): TQ3Status; C;
FUNCTION Q3File_IsOpen(theFile: TQ3FileObject; VAR isOpen: TQ3Boolean): TQ3Status; C;
FUNCTION Q3File_GetMode(theFile: TQ3FileObject; VAR mode: TQ3FileMode): TQ3Status; C;
FUNCTION Q3File_GetVersion(theFile: TQ3FileObject; VAR version: TQ3FileVersion): TQ3Status; C;
FUNCTION Q3File_Close(theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3File_Cancel(theFile: TQ3FileObject): TQ3Status; C;
{
 * Writing (Application)
 }
FUNCTION Q3View_StartWriting(view: TQ3ViewObject; theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3View_EndWriting(view: TQ3ViewObject): TQ3ViewStatus; C;
{
 * Reading (Application)
 }
FUNCTION Q3File_GetNextObjectType(theFile: TQ3FileObject): LONGINT; C;
FUNCTION Q3File_IsNextObjectOfType(theFile: TQ3FileObject; ofType: TQ3ObjectType): TQ3Boolean; C;
FUNCTION Q3File_ReadObject(theFile: TQ3FileObject): TQ3Object; C;
FUNCTION Q3File_SkipObject(theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3File_IsEndOfData(theFile: TQ3FileObject): TQ3Boolean; C;
FUNCTION Q3File_IsEndOfContainer(theFile: TQ3FileObject; rootObject: TQ3Object): TQ3Boolean; C;
FUNCTION Q3File_IsEndOfFile(theFile: TQ3FileObject): TQ3Boolean; C;
{	
 *  External file references
 }
FUNCTION Q3File_MarkAsExternalReference(theFile: TQ3FileObject; sharedObject: TQ3SharedObject): TQ3Status; C;
FUNCTION Q3File_GetExternalReferences(theFile: TQ3FileObject): TQ3GroupObject; C;
{	
 *  Tracking editing in read-in objects with custom elements
 }
FUNCTION Q3Shared_ClearEditTracking(sharedObject: TQ3SharedObject): TQ3Status; C;
FUNCTION Q3Shared_GetEditTrackingState(sharedObject: TQ3SharedObject): TQ3Boolean; C;
{	
 *  Reading objects inside a group one-by-one
 }

TYPE
	TQ3FileReadGroupStateMasks 	= LONGINT;
CONST
	kQ3FileReadWholeGroup		= {TQ3FileReadGroupStateMasks}0;
	kQ3FileReadObjectsInGroup	= {TQ3FileReadGroupStateMasks}$01;
	kQ3FileCurrentlyInsideGroup	= {TQ3FileReadGroupStateMasks}$02;


TYPE
	TQ3FileReadGroupState				= LONGINT;
FUNCTION Q3File_SetReadInGroup(theFile: TQ3FileObject; readGroupState: TQ3FileReadGroupState): TQ3Status; C;
FUNCTION Q3File_GetReadInGroup(theFile: TQ3FileObject; VAR readGroupState: TQ3FileReadGroupState): TQ3Status; C;

{
 * Idling
 }

TYPE
	TQ3FileIdleMethod = ProcPtr;  { FUNCTION TQ3FileIdleMethod(theFile: TQ3FileObject; idlerData: UNIV Ptr): TQ3Status; C; }

FUNCTION Q3File_SetIdleMethod(theFile: TQ3FileObject; idle: TQ3FileIdleMethod; idleData: UNIV Ptr): TQ3Status; C;

{*****************************************************************************
 **									 										 **
 **								Primitives Routines							 **
 **									 										 **
 ****************************************************************************}
FUNCTION Q3NewLine_Write(theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3Uns8_Read(VAR data: TQ3Uns8; theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3Uns8_Write(data: ByteParameter; theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3Uns16_Read(VAR data: TQ3Uns16; theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3Uns16_Write(data: TQ3Uns16; theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3Uns32_Read(VAR data: TQ3Uns32; theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3Uns32_Write(data: TQ3Uns32; theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3Int8_Read(VAR data: TQ3Int8; theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3Int8_Write(data: TQ3Int8; theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3Int16_Read(VAR data: TQ3Int16; theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3Int16_Write(data: TQ3Int16; theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3Int32_Read(VAR data: TQ3Int32; theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3Int32_Write(data: TQ3Int32; theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3Uns64_Read(VAR data: TQ3Uns64; theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3Uns64_Write(data: TQ3Uns64; theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3Int64_Read(VAR data: TQ3Int64; theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3Int64_Write(data: TQ3Int64; theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3Float32_Read(VAR data: TQ3Float32; theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3Float32_Write(data: TQ3Float32; theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3Float64_Read(VAR data: TQ3Float64; theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3Float64_Write(data: TQ3Float64; theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3Size_Pad(size: TQ3Size): TQ3Size; C;
{
 * Pass a pointer to a buffer of kQ3StringMaximumLength bytes
 }
FUNCTION Q3String_Read(data: CStringPtr; VAR length: LONGINT; theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3String_Write(data: ConstCStringPtr; theFile: TQ3FileObject): TQ3Status; C;
{ 
 * This call will read Q3Size_Pad(size) bytes,
 *	but only place size bytes into data.
 }
FUNCTION Q3RawData_Read(VAR data: UInt8; size: LONGINT; theFile: TQ3FileObject): TQ3Status; C;
{ 
 * This call will write Q3Size_Pad(size) bytes,
 *	adding 0's to pad to the nearest 4 byte boundary.
 }
FUNCTION Q3RawData_Write({CONST}VAR data: UInt8; size: LONGINT; theFile: TQ3FileObject): TQ3Status; C;
{*****************************************************************************
 **									 										 **
 **						Convenient Primitives Routines						 **
 **									 										 **
 ****************************************************************************}
FUNCTION Q3Point2D_Read(VAR point2D: TQ3Point2D; theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3Point2D_Write({CONST}VAR point2D: TQ3Point2D; theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3Point3D_Read(VAR point3D: TQ3Point3D; theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3Point3D_Write({CONST}VAR point3D: TQ3Point3D; theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3RationalPoint3D_Read(VAR point3D: TQ3RationalPoint3D; theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3RationalPoint3D_Write({CONST}VAR point3D: TQ3RationalPoint3D; theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3RationalPoint4D_Read(VAR point4D: TQ3RationalPoint4D; theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3RationalPoint4D_Write({CONST}VAR point4D: TQ3RationalPoint4D; theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3Vector2D_Read(VAR vector2D: TQ3Vector2D; theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3Vector2D_Write({CONST}VAR vector2D: TQ3Vector2D; theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3Vector3D_Read(VAR vector3D: TQ3Vector3D; theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3Vector3D_Write({CONST}VAR vector3D: TQ3Vector3D; theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3Matrix4x4_Read(VAR matrix4x4: TQ3Matrix4x4; theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3Matrix4x4_Write({CONST}VAR matrix4x4: TQ3Matrix4x4; theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3Tangent2D_Read(VAR tangent2D: TQ3Tangent2D; theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3Tangent2D_Write({CONST}VAR tangent2D: TQ3Tangent2D; theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3Tangent3D_Read(VAR tangent3D: TQ3Tangent3D; theFile: TQ3FileObject): TQ3Status; C;
FUNCTION Q3Tangent3D_Write({CONST}VAR tangent3D: TQ3Tangent3D; theFile: TQ3FileObject): TQ3Status; C;
{	This call affects only text Files - it is a no-op in binary files }
FUNCTION Q3Comment_Write(comment: CStringPtr; theFile: TQ3FileObject): TQ3Status; C;
{*****************************************************************************
 **									 										 **
 **								Unknown Object								 **
 **									 										 **
 **		Unknown objects are generated when reading files which contain		 **
 **		custom data which has not been registered in the current			 **
 **		instantiation of QuickDraw 3D.										 **
 **									 										 **
 ****************************************************************************}
FUNCTION Q3Unknown_GetType(unknownObject: TQ3UnknownObject): LONGINT; C;
FUNCTION Q3Unknown_GetDirtyState(unknownObject: TQ3UnknownObject; VAR isDirty: TQ3Boolean): TQ3Status; C;
FUNCTION Q3Unknown_SetDirtyState(unknownObject: TQ3UnknownObject; isDirty: TQ3Boolean): TQ3Status; C;

{*****************************************************************************
 **									 										 **
 **							Unknown Text Routines							 **
 **									 										 **
 ****************************************************************************}

TYPE
	TQ3UnknownTextDataPtr = ^TQ3UnknownTextData;
	TQ3UnknownTextData = RECORD
		objectName:				CStringPtr;								{  '\0' terminated  }
		contents:				CStringPtr;								{  '\0' terminated  }
	END;

FUNCTION Q3UnknownText_GetData(unknownObject: TQ3UnknownObject; VAR unknownTextData: TQ3UnknownTextData): TQ3Status; C;
FUNCTION Q3UnknownText_EmptyData(VAR unknownTextData: TQ3UnknownTextData): TQ3Status; C;

{*****************************************************************************
 **									 										 **
 **							Unknown Binary Routines							 **
 **									 										 **
 ****************************************************************************}

TYPE
	TQ3UnknownBinaryDataPtr = ^TQ3UnknownBinaryData;
	TQ3UnknownBinaryData = RECORD
		objectType:				TQ3ObjectType;
		size:					LONGINT;
		byteOrder:				TQ3Endian;
		contents:				CStringPtr;
	END;

FUNCTION Q3UnknownBinary_GetData(unknownObject: TQ3UnknownObject; VAR unknownBinaryData: TQ3UnknownBinaryData): TQ3Status; C;
FUNCTION Q3UnknownBinary_EmptyData(VAR unknownBinaryData: TQ3UnknownBinaryData): TQ3Status; C;

FUNCTION Q3UnknownBinary_GetTypeString(unknownObject: TQ3UnknownObject; VAR typeString: CStringPtr): TQ3Status; C;
FUNCTION Q3UnknownBinary_EmptyTypeString(VAR typeString: CStringPtr): TQ3Status; C;
{*****************************************************************************
 **									 										 **
 **							ViewHints routines								 **
 **									 										 **
 **		ViewHints are an object in a metafile to give you some hints on how	 **
 **		to render a scene.	You may create a view with any of the objects	 **
 **		retrieved from it, or you can just throw it away.					 **
 **									 										 **
 **		To write a view hints to a file, create a view hints object from a	 **
 **		view and write the view hints.										 **
 **									 										 **
 ****************************************************************************}
FUNCTION Q3ViewHints_New(view: TQ3ViewObject): TQ3ViewHintsObject; C;
FUNCTION Q3ViewHints_SetRenderer(viewHints: TQ3ViewHintsObject; renderer: TQ3RendererObject): TQ3Status; C;
FUNCTION Q3ViewHints_GetRenderer(viewHints: TQ3ViewHintsObject; VAR renderer: TQ3RendererObject): TQ3Status; C;
FUNCTION Q3ViewHints_SetCamera(viewHints: TQ3ViewHintsObject; camera: TQ3CameraObject): TQ3Status; C;
FUNCTION Q3ViewHints_GetCamera(viewHints: TQ3ViewHintsObject; VAR camera: TQ3CameraObject): TQ3Status; C;
FUNCTION Q3ViewHints_SetLightGroup(viewHints: TQ3ViewHintsObject; lightGroup: TQ3GroupObject): TQ3Status; C;
FUNCTION Q3ViewHints_GetLightGroup(viewHints: TQ3ViewHintsObject; VAR lightGroup: TQ3GroupObject): TQ3Status; C;
FUNCTION Q3ViewHints_SetAttributeSet(viewHints: TQ3ViewHintsObject; attributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3ViewHints_GetAttributeSet(viewHints: TQ3ViewHintsObject; VAR attributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3ViewHints_SetDimensionsState(viewHints: TQ3ViewHintsObject; isValid: TQ3Boolean): TQ3Status; C;
FUNCTION Q3ViewHints_GetDimensionsState(viewHints: TQ3ViewHintsObject; VAR isValid: TQ3Boolean): TQ3Status; C;
FUNCTION Q3ViewHints_SetDimensions(viewHints: TQ3ViewHintsObject; width: LONGINT; height: LONGINT): TQ3Status; C;
FUNCTION Q3ViewHints_GetDimensions(viewHints: TQ3ViewHintsObject; VAR width: LONGINT; VAR height: LONGINT): TQ3Status; C;
FUNCTION Q3ViewHints_SetMaskState(viewHints: TQ3ViewHintsObject; isValid: TQ3Boolean): TQ3Status; C;
FUNCTION Q3ViewHints_GetMaskState(viewHints: TQ3ViewHintsObject; VAR isValid: TQ3Boolean): TQ3Status; C;
FUNCTION Q3ViewHints_SetMask(viewHints: TQ3ViewHintsObject; {CONST}VAR mask: TQ3Bitmap): TQ3Status; C;
FUNCTION Q3ViewHints_GetMask(viewHints: TQ3ViewHintsObject; VAR mask: TQ3Bitmap): TQ3Status; C;
{ Call Q3Bitmap_Empty when done with the mask	}
FUNCTION Q3ViewHints_SetClearImageMethod(viewHints: TQ3ViewHintsObject; clearMethod: TQ3DrawContextClearImageMethod): TQ3Status; C;
FUNCTION Q3ViewHints_GetClearImageMethod(viewHints: TQ3ViewHintsObject; VAR clearMethod: TQ3DrawContextClearImageMethod): TQ3Status; C;
FUNCTION Q3ViewHints_SetClearImageColor(viewHints: TQ3ViewHintsObject; {CONST}VAR color: TQ3ColorARGB): TQ3Status; C;
FUNCTION Q3ViewHints_GetClearImageColor(viewHints: TQ3ViewHintsObject; VAR color: TQ3ColorARGB): TQ3Status; C;


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DIOIncludes}

{$ENDC} {__QD3DIO__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}