/*
 	File:		Video.r
 
 	Contains:	Video Driver Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1986-1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
*/

#ifndef __VIDEO_R__
#define __VIDEO_R__

#ifndef __CONDITIONALMACROS_R__
#include "ConditionalMacros.r"
#endif

#define mBaseOffset 					1					/* Id of mBaseOffset. */
#define mRowBytes 						2					/* Video sResource parameter Id's  */
#define mBounds 						3					/* Video sResource parameter Id's  */
#define mVersion 						4					/* Video sResource parameter Id's  */
#define mHRes 							5					/* Video sResource parameter Id's  */
#define mVRes 							6					/* Video sResource parameter Id's  */
#define mPixelType 						7					/* Video sResource parameter Id's  */
#define mPixelSize 						8					/* Video sResource parameter Id's  */
#define mCmpCount 						9					/* Video sResource parameter Id's  */
#define mCmpSize 						10					/* Video sResource parameter Id's  */
#define mPlaneBytes 					11					/* Video sResource parameter Id's  */
#define mVertRefRate 					14					/* Video sResource parameter Id's  */
#define mVidParams 						1					/* Video parameter block id. */
#define mTable 							2					/* Offset to the table. */
#define mPageCnt 						3					/* Number of pages */
#define mDevType 						4					/* Device Type */
#define oneBitMode 						128					/* Id of OneBitMode Parameter list. */
#define twoBitMode 						129					/* Id of TwoBitMode Parameter list. */
#define fourBitMode 					130					/* Id of FourBitMode Parameter list. */
#define eightBitMode 					131					/* Id of EightBitMode Parameter list. */

#define sixteenBitMode 					132					/* Id of SixteenBitMode Parameter list. */
#define thirtyTwoBitMode 				133					/* Id of ThirtyTwoBitMode Parameter list. */
#define firstVidMode 					128					/* The new, better way to do the above.  */
#define secondVidMode 					129					/*  QuickDraw only supports six video  */
#define thirdVidMode 					130					/*  at this time.       */
#define fourthVidMode 					131
#define fifthVidMode 					132
#define sixthVidMode 					133
#define spGammaDir 						64
#define spVidNamesDir 					65

#define kDeclROMtables 					'decl'
#define kDDCBlockSize 					128
#define kDDCBlockTypeEDID 				0					/*  EDID block type.  */
#define kDDCForceReadBit 				0					/*  Force a new read of the EDID.  */
#define kDDCForceReadMask 				0x01				/*  Mask for kddcForceReadBit.  */

