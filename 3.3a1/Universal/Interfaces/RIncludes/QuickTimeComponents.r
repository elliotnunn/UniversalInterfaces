/*
 	File:		QuickTimeComponents.r
 
 	Contains:	QuickTime Interfaces.
 
 	Version:	Technology:	QuickTime 4.0
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1990-1999 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
*/

#ifndef __QUICKTIMECOMPONENTS_R__
#define __QUICKTIMECOMPONENTS_R__

#ifndef __CONDITIONALMACROS_R__
#include "ConditionalMacros.r"
#endif

#define canMovieImportHandles 			0x01
#define canMovieImportFiles 			0x02
#define hasMovieImportUserInterface 	0x04
#define canMovieExportHandles 			0x08
#define canMovieExportFiles 			0x10
#define hasMovieExportUserInterface 	0x20
#define dontAutoFileMovieImport 		0x40
#define canMovieExportAuxDataHandle 	0x80
#define canMovieImportValidateHandles 	0x0100
#define canMovieImportValidateFile 		0x0200
#define dontRegisterWithEasyOpen 		0x0400
#define canMovieImportInPlace 			0x0800
#define movieImportSubTypeIsFileExtension  0x1000
#define canMovieImportPartial 			0x2000
#define hasMovieImportMIMEList 			0x4000
#define canMovieExportFromProcedures 	0x8000
#define canMovieExportValidateMovie 	0x00010000
#define movieExportNeedsResourceFork 	0x00020000
#define canMovieImportDataReferences 	0x00040000
#define movieExportMustGetSourceMediaType  0x00080000
#define canMovieImportWithIdle 			0x00100000
#define canMovieImportValidateDataReferences  0x00200000
#define reservedForUseByGraphicsImporters  0x00800000

#define kMimeInfoMimeTypeTag 			'mime'
#define kMimeInfoFileExtensionTag 		'ext '
#define kMimeInfoDescriptionTag 		'desc'
#define kMimeInfoGroupTag 				'grop'
#define kMimeInfoDoNotOverrideExistingFileTypeAssociation  'nofa'


type 'mime' {
	// 10 bytes of reserved
	longint = 0;
	longint = 0;
	integer = 0;
	// 2 bytes of lock count
	integer = 0;
	
	// size of this atom
	parentStart:
	longint = ( (parentEnd - parentStart) / 8 );
	
	// atom type
	literal longint = 'sean';
	
	// atom id
	longint = 1;
	integer = 0;
	integer =  $$CountOf(AtomArray);
	longint = 0;
	
	array AtomArray {
		atomStart:
		// size of this atom
		longint = ((atomEnd[$$ArrayIndex(AtomArray)] - atomStart[$$ArrayIndex(AtomArray)]) / 8);
		
		// atom type
		literal longint;
		
		// atom id
		longint;
		integer = 0;
		integer = 0; // no children
		longint = 0;
		string;
		atomEnd:
		};
	parentEnd:
		
};


/*----------------------------'stg#'  • QuickTime preset list ------------------------*/
/*
	
 */
type 'stg#' {
	hex longint;				/* flags */
	longint = $$CountOf(PresetDescriptionArray);
	longint = 0;
	
	array PresetDescriptionArray {
		literal longint;			/*	preset key ID */
		unsigned hex longint noFlags = 0,
							 kQTPresetInfoIsDivider = 1;	/*  preset flags */
		literal longint;			/*	preset resource type */
		integer;					/*	preset resource ID */
		integer = 0;				/*  padding but also reserved */
		integer;					/*	preset name string list ID */
		integer;					/*	preset name string index */
		integer;					/*  preset description string list ID */
		integer;					/*	preset description string index */
	};
};


/*----------------------------'stgp'  • QuickTime preset platform list ------------------------*/
/*
	
 */
type 'stgp' {
		longint = 0;											/* reserved */
		literal longint;										/* default settings list resource type */
		integer;												/* default settings list resource id */
		integer = $$CountOf(SettingsPlatformInfo);
		wide array SettingsPlatformInfo {
			unsigned hex longint = 0; 							/* reserved */
			literal longint;									/* platform settings list resource Type */
			integer;											/* platform settings list resource ID */
			integer platform68k = 1,							/* platform type (response from gestaltSysArchitecture) */
					platformPowerPC = 2,
					platformInterpreted = 3,
					platformWin32 = 4;
		};
};


/*----------------------------'src#'  • MovieExporter source list ------------------------*/
/*
	
 */
type 'src#' {
	longint = $$CountOf(SourceArray);
	longint = 0;					/* reserved */

	array SourceArray {
		literal longint;			/* Media type of source */
		integer;					/* min number of sources of this kind required, zero if none required */
		integer;					/* max number of sources of this kind allowed, 65535 if unlimited allowed */
		longint isMediaType = 0x01, isMediaCharacteristic = 0x02, isSourceType = 0x04;
	};
};

type 'trk#' as 'src#';


#endif /* __QUICKTIMECOMPONENTS_R__ */

