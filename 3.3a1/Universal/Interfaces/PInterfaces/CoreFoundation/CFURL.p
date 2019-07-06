{
 	File:		CFURL.p
 
 	Contains:	CoreFoundation urls
 
 	Version:	Technology:	Mac OS X
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1999 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CFURL;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CFURL__}
{$SETC __CFURL__ := 1}

{$I+}
{$SETC CFURLIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CFBASE__}
{$I CFBase.p}
{$ENDC}
{$IFC UNDEFINED __CFDATA__}
{$I CFData.p}
{$ENDC}
{$IFC UNDEFINED __CFSTRING__}
{$I CFString.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	CFURLPathStyle 				= SInt32;
CONST
	kCFURLPOSIXPathStyle		= 0;
	kCFURLHFSPathStyle			= 1;
	kCFURLWindowsPathStyle		= 2;


TYPE
	CFURLRef = ^LONGINT; { an opaque 32-bit type }
FUNCTION CFURLGetTypeID: CFTypeID; C;
{ encoding will be used both to interpret the bytes of URLBytes, and to }
{ interpret any percent-escapes within the bytes. }
FUNCTION CFURLCreateWithBytes(allocator: CFAllocatorRef; {CONST}VAR URLBytes: UInt8; length: CFIndex; encoding: CFStringEncoding; baseURL: CFURLRef): CFURLRef; C;
{ Escapes any character that is not 7-bit ASCII with the byte-code }
{ for the given encoding.  If escapeWhitespace is true, whitespace }
{ characters (' ', '\t', '\r', '\n') will be escaped also (desirable }
{ if embedding the URL into a larger text stream like HTML) }
FUNCTION CFURLCreateData(allocator: CFAllocatorRef; url: CFURLRef; encoding: CFStringEncoding; escapeWhitespace: BOOLEAN): CFDataRef; C;
{ Any escape sequences in URLString will be interpreted via UTF-8. }
FUNCTION CFURLCreateWithString(allocator: CFAllocatorRef; URLString: CFStringRef; baseURL: CFURLRef): CFURLRef; C;
{ filePath should be the URL's path expressed as a path of the type }
{ fsType.  If filePath is not absolute, the resulting URL will be }
{ considered relative to the current working directory (evaluated }
{ at creation time).  isDirectory determines whether filePath is }
{ treated as a directory path when resolving against relative path }
{ components }
FUNCTION CFURLCreateWithFileSystemPath(allocator: CFAllocatorRef; filePath: CFStringRef; pathStyle: CFURLPathStyle; isDirectory: BOOLEAN): CFURLRef; C;
{ Returns the URL's path in a form suitable for file system use. }
{ The path has been fully processed for the file system type requested }
{ by fsType.  If resolveAgainstBase is TRUE, then the URL's path is first }
{ resolved against that of its base URL (if a base URL exists) before being returned. }
FUNCTION CFURLCreateStringWithFileSystemPath(allocator: CFAllocatorRef; anURL: CFURLRef; pathStyle: CFURLPathStyle; resolveAgainstBase: BOOLEAN): CFStringRef; C;
{ Creates a new URL by resolving the relative portion of relativeURL against its base. }
FUNCTION CFURLCopyAbsoluteURL(relativeURL: CFURLRef): CFURLRef; C;
{ Returns the URL's string. }
FUNCTION CFURLGetString(anURL: CFURLRef): CFStringRef; C;
{ Returns the base URL if it exists }
FUNCTION CFURLGetBaseURL(anURL: CFURLRef): CFURLRef; C;
{ All URLs can be broken into two pieces - the scheme (preceding the first colon) and the resource }
{ specifier (following the first colon).  Most URLs are also "standard" URLs conforming to RFC 1808 }
{ (available from www.w3c.org).  This category includes URLs of the file, http, https, and ftp }
{ schemes, to name a few.  Standard URLs start the resource specifier with two slashes ("//"), and }
{ can be broken into 4 distinct pieces - the scheme, the net location, the path, and further }
{ resource specifiers (typically an optional parameter, query, and/or fragment).  The net location }
{ appears immediately following the two slashes and goes up to the next slash; it's format is }
{ scheme-specific, but is usually composed of some or all of a username, password, host name, and }
{ port.  The path is a series of path components separated by slashes; if the net location is }
{ present, the path always begins with a slash.  Standard URLs can be relative to another URL, in }
{ which case at least the scheme and possibly other pieces as well come from the base URL (see RFC }
{ 1808 for precise details when resolving a relative URL against its base).  The full URL is therefore }
{ <scheme> "://" <net location> <path, always starting with a slash> <additional resource specifiers> }
{ If a given CFURL can be decomposed (that is, conforms to RFC 1808), you can ask for each of the four }
{ basic pieces (scheme, net location, path, and resource specifer) separately, as well as for its base }
{ URL.  The basic pieces are returned with any percent escape sequences still in place (although note }
{ that the scheme may not legally include any percent escapes); this is to allow the caller to distinguish }
{ between percent sequences that may have syntactic meaning if replaced by the character being escaped }
{ (for instance, a '/' in a path component).  Since only the individual schemes know which characters }
{ are syntactically significant, CFURL cannot safely replace any percent escape sequences.  However, }
{ you can use CFStringCreateReplacingPercentEscapes() to create a new string with the percent escapes }
{ removed.  The first argument is the original string containing percent escapes; the second argument }
{ is a string containing any characters that, if escaped in the original string, should NOT be replaced. }
{ Note that this function may return the original string (retained) if the original string contains no }
{ escape sequences to be processed. }
{ If a given CFURL can not be decomposed, you can ask for its scheme and its resource specifier; asking }
{ it for its net location or path will return NULL. }
{ All of the methods discussed above do not require an autorelease pool to be in place. }
{ To get more refined information about the components of a decomposable CFURL, you may ask for more }
{ specific pieces of the URL, expressed with the percent escapes removed.  These functions require an }
{ autorelease pool to be in place, as they will return an autoreleased CFString.  They are }
{ CFURLHostName(), CFURLPortNumber() (actually returns an Int32; does not use the autorelease pool), }
{ CFURLUserName(), CFURLPassword(), CFURLQuery(), CFURLParameters(), and CFURLFragment().  Because the }
{ parameters, query, and fragment of an URL may contain scheme-specific syntaxes, these methods take a }
{ second argument, giving a list of characters which should NOT be replaced if percent escaped.  For }
{ instance, the ftp parameter syntax gives simple key-value pairs as "<key>=<value>;"  Clearly if a key }
{ or value includes either '=' or ';', it must be escaped to avoid corrupting the meaning of the }
{ parameters, so the caller may request the parameter string as }
{ CFStringRef myParams = CFURLParameters(ftpURL, CFSTR("=;%")); }
{ requesting that all percent escape sequences be replaced by the represented characters, except for escaped }
{ '=', '%' or ';' characters.  If you are not interested in any escape sequences being left in, pass NULL for the }
{ second argument. }
{ Returns TRUE if anURL conforms to RFC 1808 }
FUNCTION CFURLCanBeDecomposed(anURL: CFURLRef): BOOLEAN; C;
{ The next several methods leave any percent escape sequences intact }
FUNCTION CFURLCopyScheme(anURL: CFURLRef): CFStringRef; C;
{ NULL if CFURLCanBeDecomposed(anURL) is FALSE }
FUNCTION CFURLCopyNetLocation(anURL: CFURLRef): CFStringRef; C;
{ NULL if CFURLCanBeDecomposed(anURL) is FALSE; also does not resolve }
{ the URL against its base.  See also CFCreateAbsoluteURL() and }
{ CFStringCreateFileSystemPathFromURL() }
FUNCTION CFURLCopyPath(anURL: CFURLRef): CFStringRef; C;
{ Returns whether anURL's path represents a directory }
{ (TRUE returned) or a simple file (FALSE returned) }
FUNCTION CFURLHasDirectoryPath(anURL: CFURLRef): BOOLEAN; C;
{ Any additional resource specifiers after the path.  For URLs }
{ that cannot be decomposed, this is everything except the scheme itself. }
FUNCTION CFURLCopyResourceSpecifier(anURL: CFURLRef): CFStringRef; C;
FUNCTION CFURLCopyHostName(anURL: CFURLRef): CFStringRef; C;
FUNCTION CFURLGetPortNumber(anURL: CFURLRef): SInt32; C;
{ Returns -1 if no port number is specified }
FUNCTION CFURLCopyUserName(anURL: CFURLRef): CFStringRef; C;
FUNCTION CFURLCopyPassword(anURL: CFURLRef): CFStringRef; C;
{ These remove all percent escape sequences except those for }
{ characters in charactersToLeaveEscaped.  If charactersToLeaveEscaped }
{ is empty (""), all percent escape sequences are replaced by their }
{ corresponding characters.  If charactersToLeaveEscaped is NULL, }
{ then no escape sequences are removed at all }
FUNCTION CFURLCopyParameterString(anURL: CFURLRef; charactersToLeaveEscaped: CFStringRef): CFStringRef; C;
FUNCTION CFURLCopyQueryString(anURL: CFURLRef; charactersToLeaveEscaped: CFStringRef): CFStringRef; C;
FUNCTION CFURLCopyFragment(anURL: CFURLRef; charactersToLeaveEscaped: CFStringRef): CFStringRef; C;
{ Returns a string with any percent escape sequences that do NOT }
{ correspond to characters in charactersToLeaveEscaped with their }
{ equivalent.  Returns NULL on failure (if an invalid percent sequence }
{ is encountered), or the original string itself if no characters need to be replaced. }
FUNCTION CFURLCreateStringByReplacingPercentEscapes(allocator: CFAllocatorRef; originalString: CFStringRef; charactersToLeaveEscaped: CFStringRef): CFStringRef; C;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CFURLIncludes}

{$ENDC} {__CFURL__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
