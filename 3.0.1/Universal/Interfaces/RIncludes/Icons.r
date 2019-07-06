/*
 	File:		Icons.r
 
 	Contains:	Icon Utilities Interfaces.
 
 	Version:	Technology:	System 8
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1990-1997 by Apple Computer, Inc. All rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
*/

#ifndef __ICONS_R__
#define __ICONS_R__

#ifndef __CONDITIONALMACROS_R__
#include "ConditionalMacros.r"
#endif

#ifndef __QUICKDRAW_R__
#include "Quickdraw.r"
#endif

															/*  The following are icons for which there are both icon suites and SICNs.  */
#define kGenericDocumentIconResource 	(-4000)
#define kGenericStationeryIconResource 	(-3985)
#define kGenericEditionFileIconResource  (-3989)
#define kGenericApplicationIconResource  (-3996)
#define kGenericDeskAccessoryIconResource  (-3991)
#define kGenericFolderIconResource 		(-3999)
#define kPrivateFolderIconResource 		(-3994)
#define kFloppyIconResource 			(-3998)
#define kTrashIconResource 				(-3993)
#define kGenericRAMDiskIconResource 	(-3988)
#define kGenericCDROMIconResource 		(-3987)				/*  The following are icons for which there are SICNs only.  */
#define kDesktopIconResource 			(-3992)
#define kOpenFolderIconResource 		(-3997)
#define kGenericHardDiskIconResource 	(-3995)
#define kGenericFileServerIconResource 	(-3972)
#define kGenericSuitcaseIconResource 	(-3970)
#define kGenericMoverObjectIconResource  (-3969)			/*  The following are icons for which there are icon suites only.  */
#define kGenericPreferencesIconResource  (-3971)
#define kGenericQueryDocumentIconResource  (-16506)
#define kGenericExtensionIconResource 	(-16415)
#define kSystemFolderIconResource 		(-3983)
#define kAppleMenuFolderIconResource 	(-3982)

															/*  Obsolete. Use named constants defined above.  */
#define genericDocumentIconResource 	(-4000)
#define genericStationeryIconResource 	(-3985)
#define genericEditionFileIconResource 	(-3989)
#define genericApplicationIconResource 	(-3996)
#define genericDeskAccessoryIconResource  (-3991)
#define genericFolderIconResource 		(-3999)
#define privateFolderIconResource 		(-3994)
#define floppyIconResource 				(-3998)
#define trashIconResource 				(-3994)
#define genericRAMDiskIconResource 		(-3988)
#define genericCDROMIconResource 		(-3987)
#define desktopIconResource 			(-3992)
#define openFolderIconResource 			(-3997)
#define genericHardDiskIconResource 	(-3995)
#define genericFileServerIconResource 	(-3972)
#define genericSuitcaseIconResource 	(-3970)
#define genericMoverObjectIconResource 	(-3969)
#define genericPreferencesIconResource 	(-3971)
#define genericQueryDocumentIconResource  (-16506)
#define genericExtensionIconResource 	(-16415)
#define systemFolderIconResource 		(-3983)
#define appleMenuFolderIconResource 	(-3982)

#define kStartupFolderIconResource 		(-3981)
#define kOwnedFolderIconResource 		(-3980)
#define kDropFolderIconResource 		(-3979)
#define kSharedFolderIconResource 		(-3978)
#define kMountedFolderIconResource 		(-3977)
#define kControlPanelFolderIconResource  (-3976)
#define kPrintMonitorFolderIconResource  (-3975)
#define kPreferencesFolderIconResource 	(-3974)
#define kExtensionsFolderIconResource 	(-3973)
#define kFontsFolderIconResource 		(-3968)
#define kFullTrashIconResource 			(-3984)

															/*  Obsolete. Use named constants defined above.  */
#define startupFolderIconResource 		(-3981)
#define ownedFolderIconResource 		(-3980)
#define dropFolderIconResource 			(-3979)
#define sharedFolderIconResource 		(-3978)
#define mountedFolderIconResource 		(-3977)
#define controlPanelFolderIconResource 	(-3976)
#define printMonitorFolderIconResource 	(-3975)
#define preferencesFolderIconResource 	(-3974)
#define extensionsFolderIconResource 	(-3973)
#define fontsFolderIconResource 		(-3968)
#define fullTrashIconResource 			(-3984)

