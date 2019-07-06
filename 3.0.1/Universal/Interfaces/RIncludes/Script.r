/*
 	File:		Script.r
 
 	Contains:	Script Manager interfaces
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1986-1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
*/

#ifndef __SCRIPT_R__
#define __SCRIPT_R__

#ifndef __CONDITIONALMACROS_R__
#include "ConditionalMacros.r"
#endif

															/*  Script System constants  */
#define smSystemScript 					(-1)				/* designates system script. */
#define smCurrentScript 				(-2)				/* designates current font script. */
#define smAllScripts 					(-3)				/* designates any script	 */

#define smRoman 						0					/* Roman */
#define smJapanese 						1					/* Japanese */
#define smTradChinese 					2					/* Traditional Chinese */
#define smKorean 						3					/* Korean */
#define smArabic 						4					/* Arabic */
#define smHebrew 						5					/* Hebrew */
#define smGreek 						6					/* Greek */
#define smCyrillic 						7					/* Cyrillic */
#define smRSymbol 						8					/* Right-left symbol */
#define smDevanagari 					9					/* Devanagari */
#define smGurmukhi 						10					/* Gurmukhi */
#define smGujarati 						11					/* Gujarati */
#define smOriya 						12					/* Oriya */
#define smBengali 						13					/* Bengali */
#define smTamil 						14					/* Tamil */
#define smTelugu 						15					/* Telugu */
#define smKannada 						16					/* Kannada/Kanarese */
#define smMalayalam 					17					/* Malayalam */

#define smSinhalese 					18					/* Sinhalese */
#define smBurmese 						19					/* Burmese */
#define smKhmer 						20					/* Khmer/Cambodian */
#define smThai 							21					/* Thai */
#define smLaotian 						22					/* Laotian */
#define smGeorgian 						23					/* Georgian */
#define smArmenian 						24					/* Armenian */
#define smSimpChinese 					25					/* Simplified Chinese */
#define smTibetan 						26					/* Tibetan */
#define smMongolian 					27					/* Mongolian */
#define smGeez 							28					/* Geez/Ethiopic */
#define smEthiopic 						28					/* Synonym for smGeez */
#define smEastEurRoman 					29					/* Synonym for smSlavic */
#define smCentralEuroRoman 				29					/*  another synonym  */
#define smVietnamese 					30					/* Vietnamese */
#define smExtArabic 					31					/* extended Arabic */
#define smUninterp 						32					/* uninterpreted symbols, e.g. palette symbols */
#define smKlingon 						32					/* Klingon */
															/* Obsolete names for script systems (kept for backward compatibility) */
#define smChinese 						2					/* (use smTradChinese or smSimpChinese) */
#define smRussian 						7					/* (old name for smCyrillic) */
															/*  smMaldivian = 25;         (no more smMaldivian!) */
#define smAmharic 						28					/* (old name for smGeez) */
#define smSlavic 						29					/* (old name for smEastEurRoman) */
#define smSindhi 						31					/* (old name for smExtArabic) */

															/*  Language Codes  */
#define langEnglish 					0					/*  smRoman script  */
#define langFrench 						1					/*  smRoman script  */
#define langGerman 						2					/*  smRoman script  */
#define langItalian 					3					/*  smRoman script  */
#define langDutch 						4					/*  smRoman script  */
#define langSwedish 					5					/*  smRoman script  */
#define langSpanish 					6					/*  smRoman script  */
#define langDanish 						7					/*  smRoman script  */
#define langPortuguese 					8					/*  smRoman script  */
#define langNorwegian 					9					/*  smRoman script  */
#define langHebrew 						10					/*  smHebrew script  */
#define langJapanese 					11					/*  smJapanese script  */
#define langArabic 						12					/*  smArabic script  */
#define langFinnish 					13					/*  smRoman script  */
#define langGreek 						14					/*  should be smGreek script; current systems actually use smRoman (11/95)  */
#define langIcelandic 					15					/*  variant smRoman script  */
#define langMaltese 					16					/*  variant smRoman script  */
#define langTurkish 					17					/*  variant smRoman script  */
#define langCroatian 					18					/*  Serbo-Croatian in variant Roman script  */
#define langTradChinese 				19					/*  Chinese in traditional characters  */

