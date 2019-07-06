{
 	File:		OCETemplates.p
 
 	Contains:	Apple Open Collaboration Environment Templates Interfaces.
 
 	Version:	Technology:	AOCE Toolbox 1.02
 				Release:	Universal Interfaces 3.2
 
 	Copyright:	© 1994-1998 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT OCETemplates;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OCETEMPLATES__}
{$SETC __OCETEMPLATES__ := 1}

{$I+}
{$SETC OCETemplatesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}

{$IFC UNDEFINED __OCE__}
{$I OCE.p}
{$ENDC}

{$IFC UNDEFINED __OCESTANDARDMAIL__}
{$I OCEStandardMail.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


{***********************************************************************************************
 ********************************* Template Resource Constants: *********************************
 ***********************************************************************************************}

{ Current versions of all the different template types: }

CONST
	kDETAspectVersion			= -976;
	kDETInfoPageVersion			= -976;
	kDETKillerVersion			= -976;
	kDETForwarderVersion		= -976;
	kDETFileTypeVersion			= -976;

{	"Normal" separation for template IDs within the file (this is just a suggestion; you can use whatever
	separation you like, so long as two separate templates don't have overlapping resources): }
	kDETIDSep					= 250;

{ A few predefined base IDs (again, just suggestions): }
	kDETFirstID					= 1000;
	kDETSecondID				= 1250;
	kDETThirdID					= 1500;
	kDETFourthID				= 1750;
	kDETFifthID					= 2000;

{	Templates consist of a set of associated resources, at constant offsets from a "base ID" set by the
	signature resource of the template. In the case of aspect templates, most of the resources in the
	template are accessible from the template as property default values. The property number is the same
	as the offset from the base ID of the resource. In describing the resources which make up templates,
	we give the type, the offset, and a description. For aspect templates, the offset is also the property #. 
	
	All templates include the following resource fork resources:

	 Type	Offset						Description
	 ----	------						-----------
	'rstr'	kDETTemplateName			Contains the name of the template

}
	kDETTemplateName			= 0;

{	Aspects, info-pages, and forwarders include the following as well:

	 Type	Offset						Description
	 ----	------						-----------
	'rstr'	kDETRecordType				Contains the type of record this applies to
	'rstr'	kDETAttributeType			Contains the type of attribute this applies to
	'detn'	kDETAttributeValueTag		Contains the tag of the attribute values this applies to

}
	kDETRecordType				= 1;
	kDETAttributeType			= 2;
	kDETAttributeValueTag		= 3;


{ ************************************ Aspects }
{	In the case of aspects, property numbers and resource id offsets are the same. Therefore, some of the following
	defines are used for resource offsets, some are used for dynamically generated properties, and some are used for
	both (i.e., properties which may be dynamically generated, but if they aren't, then they're taken from the
	resource). Resource types are given in all cases below; even if there is no actual resource (for example in
	the case of kDETAspectName), it indicates the type for the dynamically generated property. A resource type of
	'rstr' corresponds to a property type of kDETPrTypeString; type 'detn' corresponds to kDETPrTypeNumber; and
	'detb' corresponds to kDETPrTypeBinary.

	 Type	Offset						Description
	 ----	------						-----------
	'deta'	0							Identifies the type of resource
	'detc'	kDETCode					Is the code resource, if any is used
	'ICN#'	kDETAspectMainBitmap
	'icl8'	kDETAspectMainBitmap
	'icl4'	kDETAspectMainBitmap
	'ics#'	kDETAspectMainBitmap
	'ics8'	kDETAspectMainBitmap
	'ics4'	kDETAspectMainBitmap
	'sicn'	kDETAspectMainBitmap		Is the icon suite to display for this item type (main aspect only)
	'rstr'	kDETAspectName				Contains the name of the item (attribute main aspect only)
	'rst#'	kDETAspectCategory			Contains the internal categories for the record type (main aspect only)
	'rst#'	kDETAspectExternalCategory	Contains the external (user-visible) names which correspond to the categories in
										kDETAspectCategory; if this resource is not present, external names are taken from
										another template; if no other template provides an external name for a given internal
										category, the internal name is used as the external name (main aspect only)
	'rstr'	kDETAspectKind				Is the item kind to display (main aspect only)
	'detn'	kDETAspectGender			Is the gender of this kind of object for internationalization (main aspect only)
	'rstr'	kDETAspectWhatIs			Is the string for balloon help when item is in sublist (main aspect only)
	'rstr'	kDETAspectAliasKind			Is the item kind to display for aliases to this type of item (main aspect only)
	'detn'	kDETAspectAliasGender		Is the gender of an alias to this kind of object for internationalization (main aspect only)
	'rstr'	kDETAspectAliasWhatIs		Is the string for balloon help when an alias to the item is in sublist (main aspect only)
	'rst#'	kDETAspectBalloons			Is a list of strings for balloon help; for each item in an info-page, it's
										property # times 2 is used as an index into this array; if the item is not editable,
										then the property # times 2 plus 1 is used
	'rstr'	kDETAspectNewMenuName		Is the string to be used for the user to select new item creation; for records, the
										string is used as a menu entry in the Catalogs menu; for attributes, the string
										is used in a selection dialog invoked by an "Add..." button
	'rstr'	kDETAspectNewEntryName		Is the name to be used for new records (with a digit appended if not unique)
	'detb'	kDETAspectNewValue			Is the value to use when creating a new attribute value; the first four bytes
										is the tag; the rest is the attribute value contents
	'detn'	kDETAspectSublistOpenOnNew	If true (non-zero), automatically open newly created entries (property can be set
										from a code resource, or via a default value in a resource)
	'dett'	kDETAspectLookup			Is the attribute-to-property translation table
	'rstr'	kDETAspectDragInString		Is a string describing the action of dragging into this aspect (if any)
	'rstr'	kDETAspectDragInVerb		Is a single, short word that's the verb of the action (like "add" or "drop"; if
										there's any doubt, use "OK")
	'rstr'	kDETAspectDragInSummary		Is a short phrase that describes the action, suitable to be included in a selection list
	'rst#'	kDETAspectRecordDragIn		Is a list of type pairs; in each pair, the first is the type of a record which
										can be dragged into this aspect, and the second is the attribute type to store
										the reference in
	'rst#'	kDETAspectRecordCatDragIn	Is a list of category/attribute type pairs; in each pair, the first is the
										category of records which can be dragged in, and the second is the type of
										attribute to place the alias in
	'rst#'	kDETAspectAttrDragIn		Is a list of type triples; in each triple, the first is the record type which can be
										dragged from (or "" for any), the second is the attribute type which can be dragged
										in, and the third is the attribute type to store the new attribute in
	'rst#'	kDETAspectDragOut			Is a list of attribute types which can be dragged out of this aspect (an 'rst#'
										resource with no entries means nothing can be dragged out; no 'rst#' resource means
										everything can be dragged out)
	'detm'	kDETAspectViewMenu			Is a table to fill in the view menu from
	'detp'	kDETAspectReverseSort		Is a table listing which properties to sort in reverse order
	'detw'	kDETAspectInfoPageCustomWindow	Is a specification of a custom window size/placement & whether to use the
											page-selector (main aspect only)
	'detv'	kDETAspectInfoPageCustomWindow	Is a view list which is common to all info-pages (main aspect only)
}
	kDETAspectCode				= 4;
	kDETAspectMainBitmap		= 5;
	kDETAspectName				= 6;
	kDETAspectCategory			= 7;
	kDETAspectExternalCategory	= 8;
	kDETAspectKind				= 9;
	kDETAspectGender			= 10;
	kDETAspectWhatIs			= 11;
	kDETAspectAliasKind			= 12;
	kDETAspectAliasGender		= 13;
	kDETAspectAliasWhatIs		= 14;
	kDETAspectBalloons			= 15;
	kDETAspectNewMenuName		= 16;
	kDETAspectNewEntryName		= 17;
	kDETAspectNewValue			= 18;
	kDETAspectSublistOpenOnNew	= 19;
	kDETAspectLookup			= 20;
	kDETAspectDragInString		= 21;
	kDETAspectDragInVerb		= 22;
	kDETAspectDragInSummary		= 23;
	kDETAspectRecordDragIn		= 24;
	kDETAspectRecordCatDragIn	= 25;
	kDETAspectAttrDragIn		= 26;
	kDETAspectAttrDragOut		= 27;
	kDETAspectViewMenu			= 28;
	kDETAspectReverseSort		= 29;
	kDETAspectInfoPageCustomWindow = 30;

{ Properties: }
	kDETNoProperty				= -1;

{ Each aspect has 250 attribute properties in this range: }
	kDETFirstLocalProperty		= 0;
	kDETLastLocalProperty		= 249;

{ Developers should use property numbers starting at this point: }
	kDETFirstDevProperty		= 40;

{ The following range provides constant numeric properties for use in patterns and comparisons (constant n is
  
   given by kDETFirstConstantProperty+n): }
	kDETFirstConstantProperty	= 250;
	kDETLastConstantProperty	= 499;

{ To convert a number into a constant property, add this: }
	kDETConstantProperty		= 250;
	kDETZeroProperty			= 250;
	kDETOneProperty				= 251;
	kDETFalseProperty			= 250;
	kDETTrueProperty			= 251;

{ The following apply to records, attributes, or aliases; they are the name and kind, as they appear in icon lists: }
	kDETPrName					= 3050;
	kDETPrKind					= 3051;

{ Access mask properties: }
	kDETDNodeAccessMask			= 25825;						{  The DNode access mask  }
	kDETRecordAccessMask		= 25826;						{  The record access mask  }
	kDETAttributeAccessMask		= 25827;						{  The attribute access mask  }
	kDETPrimaryMaskByBit		= 25828;						{  A set of sixteen properties to access all bits of the primary mask  }

{ See AOCE documentation for details definitions of each of these bits: }
	kDETPrimarySeeMask			= 25828;
	kDETPrimaryAddMask			= 25829;
	kDETPrimaryDeleteMask		= 25830;
	kDETPrimaryChangeMask		= 25831;
	kDETPrimaryRenameMask		= 25832;
	kDETPrimaryChangePrivsMask	= 25833;
	kDETPrimaryTopMaskBit		= 25843;

{ The following property is zero until we've completed the first catalog lookup; from then on it's 1 }
	kDETPastFirstLookup			= 26550;

{ The following property is the page number; issuing a property command with this property will flip info-pages }
	kDETInfoPageNumber			= 27050;

{ The value of the following properties contains the template number of the targeted aspect's template, and the
   currently open info-page (if any). These values can be used with kDETAspectTemplate and kDETInfoPageTemplate
   target selectors. }
	kDETAspectTemplateNumber	= 26551;
	kDETInfoPageTemplateNumber	= 26552;

{ Properties for property commands to deal with sublist items: }
	kDETOpenSelectedItems		= 26553;						{  Open selected sublist items  }
	kDETAddNewItem				= 26554;						{  Add new sublist item  }
	kDETRemoveSelectedItems		= 26555;						{  Remove selected sublist items  }

{ Property types are used to specify types of properties and conversions between types (zero and negative numbers
   are reserved for Apple; developer code resources can use positive numbers): }
	kDETPrTypeNumber			= -1;							{  A number  }
	kDETPrTypeString			= -2;							{  A string  }
	kDETPrTypeBinary			= -3;							{  A binary block  }

{ ************************************ Info-pages }
{ Info-pages include the following as well:

	 Type	Offset						Description
	 ----	------						-----------
	'deti'	0							Identifies the type of resource; see below for details on the contents
	'rstr'	kDETInfoPageName			Is the name of the view to use in the page selection pop-up
	'rstr'	kDETInfoPageMainViewAspect	Is the name of the aspect to use with the main page view
	'rstr'	kDETInfoPageMenuName		Is the name of the catalogs menu ("Catalogs" if not present)
	'detm'	kDETInfoPageMenuEntries		Are menu entries to go in the Catalogs menu

}
	kDETInfoPageName			= 4;
	kDETInfoPageMainViewAspect	= 5;
	kDETInfoPageMenuName		= 6;
	kDETInfoPageMenuEntries		= 7;


{ ************************************ Views 

   Flags: }
	kDETNoFlags					= 0;							{  Main view (non-sublist) field enabled  }
	kDETEnabled					= $01;

{ The following flags make sense for items in a sublist only }
																{  Hilight view when entry is selected  }
	kDETHilightIfSelected		= $01;

{ The following flags make sense for text views only }
	kDETNumericOnly				= $08;							{  Only allow the user to enter digits  }
	kDETMultiLine				= $10;							{  Allow multiple lines in view  }
	kDETDynamicSize				= $0200;						{  Don't draw box around text until user clicks in it, then auto-size it  }
																{  Don't allow the user to enter colons (convert ":"s to "-"s)  }
	kDETAllowNoColons			= $0400;

{ The following flags are used for pop-up menus only }
																{  Automatically resize pop-up based on contents  }
	kDETPopupDynamicSize		= $0100;

{ The following flags are used for EditPicture views only }
																{  Scale picture to view bounds rather than cropping  }
	kDETScaleToView				= $0100;

{	Sizes for icons }
	kDETLargeIcon				= 0;
	kDETSmallIcon				= 1;
	kDETMiniIcon				= 2;

{ Stolen from TextEdit.h }
	kDETLeft					= 0;
	kDETCenter					= 1;
	kDETRight					= -1;
	kDETForceLeft				= -2;

{ Flags for use within Box view type attributes - these are distinct from the flags above }
	kDETUnused					= 0;
	kDETBoxTakesContentClicks	= $01;
	kDETBoxIsRounded			= $02;
	kDETBoxIsGrayed				= $04;
	kDETBoxIsInvisible			= $08;

{ The common font info }
	kDETApplicationFont			= 1;
	kDETApplicationFontSize		= 9;
	kDETAppFontLineHeight		= 12;
	kDETSystemFont				= 0;
	kDETSystemFontSize			= 12;
	kDETSystemFontLineHeight	= 16;
	kDETDefaultFont				= 1;
	kDETDefaultFontSize			= 9;
	kDETDefaultFontLineHeight	= 12;

{	These were taken from QuickDraw.h (where they're enums and therefore unusable in resource definitions): }
	kDETNormal					= 0;
	kDETBold					= 1;
	kDETItalic					= 2;
	kDETUnderline				= 4;
	kDETOutline					= 8;
	kDETShadow					= $10;
	kDETCondense				= $20;
	kDETExtend					= $40;

	kDETIconStyle				= -3;							{  Normal text style for regular sublist entries, italic text style for aliases  }

{ View menu: }
	kDETChangeViewCommand		= 'view';						{  Change the view; used especially in StaticCommandTextFromView sublist headers  }

{ Info-page window sizes: }
{ Default record info-pages: }
	kDETRecordInfoWindHeight	= 228;
	kDETRecordInfoWindWidth		= 400;

{ Default attribute info-pages: }
	kDETAttributeInfoWindHeight	= 250;
	kDETAttributeInfoWindWidth	= 230;

{ Page identifying icon (for default info-page layout): }
	kDETSubpageIconTop			= 8;
	kDETSubpageIconLeft			= 8;
	kDETSubpageIconBottom		= 40;
	kDETSubpageIconRight		= 40;

{ ************************************ Killers 

   Killers include the following as well:

	 Type	Offset						Description
	 ----	------						-----------
	'detk'	0							Identifies the type of resource; see below for details on the contents
	'rst#'	kDETKillerName				Contains a list of template names to be killed

}
	kDETKillerName				= 1;

{ ************************************ Forwarders 

   Forwarders include the following as well:

	 Type	Offset						Description
	 ----	------						-----------
	'detf'	0							Identifies the type of resource; see below for details on the contents
	'rst#'	kDETForwarderTemplateNames	Contains a list of names of templates to forward to

}
	kDETForwarderTemplateNames	= 4;

{*********************************************************************************}
{******************************** Code Resources: ********************************}
{*********************************************************************************}
{ Target specification: }
	kDETSelf					= 0;							{  The "current" item  }
	kDETSelfOtherAspect			= 1;							{  Another aspect of the current item  }
	kDETParent					= 2;							{  The parent (i.e., the aspect we're in the sublist of, if any) of the current item  }
	kDETSublistItem				= 3;							{  The itemNumberth item in the sublist  }
	kDETSelectedSublistItem		= 4;							{  The itemNumberth selected item in the sublist  }
	kDETDSSpec					= 5;							{  The item specified by the packed DSSpec  }
	kDETAspectTemplate			= 6;							{  A specific aspect template (number itemNumber)  }
	kDETInfoPageTemplate		= 7;							{  A specific info-page template (number itemNumber) * Force type to be short  }
	kDETHighSelector			= $F000;


TYPE
	DETTargetSelector					= LONGINT;
	DETTargetSpecificationPtr = ^DETTargetSpecification;
	DETTargetSpecification = RECORD
		selector:				DETTargetSelector;						{  Target selection method (see above)  }
		aspectName:				RStringPtr;								{  The name of the aspect (kDETSelfOtherAspect, kDETSublistItem, }
																		{    kDETSelectedSublistItem, kDETDSSpec); nil for main aspect or none;  }
																		{   always filled in for calls if there is an aspect, even if it's the main aspect  }
		itemNumber:				LONGINT;								{  Sublist index (kDETSublistItem & kDETSelectedSublistItem & kDETAspectTemplate); }
																		{    1-based indexing  }
		dsSpec:					PackedDSSpecPtr;						{  DSSpec (kDETDSSpec only)  }
	END;

{ Code resource calls and call-backs both return an OSType:
		kDETDidNotHandle (1)	= used by template to say "I didn't handle it" (for calls only)
		noErr					= function completed successfully
		any error				= function failed, and here's why
}
{ Call-back functions:

		reqFunction							Action
		-----------							------
		kDETcmdBeep							Call SysBeep; useful for testing that a code resource's calls/call-backs are working at all

		kDETcmdBusy							Put up watch cursor and switch processes; user events elicit a beep

		kDETcmdChangeCallFors				Change call-fors mask

		kDETcmdGetCommandSelectionCount		Get the command selection count (for calls which have a command selection list)
		kDETcmdGetCommandItemN				Get command selection item n (for calls which have a command selection list)

		kDETcmdOpenDSSpec					PackedDSSpec open (can also be done via AppleEvents -- this is a short-cut)

		kDETcmdAboutToTalk					About to talk to user: bring us to front, disable watch cursor, etc.

		kDETcmdUnloadTemplates				Flush templates

		kDETcmdTemplateCounts				Return number of aspect and info-page templates in system

		kDETcmdGetDSSpec					Get the PackedDSSpec for this object

		kDETcmdSublistCount					Return the count of the sublist items
		kDETcmdSelectedSublistCount			Return the count of the selected sublist items

		kDETcmdRequestSync					Request a sync-up of the aspect with the catalog

		kDETcmdBreakAttribute				Break an attribute -- apply all applicable patterns to an attribute to generate properties

		kDETcmdGetTemplateFSSpec			Get the FSSpec of the file containing the template

		kDETcmdGetOpenEdit					Return the property of the view being edited (or kDETNoProperty if none)
		kDETcmdCloseEdit					Close the current edit

		kDETcmdGetPropertyType				Get a property type

		kDETcmdGetPropertyNumber			Get a property, number format
		kDETcmdGetPropertyRString			Get a property, RString format
		kDETcmdGetPropertyBinarySize		Get a property, binary, return size
		kDETcmdGetPropertyBinary			Get a property, binary format

		kDETcmdGetPropertyChanged			Get a property changed flag
		kDETcmdGetPropertyEditable			Get a property editable flag

		kDETcmdSetPropertyType				Set a property type

		kDETcmdSetPropertyNumber			Set a property, number format
		kDETcmdSetPropertyRString			Set a property, RString format
		kDETcmdSetPropertyBinary			Set a property, binary data & size

		kDETcmdSetPropertyChanged			Set a property changed flag
		kDETcmdSetPropertyEditable			Set a property editable flag

		kDETcmdDirtyProperty				Dirty a property (notify other code resources of change)

		kDETcmdDoPropertyCommand			Issue a property command

		kDETcmdAddMenu						Add to the end of a dynamic menu
		kDETcmdRemoveMenu					Remove a dynamic menu item
		kDETcmdMenuItemRString				Get a dynamic menu item RString

		kDETcmdSaveProperty					Force a save of a property -- apply all applicable patterns to write out the property

		kDETcmdGetCustomViewUserReference	Get custom view user reference (as given in .r file)
		kDETcmdGetCustomViewBounds			Get custom view current bounds

		kDETcmdGetResource					Get a resource from a template
}


CONST
	kDETcmdSimpleCallback		= 0;
	kDETcmdBeep					= 1;
	kDETcmdBusy					= 2;
	kDETcmdChangeCallFors		= 3;
	kDETcmdGetCommandSelectionCount = 4;
	kDETcmdGetCommandItemN		= 5;
	kDETcmdOpenDSSpec			= 6;
	kDETcmdAboutToTalk			= 7;
	kDETcmdUnloadTemplates		= 8;
	kDETcmdTemplateCounts		= 9;
	kDETcmdTargetedCallback		= 1000;
	kDETcmdGetDSSpec			= 1001;
	kDETcmdSublistCount			= 1002;
	kDETcmdSelectedSublistCount	= 1003;
	kDETcmdRequestSync			= 1004;
	kDETcmdBreakAttribute		= 1005;
	kDETcmdGetTemplateFSSpec	= 1006;
	kDETcmdGetOpenEdit			= 1007;
	kDETcmdCloseEdit			= 1008;
	kDETcmdPropertyCallback		= 2000;
	kDETcmdGetPropertyType		= 2001;
	kDETcmdGetPropertyNumber	= 2002;
	kDETcmdGetPropertyRString	= 2003;
	kDETcmdGetPropertyBinarySize = 2004;
	kDETcmdGetPropertyBinary	= 2005;
	kDETcmdGetPropertyChanged	= 2006;
	kDETcmdGetPropertyEditable	= 2007;
	kDETcmdSetPropertyType		= 2008;
	kDETcmdSetPropertyNumber	= 2009;
	kDETcmdSetPropertyRString	= 2010;
	kDETcmdSetPropertyBinary	= 2011;
	kDETcmdSetPropertyChanged	= 2012;
	kDETcmdSetPropertyEditable	= 2013;
	kDETcmdDirtyProperty		= 2014;
	kDETcmdDoPropertyCommand	= 2015;
	kDETcmdAddMenu				= 2016;
	kDETcmdRemoveMenu			= 2017;
	kDETcmdMenuItemRString		= 2018;
	kDETcmdSaveProperty			= 2019;
	kDETcmdGetCustomViewUserReference = 2020;
	kDETcmdGetCustomViewBounds	= 2021;
	kDETcmdGetResource			= 2022;							{  Force type to be long  }
	kDETcmdHighCallback			= $F0000000;


TYPE
	DETCallBackFunctions				= UInt32;
{ Call functions:

		reqFunction						Action
		-----------						------
		kDETcmdInit						Called once when template is first loaded (good time to allocate private data); returns call-for list
		kDETcmdExit						Called once when template is freed (good time to free private data)

		kDETcmdAttributeCreation		New sublist attribute creation about to occur; this gives the template a chance to modify
										the value that's about to be created; sent to the template that will be used for
										the main aspect of the new entry

		kDETcmdDynamicForwarders		Return a list of dynamically created forwarders

		kDETcmdInstanceInit				Called once when instance of template is started (good time to allocate private instance data)
		kDETcmdInstanceExit				Called once when instance is ended (good time to free private instance data)

		kDETcmdIdle						Called periodically during idle times

		kDETcmdViewListChanged			Called when the info-page view-list (list of enabled views) has changed

		kDETcmdValidateSave				Validate save: about to save info-page, return noErr (or kDETDidNotHandle) if it's OK to do so

		kDETcmdDropQuery				Drop query: return the appropriate operation for this drag; ask destination
		kDETcmdDropMeQuery				Drop query: return the appropriate operation for this drag; ask dropee

		kDETcmdAttributeNew				Attribute value new (return kDETDidNotHandle to let normal new processing occur)
		kDETcmdAttributeChange			Attribute value change (return kDETDidNotHandle to let normal change processing occur)
		kDETcmdAttributeDelete			Attribute value delete (return kDETDidNotHandle to let normal deletion occur); sent to the
										main aspect of the attribute that's about to be deleted
		kDETcmdItemNew					Target item (record or attribute) has just been created

		kDETcmdOpenSelf					Self open (return noErr to prevent opening; return kDETDidNotHandle to allow it)

		kDETcmdDynamicResource			Return a dynamically created resource

		kDETcmdShouldSync				Check if the code resource wants to force a sync (update data from catalog)
		kDETcmdDoSync					Give code resource a chance to sync (read in and break all attributes)

		kDETcmdPropertyCommand			Command received in the property number range (usually means a button's been pushed)

		kDETcmdMaximumTextLength		Return maximum size for text form of property

		kDETcmdPropertyDirtied			Property dirtied, need to redraw

		kDETcmdPatternIn				Custom pattern element encountered on reading in an attribute
		kDETcmdPatternOut				Custom pattern element encountered on writing out an attribute

		kDETcmdConvertToNumber			Convert from template-defined property type to number
		kDETcmdConvertToRString			Convert from template-defined property type to RString
		kDETcmdConvertFromNumber		Convert from number to template-defined property type
		kDETcmdConvertFromRString		Convert from RString to template-defined property type

		kDETcmdCustomViewDraw			Custom view draw
		kDETcmdCustomViewMouseDown		Custom view mouse down

		kDETcmdKeyPress					Key press (used primarily to filter entry into EditText views)
		kDETcmdPaste					Paste (used primarily to filter entry into EditText views)

		kDETcmdCustomMenuSelected		Custom Catalogs menu selected
		kDETcmdCustomMenuEnabled		Return whether custom Catalogs menu entry should be enabled
}


CONST
	kDETcmdSimpleCall			= 0;
	kDETcmdInit					= 1;
	kDETcmdExit					= 2;
	kDETcmdAttributeCreation	= 3;
	kDETcmdDynamicForwarders	= 4;
	kDETcmdTargetedCall			= 1000;
	kDETcmdInstanceInit			= 1001;
	kDETcmdInstanceExit			= 1002;
	kDETcmdIdle					= 1003;
	kDETcmdViewListChanged		= 1004;
	kDETcmdValidateSave			= 1005;
	kDETcmdDropQuery			= 1006;
	kDETcmdDropMeQuery			= 1007;
	kDETcmdAttributeNew			= 1008;
	kDETcmdAttributeChange		= 1009;
	kDETcmdAttributeDelete		= 1010;
	kDETcmdItemNew				= 1011;
	kDETcmdOpenSelf				= 1012;
	kDETcmdDynamicResource		= 1013;
	kDETcmdShouldSync			= 1014;
	kDETcmdDoSync				= 1015;
	kDETcmdPropertyCall			= 2000;
	kDETcmdPropertyCommand		= 2001;
	kDETcmdMaximumTextLength	= 2002;
	kDETcmdPropertyDirtied		= 2003;
	kDETcmdPatternIn			= 2004;
	kDETcmdPatternOut			= 2005;
	kDETcmdConvertToNumber		= 2006;
	kDETcmdConvertToRString		= 2007;
	kDETcmdConvertFromNumber	= 2008;
	kDETcmdConvertFromRString	= 2009;
	kDETcmdCustomViewDraw		= 2010;
	kDETcmdCustomViewMouseDown	= 2011;
	kDETcmdKeyPress				= 2012;
	kDETcmdPaste				= 2013;
	kDETcmdCustomMenuSelected	= 2014;
	kDETcmdCustomMenuEnabled	= 2015;
	kDETcmdHighCall				= $F0000000;					{  Force the type to be long  }


TYPE
	DETCallFunctions					= UInt32;
{ Valid commandIDs for DETDropQueryBlock and DETDropMeQueryBlock (in addition to property numbers): }

CONST
	kDETDoNothing				= 'xxx0';
	kDETMove					= 'move';
	kDETDrag					= 'drag';
	kDETAlias					= 'alis';



TYPE
	DETProtoCallBackBlockPtr = ^DETProtoCallBackBlock;
	DETProtoCallBackBlock = RECORD
		reqFunction:			DETCallBackFunctions;					{  Requested function  }
		target:					DETTargetSpecification;					{  The target for the request  }
		property:				INTEGER;								{  The property to apply the request to  }
	END;

	DETBeepBlockPtr = ^DETBeepBlock;
	DETBeepBlock = RECORD
		reqFunction:			DETCallBackFunctions;					{  Requested function  }
	END;

	DETBusyBlockPtr = ^DETBusyBlock;
	DETBusyBlock = RECORD
		reqFunction:			DETCallBackFunctions;					{  Requested function  }
	END;

	DETChangeCallForsBlockPtr = ^DETChangeCallForsBlock;
	DETChangeCallForsBlock = RECORD
		reqFunction:			DETCallBackFunctions;					{  Requested function  }
		target:					DETTargetSpecification;					{  The target for the request  }
		newCallFors:			LONGINT;								{   -> New call-for mask  }
	END;

	DETGetCommandSelectionCountBlockPtr = ^DETGetCommandSelectionCountBlock;
	DETGetCommandSelectionCountBlock = RECORD
		reqFunction:			DETCallBackFunctions;					{  Requested function  }
		count:					LONGINT;								{  <-  The number of items in the command selection list  }
	END;


CONST
	kDETHFSType					= 0;							{  HFS item type  }
	kDETDSType					= 1;							{  Catalog Service item type  }
	kDETMailType				= 2;							{  Mail (letter) item type  }
	kDETMoverType				= 3;							{  Sounds, fonts, etc., from inside a suitcase or system file  }
	kDETLastItemType			= $F0000000;					{  Force it to be a long (C & C++ seem to disagree about the definition of 0xF000)  }


TYPE
	DETItemType							= UInt32;
{ FSSpec plus possibly interesting additional info }
	DETFSInfoPtr = ^DETFSInfo;
	DETFSInfo = RECORD
		fileType:				OSType;									{  File type  }
		fileCreator:			OSType;									{  File creator  }
		fdFlags:				UInt16;									{  Finder flags  }
		fsSpec:					FSSpec;									{  FSSpec  }
	END;

	DSRecPtr = ^DSRec;
	DSRec = RECORD
		dsSpec:					^PackedDSSpecPtr;						{  <-  DSSpec for item (caller must DisposHandle() when done)  }
		refNum:					INTEGER;								{  <-  Refnum for returned address  }
		identity:				AuthIdentity;							{  <-  Identity for returned address  }
	END;

	ItemRecPtr = ^ItemRec;
	ItemRec = RECORD
		CASE INTEGER OF
		0: (
			fsInfo:				^DETFSInfoPtr;							{  <-  FSSpec & info for item (caller must DisposHandle() when done)  }
			);
		1: (
			ds:					DSRec;
			);
		2: (
			dsSpec:				^PackedDSSpecPtr;						{  <-  DSSpec for item (caller must DisposHandle() when done)  }
			);
		3: (
			ltrSpec:			^LetterSpecPtr;							{  <-  Letter spec for item (caller must DisposHandle() when done)  }
			);
	END;

	DETGetCommandItemNBlockPtr = ^DETGetCommandItemNBlock;
	DETGetCommandItemNBlock = RECORD
		reqFunction:			DETCallBackFunctions;					{  Requested function  }
		itemNumber:				LONGINT;								{   -> Item number to retrieve (1-based)  }
		itemType:				DETItemType;							{   -> Type of item to be returned (if we can interpret it as such)  }
		item:					ItemRec;
	END;

	DETGetDSSpecBlockPtr = ^DETGetDSSpecBlock;
	DETGetDSSpecBlock = RECORD
		reqFunction:			DETCallBackFunctions;					{  Requested function  }
		target:					DETTargetSpecification;					{  The target for the request  }
		dsSpec:					^PackedDSSpecPtr;						{  <-  Handle with result (caller must DisposHandle() when done)  }
		refNum:					INTEGER;								{  <-  Refnum for address if PD  }
		identity:				AuthIdentity;							{  <-  Identity for address  }
		isAlias:				BOOLEAN;								{  <-  True if this entry is an alias  }
		isRecordRef:			BOOLEAN;								{  <-  True if this entry is a record reference (reserved)  }
	END;

	DETGetTemplateFSSpecBlockPtr = ^DETGetTemplateFSSpecBlock;
	DETGetTemplateFSSpecBlock = RECORD
		reqFunction:			DETCallBackFunctions;					{  Requested function  }
		target:					DETTargetSpecification;					{  The target for the request  }
		fsSpec:					FSSpec;									{  <-  FSSpec of template file  }
		baseID:					INTEGER;								{  <-  Base ID of this template  }
		aspectTemplateNumber:	LONGINT;								{  <-  The template number for this aspect template  }
	END;

	DETGetOpenEditBlockPtr = ^DETGetOpenEditBlock;
	DETGetOpenEditBlock = RECORD
		reqFunction:			DETCallBackFunctions;					{  Requested function  }
		target:					DETTargetSpecification;					{  The target for the request  }
		viewProperty:			INTEGER;								{  <-  The property of the view being edited (or kNoProperty if none)  }
	END;

	DETCloseEditBlockPtr = ^DETCloseEditBlock;
	DETCloseEditBlock = RECORD
		reqFunction:			DETCallBackFunctions;					{  Requested function  }
		target:					DETTargetSpecification;					{  The target for the request  }
	END;

	DETGetPropertyTypeBlockPtr = ^DETGetPropertyTypeBlock;
	DETGetPropertyTypeBlock = RECORD
		reqFunction:			DETCallBackFunctions;					{  Requested function  }
		target:					DETTargetSpecification;					{  The target for the request  }
		property:				INTEGER;								{  The property to apply the request to  }
		propertyType:			INTEGER;								{  <-  The type of the property  }
	END;

	DETGetPropertyNumberBlockPtr = ^DETGetPropertyNumberBlock;
	DETGetPropertyNumberBlock = RECORD
		reqFunction:			DETCallBackFunctions;					{  Requested function  }
		target:					DETTargetSpecification;					{  The target for the request  }
		property:				INTEGER;								{  The property to apply the request to  }
		propertyValue:			UInt32;									{  <-  The value of the property  }
	END;

	DETGetPropertyRStringBlockPtr = ^DETGetPropertyRStringBlock;
	DETGetPropertyRStringBlock = RECORD
		reqFunction:			DETCallBackFunctions;					{  Requested function  }
		target:					DETTargetSpecification;					{  The target for the request  }
		property:				INTEGER;								{  The property to apply the request to  }
		propertyValue:			RStringHandle;							{  <-  A handle containing the property (as an RString) (caller must DisposHandle() when done)  }
	END;

	DETGetPropertyBinarySizeBlockPtr = ^DETGetPropertyBinarySizeBlock;
	DETGetPropertyBinarySizeBlock = RECORD
		reqFunction:			DETCallBackFunctions;					{  Requested function  }
		target:					DETTargetSpecification;					{  The target for the request  }
		property:				INTEGER;								{  The property to apply the request to  }
		propertyBinarySize:		LONGINT;								{  <-  The size of the property as a binary block  }
	END;

	DETGetPropertyBinaryBlockPtr = ^DETGetPropertyBinaryBlock;
	DETGetPropertyBinaryBlock = RECORD
		reqFunction:			DETCallBackFunctions;					{  Requested function  }
		target:					DETTargetSpecification;					{  The target for the request  }
		property:				INTEGER;								{  The property to apply the request to  }
		propertyValue:			Handle;									{  <-  Handle with the value of the property (caller must DisposHandle() when done)  }
	END;

	DETGetPropertyChangedBlockPtr = ^DETGetPropertyChangedBlock;
	DETGetPropertyChangedBlock = RECORD
		reqFunction:			DETCallBackFunctions;					{  Requested function  }
		target:					DETTargetSpecification;					{  The target for the request  }
		property:				INTEGER;								{  The property to apply the request to  }
		propertyChanged:		BOOLEAN;								{  <-  True if the property is marked as changed  }
		filler1:				BOOLEAN;
	END;

	DETGetPropertyEditableBlockPtr = ^DETGetPropertyEditableBlock;
	DETGetPropertyEditableBlock = RECORD
		reqFunction:			DETCallBackFunctions;					{  Requested function  }
		target:					DETTargetSpecification;					{  The target for the request  }
		property:				INTEGER;								{  The property to apply the request to  }
		propertyEditable:		BOOLEAN;								{  <-  True if the property can be edited by the user (if false, view will appear disabled)  }
		filler1:				BOOLEAN;
	END;

	DETSetPropertyTypeBlockPtr = ^DETSetPropertyTypeBlock;
	DETSetPropertyTypeBlock = RECORD
		reqFunction:			DETCallBackFunctions;					{  Requested function  }
		target:					DETTargetSpecification;					{  The target for the request  }
		property:				INTEGER;								{  The property to apply the request to  }
		newType:				INTEGER;								{   -> New type for property (just sets type, does not convert contents)  }
	END;

	DETSetPropertyNumberBlockPtr = ^DETSetPropertyNumberBlock;
	DETSetPropertyNumberBlock = RECORD
		reqFunction:			DETCallBackFunctions;					{  Requested function  }
		target:					DETTargetSpecification;					{  The target for the request  }
		property:				INTEGER;								{  The property to apply the request to  }
		newValue:				UInt32;									{   -> New value to set property to (and set type to number)  }
	END;

	DETSetPropertyRStringBlockPtr = ^DETSetPropertyRStringBlock;
	DETSetPropertyRStringBlock = RECORD
		reqFunction:			DETCallBackFunctions;					{  Requested function  }
		target:					DETTargetSpecification;					{  The target for the request  }
		property:				INTEGER;								{  The property to apply the request to  }
		newValue:				RStringPtr;								{   -> New value to set property to (and set type to RString)  }
	END;

	DETSetPropertyBinaryBlockPtr = ^DETSetPropertyBinaryBlock;
	DETSetPropertyBinaryBlock = RECORD
		reqFunction:			DETCallBackFunctions;					{  Requested function  }
		target:					DETTargetSpecification;					{  The target for the request  }
		property:				INTEGER;								{  The property to apply the request to  }
		newValue:				Ptr;									{   -> New value to set property to (and set type to binary)  }
		newValueSize:			LONGINT;								{   -> Size of new value  }
	END;

	DETSetPropertyChangedBlockPtr = ^DETSetPropertyChangedBlock;
	DETSetPropertyChangedBlock = RECORD
		reqFunction:			DETCallBackFunctions;					{  Requested function  }
		target:					DETTargetSpecification;					{  The target for the request  }
		property:				INTEGER;								{  The property to apply the request to  }
		propertyChanged:		BOOLEAN;								{   -> Value to set changed flag on property to  }
		filler1:				BOOLEAN;
	END;

	DETSetPropertyEditableBlockPtr = ^DETSetPropertyEditableBlock;
	DETSetPropertyEditableBlock = RECORD
		reqFunction:			DETCallBackFunctions;					{  Requested function  }
		target:					DETTargetSpecification;					{  The target for the request  }
		property:				INTEGER;								{  The property to apply the request to  }
		propertyEditable:		BOOLEAN;								{   -> Value to set editable flag on property to  }
		filler1:				BOOLEAN;
	END;

	DETDirtyPropertyBlockPtr = ^DETDirtyPropertyBlock;
	DETDirtyPropertyBlock = RECORD
		reqFunction:			DETCallBackFunctions;					{  Requested function  }
		target:					DETTargetSpecification;					{  The target for the request  }
		property:				INTEGER;								{  The property to apply the request to  }
	END;

	DETDoPropertyCommandBlockPtr = ^DETDoPropertyCommandBlock;
	DETDoPropertyCommandBlock = RECORD
		reqFunction:			DETCallBackFunctions;					{  Requested function  }
		target:					DETTargetSpecification;					{  The target for the request  }
		property:				INTEGER;								{  The property to apply the request to  }
		parameter:				LONGINT;								{  ->  Parameter of command  }
	END;

	DETSublistCountBlockPtr = ^DETSublistCountBlock;
	DETSublistCountBlock = RECORD
		reqFunction:			DETCallBackFunctions;					{  Requested function  }
		target:					DETTargetSpecification;					{  The target for the request  }
		count:					LONGINT;								{  <-  The number of items in the current item's sublist  }
	END;

	DETSelectedSublistCountBlockPtr = ^DETSelectedSublistCountBlock;
	DETSelectedSublistCountBlock = RECORD
		reqFunction:			DETCallBackFunctions;					{  Requested function  }
		target:					DETTargetSpecification;					{  The target for the request  }
		count:					LONGINT;								{  <-  The number of selected items in the current item's sublist  }
	END;

	DETRequestSyncBlockPtr = ^DETRequestSyncBlock;
	DETRequestSyncBlock = RECORD
		reqFunction:			DETCallBackFunctions;					{  Requested function  }
		target:					DETTargetSpecification;					{  The target for the request  }
	END;

	DETAddMenuBlockPtr = ^DETAddMenuBlock;
	DETAddMenuBlock = RECORD
		reqFunction:			DETCallBackFunctions;					{  Requested function  }
		target:					DETTargetSpecification;					{  The target for the request  }
		property:				INTEGER;								{  The property to apply the request to  }
		name:					RStringPtr;								{   -> Name of new menu item  }
		parameter:				LONGINT;								{   -> Parameter to return when this item is selected  }
		addAfter:				LONGINT;								{   -> Parameter of entry to add after, or -1 for add at end  }
	END;

	DETRemoveMenuBlockPtr = ^DETRemoveMenuBlock;
	DETRemoveMenuBlock = RECORD
		reqFunction:			DETCallBackFunctions;					{  Requested function  }
		target:					DETTargetSpecification;					{  The target for the request  }
		property:				INTEGER;								{  The property to apply the request to  }
		itemToRemove:			LONGINT;								{   -> Parameter of menu item to remove  }
	END;

	DETMenuItemRStringBlockPtr = ^DETMenuItemRStringBlock;
	DETMenuItemRStringBlock = RECORD
		reqFunction:			DETCallBackFunctions;					{  Requested function  }
		target:					DETTargetSpecification;					{  The target for the request  }
		property:				INTEGER;								{  The property to apply the request to  }
		itemParameter:			LONGINT;								{   -> Parameter of menu item to return string for  }
		rString:				RStringHandle;							{  <-  Handle with the RString (caller must DisposHandle() when done)  }
	END;

	DETOpenDSSpecBlockPtr = ^DETOpenDSSpecBlock;
	DETOpenDSSpecBlock = RECORD
		reqFunction:			DETCallBackFunctions;					{  Requested function  }
		dsSpec:					PackedDSSpecPtr;						{   -> DSSpec of object to be opened  }
	END;

	DETAboutToTalkBlockPtr = ^DETAboutToTalkBlock;
	DETAboutToTalkBlock = RECORD
		reqFunction:			DETCallBackFunctions;					{  Requested function  }
	END;

	DETBreakAttributeBlockPtr = ^DETBreakAttributeBlock;
	DETBreakAttributeBlock = RECORD
		reqFunction:			DETCallBackFunctions;					{  Requested function  }
		target:					DETTargetSpecification;					{  The target for the request  }
		breakAttribute:			AttributePtr;							{   -> Attribute to parse  }
		isChangeable:			BOOLEAN;								{   -> True if the value can be changed by the user  }
		filler1:				BOOLEAN;
	END;

	DETSavePropertyBlockPtr = ^DETSavePropertyBlock;
	DETSavePropertyBlock = RECORD
		reqFunction:			DETCallBackFunctions;					{  Requested function  }
		target:					DETTargetSpecification;					{  The target for the request  }
		property:				INTEGER;								{  The property to apply the request to  }
	END;

	DETGetCustomViewUserReferenceBlockPtr = ^DETGetCustomViewUserReferenceBlock;
	DETGetCustomViewUserReferenceBlock = RECORD
		reqFunction:			DETCallBackFunctions;					{  Requested function  }
		target:					DETTargetSpecification;					{  The target for the request  }
		property:				INTEGER;								{  The property to apply the request to  }
		userReference:			INTEGER;								{  <-  User reference value, as specified in the .r file  }
	END;

	DETGetCustomViewBoundsBlockPtr = ^DETGetCustomViewBoundsBlock;
	DETGetCustomViewBoundsBlock = RECORD
		reqFunction:			DETCallBackFunctions;					{  Requested function  }
		target:					DETTargetSpecification;					{  The target for the request  }
		property:				INTEGER;								{  The property to apply the request to  }
		bounds:					Rect;									{  <-  Bounds of the view  }
	END;

	DETGetResourceBlockPtr = ^DETGetResourceBlock;
	DETGetResourceBlock = RECORD
		reqFunction:			DETCallBackFunctions;					{  Requested function  }
		target:					DETTargetSpecification;					{  The target for the request  }
		property:				INTEGER;								{  The property to apply the request to  }
		resourceType:			ResType;								{   -> Resource type  }
		theResource:			Handle;									{  <-  The resource handle (caller must dispose when done)  }
	END;

	DETTemplateCountsPtr = ^DETTemplateCounts;
	DETTemplateCounts = RECORD
		reqFunction:			DETCallBackFunctions;					{  Requested function  }
		aspectTemplateCount:	LONGINT;								{  <-  Number of aspect templates in the system  }
		infoPageTemplateCount:	LONGINT;								{  <-  Number of info-page templates in the system  }
	END;

	DETUnloadTemplatesBlockPtr = ^DETUnloadTemplatesBlock;
	DETUnloadTemplatesBlock = RECORD
		reqFunction:			DETCallBackFunctions;					{  Requested function  }
	END;


	DETCallBackBlockPtr = ^DETCallBackBlock;
	DETCallBackBlock = RECORD
		CASE INTEGER OF
		0: (
			protoCallBack:		DETProtoCallBackBlock;
			);
		1: (
			beep:				DETBeepBlock;
			);
		2: (
			busy:				DETBusyBlock;
			);
		3: (
			changeCallFors:		DETChangeCallForsBlock;
			);
		4: (
			getCommandSelectionCount: DETGetCommandSelectionCountBlock;
			);
		5: (
			getCommandItemN:	DETGetCommandItemNBlock;
			);
		6: (
			getDSSpec:			DETGetDSSpecBlock;
			);
		7: (
			getTemplateFSSpec:	DETGetTemplateFSSpecBlock;
			);
		8: (
			getOpenEdit:		DETGetOpenEditBlock;
			);
		9: (
			closeEdit:			DETCloseEditBlock;
			);
		10: (
			getPropertyType:	DETGetPropertyTypeBlock;
			);
		11: (
			getPropertyNumber:	DETGetPropertyNumberBlock;
			);
		12: (
			getPropertyRString:	DETGetPropertyRStringBlock;
			);
		13: (
			getPropertyBinarySize: DETGetPropertyBinarySizeBlock;
			);
		14: (
			getPropertyBinary:	DETGetPropertyBinaryBlock;
			);
		15: (
			getPropertyChanged:	DETGetPropertyChangedBlock;
			);
		16: (
			getPropertyEditable: DETGetPropertyEditableBlock;
			);
		17: (
			setPropertyType:	DETSetPropertyTypeBlock;
			);
		18: (
			setPropertyNumber:	DETSetPropertyNumberBlock;
			);
		19: (
			setPropertyRString:	DETSetPropertyRStringBlock;
			);
		20: (
			setPropertyBinary:	DETSetPropertyBinaryBlock;
			);
		21: (
			setPropertyChanged:	DETSetPropertyChangedBlock;
			);
		22: (
			setPropertyEditable: DETSetPropertyEditableBlock;
			);
		23: (
			dirtyProperty:		DETDirtyPropertyBlock;
			);
		24: (
			doPropertyCommand:	DETDoPropertyCommandBlock;
			);
		25: (
			sublistCount:		DETSublistCountBlock;
			);
		26: (
			selectedSublistCount: DETSelectedSublistCountBlock;
			);
		27: (
			requestSync:		DETRequestSyncBlock;
			);
		28: (
			addMenu:			DETAddMenuBlock;
			);
		29: (
			removeMenu:			DETRemoveMenuBlock;
			);
		30: (
			menuItemRString:	DETMenuItemRStringBlock;
			);
		31: (
			openDSSpec:			DETOpenDSSpecBlock;
			);
		32: (
			aboutToTalk:		DETAboutToTalkBlock;
			);
		33: (
			breakAttribute:		DETBreakAttributeBlock;
			);
		34: (
			saveProperty:		DETSavePropertyBlock;
			);
		35: (
			getCustomViewUserReference: DETGetCustomViewUserReferenceBlock;
			);
		36: (
			getCustomViewBounds: DETGetCustomViewBoundsBlock;
			);
		37: (
			getResource:		DETGetResourceBlock;
			);
		38: (
			templateCounts:		DETTemplateCounts;
			);
		39: (
			unloadTemplates:	DETUnloadTemplatesBlock;
			);
	END;

	DETCallBlockPtr = ^DETCallBlock;
{$IFC TYPED_FUNCTION_POINTERS}
	DETCallBackProcPtr = FUNCTION(VAR callBlockPtr: DETCallBlock; callBackBlockPtr: DETCallBackBlockPtr): OSErr;
{$ELSEC}
	DETCallBackProcPtr = ProcPtr;
{$ENDC}

	DETCallBackUPP = UniversalProcPtr;
	DETCallBack							= DETCallBackUPP;
	DETProtoCallBlockPtr = ^DETProtoCallBlock;
	DETProtoCallBlock = RECORD
		reqFunction:			DETCallFunctions;						{  Requested function  }
		callBack:				DETCallBack;							{  Pointer to call-back routine  }
		callBackPrivate:		LONGINT;								{  Private data for the call-back routine  }
		templatePrivate:		LONGINT;								{  Private storage for use by code resource (stays for life of code resource,  }
																		{ 	common to all invocations of code resource)  }
		instancePrivate:		LONGINT;								{  Private storage for use by code resource (separate for each item using the  }
																		{ 	code resource)  }
		target:					DETTargetSpecification;					{  The target (originator) of the call, for targeted and property calls  }
		targetIsMainAspect:		BOOLEAN;								{  True if the target is the main aspect (even though it has a non-nil name)  }
		filler1:				BOOLEAN;
		property:				INTEGER;								{  The property number the call refers to  }
	END;

	DETInitBlockPtr = ^DETInitBlock;
	DETInitBlock = RECORD
		reqFunction:			DETCallFunctions;						{  Requested function  }
		callBack:				DETCallBack;							{  Pointer to call-back routine  }
		callBackPrivate:		LONGINT;								{  Private data for the call-back routine  }
		templatePrivate:		LONGINT;								{  Private storage for use by code resource (stays for life of code resource, common to all invocations of code resource)  }
		newCallFors:			LONGINT;								{  <-  New call-for mask  }
	END;

	DETExitBlockPtr = ^DETExitBlock;
	DETExitBlock = RECORD
		reqFunction:			DETCallFunctions;						{  Requested function  }
		callBack:				DETCallBack;							{  Pointer to call-back routine  }
		callBackPrivate:		LONGINT;								{  Private data for the call-back routine  }
		templatePrivate:		LONGINT;								{  Private storage for use by code resource (stays for life of code resource, common to all invocations of code resource)  }
	END;

	DETInstanceInitBlockPtr = ^DETInstanceInitBlock;
	DETInstanceInitBlock = RECORD
		reqFunction:			DETCallFunctions;						{  Requested function  }
		callBack:				DETCallBack;							{  Pointer to call-back routine  }
		callBackPrivate:		LONGINT;								{  Private data for the call-back routine  }
		templatePrivate:		LONGINT;								{  Private storage for use by code resource (stays for life of code resource,  }
																		{ 	common to all invocations of code resource)  }
		instancePrivate:		LONGINT;								{  Private storage for use by code resource (separate for each item using the  }
																		{ 	code resource)  }
		target:					DETTargetSpecification;					{  The target (originator) of the call, for targeted and property calls  }
		targetIsMainAspect:		BOOLEAN;								{  True if the target is the main aspect (even though it has a non-nil name)  }
		filler1:				BOOLEAN;
	END;

	DETInstanceExitBlockPtr = ^DETInstanceExitBlock;
	DETInstanceExitBlock = RECORD
		reqFunction:			DETCallFunctions;						{  Requested function  }
		callBack:				DETCallBack;							{  Pointer to call-back routine  }
		callBackPrivate:		LONGINT;								{  Private data for the call-back routine  }
		templatePrivate:		LONGINT;								{  Private storage for use by code resource (stays for life of code resource,  }
																		{ 	common to all invocations of code resource)  }
		instancePrivate:		LONGINT;								{  Private storage for use by code resource (separate for each item using the  }
																		{ 	code resource)  }
		target:					DETTargetSpecification;					{  The target (originator) of the call, for targeted and property calls  }
		targetIsMainAspect:		BOOLEAN;								{  True if the target is the main aspect (even though it has a non-nil name)  }
		filler1:				BOOLEAN;
	END;

	DETInstanceIdleBlockPtr = ^DETInstanceIdleBlock;
	DETInstanceIdleBlock = RECORD
		reqFunction:			DETCallFunctions;						{  Requested function  }
		callBack:				DETCallBack;							{  Pointer to call-back routine  }
		callBackPrivate:		LONGINT;								{  Private data for the call-back routine  }
		templatePrivate:		LONGINT;								{  Private storage for use by code resource (stays for life of code resource,  }
																		{ 	common to all invocations of code resource)  }
		instancePrivate:		LONGINT;								{  Private storage for use by code resource (separate for each item using the  }
																		{ 	code resource)  }
		target:					DETTargetSpecification;					{  The target (originator) of the call, for targeted and property calls  }
		targetIsMainAspect:		BOOLEAN;								{  True if the target is the main aspect (even though it has a non-nil name)  }
		filler1:				BOOLEAN;
	END;

	DETPropertyCommandBlockPtr = ^DETPropertyCommandBlock;
	DETPropertyCommandBlock = RECORD
		reqFunction:			DETCallFunctions;						{  Requested function  }
		callBack:				DETCallBack;							{  Pointer to call-back routine  }
		callBackPrivate:		LONGINT;								{  Private data for the call-back routine  }
		templatePrivate:		LONGINT;								{  Private storage for use by code resource (stays for life of code resource,  }
																		{ 	common to all invocations of code resource)  }
		instancePrivate:		LONGINT;								{  Private storage for use by code resource (separate for each item using the  }
																		{ 	code resource)  }
		target:					DETTargetSpecification;					{  The target (originator) of the call, for targeted and property calls  }
		targetIsMainAspect:		BOOLEAN;								{  True if the target is the main aspect (even though it has a non-nil name)  }
		filler1:				BOOLEAN;
		property:				INTEGER;								{  The property number the call refers to  }
		parameter:				LONGINT;								{   -> Parameter of command  }
	END;

	DETMaximumTextLengthBlockPtr = ^DETMaximumTextLengthBlock;
	DETMaximumTextLengthBlock = RECORD
		reqFunction:			DETCallFunctions;						{  Requested function  }
		callBack:				DETCallBack;							{  Pointer to call-back routine  }
		callBackPrivate:		LONGINT;								{  Private data for the call-back routine  }
		templatePrivate:		LONGINT;								{  Private storage for use by code resource (stays for life of code resource,  }
																		{ 	common to all invocations of code resource)  }
		instancePrivate:		LONGINT;								{  Private storage for use by code resource (separate for each item using the  }
																		{ 	code resource)  }
		target:					DETTargetSpecification;					{  The target (originator) of the call, for targeted and property calls  }
		targetIsMainAspect:		BOOLEAN;								{  True if the target is the main aspect (even though it has a non-nil name)  }
		filler1:				BOOLEAN;
		property:				INTEGER;								{  The property number the call refers to  }
		maxSize:				LONGINT;								{  <-  Return the maximum number of characters the user can entry when property is edited in an EditText  }
	END;

	DETViewListChangedBlockPtr = ^DETViewListChangedBlock;
	DETViewListChangedBlock = RECORD
		reqFunction:			DETCallFunctions;						{  Requested function  }
		callBack:				DETCallBack;							{  Pointer to call-back routine  }
		callBackPrivate:		LONGINT;								{  Private data for the call-back routine  }
		templatePrivate:		LONGINT;								{  Private storage for use by code resource (stays for life of code resource,  }
																		{ 	common to all invocations of code resource)  }
		instancePrivate:		LONGINT;								{  Private storage for use by code resource (separate for each item using the  }
																		{ 	code resource)  }
		target:					DETTargetSpecification;					{  The target (originator) of the call, for targeted and property calls  }
		targetIsMainAspect:		BOOLEAN;								{  True if the target is the main aspect (even though it has a non-nil name)  }
		filler1:				BOOLEAN;
	END;

	DETPropertyDirtiedBlockPtr = ^DETPropertyDirtiedBlock;
	DETPropertyDirtiedBlock = RECORD
		reqFunction:			DETCallFunctions;						{  Requested function  }
		callBack:				DETCallBack;							{  Pointer to call-back routine  }
		callBackPrivate:		LONGINT;								{  Private data for the call-back routine  }
		templatePrivate:		LONGINT;								{  Private storage for use by code resource (stays for life of code resource,  }
																		{ 	common to all invocations of code resource)  }
		instancePrivate:		LONGINT;								{  Private storage for use by code resource (separate for each item using the  }
																		{ 	code resource)  }
		target:					DETTargetSpecification;					{  The target (originator) of the call, for targeted and property calls  }
		targetIsMainAspect:		BOOLEAN;								{  True if the target is the main aspect (even though it has a non-nil name)  }
		filler1:				BOOLEAN;
		property:				INTEGER;								{  The property number the call refers to  }
	END;

	DETValidateSaveBlockPtr = ^DETValidateSaveBlock;
	DETValidateSaveBlock = RECORD
		reqFunction:			DETCallFunctions;						{  Requested function  }
		callBack:				DETCallBack;							{  Pointer to call-back routine  }
		callBackPrivate:		LONGINT;								{  Private data for the call-back routine  }
		templatePrivate:		LONGINT;								{  Private storage for use by code resource (stays for life of code resource,  }
																		{ 	common to all invocations of code resource)  }
		instancePrivate:		LONGINT;								{  Private storage for use by code resource (separate for each item using the  }
																		{ 	code resource)  }
		target:					DETTargetSpecification;					{  The target (originator) of the call, for targeted and property calls  }
		targetIsMainAspect:		BOOLEAN;								{  True if the target is the main aspect (even though it has a non-nil name)  }
		filler1:				BOOLEAN;
		errorString:			RStringHandle;							{  <-  Handle with error string if validation fails (callee must allocate handle, DE will DisposHandle() it)  }
	END;

	DETDropQueryBlockPtr = ^DETDropQueryBlock;
	DETDropQueryBlock = RECORD
		reqFunction:			DETCallFunctions;						{  Requested function  }
		callBack:				DETCallBack;							{  Pointer to call-back routine  }
		callBackPrivate:		LONGINT;								{  Private data for the call-back routine  }
		templatePrivate:		LONGINT;								{  Private storage for use by code resource (stays for life of code resource,  }
																		{ 	common to all invocations of code resource)  }
		instancePrivate:		LONGINT;								{  Private storage for use by code resource (separate for each item using the  }
																		{ 	code resource)  }
		target:					DETTargetSpecification;					{  The target (originator) of the call, for targeted and property calls  }
		targetIsMainAspect:		BOOLEAN;								{  True if the target is the main aspect (even though it has a non-nil name)  }
		filler1:				BOOLEAN;
		modifiers:				INTEGER;								{   -> Modifiers at drop time (option/control/command/shift keys)  }
		commandID:				LONGINT;								{  <-> Command ID (kDETDoNothing, kDETMove, kDETDrag (copy), kDETAlias, or a property number)  }
		destinationType:		AttributeType;							{  <-> Type to convert attribute to  }
		copyToHFS:				BOOLEAN;								{  <-  If true, object should be copied to HFS before being operated on, and deleted after  }
		filler2:				BOOLEAN;
	END;

	DETDropMeQueryBlockPtr = ^DETDropMeQueryBlock;
	DETDropMeQueryBlock = RECORD
		reqFunction:			DETCallFunctions;						{  Requested function  }
		callBack:				DETCallBack;							{  Pointer to call-back routine  }
		callBackPrivate:		LONGINT;								{  Private data for the call-back routine  }
		templatePrivate:		LONGINT;								{  Private storage for use by code resource (stays for life of code resource,  }
																		{ 	common to all invocations of code resource)  }
		instancePrivate:		LONGINT;								{  Private storage for use by code resource (separate for each item using the  }
																		{ 	code resource)  }
		target:					DETTargetSpecification;					{  The target (originator) of the call, for targeted and property calls  }
		targetIsMainAspect:		BOOLEAN;								{  True if the target is the main aspect (even though it has a non-nil name)  }
		filler1:				BOOLEAN;
		modifiers:				INTEGER;								{   -> Modifiers at drop time (option/control/command/shift keys)  }
		commandID:				LONGINT;								{  <-> Command ID (kDETDoNothing, kDETMove, kDETDrag (copy), kDETAlias, or a property number)  }
		destinationType:		AttributeType;							{  <-> Type to convert attribute to  }
		copyToHFS:				BOOLEAN;								{  <-  If true, object should be copied to HFS before being operated on, and deleted after  }
		filler2:				BOOLEAN;
	END;

	DETAttributeCreationBlockPtr = ^DETAttributeCreationBlock;
	DETAttributeCreationBlock = RECORD
		reqFunction:			DETCallFunctions;						{  Requested function  }
		callBack:				DETCallBack;							{  Pointer to call-back routine  }
		callBackPrivate:		LONGINT;								{  Private data for the call-back routine  }
		templatePrivate:		LONGINT;								{  Private storage for use by code resource (stays for life of code resource, common to all invocations of code resource)  }
		parent:					PackedDSSpecPtr;						{   -> The object within which the creation will occur  }
		refNum:					INTEGER;								{   -> Refnum for returned address (DSSpecs in PDs only)  }
		identity:				AuthIdentity;							{   -> The identity we're browsing as in the parent object  }
		attrType:				AttributeType;							{  <-> The type of the attribute being created  }
		attrTag:				AttributeTag;							{  <-> The tag of the attribute being created  }
		value:					Handle;									{  <-> The value to write (pre-allocated, resize as needed)  }
	END;

	DETAttributeNewBlockPtr = ^DETAttributeNewBlock;
	DETAttributeNewBlock = RECORD
		reqFunction:			DETCallFunctions;						{  Requested function  }
		callBack:				DETCallBack;							{  Pointer to call-back routine  }
		callBackPrivate:		LONGINT;								{  Private data for the call-back routine  }
		templatePrivate:		LONGINT;								{  Private storage for use by code resource (stays for life of code resource,  }
																		{ 	common to all invocations of code resource)  }
		instancePrivate:		LONGINT;								{  Private storage for use by code resource (separate for each item using the  }
																		{ 	code resource)  }
		target:					DETTargetSpecification;					{  The target (originator) of the call, for targeted and property calls  }
		targetIsMainAspect:		BOOLEAN;								{  True if the target is the main aspect (even though it has a non-nil name)  }
		filler1:				BOOLEAN;
		parent:					PackedDSSpecPtr;						{   -> The object within which the creation will occur  }
		refNum:					INTEGER;								{   -> Refnum for returned address (DSSpecs in PDs only)  }
		identity:				AuthIdentity;							{   -> The identity we're browsing as in the parent object  }
		attrType:				AttributeType;							{  <-> The type of the attribute being created  }
		attrTag:				AttributeTag;							{  <-> The tag of the attribute being created  }
		value:					Handle;									{  <-> The value to write (pre-allocated, resize as needed)  }
	END;

	DETAttributeChangeBlockPtr = ^DETAttributeChangeBlock;
	DETAttributeChangeBlock = RECORD
		reqFunction:			DETCallFunctions;						{  Requested function  }
		callBack:				DETCallBack;							{  Pointer to call-back routine  }
		callBackPrivate:		LONGINT;								{  Private data for the call-back routine  }
		templatePrivate:		LONGINT;								{  Private storage for use by code resource (stays for life of code resource,  }
																		{ 	common to all invocations of code resource)  }
		instancePrivate:		LONGINT;								{  Private storage for use by code resource (separate for each item using the  }
																		{ 	code resource)  }
		target:					DETTargetSpecification;					{  The target (originator) of the call, for targeted and property calls  }
		targetIsMainAspect:		BOOLEAN;								{  True if the target is the main aspect (even though it has a non-nil name)  }
		filler1:				BOOLEAN;
		parent:					PackedDSSpecPtr;						{   -> The object within which the creation will occur  }
		refNum:					INTEGER;								{   -> Refnum for returned address (DSSpecs in PDs only)  }
		identity:				AuthIdentity;							{   -> The identity we're browsing as in the parent object  }
		attrType:				AttributeType;							{  <-> The type of the attribute being changed  }
		attrTag:				AttributeTag;							{  <-> The tag of the attribute being changed  }
		attrCID:				AttributeCreationID;					{  <-> The CID of the attribute being changed  }
		value:					Handle;									{  <-> The value to write (pre-allocated, resize as needed)  }
	END;

	DETAttributeDeleteBlockPtr = ^DETAttributeDeleteBlock;
	DETAttributeDeleteBlock = RECORD
		reqFunction:			DETCallFunctions;						{  Requested function  }
		callBack:				DETCallBack;							{  Pointer to call-back routine  }
		callBackPrivate:		LONGINT;								{  Private data for the call-back routine  }
		templatePrivate:		LONGINT;								{  Private storage for use by code resource (stays for life of code resource,  }
																		{ 	common to all invocations of code resource)  }
		instancePrivate:		LONGINT;								{  Private storage for use by code resource (separate for each item using the  }
																		{ 	code resource)  }
		target:					DETTargetSpecification;					{  The target (originator) of the call, for targeted and property calls  }
		targetIsMainAspect:		BOOLEAN;								{  True if the target is the main aspect (even though it has a non-nil name)  }
		filler1:				BOOLEAN;
		dsSpec:					PackedDSSpecPtr;						{   -> The object which will be deleted  }
		refNum:					INTEGER;								{   -> Refnum for returned address (DSSpecs in PDs only)  }
		identity:				AuthIdentity;							{   -> The identity we're browsing as  }
	END;

	DETItemNewBlockPtr = ^DETItemNewBlock;
	DETItemNewBlock = RECORD
		reqFunction:			DETCallFunctions;						{  Requested function  }
		callBack:				DETCallBack;							{  Pointer to call-back routine  }
		callBackPrivate:		LONGINT;								{  Private data for the call-back routine  }
		templatePrivate:		LONGINT;								{  Private storage for use by code resource (stays for life of code resource,  }
																		{ 	common to all invocations of code resource)  }
		instancePrivate:		LONGINT;								{  Private storage for use by code resource (separate for each item using the  }
																		{ 	code resource)  }
		target:					DETTargetSpecification;					{  The target (originator) of the call, for targeted and property calls  }
		targetIsMainAspect:		BOOLEAN;								{  True if the target is the main aspect (even though it has a non-nil name)  }
		filler1:				BOOLEAN;
	END;

	DETShouldSyncBlockPtr = ^DETShouldSyncBlock;
	DETShouldSyncBlock = RECORD
		reqFunction:			DETCallFunctions;						{  Requested function  }
		callBack:				DETCallBack;							{  Pointer to call-back routine  }
		callBackPrivate:		LONGINT;								{  Private data for the call-back routine  }
		templatePrivate:		LONGINT;								{  Private storage for use by code resource (stays for life of code resource,  }
																		{ 	common to all invocations of code resource)  }
		instancePrivate:		LONGINT;								{  Private storage for use by code resource (separate for each item using the  }
																		{ 	code resource)  }
		target:					DETTargetSpecification;					{  The target (originator) of the call, for targeted and property calls  }
		targetIsMainAspect:		BOOLEAN;								{  True if the target is the main aspect (even though it has a non-nil name)  }
		filler1:				BOOLEAN;
		shouldSync:				BOOLEAN;								{  <-  True if we should now sync with catalog  }
		filler2:				BOOLEAN;
	END;

	DETDoSyncBlockPtr = ^DETDoSyncBlock;
	DETDoSyncBlock = RECORD
		reqFunction:			DETCallFunctions;						{  Requested function  }
		callBack:				DETCallBack;							{  Pointer to call-back routine  }
		callBackPrivate:		LONGINT;								{  Private data for the call-back routine  }
		templatePrivate:		LONGINT;								{  Private storage for use by code resource (stays for life of code resource,  }
																		{ 	common to all invocations of code resource)  }
		instancePrivate:		LONGINT;								{  Private storage for use by code resource (separate for each item using the  }
																		{ 	code resource)  }
		target:					DETTargetSpecification;					{  The target (originator) of the call, for targeted and property calls  }
		targetIsMainAspect:		BOOLEAN;								{  True if the target is the main aspect (even though it has a non-nil name)  }
		filler1:				BOOLEAN;
	END;

	DETPatternInBlockPtr = ^DETPatternInBlock;
	DETPatternInBlock = RECORD
		reqFunction:			DETCallFunctions;						{  Requested function  }
		callBack:				DETCallBack;							{  Pointer to call-back routine  }
		callBackPrivate:		LONGINT;								{  Private data for the call-back routine  }
		templatePrivate:		LONGINT;								{  Private storage for use by code resource (stays for life of code resource,  }
																		{ 	common to all invocations of code resource)  }
		instancePrivate:		LONGINT;								{  Private storage for use by code resource (separate for each item using the  }
																		{ 	code resource)  }
		target:					DETTargetSpecification;					{  The target (originator) of the call, for targeted and property calls  }
		targetIsMainAspect:		BOOLEAN;								{  True if the target is the main aspect (even though it has a non-nil name)  }
		filler1:				BOOLEAN;
		property:				INTEGER;								{  The property number the call refers to  }
		elementType:			LONGINT;								{   -> Element type from pattern  }
		extra:					LONGINT;								{   -> Extra field from pattern  }
		attribute:				AttributePtr;							{   -> The complete attribute  }
		dataOffset:				LONGINT;								{  <-> Offset to current (next) byte  }
		bitOffset:				INTEGER;								{  <-> Bit offset (next bit is *fData >> fBitOffset++)  }
	END;

	DETPatternOutBlockPtr = ^DETPatternOutBlock;
	DETPatternOutBlock = RECORD
		reqFunction:			DETCallFunctions;						{  Requested function  }
		callBack:				DETCallBack;							{  Pointer to call-back routine  }
		callBackPrivate:		LONGINT;								{  Private data for the call-back routine  }
		templatePrivate:		LONGINT;								{  Private storage for use by code resource (stays for life of code resource,  }
																		{ 	common to all invocations of code resource)  }
		instancePrivate:		LONGINT;								{  Private storage for use by code resource (separate for each item using the  }
																		{ 	code resource)  }
		target:					DETTargetSpecification;					{  The target (originator) of the call, for targeted and property calls  }
		targetIsMainAspect:		BOOLEAN;								{  True if the target is the main aspect (even though it has a non-nil name)  }
		filler1:				BOOLEAN;
		property:				INTEGER;								{  The property number the call refers to  }
		elementType:			LONGINT;								{   -> Element type from pattern  }
		extra:					LONGINT;								{   -> Extra field from pattern  }
		attribute:				AttributePtr;							{   -> The attribute (minus the data portion)  }
		data:					Handle;									{   -> Data to be written (pre-allocated, resize and add at end)  }
		dataOffset:				LONGINT;								{  <-> Offset to next byte to write  }
		bitOffset:				INTEGER;								{  <-> Bit offset (if zero, handle will need to be resized to one more byte before write)  }
	END;

	DETOpenSelfBlockPtr = ^DETOpenSelfBlock;
	DETOpenSelfBlock = RECORD
		reqFunction:			DETCallFunctions;						{  Requested function  }
		callBack:				DETCallBack;							{  Pointer to call-back routine  }
		callBackPrivate:		LONGINT;								{  Private data for the call-back routine  }
		templatePrivate:		LONGINT;								{  Private storage for use by code resource (stays for life of code resource,  }
																		{ 	common to all invocations of code resource)  }
		instancePrivate:		LONGINT;								{  Private storage for use by code resource (separate for each item using the  }
																		{ 	code resource)  }
		target:					DETTargetSpecification;					{  The target (originator) of the call, for targeted and property calls  }
		targetIsMainAspect:		BOOLEAN;								{  True if the target is the main aspect (even though it has a non-nil name)  }
		filler1:				BOOLEAN;
		modifiers:				INTEGER;								{   -> Modifiers at open time (option/control/command/shift keys)  }
	END;

	DETConvertToNumberBlockPtr = ^DETConvertToNumberBlock;
	DETConvertToNumberBlock = RECORD
		reqFunction:			DETCallFunctions;						{  Requested function  }
		callBack:				DETCallBack;							{  Pointer to call-back routine  }
		callBackPrivate:		LONGINT;								{  Private data for the call-back routine  }
		templatePrivate:		LONGINT;								{  Private storage for use by code resource (stays for life of code resource,  }
																		{ 	common to all invocations of code resource)  }
		instancePrivate:		LONGINT;								{  Private storage for use by code resource (separate for each item using the  }
																		{ 	code resource)  }
		target:					DETTargetSpecification;					{  The target (originator) of the call, for targeted and property calls  }
		targetIsMainAspect:		BOOLEAN;								{  True if the target is the main aspect (even though it has a non-nil name)  }
		filler1:				BOOLEAN;
		property:				INTEGER;								{  The property number the call refers to  }
		theValue:				LONGINT;								{  <-  The converted value to return  }
	END;

	DETConvertToRStringBlockPtr = ^DETConvertToRStringBlock;
	DETConvertToRStringBlock = RECORD
		reqFunction:			DETCallFunctions;						{  Requested function  }
		callBack:				DETCallBack;							{  Pointer to call-back routine  }
		callBackPrivate:		LONGINT;								{  Private data for the call-back routine  }
		templatePrivate:		LONGINT;								{  Private storage for use by code resource (stays for life of code resource,  }
																		{ 	common to all invocations of code resource)  }
		instancePrivate:		LONGINT;								{  Private storage for use by code resource (separate for each item using the  }
																		{ 	code resource)  }
		target:					DETTargetSpecification;					{  The target (originator) of the call, for targeted and property calls  }
		targetIsMainAspect:		BOOLEAN;								{  True if the target is the main aspect (even though it has a non-nil name)  }
		filler1:				BOOLEAN;
		property:				INTEGER;								{  The property number the call refers to  }
		theValue:				RStringHandle;							{  <-  A handle with the converted value (callee must allocate handle, DE will DisposHandle() it)  }
	END;

	DETConvertFromNumberBlockPtr = ^DETConvertFromNumberBlock;
	DETConvertFromNumberBlock = RECORD
		reqFunction:			DETCallFunctions;						{  Requested function  }
		callBack:				DETCallBack;							{  Pointer to call-back routine  }
		callBackPrivate:		LONGINT;								{  Private data for the call-back routine  }
		templatePrivate:		LONGINT;								{  Private storage for use by code resource (stays for life of code resource,  }
																		{ 	common to all invocations of code resource)  }
		instancePrivate:		LONGINT;								{  Private storage for use by code resource (separate for each item using the  }
																		{ 	code resource)  }
		target:					DETTargetSpecification;					{  The target (originator) of the call, for targeted and property calls  }
		targetIsMainAspect:		BOOLEAN;								{  True if the target is the main aspect (even though it has a non-nil name)  }
		filler1:				BOOLEAN;
		property:				INTEGER;								{  The property number the call refers to  }
		theValue:				LONGINT;								{   -> The value to convert (result should be written direct to the property)  }
	END;

	DETConvertFromRStringBlockPtr = ^DETConvertFromRStringBlock;
	DETConvertFromRStringBlock = RECORD
		reqFunction:			DETCallFunctions;						{  Requested function  }
		callBack:				DETCallBack;							{  Pointer to call-back routine  }
		callBackPrivate:		LONGINT;								{  Private data for the call-back routine  }
		templatePrivate:		LONGINT;								{  Private storage for use by code resource (stays for life of code resource,  }
																		{ 	common to all invocations of code resource)  }
		instancePrivate:		LONGINT;								{  Private storage for use by code resource (separate for each item using the  }
																		{ 	code resource)  }
		target:					DETTargetSpecification;					{  The target (originator) of the call, for targeted and property calls  }
		targetIsMainAspect:		BOOLEAN;								{  True if the target is the main aspect (even though it has a non-nil name)  }
		filler1:				BOOLEAN;
		property:				INTEGER;								{  The property number the call refers to  }
		theValue:				RStringPtr;								{   -> The value to convert (result should be written direct to the property)  }
	END;

	DETCustomViewDrawBlockPtr = ^DETCustomViewDrawBlock;
	DETCustomViewDrawBlock = RECORD
		reqFunction:			DETCallFunctions;						{  Requested function  }
		callBack:				DETCallBack;							{  Pointer to call-back routine  }
		callBackPrivate:		LONGINT;								{  Private data for the call-back routine  }
		templatePrivate:		LONGINT;								{  Private storage for use by code resource (stays for life of code resource,  }
																		{ 	common to all invocations of code resource)  }
		instancePrivate:		LONGINT;								{  Private storage for use by code resource (separate for each item using the  }
																		{ 	code resource)  }
		target:					DETTargetSpecification;					{  The target (originator) of the call, for targeted and property calls  }
		targetIsMainAspect:		BOOLEAN;								{  True if the target is the main aspect (even though it has a non-nil name)  }
		filler1:				BOOLEAN;
		property:				INTEGER;								{  The property number the call refers to  }
	END;

	DETCustomViewMouseDownBlockPtr = ^DETCustomViewMouseDownBlock;
	DETCustomViewMouseDownBlock = RECORD
		reqFunction:			DETCallFunctions;						{  Requested function  }
		callBack:				DETCallBack;							{  Pointer to call-back routine  }
		callBackPrivate:		LONGINT;								{  Private data for the call-back routine  }
		templatePrivate:		LONGINT;								{  Private storage for use by code resource (stays for life of code resource,  }
																		{ 	common to all invocations of code resource)  }
		instancePrivate:		LONGINT;								{  Private storage for use by code resource (separate for each item using the  }
																		{ 	code resource)  }
		target:					DETTargetSpecification;					{  The target (originator) of the call, for targeted and property calls  }
		targetIsMainAspect:		BOOLEAN;								{  True if the target is the main aspect (even though it has a non-nil name)  }
		filler1:				BOOLEAN;
		property:				INTEGER;								{  The property number the call refers to  }
		theEvent:				EventRecordPtr;							{   -> The original event record of the mouse-down  }
	END;

	DETKeyPressBlockPtr = ^DETKeyPressBlock;
	DETKeyPressBlock = RECORD
		reqFunction:			DETCallFunctions;						{  Requested function  }
		callBack:				DETCallBack;							{  Pointer to call-back routine  }
		callBackPrivate:		LONGINT;								{  Private data for the call-back routine  }
		templatePrivate:		LONGINT;								{  Private storage for use by code resource (stays for life of code resource,  }
																		{ 	common to all invocations of code resource)  }
		instancePrivate:		LONGINT;								{  Private storage for use by code resource (separate for each item using the  }
																		{ 	code resource)  }
		target:					DETTargetSpecification;					{  The target (originator) of the call, for targeted and property calls  }
		targetIsMainAspect:		BOOLEAN;								{  True if the target is the main aspect (even though it has a non-nil name)  }
		filler1:				BOOLEAN;
		property:				INTEGER;								{  The property number the call refers to  }
		theEvent:				EventRecordPtr;							{   -> The original event record of the key-press  }
	END;

	DETPasteBlockPtr = ^DETPasteBlock;
	DETPasteBlock = RECORD
		reqFunction:			DETCallFunctions;						{  Requested function  }
		callBack:				DETCallBack;							{  Pointer to call-back routine  }
		callBackPrivate:		LONGINT;								{  Private data for the call-back routine  }
		templatePrivate:		LONGINT;								{  Private storage for use by code resource (stays for life of code resource,  }
																		{ 	common to all invocations of code resource)  }
		instancePrivate:		LONGINT;								{  Private storage for use by code resource (separate for each item using the  }
																		{ 	code resource)  }
		target:					DETTargetSpecification;					{  The target (originator) of the call, for targeted and property calls  }
		targetIsMainAspect:		BOOLEAN;								{  True if the target is the main aspect (even though it has a non-nil name)  }
		filler1:				BOOLEAN;
		property:				INTEGER;								{  The property number the call refers to  }
		modifiers:				INTEGER;								{   -> Modifiers at paste time (option/control/command/shift keys)  }
	END;

	DETCustomMenuSelectedBlockPtr = ^DETCustomMenuSelectedBlock;
	DETCustomMenuSelectedBlock = RECORD
		reqFunction:			DETCallFunctions;						{  Requested function  }
		callBack:				DETCallBack;							{  Pointer to call-back routine  }
		callBackPrivate:		LONGINT;								{  Private data for the call-back routine  }
		templatePrivate:		LONGINT;								{  Private storage for use by code resource (stays for life of code resource,  }
																		{ 	common to all invocations of code resource)  }
		instancePrivate:		LONGINT;								{  Private storage for use by code resource (separate for each item using the  }
																		{ 	code resource)  }
		target:					DETTargetSpecification;					{  The target (originator) of the call, for targeted and property calls  }
		targetIsMainAspect:		BOOLEAN;								{  True if the target is the main aspect (even though it has a non-nil name)  }
		filler1:				BOOLEAN;
		menuTableParameter:		INTEGER;								{   -> The "property" field from the custom menu table  }
	END;

	DETCustomMenuEnabledBlockPtr = ^DETCustomMenuEnabledBlock;
	DETCustomMenuEnabledBlock = RECORD
		reqFunction:			DETCallFunctions;						{  Requested function  }
		callBack:				DETCallBack;							{  Pointer to call-back routine  }
		callBackPrivate:		LONGINT;								{  Private data for the call-back routine  }
		templatePrivate:		LONGINT;								{  Private storage for use by code resource (stays for life of code resource,  }
																		{ 	common to all invocations of code resource)  }
		instancePrivate:		LONGINT;								{  Private storage for use by code resource (separate for each item using the  }
																		{ 	code resource)  }
		target:					DETTargetSpecification;					{  The target (originator) of the call, for targeted and property calls  }
		targetIsMainAspect:		BOOLEAN;								{  True if the target is the main aspect (even though it has a non-nil name)  }
		filler1:				BOOLEAN;
		menuTableParameter:		INTEGER;								{   -> The "property" field from the custom menu table  }
		enable:					BOOLEAN;								{  <-  Whether to enable the menu item  }
		filler2:				BOOLEAN;
	END;

	DETForwarderListItemPtr = ^DETForwarderListItem;
	DETForwarderListItem = RECORD
		next:					^DETForwarderListItemPtr;				{  Pointer to next item, or nil  }
		attributeValueTag:		AttributeTag;							{  Tag of new templates (0 for none)  }
		rstrs:					PackedPathName;							{  Record type (empty if none), attrbute type (empty if none),list of template names to forward to  }
	END;

	DETForwarderListPtr					= ^DETForwarderListItem;
	DETForwarderListHandle				= ^DETForwarderListPtr;
	DETDynamicForwardersBlockPtr = ^DETDynamicForwardersBlock;
	DETDynamicForwardersBlock = RECORD
		reqFunction:			DETCallFunctions;						{  Requested function  }
		callBack:				DETCallBack;							{  Pointer to call-back routine  }
		callBackPrivate:		LONGINT;								{  Private data for the call-back routine  }
		templatePrivate:		LONGINT;								{  Private storage for use by code resource (stays for life of code resource, common to all invocations of code resource)  }
		forwarders:				DETForwarderListHandle;					{  <-  List of forwaders  }
	END;

	DETDynamicResourceBlockPtr = ^DETDynamicResourceBlock;
	DETDynamicResourceBlock = RECORD
		reqFunction:			DETCallFunctions;						{  Requested function  }
		callBack:				DETCallBack;							{  Pointer to call-back routine  }
		callBackPrivate:		LONGINT;								{  Private data for the call-back routine  }
		templatePrivate:		LONGINT;								{  Private storage for use by code resource (stays for life of code resource,  }
																		{ 	common to all invocations of code resource)  }
		instancePrivate:		LONGINT;								{  Private storage for use by code resource (separate for each item using the  }
																		{ 	code resource)  }
		target:					DETTargetSpecification;					{  The target (originator) of the call, for targeted and property calls  }
		targetIsMainAspect:		BOOLEAN;								{  True if the target is the main aspect (even though it has a non-nil name)  }
		filler1:				BOOLEAN;
		resourceType:			ResType;								{   -> The resource type being requested  }
		propertyNumber:			INTEGER;								{   -> The property number of the resource being requested  }
		resourceID:				INTEGER;								{   -> The resource ID (base ID + property number) of the resource  }
		theResource:			Handle;									{  <-  The requested resource  }
	END;


	DETCallBlock = RECORD
		CASE INTEGER OF
		0: (
			protoCall:			DETProtoCallBlock;
			);
		1: (
			init:				DETInitBlock;
			);
		2: (
			exit:				DETExitBlock;
			);
		3: (
			instanceInit:		DETInstanceInitBlock;
			);
		4: (
			instanceExit:		DETInstanceExitBlock;
			);
		5: (
			instanceIdle:		DETInstanceIdleBlock;
			);
		6: (
			propertyCommand:	DETPropertyCommandBlock;
			);
		7: (
			maximumTextLength:	DETMaximumTextLengthBlock;
			);
		8: (
			viewListChanged:	DETViewListChangedBlock;
			);
		9: (
			propertyDirtied:	DETPropertyDirtiedBlock;
			);
		10: (
			validateSave:		DETValidateSaveBlock;
			);
		11: (
			dropQuery:			DETDropQueryBlock;
			);
		12: (
			dropMeQuery:		DETDropMeQueryBlock;
			);
		13: (
			attributeCreationBlock: DETAttributeCreationBlock;
			);
		14: (
			attributeNew:		DETAttributeNewBlock;
			);
		15: (
			attributeChange:	DETAttributeChangeBlock;
			);
		16: (
			attributeDelete:	DETAttributeDeleteBlock;
			);
		17: (
			itemNew:			DETItemNewBlock;
			);
		18: (
			patternIn:			DETPatternInBlock;
			);
		19: (
			patternOut:			DETPatternOutBlock;
			);
		20: (
			shouldSync:			DETShouldSyncBlock;
			);
		21: (
			doSync:				DETDoSyncBlock;
			);
		22: (
			openSelf:			DETOpenSelfBlock;
			);
		23: (
			convertToNumber:	DETConvertToNumberBlock;
			);
		24: (
			convertToRString:	DETConvertToRStringBlock;
			);
		25: (
			convertFromNumber:	DETConvertFromNumberBlock;
			);
		26: (
			convertFromRString:	DETConvertFromRStringBlock;
			);
		27: (
			customViewDraw:		DETCustomViewDrawBlock;
			);
		28: (
			customViewMouseDown: DETCustomViewMouseDownBlock;
			);
		29: (
			keyPress:			DETKeyPressBlock;
			);
		30: (
			paste:				DETPasteBlock;
			);
		31: (
			customMenuSelected:	DETCustomMenuSelectedBlock;
			);
		32: (
			customMenuEnabled:	DETCustomMenuEnabledBlock;
			);
		33: (
			dynamicForwarders:	DETDynamicForwardersBlock;
			);
		34: (
			dynamicResource:	DETDynamicResourceBlock;
			);
	END;


CONST
	uppDETCallBackProcInfo = $000003E0;

FUNCTION CallDETCallBackProc(VAR callBlockPtr: DETCallBlock; callBackBlockPtr: DETCallBackBlockPtr; userRoutine: DETCallBackUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION NewDETCallBackProc(userRoutine: DETCallBackProcPtr): DETCallBackUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}
{ Call-for list: }

CONST
	kDETCallForOther			= 1;							{  Call for things not listed below (also auto-enabled by DE if any of the below are enabled)  }
	kDETCallForIdle				= 2;							{  kDETcmdIdle  }
	kDETCallForCommands			= 4;							{  kDETcmdPropertyCommand, kDETcmdSelfOpen  }
	kDETCallForViewChanges		= 8;							{  kDETcmdViewListChanged, kDETcmdPropertyDirtied, kDETcmdMaximumTextLength  }
	kDETCallForDrops			= $10;							{  kDETcmdDropQuery, kDETcmdDropMeQuery  }
	kDETCallForAttributes		= $20;							{  kDETcmdAttributeCreation, kDETcmdAttributeNew, kDETcmdAttributeChange, kDETcmdAttributeDelete  }
	kDETCallForValidation		= $40;							{  kDETcmdValidateSave  }
	kDETCallForKeyPresses		= $80;							{  kDETcmdKeyPress and kDETcmdPaste  }
	kDETCallForResources		= $0100;						{  kDETcmdDynamicResource  }
	kDETCallForSyncing			= $0200;						{  kDETcmdShouldSync, kDETcmdDoSync  }
	kDETCallForEscalation		= $8000;						{  All calls escalated from the next lower level  }
	kDETCallForNothing			= 0;							{  None of the above  }
	kDETCallForEverything		= $FFFFFFFF;					{  All of the above  }


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	DETCallProcPtr = FUNCTION(callBlockPtr: DETCallBlockPtr): OSErr;
{$ELSEC}
	DETCallProcPtr = ProcPtr;
{$ENDC}

	DETCallUPP = UniversalProcPtr;

CONST
	uppDETCallProcInfo = $000000E0;

FUNCTION NewDETCallProc(userRoutine: DETCallProcPtr): DETCallUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallDETCallProc(callBlockPtr: DETCallBlockPtr; userRoutine: DETCallUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

TYPE
	DETCall								= DETCallUPP;
{ This following macro saves you from having to dig out the call-back pointer from the call block: }
{**********************************************************************************}
{******************************** SAM Definitions: ********************************}
{**********************************************************************************}
{ SAM Developers should use property numbers starting at this point: }

CONST
	kSAMFirstDevProperty		= 50;


{
	SAM templates have additional resources/properties that are required
	for interaction with the AOCE Key Chain.
	
	 Type	Offset						Description
	 ----	------						-----------
	'rstr'	kSAMAspectUserName			The user name
	'rstr'	kSAMAspectKind				The kind of SAM
	'detn'	kSAMAspectCannotDelete		If 0, then the slot cannot be deleted
	'sami'	kSAMAspectSlotCreationInfo	The info required to create a slot record
}
	kSAMAspectUserName			= 41;
	kSAMAspectKind				= 42;
	kSAMAspectCannotDelete		= 43;
	kSAMAspectSlotCreationInfo	= 44;

{*************************************************************************************
 ********************************* Admin Definitions: *********************************
 *************************************************************************************}
	kDETAdminVersion			= -978;



{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := OCETemplatesIncludes}

{$ENDC} {__OCETEMPLATES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}