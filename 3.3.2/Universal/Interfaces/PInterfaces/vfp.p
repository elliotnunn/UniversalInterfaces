{
     File:       vfp.p
 
     Contains:   MathLib style functions for vectors
 
     Version:    Technology: 1.0
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1999-2000 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT vfp;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __VFP__}
{$SETC __VFP__ := 1}

{$I+}
{$SETC vfpIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := vfpIncludes}

{$ENDC} {__VFP__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