#define langUrdu 						20					/*  smArabic script  */
#define langHindi 						21					/*  smDevanagari script  */
#define langThai 						22					/*  smThai script  */
#define langKorean 						23					/*  smKorean script  */
#define langLithuanian 					24					/*  smCentralEuroRoman script  */
#define langPolish 						25					/*  smCentralEuroRoman script  */
#define langHungarian 					26					/*  smCentralEuroRoman script  */
#define langEstonian 					27					/*  smCentralEuroRoman script  */
#define langLettish 					28					/*  smCentralEuroRoman script  */
#define langLatvian 					28					/*  Synonym for langLettish  */
#define langSaamisk 					29					/*  lang. of the Sami/Lapp people of Scand. (11/95, no current script supports this)  */
#define langFaeroese 					30					/*  smRoman script  */
#define langFarsi 						31					/*  smArabic script  */
#define langPersian 					31					/*  Synonym for langFarsi  */
#define langRussian 					32					/*  smCyrillic script  */
#define langSimpChinese 				33					/*  Chinese in simplified characters  */
#define langFlemish 					34					/*  smRoman script  */
#define langIrish 						35					/*  smRoman script  */
#define langAlbanian 					36					/*  smRoman script  */

#define langRomanian 					37					/*  variant smRoman script (11/95) <22>  */
#define langCzech 						38					/*  smCentralEuroRoman script  */
#define langSlovak 						39					/*  smCentralEuroRoman script  */
#define langSlovenian 					40					/*  uses Croatian variant of smRoman script (11/95) <22>  */
#define langYiddish 					41					/*  smHebrew script  */
#define langSerbian 					42					/*  Serbo-Croatian in smCyrillic script  */
#define langMacedonian 					43					/*  smCyrillic script  */
#define langBulgarian 					44					/*  variant smCyrillic script (11/95) <22>  */
#define langUkrainian 					45					/*  variant smCyrillic script (11/95) <22>  */
#define langByelorussian 				46					/*  smCyrillic script  */
#define langUzbek 						47					/*  variant smCyrillic script (11/95) <22>  */
#define langKazakh 						48					/*  variant smCyrillic script (11/95) <22>  */
#define langAzerbaijani 				49					/*  Azerbaijani in variant smCyrillic script (11/95) <22>  */
#define langAzerbaijanAr 				50					/*  Azerbaijani in smArabic script (Iran)  */
#define langArmenian 					51					/*  smArmenian script  */
#define langGeorgian 					52					/*  smGeorgian script  */
#define langMoldavian 					53					/*  smCyrillic script  */
#define langKirghiz 					54					/*  variant smCyrillic script (11/95) <22>  */
#define langTajiki 						55					/*  variant smCyrillic script (11/95) <22>  */
#define langTurkmen 					56					/*  variant smCyrillic script (11/95) <22>  */

#define langMongolian 					57					/*  Mongolian in smMongolian script  */
#define langMongolianCyr 				58					/*  Mongolian in variant smCyrillic script (11/95) <22>  */
#define langPashto 						59					/*  smExtArabic script (11/95) <22>  */
#define langKurdish 					60					/*  smArabic script  */
#define langKashmiri 					61					/*  smExtArabic script (11/95) <22>  */
#define langSindhi 						62					/*  smExtArabic script (11/95) <22>  */
#define langTibetan 					63					/*  smTibetan script  */
#define langNepali 						64					/*  smDevanagari script  */
#define langSanskrit 					65					/*  smDevanagari script  */
#define langMarathi 					66					/*  smDevanagari script  */
#define langBengali 					67					/*  smBengali script  */
#define langAssamese 					68					/*  smBengali script  */
#define langGujarati 					69					/*  smGujarati script  */
#define langPunjabi 					70					/*  smGurmukhi script  */
#define langOriya 						71					/*  smOriya script  */
#define langMalayalam 					72					/*  smMalayalam script  */
#define langKannada 					73					/*  smKannada script  */
#define langTamil 						74					/*  smTamil script  */
#define langTelugu 						75					/*  smTelugu script  */
#define langSinhalese 					76					/*  smSinhalese script  */