#define timingInvalid 					0					/* 	Unknown timing… force user to confirm.  */
#define timingInvalid_SM_T24 			8					/* 	Work around bug in SM Thunder24 card. */
#define timingApple_FixedRateLCD 		42					/* 	Lump all fixed-rate LCDs into one category. */
#define timingApple_512x384_60hz 		130					/*   512x384  (60 Hz) Rubik timing.  */
#define timingApple_560x384_60hz 		135					/*   560x384  (60 Hz) Rubik-560 timing.  */
#define timingApple_640x480_67hz 		140					/*   640x480  (67 Hz) HR timing.  */
#define timingApple_640x400_67hz 		145					/*   640x400  (67 Hz) HR-400 timing.  */
#define timingVESA_640x480_60hz 		150					/*   640x480  (60 Hz) VGA timing.  */
#define timingVESA_640x480_72hz 		152					/*   640x480  (72 Hz) VGA timing.  */
#define timingVESA_640x480_75hz 		154					/*   640x480  (75 Hz) VGA timing.  */
#define timingVESA_640x480_85hz 		158					/*   640x480  (85 Hz) VGA timing.  */
#define timingGTF_640x480_120hz 		159					/*   640x480  (120 Hz) VESA Generalized Timing Formula  */
#define timingApple_640x870_75hz 		160					/*   640x870  (75 Hz) FPD timing. */
#define timingApple_640x818_75hz 		165					/*   640x818  (75 Hz) FPD-818 timing. */
#define timingApple_832x624_75hz 		170					/*   832x624  (75 Hz) GoldFish timing. */
#define timingVESA_800x600_56hz 		180					/*   800x600  (56 Hz) SVGA timing.  */
#define timingVESA_800x600_60hz 		182					/*   800x600  (60 Hz) SVGA timing.  */
#define timingVESA_800x600_72hz 		184					/*   800x600  (72 Hz) SVGA timing.  */
#define timingVESA_800x600_75hz 		186					/*   800x600  (75 Hz) SVGA timing.  */
#define timingVESA_800x600_85hz 		188					/*   800x600  (85 Hz) SVGA timing.  */
#define timingVESA_1024x768_60hz 		190					/*  1024x768  (60 Hz) VESA 1K-60Hz timing.  */
#define timingVESA_1024x768_70hz 		200					/*  1024x768  (70 Hz) VESA 1K-70Hz timing.  */
#define timingVESA_1024x768_75hz 		204					/*  1024x768  (75 Hz) VESA 1K-75Hz timing (very similar to timingApple_1024x768_75hz).  */
#define timingVESA_1024x768_85hz 		208					/*  1024x768  (85 Hz) VESA timing.  */
#define timingApple_1024x768_75hz 		210					/*  1024x768  (75 Hz) Apple 19" RGB.  */
#define timingApple_1152x870_75hz 		220					/*  1152x870  (75 Hz) Apple 21" RGB.  */
#define timingAppleNTSC_ST 				230					/*   512x384  (60 Hz, interlaced, non-convolved).  */
#define timingAppleNTSC_FF 				232					/*   640x480  (60 Hz, interlaced, non-convolved).  */
#define timingAppleNTSC_STconv 			234					/*   512x384  (60 Hz, interlaced, convolved).  */
#define timingAppleNTSC_FFconv 			236					/*   640x480  (60 Hz, interlaced, convolved).  */
#define timingApplePAL_ST 				238					/*   640x480  (50 Hz, interlaced, non-convolved).  */
#define timingApplePAL_FF 				240					/*   768x576  (50 Hz, interlaced, non-convolved).  */
#define timingApplePAL_STconv 			242					/*   640x480  (50 Hz, interlaced, convolved).  */
#define timingApplePAL_FFconv 			244					/*   768x576  (50 Hz, interlaced, convolved).  */
#define timingVESA_1280x960_75hz 		250					/*  1280x960  (75 Hz)  */
#define timingVESA_1280x960_60hz 		252					/*  1280x960  (60 Hz)  */
#define timingVESA_1280x960_85hz 		254					/*  1280x960  (85 Hz)  */
#define timingVESA_1280x1024_60hz 		260					/*  1280x1024 (60 Hz)  */
#define timingVESA_1280x1024_75hz 		262					/*  1280x1024 (75 Hz)  */
#define timingVESA_1280x1024_85hz 		268					/*  1280x1024 (85 Hz)  */
#define timingVESA_1600x1200_60hz 		280					/*  1600x1200 (60 Hz) VESA proposed timing.  */
#define timingVESA_1600x1200_65hz 		282					/*  1600x1200 (65 Hz) VESA proposed timing.  */
#define timingVESA_1600x1200_70hz 		284					/*  1600x1200 (70 Hz) VESA proposed timing.  */
#define timingVESA_1600x1200_75hz 		286					/*  1600x1200 (75 Hz) VESA proposed timing.  */
#define timingVESA_1600x1200_80hz 		288					/*  1600x1200 (80 Hz) VESA proposed timing (pixel clock is 216 Mhz dot clock).  */
#define timingSMPTE240M_60hz 			400					/*  60Hz V, 33.75KHz H, interlaced timing, 16:9 aspect, typical resolution of 1920x1035.  */
#define timingFilmRate_48hz 			410					/*  48Hz V, 25.20KHz H, non-interlaced timing, typical resolution of 640x480.  */

#define timingApple12 					130
#define timingApple12x 					135
#define timingApple13 					140
#define timingApple13x 					145
#define timingAppleVGA 					150
#define timingApple15 					160
#define timingApple15x 					165
#define timingApple16 					170
#define timingAppleSVGA 				180
#define timingApple1Ka 					190
#define timingApple1Kb 					200
#define timingApple19 					210
#define timingApple21 					220

