{
     File:       MacApplication.p
 
     Contains:   Application-level APIs
 
     Version:    Technology: Mac OS X
                 Release:    Universal Interfaces 3.4.1
 
     Copyright:  © 2000-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT MacApplication;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __MACAPPLICATION__}
{$SETC __MACAPPLICATION__ := 1}

{$I+}
{$SETC MacApplicationIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CGCONTEXT__}
{$I CGContext.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
 *  SetApplicationDockTileImage()
 *  
 *  Discussion:
 *    Sets the image for the tile in the dock that represents your
 *    application while it is running. If you set the image, it will
 *    revert back to its original image when your application
 *    terminates automatically. You do not need to manually restore it.
 *  
 *  Parameters:
 *    
 *    inImage:
 *      The image you wish to have as your tile image.
 *  
 *  Result:
 *    An operating system status code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION SetApplicationDockTileImage(inImage: CGImageRef): OSStatus; C;

{
 *  OverlayApplicationDockTileImage()
 *  
 *  Discussion:
 *    Takes the image passed in and composites it on top of the current
 *    image of your application's dock tile. You might do this to put a
 *    standard badge over your application's icon to indicate something
 *    to the user.
 *  
 *  Parameters:
 *    
 *    inImage:
 *      The image you wish to overlay onto your tile image.
 *  
 *  Result:
 *    An operating system status code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION OverlayApplicationDockTileImage(inImage: CGImageRef): OSStatus; C;

{
 *  RestoreApplicationDockTileImage()
 *  
 *  Discussion:
 *    Restores the tile for your appliation in the dock to its normal
 *    image (your application icon). You would use this if some overlay
 *    or change of the application icon needed to be removed.
 *  
 *  Result:
 *    An operating system status code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION RestoreApplicationDockTileImage: OSStatus; C;

{
 *  BeginCGContextForApplicationDockTile()
 *  
 *  Discussion:
 *    Creates and returns a CGContextRef. You can use this context to
 *    draw into your application's dock tile with Quartz. You **MUST**
 *    call EndCGContextForApplicationDockTile and NOT CGEndContext when
 *    using this API, as it locks your application's tile in the dock.
 *    If you call CGEndContext, the dock will never know you are done
 *    with the tile.
 *  
 *  Result:
 *    An Quartz (Core Graphics) context reference.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION BeginCGContextForApplicationDockTile: CGContextRef; C;

{
 *  EndCGContextForApplicationDockTile()
 *  
 *  Discussion:
 *    Ends the CG context for your application tile and frees the lock
 *    on the application dock tile. You **MUST** call this routine and
 *    NOT CGEndContext when using BeginCGContextForApplicationDockTile,
 *    as it locks your application's tile in the dock. If you call
 *    CGEndContext, the dock will never know you are done with the tile.
 *  
 *  Parameters:
 *    
 *    inContext:
 *      The context to end. The context is invalid after this call and
 *      should no longer be used.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE EndCGContextForApplicationDockTile(inContext: CGContextRef); C;



{
 *  BeginQDContextForApplicationDockTile()
 *  
 *  Discussion:
 *    Creates and returns a CGrafPtr for your application's tile in the
 *    dock. You can use this port to draw into your application's dock
 *    tile with Quickdraw. You **MUST** call
 *    EndQDContextForApplicationDockTile and NOT DisposePort when using
 *    this API, as it locks your application's tile in the dock. If you
 *    call DisposePort, the dock will never know you are done with the
 *    tile.
 *  
 *  Result:
 *    A Quickdraw port reference.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION BeginQDContextForApplicationDockTile: CGrafPtr; C;

{
 *  EndQDContextForApplicationDockTile()
 *  
 *  Discussion:
 *    Disposes the Quickdraw port for your application tile and frees
 *    the lock on the application dock tile. You **MUST** call this
 *    routine and NOT DisposePort when using
 *    BeginQDContextForApplicationDockTile, else the dock will never
 *    know you are done with the tile.
 *  
 *  Parameters:
 *    
 *    inContext:
 *      The context to end. The context is invalid after this call and
 *      should no longer be used.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
PROCEDURE EndQDContextForApplicationDockTile(inContext: CGrafPtr); C;


{
 *  SetApplicationDockTileMenu()
 *  
 *  Summary:
 *    Sets the menu that is displayed by the application's dock tile.
 *  
 *  Discussion:
 *    The Carbon Window Manager and the Dock will always automatically
 *    display a menu containing a list of the application's document
 *    windows. If the application wants to add other additional menu
 *    items, it can use the SetApplicationDockTileMenu API to provide
 *    those items. The items in the specified menu will be combined
 *    with the window title items. This API increments the refcount of
 *    the specified menu. Before the menu is actually displayed, it
 *    will receive kEventMenuPopulate, kEventMenuOpening, and
 *    kEventMenuEnableItems Carbon events, so any event handlers for
 *    these events may update the menu appropriately for the current
 *    state of the application. The application should set a command ID
 *    for each menu item in the dock tile menu, and when that item is
 *    chosen, a kEventCommandProcess Carbon event containing the item's
 *    command ID will be sent to the user focus target.
 *  
 *  Parameters:
 *    
 *    inMenu:
 *      The menu to display, or NULL to remove the current dock tile
 *      menu.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.1 and later
 *    Mac OS X:         in version 10.1 and later
 }
FUNCTION SetApplicationDockTileMenu(inMenu: MenuRef): OSStatus; C;

{
 *  GetApplicationDockTileMenu()
 *  
 *  Summary:
 *    Returns the menu that is displayed by the application's dock tile.
 *  
 *  Result:
 *    The application's dock tile menu, or NULL if none.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.1 and later
 *    Mac OS X:         in version 10.1 and later
 }
FUNCTION GetApplicationDockTileMenu: MenuRef; C;


{
 *  CreateCGImageFromPixMaps()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION CreateCGImageFromPixMaps(inImage: PixMapHandle; inMask: PixMapHandle; VAR outImage: CGImageRef): OSStatus; C;


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := MacApplicationIncludes}

{$ENDC} {__MACAPPLICATION__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