#define langBurmese 					77					/*  smBurmese script  */
#define langKhmer 						78					/*  smKhmer script  */
#define langLao 						79					/*  smLaotian script  */
#define langVietnamese 					80					/*  smVietnamese script  */
#define langIndonesian 					81					/*  smRoman script  */
#define langTagalog 					82					/*  smRoman script  */
#define langMalayRoman 					83					/*  Malay in smRoman script  */
#define langMalayArabic 				84					/*  Malay in smArabic script  */
#define langAmharic 					85					/*  smEthiopic script  */
#define langTigrinya 					86					/*  smEthiopic script  */
#define langGalla 						87					/*  smEthiopic script  */
#define langOromo 						87					/*  Synonym for langGalla  */
#define langSomali 						88					/*  smRoman script  */
#define langSwahili 					89					/*  smRoman script  */
#define langKinyarwanda 				90					/*  smRoman script  */
#define langRuanda 						90					/*  synonym for langKinyarwanda  */
#define langRundi 						91					/*  smRoman script  */
#define langNyanja 						92					/*  smRoman script  */
#define langChewa 						92					/*  synonym for langNyanja  */
#define langMalagasy 					93					/*  smRoman script  */
#define langEsperanto 					94					/*  extended Roman script  */
#define langWelsh 						128					/*  smRoman script  */

#define langBasque 						129					/*  smRoman script  */
#define langCatalan 					130					/*  smRoman script  */
#define langLatin 						131					/*  smRoman script  */
#define langQuechua 					132					/*  smRoman script  */
#define langGuarani 					133					/*  smRoman script  */
#define langAymara 						134					/*  smRoman script  */
#define langTatar 						135					/*  smCyrillic script  */
#define langUighur 						136					/*  smArabic script  */
#define langDzongkha 					137					/*  (lang of Bhutan) smTibetan script  */
#define langJavaneseRom 				138					/*  Javanese in smRoman script  */
#define langSundaneseRom 				139					/*  Sundanese in smRoman script  */
#define langGalician 					140					/*  smRoman script  */
#define langAfricaans 					141					/*  smRoman script  */
															/*  Obsolete names, kept for backward compatibility  */
#define langPortugese 					8					/*  old misspelled version, kept for compatibility  */
#define langMalta 						16					/*  old misspelled version, kept for compatibility  */
#define langYugoslavian 				18					/*  (use langCroatian, langSerbian, etc.)  */
#define langChinese 					19					/*  (use langTradChinese or langSimpChinese)  */
#define langLapponian 					29					/*  Synonym for langSaamisk, not correct name  */
#define langLappish 					29					/*  Synonym for langSaamisk  */

															/*  Regional version codes  */
#define verUS 							0
#define verFrance 						1
#define verBritain 						2
#define verGermany 						3
#define verItaly 						4
#define verNetherlands 					5
#define verFrBelgiumLux 				6					/*  French for Belgium & Luxembourg  */
#define verSweden 						7
#define verSpain 						8
#define verDenmark 						9
#define verPortugal 					10
#define verFrCanada 					11
#define verNorway 						12