#define kAllModesValid 					0					/*  All modes not trimmed by primary init are good close enough to try  */
#define kAllModesSafe 					1					/*  All modes not trimmed by primary init are know to be safe  */
#define kReportsTagging 				2					/*  Can detect tagged displays (to identify smart monitors)  */
#define kHasDirectConnection 			3					/*  True implies that driver can talk directly to device (e.g. serial data link via sense lines)  */
#define kIsMonoDev 						4					/*  Says whether there’s an RGB (0) or Monochrome (1) connection.  */
#define kUncertainConnection 			5					/*  There may not be a display (no sense lines?).  */
#define kTaggingInfoNonStandard 		6					/*  Set when csConnectTaggedType/csConnectTaggedData are non-standard (i.e., not the Apple CRT sense codes).  */
#define kReportsDDCConnection 			7					/*  Card can do ddc (set kHasDirectConnect && kHasDDCConnect if you actually found a ddc display).  */
#define kHasDDCConnection 				8					/*  Card has ddc connect now.  */
#define kConnectionInactive 			9					/*  Set when the connection is NOT currently active (generally used in a multiconnection environment).  */
#define kDependentConnection 			10					/*  Set when some ascpect of THIS connection depends on another (will generally be set in a kModeSimulscan environment).  */
#define kBuiltInConnection 				11					/*  Set when connection is KNOWN to be built-in (this is not the same as kHasDirectConnection).  */

#define kUnknownConnect 				1					/*  Not sure how we’ll use this, but seems like a good idea.  */
#define kPanelConnect 					2					/*  For use with fixed-in-place LCD panels.  */
#define kPanelTFTConnect 				2					/*  Alias for kPanelConnect  */
#define kFixedModeCRTConnect 			3					/*   For use with fixed-mode (i.e., very limited range) displays.  */
#define kMultiModeCRT1Connect 			4					/*  320x200 maybe, 12" maybe, 13" (default), 16" certain, 19" maybe, 21" maybe  */
#define kMultiModeCRT2Connect 			5					/*  320x200 maybe, 12" maybe, 13" certain, 16" (default), 19" certain, 21" maybe  */
#define kMultiModeCRT3Connect 			6					/*  320x200 maybe, 12" maybe, 13" certain, 16" certain, 19" default, 21" certain  */
#define kMultiModeCRT4Connect 			7					/*  Expansion to large multi mode (not yet used)  */
#define kModelessConnect 				8					/*  Expansion to modeless model (not yet used)  */
#define kFullPageConnect 				9					/*  640x818 (to get 8bpp in 512K case) and 640x870 (these two only)  */
#define kVGAConnect 					10					/*  640x480 VGA default -- question everything else  */
#define kNTSCConnect 					11					/*  NTSC ST (default), FF, STconv, FFconv  */
#define kPALConnect 					12					/*  PAL ST (default), FF, STconv, FFconv  */
#define kHRConnect 						13					/*  Straight-6 connect -- 640x480 and 640x400 (to get 8bpp in 256K case) (these two only)  */
#define kPanelFSTNConnect 				14					/*  For use with fixed-in-place LCD FSTN (aka “Supertwist”) panels  */
#define kMonoTwoPageConnect 			15					/*  1152x870 Apple color two-page display  */
#define kColorTwoPageConnect 			16					/*  1152x870 Apple B&W two-page display  */
#define kColor16Connect 				17					/*  832x624 Apple B&W two-page display  */
#define kColor19Connect 				18					/*  1024x768 Apple B&W two-page display  */
#define kGenericCRT 					19					/*  Indicates nothing except that connection is CRT in nature.  */
#define kGenericLCD 					20					/*  Indicates nothing except that connection is LCD in nature.  */
#define kDDCConnect 					21					/*  DDC connection, always set kHasDDCConnection  */

#define kModeValid 						0					/*  Says that this mode should NOT be trimmed.  */
#define kModeSafe 						1					/*  This mode does not need confirmation  */
#define kModeDefault 					2					/*  This is the default mode for this type of connection  */
#define kModeShowNow 					3					/*  This mode should always be shown (even though it may require a confirm)  */
#define kModeNotResize 					4					/*  This mode should not be used to resize the display (eg. mode selects a different connector on card)  */
#define kModeRequiresPan 				5					/*  This mode has more pixels than are actually displayed  */
#define kModeInterlaced 				6					/*  This mode is interlaced (single pixel lines look bad).  */
#define kModeShowNever 					7					/*  This mode should not be shown in the user interface.  */
#define kModeSimulscan 					8					/*  Indicates that more than one display connection can be driven from a single framebuffer controller.  */
#define kModeNotPreset 					9					/*  Indicates that the timing is not a factory preset for the current display (geometry may need correction)  */
#define kModeBuiltIn 					10					/*  Indicates that the display mode is for the built-in connect only (on multiconnect devices like the PB 3400) Only the driver is quieried  */

