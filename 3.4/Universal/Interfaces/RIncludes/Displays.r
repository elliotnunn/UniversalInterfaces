/*
     File:       Displays.r
 
     Contains:   Display Manager Interfaces.
 
     Version:    Technology: Mac OS 8
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1993-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/

#ifndef __DISPLAYS_R__
#define __DISPLAYS_R__

#ifndef __CONDITIONALMACROS_R__
#include "ConditionalMacros.r"
#endif

#define kDisplayGestaltDisplayCommunicationAttr  'comm'
#define kDisplayGestaltForbidI2CMask 	0x01				/*  Some displays have firmware problems if they get I2C communication.  If this bit is set, then I2C communication is forbidden */
#define kDisplayGestaltUseI2CPowerMask 	0x02				/*  Some displays require I2C power settings (most use DPMS). */
#define kDisplayGestaltCalibratorAttr 	'cali'
#define kDisplayGestaltBrightnessAffectsGammaMask  0x01		/*  Used by default calibrator (should we show brightness panel)  */
#define kDisplayGestaltViewAngleAffectsGammaMask  0x02		/*  Currently not used by color sync */


#endif /* __DISPLAYS_R__ */