#define verIsrael 						13
#define verJapan 						14
#define verAustralia 					15
#define verArabic 						16					/*  synonym for verArabia  */
#define verFinland 						17
#define verFrSwiss 						18					/*  French Swiss  */
#define verGrSwiss 						19					/*  German Swiss  */
#define verGreece 						20
#define verIceland 						21
#define verMalta 						22
#define verCyprus 						23
#define verTurkey 						24
#define verYugoCroatian 				25					/*  Croatian system for Yugoslavia  */
#define verNetherlandsComma 			26
#define verBelgiumLuxPoint 				27
#define verCanadaComma 					28
#define verCanadaPoint 					29
#define vervariantPortugal 				30
#define vervariantNorway 				31
#define vervariantDenmark 				32
#define verIndiaHindi 					33					/*  Hindi system for India  */
#define verPakistan 					34
#define verTurkishModified 				35
#define verItalianSwiss 				36
#define verRomania 						39
#define verGreekAncient 				40
#define verLithuania 					41
#define verPoland 						42
#define verHungary 						43
#define verEstonia 						44
#define verLatvia 						45

#define verLapland 						46
#define verFaeroeIsl 					47
#define verIran 						48
#define verRussia 						49
#define verIreland 						50					/*  English-language version for Ireland  */
#define verKorea 						51
#define verChina 						52
#define verTaiwan 						53
#define verThailand 					54
#define verCzech 						56
#define verSlovak 						57
#define verGenericFE 					58
#define verMagyar 						59
#define verBengali 						60
#define verByeloRussian 				61
#define verUkrania 						62
#define verUkraine 						62
#define verAlternateGr 					64
#define verCroatia 						68
#define verBrazil 						71
#define verBulgaria 					72
#define verCatalonia 					73

/*----------------------------KSWP • Keyboard Swapping----------------------------------*/
type 'KSWP' {
		/* The expression below that calculates the number of elements in the
		   array is complicated because of the way that $$ResourceSize works.
		   $$ResourceSize returns the size of the resource.  When derez'ing a
		   resource, the size of the resource is known from the start.  When
		   rez'ing a resource, however, the size starts out at zero and is
		   incremented each time a field is appended to the resource data.  In
		   other words, while rez'ing, $$ResourceSize rarely returns the final
		   size of the resource.  When rez'ing a KSWP, the array size expression
		   is not evaluated until all of the array elements have been parsed.
		   Since each array element is 4 bytes long (if you add up all the fields),
		   the number of array elements is the size of the resource at that point
		   divided by four.  Since the preprocessor value of "DeRez" is zero when
		   Rez'ing, the expression is equivalent to $$ResourceSize / 4.  When
		   derez'ing a KSWP, the value of $$ResourceSize is constant: always the
		   total size of the resource, in bytes.  Since the resource contains 4
		   bytes of fill at the end (which happens to be the size of an array
		   element), we have to take that in consideration when calculating the
		   size of the array.  Note that the preprocessor value of "DeRez" is one,
		   when derez'ing.
		*/
		wide array [$$ResourceSize / 4 - DeRez]{
			hex integer		Roman, Japanese, Chinese, Korean,	/* script code or verb	*/
							Arabic, Hebrew, Greek,
							Rotate = -1, System = -2,
							Alternate = -3, RotateKybd = -4,	/* <20> */
							ToggleDirection = -9,
							SetDirLeftRight = -15,
							SetDirRightLeft = -16,
							RomanIfOthers = -17;				/* <25> */
			unsigned byte;										/* virtual key code		*/
			/* Modifiers */
			fill bit;											/* rControlOn,rControlOff*/
			fill bit;											/* rOptionOn,rOptionOff	*/
			fill bit;											/* rShiftOn,rShiftOff	*/
			boolean		controlOff, controlOn;
			boolean		optionOff, optionOn;
			fill bit;											/* capsLockOn,capsLockOff*/
			boolean		shiftOff, shiftOn;
			boolean		commandOff, commandOn;
		};
		fill long;
};

#endif /* __SCRIPT_R__ */