#define kDepthDependent 				0					/*  Says that this depth mode may cause dependent changes in other framebuffers (and .  */
#define kResolutionHasMultipleDepthSizes  0					/*  Says that this mode has different csHorizontalPixels, csVerticalLines at different depths (usually slightly larger at lower depths)  */
															/* 	Power Mode constants for VDPowerStateRec.powerState.	 */
#define kAVPowerOff 					0
#define kAVPowerStandby 				1
#define kAVPowerSuspend 				2
#define kAVPowerOn 						3

															/* 	Power Mode masks and bits for VDPowerStateRec.powerFlags.	 */
#define kPowerStateNeedsRefresh 		0
#define kPowerStateNeedsRefreshMask 	0x00000001

															/*  Control Codes  */
#define cscReset 						0
#define cscKillIO 						1
#define cscSetMode 						2
#define cscSetEntries 					3
#define cscSetGamma 					4
#define cscGrayPage 					5
#define cscGrayScreen 					5
#define cscSetGray 						6
#define cscSetInterrupt 				7
#define cscDirectSetEntries 			8
#define cscSetDefaultMode 				9
#define cscSwitchMode 					10
#define cscSetSync 						11
#define cscSavePreferredConfiguration 	16
#define cscSetHardwareCursor 			22
#define cscDrawHardwareCursor 			23
#define cscSetConvolution 				24
#define cscSetPowerState 				25
#define cscPrivateControlCall 			26					/*  Takes a VDPrivateSelectorDataRec */
#define cscSetMultiConnect 				28					/*  From a GDI point of view, this call should be implemented completely in the HAL and not at all in the core. */
#define cscSetClutBehavior 				29					/*  Takes a VDClutBehavior  */
#define cscUnusedCall 					127					/*  This call used to expend the scrn resource.  Its imbedded data contains more control info  */

															/*  Status Codes  */
#define cscGetMode 						2
#define cscGetEntries 					3
#define cscGetPageCnt 					4
#define cscGetPages 					4					/*  This is what C&D 2 calls it.  */
#define cscGetPageBase 					5
#define cscGetBaseAddr 					5					/*  This is what C&D 2 calls it.  */
#define cscGetGray 						6
#define cscGetInterrupt 				7
#define cscGetGamma 					8
#define cscGetDefaultMode 				9
#define cscGetCurMode 					10
#define cscGetSync 						11
#define cscGetConnection 				12					/*  Return information about the connection to the display  */
#define cscGetModeTiming 				13					/*  Return timing info for a mode  */
#define cscGetModeBaseAddress 			14					/*  Return base address information about a particular mode  */
#define cscGetScanProc 					15					/*  QuickTime scan chasing routine  */
#define cscGetPreferredConfiguration 	16
#define cscGetNextResolution 			17
#define cscGetVideoParameters 			18
#define cscGetGammaInfoList 			20
#define cscRetrieveGammaTable 			21
#define cscSupportsHardwareCursor 		22
#define cscGetHardwareCursorDrawState 	23
#define cscGetConvolution 				24
#define cscGetPowerState 				25
#define cscPrivateStatusCall 			26					/*  Takes a VDPrivateSelectorDataRec */
#define cscGetDDCBlock 					27					/*  Takes a VDDDCBlockRec   */
#define cscGetMultiConnect 				28					/*  From a GDI point of view, this call should be implemented completely in the HAL and not at all in the core. */
#define cscGetClutBehavior 				29					/*  Takes a VDClutBehavior  */

#define kDisableHorizontalSyncBit 		0
#define kDisableVerticalSyncBit 		1
#define kDisableCompositeSyncBit 		2
#define kEnableSyncOnBlue 				3
#define kEnableSyncOnGreen 				4
#define kEnableSyncOnRed 				5
#define kNoSeparateSyncControlBit 		6
#define kTriStateSyncBit 				7
#define kHorizontalSyncMask 			0x01
#define kVerticalSyncMask 				0x02
#define kCompositeSyncMask 				0x04
#define kDPMSSyncMask 					0x07
#define kTriStateSyncMask 				0x80
#define kSyncOnBlueMask 				0x08
#define kSyncOnGreenMask 				0x10
#define kSyncOnRedMask 					0x20
#define kSyncOnMask 					0x38

															/* 	Power Mode constants for translating DPMS modes to Get/SetSync calls.	 */