#define kLarge1BitMask 					'ICN#'
#define kLarge4BitData 					'icl4'
#define kLarge8BitData 					'icl8'
#define kSmall1BitMask 					'ics#'
#define kSmall4BitData 					'ics4'
#define kSmall8BitData 					'ics8'
#define kMini1BitMask 					'icm#'
#define kMini4BitData 					'icm4'
#define kMini8BitData 					'icm8'

															/*  Obsolete. Use names defined above.  */
#define large1BitMask 					'ICN#'
#define large4BitData 					'icl4'
#define large8BitData 					'icl8'
#define small1BitMask 					'ics#'
#define small4BitData 					'ics4'
#define small8BitData 					'ics8'
#define mini1BitMask 					'icm#'
#define mini4BitData 					'icm4'
#define mini8BitData 					'icm8'

#define kAlignNone 						0x00
#define kAlignVerticalCenter 			0x01
#define kAlignTop 						0x02
#define kAlignBottom 					0x03
#define kAlignHorizontalCenter 			0x04
#define kAlignAbsoluteCenter 			0x05
#define kAlignCenterTop 				0x06
#define kAlignCenterBottom 				0x07
#define kAlignLeft 						0x08
#define kAlignCenterLeft 				0x09
#define kAlignTopLeft 					0x0A
#define kAlignBottomLeft 				0x0B
#define kAlignRight 					0x0C
#define kAlignCenterRight 				0x0D
#define kAlignTopRight 					0x0E
#define kAlignBottomRight 				0x0F

															/*  Obsolete. Use names defined above.  */
#define atNone 							0x00
#define atVerticalCenter 				0x01
#define atTop 							0x02
#define atBottom 						0x03
#define atHorizontalCenter 				0x04
#define atAbsoluteCenter 				0x05
#define atCenterTop 					0x06
#define atCenterBottom 					0x07
#define atLeft 							0x08
#define atCenterLeft 					0x09
#define atTopLeft 						0x0A
#define atBottomLeft 					0x0B
#define atRight 						0x0C
#define atCenterRight 					0x0D
#define atTopRight 						0x0E
#define atBottomRight 					0x0F

#define kTransformNone 					0x00
#define kTransformDisabled 				0x01
#define kTransformOffline 				0x02
#define kTransformOpen 					0x03
#define kTransformLabel1 				0x0100
#define kTransformLabel2 				0x0200
#define kTransformLabel3 				0x0300
#define kTransformLabel4 				0x0400
#define kTransformLabel5 				0x0500
#define kTransformLabel6 				0x0600
#define kTransformLabel7 				0x0700
#define kTransformSelected 				0x4000
#define kTransformSelectedDisabled 		0x4001
#define kTransformSelectedOffline 		0x4002
#define kTransformSelectedOpen 			0x4003

															/*  Obsolete. Use names defined above.  */
#define ttNone 							0x00
#define ttDisabled 						0x01
#define ttOffline 						0x02
#define ttOpen 							0x03
#define ttLabel1 						0x0100
#define ttLabel2 						0x0200
#define ttLabel3 						0x0300
#define ttLabel4 						0x0400
#define ttLabel5 						0x0500
#define ttLabel6 						0x0600
#define ttLabel7 						0x0700
#define ttSelected 						0x4000
#define ttSelectedDisabled 				0x4001
#define ttSelectedOffline 				0x4002
#define ttSelectedOpen 					0x4003

