{
     File:       ASRegistry.p
 
     Contains:   AppleScript Registry constants.
 
     Version:    Technology: AppleScript 1.3
                 Release:    Universal Interfaces 3.4.1
 
     Copyright:  © 1991-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT ASRegistry;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __ASREGISTRY__}
{$SETC __ASREGISTRY__ := 1}

{$I+}
{$SETC ASRegistryIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __AEREGISTRY__}
{$I AERegistry.p}
{$ENDC}
{$IFC UNDEFINED __AEOBJECTS__}
{$I AEObjects.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}



CONST
	keyAETarget					= 'targ';
	keySubjectAttr				= 'subj';						{  Magic 'returning' parameter:  }
	keyASReturning				= 'Krtn';						{  AppleScript Specific Codes:  }
	kASAppleScriptSuite			= 'ascr';
	kASScriptEditorSuite		= 'ToyS';
	kASTypeNamesSuite			= 'tpnm';						{  dynamic terminologies  }
	typeAETE					= 'aete';
	typeAEUT					= 'aeut';
	kGetAETE					= 'gdte';
	kGetAEUT					= 'gdut';
	kUpdateAEUT					= 'udut';
	kUpdateAETE					= 'udte';
	kCleanUpAEUT				= 'cdut';
	kASComment					= 'cmnt';
	kASLaunchEvent				= 'noop';
	keyScszResource				= 'scsz';
	typeScszResource			= 'scsz';						{  subroutine calls  }
	kASSubroutineEvent			= 'psbr';
	keyASSubroutineName			= 'snam';
	kASPrepositionalSubroutine	= 'psbr';
	keyASPositionalArgs			= 'parg';

																{  Add this parameter to a Get Data result if your app handled the 'as' parameter  }
	keyAppHandledCoercion		= 'idas';

																{  Miscellaneous AppleScript commands  }
	kASStartLogEvent			= 'log1';
	kASStopLogEvent				= 'log0';
	kASCommentEvent				= 'cmnt';


	{	 Operator Events: 	}
																{  Binary:  }
	kASAdd						= '+   ';
	kASSubtract					= '-   ';
	kASMultiply					= '*   ';
	kASDivide					= '/   ';
	kASQuotient					= 'div ';
	kASRemainder				= 'mod ';
	kASPower					= '^   ';
	kASEqual					= '=   ';
	kASNotEqual					= '≠   ';
	kASGreaterThan				= '>   ';
	kASGreaterThanOrEqual		= '>=  ';
	kASLessThan					= '<   ';
	kASLessThanOrEqual			= '<=  ';
	kASComesBefore				= 'cbfr';
	kASComesAfter				= 'cafr';
	kASConcatenate				= 'ccat';
	kASStartsWith				= 'bgwt';
	kASEndsWith					= 'ends';
	kASContains					= 'cont';

	kASAnd						= 'AND ';
	kASOr						= 'OR  ';						{  Unary:  }
	kASNot						= 'NOT ';
	kASNegate					= 'neg ';
	keyASArg					= 'arg ';

																{  event code for the 'error' statement  }
	kASErrorEventCode			= 'err ';
	kOSAErrorArgs				= 'erra';
	keyAEErrorObject			= 'erob';						{  Properties:  }
	pLength						= 'leng';
	pReverse					= 'rvse';
	pRest						= 'rest';
	pInherits					= 'c@#^';
	pProperties					= 'pALL';						{  User-Defined Record Fields:  }
	keyASUserRecordFields		= 'usrf';
	typeUserRecordFields		= 'list';

	{	 Prepositions: 	}
	keyASPrepositionAt			= 'at  ';
	keyASPrepositionIn			= 'in  ';
	keyASPrepositionFrom		= 'from';
	keyASPrepositionFor			= 'for ';
	keyASPrepositionTo			= 'to  ';
	keyASPrepositionThru		= 'thru';
	keyASPrepositionThrough		= 'thgh';
	keyASPrepositionBy			= 'by  ';
	keyASPrepositionOn			= 'on  ';
	keyASPrepositionInto		= 'into';
	keyASPrepositionOnto		= 'onto';
	keyASPrepositionBetween		= 'btwn';
	keyASPrepositionAgainst		= 'agst';
	keyASPrepositionOutOf		= 'outo';
	keyASPrepositionInsteadOf	= 'isto';
	keyASPrepositionAsideFrom	= 'asdf';
	keyASPrepositionAround		= 'arnd';
	keyASPrepositionBeside		= 'bsid';
	keyASPrepositionBeneath		= 'bnth';
	keyASPrepositionUnder		= 'undr';

	keyASPrepositionOver		= 'over';
	keyASPrepositionAbove		= 'abve';
	keyASPrepositionBelow		= 'belw';
	keyASPrepositionApartFrom	= 'aprt';
	keyASPrepositionGiven		= 'givn';
	keyASPrepositionWith		= 'with';
	keyASPrepositionWithout		= 'wout';
	keyASPrepositionAbout		= 'abou';
	keyASPrepositionSince		= 'snce';
	keyASPrepositionUntil		= 'till';

																{  Terminology & Dialect things:  }
	kDialectBundleResType		= 'Dbdl';						{  AppleScript Classes and Enums:  }
	cConstant					= 'enum';
	cClassIdentifier			= 'pcls';
	cObjectBeingExamined		= 'exmn';
	cList						= 'list';
	cSmallReal					= 'sing';
	cReal						= 'doub';
	cRecord						= 'reco';
	cReference					= 'obj ';
	cUndefined					= 'undf';
	cMissingValue				= 'msng';
	cSymbol						= 'symb';
	cLinkedList					= 'llst';
	cVector						= 'vect';
	cEventIdentifier			= 'evnt';
	cKeyIdentifier				= 'kyid';
	cUserIdentifier				= 'uid ';
	cPreposition				= 'prep';
	cKeyForm					= 'kfrm';
	cScript						= 'scpt';
	cHandler					= 'hand';
	cProcedure					= 'proc';

	cHandleBreakpoint			= 'brak';

	cClosure					= 'clsr';
	cRawData					= 'rdat';
	cStringClass				= 'TEXT';
	cNumber						= 'nmbr';
	cListElement				= 'celm';
	cListOrRecord				= 'lr  ';
	cListOrString				= 'ls  ';
	cListRecordOrString			= 'lrs ';
	cNumberOrString				= 'ns  ';
	cNumberOrDateTime			= 'nd  ';
	cNumberDateTimeOrString		= 'nds ';
	cAliasOrString				= 'sf  ';
	cSeconds					= 'scnd';
	typeSound					= 'snd ';
	enumBooleanValues			= 'boov';						{   Use this instead of typeBoolean to avoid with/without conversion   }
	kAETrue						= 'true';
	kAEFalse					= 'fals';
	enumMiscValues				= 'misc';
	kASCurrentApplication		= 'cura';						{  User-defined property ospecs:  }
	formUserPropertyID			= 'usrp';

	cString						= 'TEXT';						{  old name for cStringClass - can't be used in .r files }

																{  Global properties:  }
	pASIt						= 'it  ';
	pASMe						= 'me  ';
	pASResult					= 'rslt';
	pASSpace					= 'spac';
	pASReturn					= 'ret ';
	pASTab						= 'tab ';
	pASPi						= 'pi  ';
	pASParent					= 'pare';
	kASInitializeEventCode		= 'init';
	pASPrintLength				= 'prln';
	pASPrintDepth				= 'prdp';
	pASTopLevelScript			= 'ascr';

																{  Considerations  }
	kAECase						= 'case';
	kAEDiacritic				= 'diac';
	kAEWhiteSpace				= 'whit';
	kAEHyphens					= 'hyph';
	kAEExpansion				= 'expa';
	kAEPunctuation				= 'punc';
	kAEZenkakuHankaku			= 'zkhk';
	kAESmallKana				= 'skna';
	kAEKataHiragana				= 'hika';
	kASConsiderReplies			= 'rmte';
	enumConsiderations			= 'cons';

	{	 Considerations bit masks 	}
	kAECaseConsiderMask			= $00000001;
	kAEDiacriticConsiderMask	= $00000002;
	kAEWhiteSpaceConsiderMask	= $00000004;
	kAEHyphensConsiderMask		= $00000008;
	kAEExpansionConsiderMask	= $00000010;
	kAEPunctuationConsiderMask	= $00000020;
	kASConsiderRepliesConsiderMask = $00000040;
	kAECaseIgnoreMask			= $00010000;
	kAEDiacriticIgnoreMask		= $00020000;
	kAEWhiteSpaceIgnoreMask		= $00040000;
	kAEHyphensIgnoreMask		= $00080000;
	kAEExpansionIgnoreMask		= $00100000;
	kAEPunctuationIgnoreMask	= $00200000;
	kASConsiderRepliesIgnoreMask = $00400000;
	enumConsidsAndIgnores		= 'csig';

	cCoercion					= 'coec';
	cCoerceUpperCase			= 'txup';
	cCoerceLowerCase			= 'txlo';
	cCoerceRemoveDiacriticals	= 'txdc';
	cCoerceRemovePunctuation	= 'txpc';
	cCoerceRemoveHyphens		= 'txhy';
	cCoerceOneByteToTwoByte		= 'txex';
	cCoerceRemoveWhiteSpace		= 'txws';
	cCoerceSmallKana			= 'txsk';
	cCoerceZenkakuhankaku		= 'txze';
	cCoerceKataHiragana			= 'txkh';						{  Lorax things:  }
	cZone						= 'zone';
	cMachine					= 'mach';
	cAddress					= 'addr';
	cRunningAddress				= 'radd';
	cStorage					= 'stor';

																{  DateTime things:  }
	pASWeekday					= 'wkdy';
	pASMonth					= 'mnth';
	pASDay						= 'day ';
	pASYear						= 'year';
	pASTime						= 'time';
	pASDateString				= 'dstr';
	pASTimeString				= 'tstr';						{  Months  }
	cMonth						= 'mnth';
	cJanuary					= 'jan ';
	cFebruary					= 'feb ';
	cMarch						= 'mar ';
	cApril						= 'apr ';
	cMay						= 'may ';
	cJune						= 'jun ';
	cJuly						= 'jul ';
	cAugust						= 'aug ';
	cSeptember					= 'sep ';
	cOctober					= 'oct ';
	cNovember					= 'nov ';
	cDecember					= 'dec ';

																{  Weekdays  }
	cWeekday					= 'wkdy';
	cSunday						= 'sun ';
	cMonday						= 'mon ';
	cTuesday					= 'tue ';
	cWednesday					= 'wed ';
	cThursday					= 'thu ';
	cFriday						= 'fri ';
	cSaturday					= 'sat ';						{  AS 1.1 Globals:  }
	pASQuote					= 'quot';
	pASSeconds					= 'secs';
	pASMinutes					= 'min ';
	pASHours					= 'hour';
	pASDays						= 'days';
	pASWeeks					= 'week';						{  Writing Code things:  }
	cWritingCodeInfo			= 'citl';
	pScriptCode					= 'pscd';
	pLangCode					= 'plcd';						{  Magic Tell and End Tell events for logging:  }
	kASMagicTellEvent			= 'tell';
	kASMagicEndTellEvent		= 'tend';

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ASRegistryIncludes}

{$ENDC} {__ASREGISTRY__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}