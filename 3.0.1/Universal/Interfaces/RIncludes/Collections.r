/*
 	File:		Collections.r
 
 	Contains:	Collection Manager Interfaces
 
 	Version:	Technology:	System 7.x
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1989-1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
*/

#ifndef __COLLECTIONS_R__
#define __COLLECTIONS_R__

#ifndef __CONDITIONALMACROS_R__
#include "ConditionalMacros.r"
#endif

// 'cltn' - definition of a collection resource
type 'cltn' {
	longint = $$CountOf(ItemArray);
	array ItemArray
		{
		longint;	// tag
		longint;	// id
			boolean		itemUnlocked			=	false,	// defined attributes bits...
						itemLocked				=	true;
			boolean		itemNonPersistent		=	false,
						itemPersistent			=	true;
			unsigned bitstring[14] = 0;						// reserved attributes bits...
			unsigned bitstring[16];							// user attributes bits...
		wstring;
		align word;
	};
};

#endif /* __COLLECTIONS_R__ */