#define kSelectorLarge1Bit 				0x00000001
#define kSelectorLarge4Bit 				0x00000002
#define kSelectorLarge8Bit 				0x00000004
#define kSelectorSmall1Bit 				0x00000100
#define kSelectorSmall4Bit 				0x00000200
#define kSelectorSmall8Bit 				0x00000400
#define kSelectorMini1Bit 				0x00010000
#define kSelectorMini4Bit 				0x00020000
#define kSelectorMini8Bit 				0x00040000
#define kSelectorAllLargeData 			0x000000FF
#define kSelectorAllSmallData 			0x0000FF00
#define kSelectorAllMiniData 			0x00FF0000
#define kSelectorAll1BitData 			0x00010101
#define kSelectorAll4BitData 			0x00020202
#define kSelectorAll8BitData 			0x00040404
#define kSelectorAllAvailableData 		0xFFFFFFFF

															/*  Obsolete. Use names defined above.  */
#define svLarge1Bit 					0x00000001
#define svLarge4Bit 					0x00000002
#define svLarge8Bit 					0x00000004
#define svSmall1Bit 					0x00000100
#define svSmall4Bit 					0x00000200
#define svSmall8Bit 					0x00000400
#define svMini1Bit 						0x00010000
#define svMini4Bit 						0x00020000
#define svMini8Bit 						0x00040000
#define svAllLargeData 					0x000000FF
#define svAllSmallData 					0x0000FF00
#define svAllMiniData 					0x00FF0000
#define svAll1BitData 					0x00010101
#define svAll4BitData 					0x00020202
#define svAll8BitData 					0x00040404
#define svAllAvailableData 				0xFFFFFFFF


/*-----------------------------------cicn • Color Icon -------------------------------------------*/
/*
	cicn_RezTemplateVersion:
		0 - original 
		1 - auto calculate much of internal data 				<-- default
*/
#ifndef cicn_RezTemplateVersion
	#ifdef oldTemp							/* grandfather in use of “oldTemp” */
		#define cicn_RezTemplateVersion 0
	#else
		#define cicn_RezTemplateVersion 1
	#endif
#endif


type 'cicn' {
		/* IconPMap (pixMap) record */
		fill long;												/* Base address			*/
		unsigned bitstring[1] = 1;								/* New pixMap flag		*/
		unsigned bitstring[2] = 0;								/* Must be 0			*/
#if cicn_RezTemplateVersion == 0
	pMapRowBytes:
		unsigned bitstring[13];									/* Offset to next row	*/
	Bounds:
		rect;													/* Bitmap bounds		*/
		integer;												/* pixMap vers number	*/
		integer	unpacked;										/* Packing format		*/
		unsigned longint;										/* Size of pixel data	*/
		unsigned hex longint;									/* h. resolution (ppi) (fixed) */
		unsigned hex longint;									/* v. resolution (ppi) (fixed) */
		integer			chunky, chunkyPlanar, planar;			/* Pixel storage format	*/
		integer;												/* # bits in pixel		*/
		integer;												/* # components in pixel*/
		integer;												/* # bits per field		*/
		unsigned longint;										/* Offset to next plane	*/
		unsigned longint;										/* Offset to color table*/
		fill long;												/* Reserved				*/

		/* IconMask (bitMap) record */
		fill long;												/* Base address			*/
	maskRowBytes:
		integer;												/* Row bytes			*/
		rect;													/* Bitmap bounds		*/


		/* IconBMap (bitMap) record */
		fill long;												/* Base address			*/
	iconBMapRowBytes:
		integer;												/* Row bytes			*/
		rect;													/* Bitmap bounds		*/

		fill long;												/* Handle placeholder	*/

		/* Mask data */
		hex string [$$Word(maskRowBytes) * PIXMAPHEIGHT];

		/* BitMap data */
		hex string [$$Word(iconBMapRowBytes) * PIXMAPHEIGHT];

		/* Color Table */
		unsigned hex longint;									/* ctSeed				*/
		integer;												/* ctFlags				*/
		integer = $$Countof(ColorSpec) - 1;						/* ctSize				*/
		wide array ColorSpec {
				integer;										/* value				*/
				unsigned integer;								/* RGB:	red				*/
				unsigned integer;								/*		green			*/
				unsigned integer;								/*		blue			*/
		};

		/* PixelMap data */
		hex string [$$BitField(pMapRowBytes, 0, 13) * PIXMAPHEIGHT];


#else
	pMapRowBytes:
		unsigned bitstring[13] k32x32x4 = 16;					/* Offset to next row	*/
	Bounds:	
		rect;													/* Bitmap bounds		*/
		integer = 0;											/* pixMap vers number	*/
		integer = 0;											/* Packing format		*/
		fill long;												/* Size of pixel data	*/
		unsigned hex longint = $00480000;						/* h. resolution (ppi)  */
		unsigned hex longint = $00480000;						/* v. resolution (ppi)  */
		integer = 0 /* chunky */;								/* Pixel storage format	*/
	PixelSize:
		integer;												/* # bits in pixel		*/
		integer = 1;											/* # components in pixel*/
		integer = $$Word(PixelSize);							/* # bits per field		*/
		fill long;
		fill long;
		fill long;

		/* IconMask (bitMap) record */
		fill long;												/* Base address			*/
		integer = BitMapRowBytes;								/* Row bytes			*/
		PixMapBounds;											/* Bitmap bounds		*/

		/* IconBMap (bitMap) record */
		fill long;												/* Base address			*/
		integer = BitMapRowBytes;								/* Row bytes			*/
		PixMapBounds;											/* Bitmap bounds		*/

		fill long;												/* Handle placeholder	*/

		/* Mask data */
		hex string [BitMapRowBytes * PixMapHeight];

		/* BitMap data */
		hex string [BitMapRowBytes * PixMapHeight];

	ColorTable:
		unsigned hex longint = 0;								/* ctSeed				*/
		integer = 0;											/* ctFlags				*/
		integer = $$Countof(ColorSpec) - 1;						/* ctSize				*/
		wide array ColorSpec {
				integer = $$ArrayIndex(ColorSpec) - 1;			/* value				*/
				unsigned integer;								/* RGB:	red				*/
				unsigned integer;								/*		green			*/
				unsigned integer;								/*		blue			*/
		};

	PixelData:
		hex string [PixMapRowBytes * PixMapHeight];				/* more of the pixmap	*/
#endif
};


