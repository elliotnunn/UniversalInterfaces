{
 	File:		CMScriptingPlugin.p
 
 	Contains:	ColorSync Scripting Plugin API
 
 	Version:	Technology:	ColorSync 2.5
 				Release:	Universal Interfaces 3.1
 
 	Copyright:	© 1998 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CMScriptingPlugin;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CMSCRIPTINGPLUGIN__}
{$SETC __CMSCRIPTINGPLUGIN__ := 1}

{$I+}
{$SETC CMScriptingPluginIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __CMAPPLICATION__}
{$I CMApplication.p}
{$ENDC}
{$IFC UNDEFINED __CODEFRAGMENTS__}
{$I CodeFragments.p}
{$ENDC}




{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
																{  ColorSync Scripting AppleEvent Errors  }
	cmspInvalidImageFile		= -4220;						{  Plugin cannot handle this image file type  }
	cmspInvalidImageSpace		= -4221;						{  Plugin cannot create an image file of this colorspace  }
	cmspInvalidProfileEmbed		= -4222;						{  Specific invalid profile errors  }
	cmspInvalidProfileSource	= -4223;
	cmspInvalidProfileDest		= -4224;
	cmspInvalidProfileProof		= -4225;
	cmspInvalidProfileLink		= -4226;


{*** embedFlags field  ***}
{ reserved for future use: currently 0 }

{*** matchFlags field  ***}
	cmspFavorEmbeddedMask		= $00000001;					{  if bit 0 is 0 then use srcProf profile, if 1 then use profile embedded in image if present }



TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	ValidateImageProcPtr = FUNCTION({CONST}VAR spec: FSSpec): CMError; C;
{$ELSEC}
	ValidateImageProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	GetImageSpaceProcPtr = FUNCTION({CONST}VAR spec: FSSpec; VAR space: OSType): CMError; C;
{$ELSEC}
	GetImageSpaceProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ValidateSpaceProcPtr = FUNCTION({CONST}VAR spec: FSSpec; VAR space: OSType): CMError; C;
{$ELSEC}
	ValidateSpaceProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	EmbedImageProcPtr = FUNCTION({CONST}VAR specFrom: FSSpec; {CONST}VAR specInto: FSSpec; embedProf: CMProfileRef; embedFlags: UInt32): CMError; C;
{$ELSEC}
	EmbedImageProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	MatchImageProcPtr = FUNCTION({CONST}VAR specFrom: FSSpec; {CONST}VAR specInto: FSSpec; qual: UInt32; srcIntent: UInt32; srcProf: CMProfileRef; dstProf: CMProfileRef; prfProf: CMProfileRef; matchFlags: UInt32): CMError; C;
{$ELSEC}
	MatchImageProcPtr = ProcPtr;
{$ENDC}

	ValidateImageUPP = UniversalProcPtr;
	GetImageSpaceUPP = UniversalProcPtr;
	ValidateSpaceUPP = UniversalProcPtr;
	EmbedImageUPP = UniversalProcPtr;
	MatchImageUPP = UniversalProcPtr;

CONST
	uppValidateImageProcInfo = $000000F1;
	uppGetImageSpaceProcInfo = $000003F1;
	uppValidateSpaceProcInfo = $000003F1;
	uppEmbedImageProcInfo = $00003FF1;
	uppMatchImageProcInfo = $003FFFF1;

FUNCTION NewValidateImageProc(userRoutine: ValidateImageProcPtr): ValidateImageUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewGetImageSpaceProc(userRoutine: GetImageSpaceProcPtr): GetImageSpaceUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewValidateSpaceProc(userRoutine: ValidateSpaceProcPtr): ValidateSpaceUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewEmbedImageProc(userRoutine: EmbedImageProcPtr): EmbedImageUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewMatchImageProc(userRoutine: MatchImageProcPtr): MatchImageUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallValidateImageProc({CONST}VAR spec: FSSpec; userRoutine: ValidateImageUPP): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

FUNCTION CallGetImageSpaceProc({CONST}VAR spec: FSSpec; VAR space: OSType; userRoutine: GetImageSpaceUPP): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

FUNCTION CallValidateSpaceProc({CONST}VAR spec: FSSpec; VAR space: OSType; userRoutine: ValidateSpaceUPP): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

FUNCTION CallEmbedImageProc({CONST}VAR specFrom: FSSpec; {CONST}VAR specInto: FSSpec; embedProf: CMProfileRef; embedFlags: UInt32; userRoutine: EmbedImageUPP): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

FUNCTION CallMatchImageProc({CONST}VAR specFrom: FSSpec; {CONST}VAR specInto: FSSpec; qual: UInt32; srcIntent: UInt32; srcProf: CMProfileRef; dstProf: CMProfileRef; prfProf: CMProfileRef; matchFlags: UInt32; userRoutine: MatchImageUPP): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CMScriptingPluginIncludes}

{$ENDC} {__CMSCRIPTINGPLUGIN__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