#define kDPMSSyncOn 					0
#define kDPMSSyncStandby 				1
#define kDPMSSyncSuspend 				2
#define kDPMSSyncOff 					7

#define kConvolved 						0
#define kLiveVideoPassThru 				1
#define kConvolvedMask 					0x01
#define kLiveVideoPassThruMask 			0x02

#define kRSCZero 						0
#define kRSCOne 						1
#define kRSCTwo 						2
#define kRSCThree 						3
#define kRSCFour 						4
#define kRSCFive 						5
#define kRSCSix 						6
#define kRSCSeven 						7

#define kESCZero21Inch 					0x00				/*  21" RGB 								 */
#define kESCOnePortraitMono 			0x14				/*  Portrait Monochrome 					 */
#define kESCTwo12Inch 					0x21				/*  12" RGB								 */
#define kESCThree21InchRadius 			0x31				/*  21" RGB (Radius)						 */
#define kESCThree21InchMonoRadius 		0x34				/*  21" Monochrome (Radius) 				 */
#define kESCThree21InchMono 			0x35				/*  21" Monochrome						 */
#define kESCFourNTSC 					0x0A				/*  NTSC 								 */
#define kESCFivePortrait 				0x1E				/*  Portrait RGB 						 */
#define kESCSixMSB1 					0x03				/*  MultiScan Band-1 (12" thru 1Six")	 */
#define kESCSixMSB2 					0x0B				/*  MultiScan Band-2 (13" thru 19")		 */
#define kESCSixMSB3 					0x23				/*  MultiScan Band-3 (13" thru 21")		 */
#define kESCSixStandard 				0x2B				/*  13"/14" RGB or 12" Monochrome		 */
#define kESCSevenPAL 					0x00				/*  PAL									 */
#define kESCSevenNTSC 					0x14				/*  NTSC 								 */
#define kESCSevenVGA 					0x17				/*  VGA 									 */
#define kESCSeven16Inch 				0x2D				/*  16" RGB (GoldFish) 				 	 */
#define kESCSevenPALAlternate 			0x30				/*  PAL (Alternate) 						 */
#define kESCSeven19Inch 				0x3A				/*  Third-Party 19”						 */
#define kESCSevenNoDisplay 				0x3F				/*  No display connected 				 */

#define kDepthMode1 					128
#define kDepthMode2 					129
#define kDepthMode3 					130
#define kDepthMode4 					131
#define kDepthMode5 					132
#define kDepthMode6 					133

#define kFirstDepthMode 				128					/*  These constants are obsolete, and just included	 */
#define kSecondDepthMode 				129					/*  for clients that have converted to the above		 */
#define kThirdDepthMode 				130					/*  kDepthModeXXX constants.							 */
#define kFourthDepthMode 				131
#define kFifthDepthMode 				132
#define kSixthDepthMode 				133

#define kDisplayModeIDCurrent 			0x00				/*  Reference the Current DisplayModeID  */
#define kDisplayModeIDInvalid 			0xFFFFFFFF			/*  A bogus DisplayModeID in all cases  */
#define kDisplayModeIDFindFirstResolution  0xFFFFFFFE		/*  Used in cscGetNextResolution to reset iterator  */
#define kDisplayModeIDNoMoreResolutions  0xFFFFFFFD			/*  Used in cscGetNextResolution to indicate End Of List  */

#define kGammaTableIDFindFirst 			0xFFFFFFFE			/*  Get the first gamma table ID  */
#define kGammaTableIDNoMoreTables 		0xFFFFFFFD			/*  Used to indicate end of list  */
#define kGammaTableIDSpecific 			0x00				/*  Return the info for the given table id  */

#define kGetConnectionCount 			0xFFFFFFFF			/*  Used to get the number of possible connections in a “multi-headed” framebuffer environment. */
#define kActivateConnection 			0x00				/*  Used for activating a connection (csConnectFlags value). */
#define kDeactivateConnection 			0x0200				/*  Used for deactivating a connection (csConnectFlags value.) */

#define kSetClutAtSetEntries 			0					/*  SetEntries behavior is to update clut during SetEntries call */
#define kSetClutAtVBL 					1					/*  SetEntries behavior is to upate clut at next vbl */


#endif /* __VIDEO_R__ */

