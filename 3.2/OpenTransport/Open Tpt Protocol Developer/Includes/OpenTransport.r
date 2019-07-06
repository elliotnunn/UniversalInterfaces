/*
	File:		OpenTransport.r

	Contains:	Templates and stuff for Open Transport resources

	Copyright:	© 1996 by Apple Computer, Inc., all rights reserved.

*/

#define kOTCFMClass					'otan'

#define kOTModulePrefix				"OTModl$"
#define kOTClientPrefix				"OTClnt$"
#define kOTKernelPrefix				"OTKrnl$"
/*
 * These are drop-ins that we search for by the extended CFRG
 */
#define kOTConfiguratorCFMTag		kOTClientPrefix "cfigMkr"
#define kOTPortScannerCFMTag		kOTKernelPrefix "pScnr"
#define kOTPseudoPortScannerCFMTag	kOTKernelPrefix "ppScnr"
