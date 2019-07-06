{
 	File:		AIFF.p
 
 	Contains:	Definition of AIFF file format components.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1989-1997, 1997 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT AIFF;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __AIFF__}
{$SETC __AIFF__ := 1}

{$I+}
{$SETC AIFFIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	AIFFID						= 'AIFF';
	AIFCID						= 'AIFC';
	FormatVersionID				= 'FVER';
	CommonID					= 'COMM';
	FORMID						= 'FORM';
	SoundDataID					= 'SSND';
	MarkerID					= 'MARK';
	InstrumentID				= 'INST';
	MIDIDataID					= 'MIDI';
	AudioRecordingID			= 'AESD';
	ApplicationSpecificID		= 'APPL';
	CommentID					= 'COMT';
	NameID						= 'NAME';
	AuthorID					= 'AUTH';
	CopyrightID					= '(c) ';
	AnnotationID				= 'ANNO';

	NoLooping					= 0;
	ForwardLooping				= 1;
	ForwardBackwardLooping		= 2;							{  AIFF-C Versions  }
	AIFCVersion1				= $A2805140;


{ Compression Names }
	NoneName     = 'not compressed';
	ACE2to1Name  = 'ACE 2-to-1';
	ACE8to3Name  = 'ACE 8-to-3';
	MACE3to1Name = 'MACE 3-to-1';
	MACE6to1Name = 'MACE 6-to-1';


																{  Compression Types  }
	NoneType					= 'NONE';
	ACE2Type					= 'ACE2';
	ACE8Type					= 'ACE8';
	MACE3Type					= 'MAC3';
	MACE6Type					= 'MAC6';


TYPE
	ID									= LONGINT;
	MarkerIdType						= INTEGER;
	ChunkHeaderPtr = ^ChunkHeader;
	ChunkHeader = RECORD
		ckID:					ID;
		ckSize:					LONGINT;
	END;

	ContainerChunkPtr = ^ContainerChunk;
	ContainerChunk = RECORD
		ckID:					ID;
		ckSize:					LONGINT;
		formType:				ID;
	END;

	FormatVersionChunkPtr = ^FormatVersionChunk;
	FormatVersionChunk = RECORD
		ckID:					ID;
		ckSize:					LONGINT;
		timestamp:				LONGINT;
	END;

	CommonChunkPtr = ^CommonChunk;
	CommonChunk = RECORD
		ckID:					ID;
		ckSize:					LONGINT;
		numChannels:			INTEGER;
		numSampleFrames:		LONGINT;
		sampleSize:				INTEGER;
		sampleRate:				extended80;
	END;

	ExtCommonChunkPtr = ^ExtCommonChunk;
	ExtCommonChunk = RECORD
		ckID:					ID;
		ckSize:					LONGINT;
		numChannels:			INTEGER;
		numSampleFrames:		LONGINT;
		sampleSize:				INTEGER;
		sampleRate:				extended80;
		compressionType:		ID;
		compressionName:		SInt8;									{  variable length array, Pascal string  }
	END;

	SoundDataChunkPtr = ^SoundDataChunk;
	SoundDataChunk = RECORD
		ckID:					ID;
		ckSize:					LONGINT;
		offset:					LONGINT;
		blockSize:				LONGINT;
	END;

	MarkerPtr = ^Marker;
	Marker = RECORD
		id:						MarkerIdType;
		position:				LONGINT;
		markerName:				Str255;
	END;

	MarkerChunkPtr = ^MarkerChunk;
	MarkerChunk = RECORD
		ckID:					ID;
		ckSize:					LONGINT;
		numMarkers:				INTEGER;
		Markers:				ARRAY [0..0] OF Marker;					{  variable length array  }
	END;

	AIFFLoopPtr = ^AIFFLoop;
	AIFFLoop = RECORD
		playMode:				INTEGER;
		beginLoop:				MarkerIdType;
		endLoop:				MarkerIdType;
	END;

	InstrumentChunkPtr = ^InstrumentChunk;
	InstrumentChunk = PACKED RECORD
		ckID:					ID;
		ckSize:					LONGINT;
		baseFrequency:			UInt8;
		detune:					UInt8;
		lowFrequency:			UInt8;
		highFrequency:			UInt8;
		lowVelocity:			UInt8;
		highVelocity:			UInt8;
		gain:					INTEGER;
		sustainLoop:			AIFFLoop;
		releaseLoop:			AIFFLoop;
	END;

	MIDIDataChunkPtr = ^MIDIDataChunk;
	MIDIDataChunk = RECORD
		ckID:					ID;
		ckSize:					LONGINT;
		MIDIdata:				SInt8;									{  variable length array  }
	END;

	AudioRecordingChunkPtr = ^AudioRecordingChunk;
	AudioRecordingChunk = RECORD
		ckID:					ID;
		ckSize:					LONGINT;
		AESChannelStatus:		PACKED ARRAY [0..23] OF UInt8;
	END;

	ApplicationSpecificChunkPtr = ^ApplicationSpecificChunk;
	ApplicationSpecificChunk = RECORD
		ckID:					ID;
		ckSize:					LONGINT;
		applicationSignature:	OSType;
		data:					SInt8;									{  variable length array  }
	END;

	CommentPtr = ^Comment;
	Comment = RECORD
		timeStamp:				LONGINT;
		marker:					MarkerIdType;
		count:					INTEGER;
		text:					SInt8;									{  variable length array, Pascal string  }
	END;

	CommentsChunkPtr = ^CommentsChunk;
	CommentsChunk = RECORD
		ckID:					ID;
		ckSize:					LONGINT;
		numComments:			INTEGER;
		comments:				ARRAY [0..0] OF Comment;				{  variable length array  }
	END;

	TextChunkPtr = ^TextChunk;
	TextChunk = RECORD
		ckID:					ID;
		ckSize:					LONGINT;
		text:					SInt8;									{  variable length array, Pascal string  }
	END;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := AIFFIncludes}

{$ENDC} {__AIFF__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