/*----------------------------ICON • Icon-----------------------------------------------*/
type 'ICON' {
		hex string[128];										/* Icon data			*/
};


/*----------------------------ICN# • Icon List------------------------------------------*/
type 'ICN#' {
		array {
				hex string[128];								/* Icon data			*/
		};
};


/*----------------------------SICN • Small Icon-----------------------------------------*/
type 'SICN' {
		array {
				hex string[32]; 								/* SICN data			*/
		};
};


/*--------------------------ics# • small icons with masks-------------------------------*/
type 'ics#' {
	array [2] {
		hex string[32];
	};
};


/*--------------------------icm# • mini icons with masks--------------------------------*/
type 'icm#' {
	array [2] {
		hex string[24];
	};
};


/*--------------------------icm8 • 8-bit mini icon no mask------------------------------*/
type 'icm8' {
	hex string[192];
};


/*--------------------------icm4 • 4-bit mini icon no mask------------------------------*/
type 'icm4' {
	hex string[96];
};


/*--------------------------icl8 • 8-bit large icon no mask-----------------------------*/
type 'icl8' {
	hex string[1024];
};


/*--------------------------icl4 • 4-bit large icon no mask-----------------------------*/
type 'icl4' {
	hex string[512];
};


/*--------------------------ics8 • 8-bit small icon no mask-----------------------------*/
type 'ics8' {
	hex string[256];
};


/*--------------------------ics4 • 4-bit small icon no mask-----------------------------*/
type 'ics4' {
	hex string[128];
};


/*-------------------------------• Keyboard Icons---------------------------------------*/
type 'KCN#' as 'ICN#';						
type 'kcs#' as 'ics#';								/* Keyboard small icon							
type 'kcl8' as 'icl8';								/* Keyboard 8-bit color icon */
type 'kcl4' as 'icl4';								/* Keyboard 4-bit color icon */
type 'kcs8' as 'ics8';								/* Keyboard 8-bit small color icon */
type 'kcs4' as 'ics4';								/* Keyboard 4-bit small color icon */


#endif /* __ICONS_R__ */

