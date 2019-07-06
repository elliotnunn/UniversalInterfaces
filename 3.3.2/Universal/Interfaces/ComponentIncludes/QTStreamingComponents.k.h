/*
     File:       QTStreamingComponents.k.h
 
     Contains:   QuickTime interfaces
 
     Version:    Technology: 
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1990-2000 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __QTSTREAMINGCOMPONENTS_K__
#define __QTSTREAMINGCOMPONENTS_K__

#include <QTStreamingComponents.h>

#if CALL_NOT_IN_CARBON
#endif
/*
	Example usage:

		#define RTPRSSM_BASENAME()	Fred
		#define RTPRSSM_GLOBALS()	FredGlobalsHandle
		#include <QTStreamingComponents.k.h>

	To specify that your component implementation does not use globals, do not #define RTPRSSM_GLOBALS
*/
#ifdef RTPRSSM_BASENAME
	#ifndef RTPRSSM_GLOBALS
		#define RTPRSSM_GLOBALS() 
		#define ADD_RTPRSSM_COMMA 
	#else
		#define ADD_RTPRSSM_COMMA ,
	#endif
	#define RTPRSSM_GLUE(a,b) a##b
	#define RTPRSSM_STRCAT(a,b) RTPRSSM_GLUE(a,b)
	#define ADD_RTPRSSM_BASENAME(name) RTPRSSM_STRCAT(RTPRSSM_BASENAME(),name)

#if CALL_NOT_IN_CARBON
	EXTERN_API( ComponentResult  ) ADD_RTPRSSM_BASENAME(Initialize) (RTPRSSM_GLOBALS() ADD_RTPRSSM_COMMA RTPRssmInitParams * inInitParams);

	EXTERN_API( ComponentResult  ) ADD_RTPRSSM_BASENAME(HandleNewPacket) (RTPRSSM_GLOBALS() ADD_RTPRSSM_COMMA QTSStreamBuffer * inStreamBuffer, SInt32  inNumWraparounds);

	EXTERN_API( ComponentResult  ) ADD_RTPRSSM_BASENAME(ComputeChunkSize) (RTPRSSM_GLOBALS() ADD_RTPRSSM_COMMA RTPRssmPacket * inPacketListHead, SInt32  inFlags, UInt32 * outChunkDataSize);

	EXTERN_API( ComponentResult  ) ADD_RTPRSSM_BASENAME(AdjustPacketParams) (RTPRSSM_GLOBALS() ADD_RTPRSSM_COMMA RTPRssmPacket * inPacket, SInt32  inFlags);

	EXTERN_API( ComponentResult  ) ADD_RTPRSSM_BASENAME(CopyDataToChunk) (RTPRSSM_GLOBALS() ADD_RTPRSSM_COMMA RTPRssmPacket * inPacketListHead, UInt32  inMaxChunkDataSize, SHChunkRecord * inChunk, SInt32  inFlags);

	EXTERN_API( ComponentResult  ) ADD_RTPRSSM_BASENAME(SendPacketList) (RTPRSSM_GLOBALS() ADD_RTPRSSM_COMMA RTPRssmPacket * inPacketListHead, const TimeValue64 * inLastChunkPresentationTime, SInt32  inFlags);

	EXTERN_API( ComponentResult  ) ADD_RTPRSSM_BASENAME(GetTimeScaleFromPacket) (RTPRSSM_GLOBALS() ADD_RTPRSSM_COMMA QTSStreamBuffer * inStreamBuffer, TimeScale * outTimeScale);

	EXTERN_API( ComponentResult  ) ADD_RTPRSSM_BASENAME(SetInfo) (RTPRSSM_GLOBALS() ADD_RTPRSSM_COMMA OSType  inSelector, void * ioParams);

	EXTERN_API( ComponentResult  ) ADD_RTPRSSM_BASENAME(GetInfo) (RTPRSSM_GLOBALS() ADD_RTPRSSM_COMMA OSType  inSelector, void * ioParams);

	EXTERN_API( ComponentResult  ) ADD_RTPRSSM_BASENAME(HasCharacteristic) (RTPRSSM_GLOBALS() ADD_RTPRSSM_COMMA OSType  inCharacteristic, Boolean * outHasIt);

	EXTERN_API( ComponentResult  ) ADD_RTPRSSM_BASENAME(Reset) (RTPRSSM_GLOBALS() ADD_RTPRSSM_COMMA SInt32  inFlags);

	EXTERN_API( ComponentResult  ) ADD_RTPRSSM_BASENAME(SetCapabilities) (RTPRSSM_GLOBALS() ADD_RTPRSSM_COMMA SInt32  inFlags, SInt32  inFlagsMask);

	EXTERN_API( ComponentResult  ) ADD_RTPRSSM_BASENAME(GetCapabilities) (RTPRSSM_GLOBALS() ADD_RTPRSSM_COMMA SInt32 * outFlags);

	EXTERN_API( ComponentResult  ) ADD_RTPRSSM_BASENAME(SetPayloadHeaderLength) (RTPRSSM_GLOBALS() ADD_RTPRSSM_COMMA UInt32  inPayloadHeaderLength);

	EXTERN_API( ComponentResult  ) ADD_RTPRSSM_BASENAME(GetPayloadHeaderLength) (RTPRSSM_GLOBALS() ADD_RTPRSSM_COMMA UInt32 * outPayloadHeaderLength);

	EXTERN_API( ComponentResult  ) ADD_RTPRSSM_BASENAME(SetTimeScale) (RTPRSSM_GLOBALS() ADD_RTPRSSM_COMMA TimeScale  inSHTimeScale);

	EXTERN_API( ComponentResult  ) ADD_RTPRSSM_BASENAME(GetTimeScale) (RTPRSSM_GLOBALS() ADD_RTPRSSM_COMMA TimeScale * outSHTimeScale);

	EXTERN_API( ComponentResult  ) ADD_RTPRSSM_BASENAME(NewStreamHandler) (RTPRSSM_GLOBALS() ADD_RTPRSSM_COMMA OSType  inSHType, SampleDescriptionHandle  inSampleDescription, TimeScale  inSHTimeScale, ComponentInstance * outHandler);

	EXTERN_API( ComponentResult  ) ADD_RTPRSSM_BASENAME(SetStreamHandler) (RTPRSSM_GLOBALS() ADD_RTPRSSM_COMMA ComponentInstance  inStreamHandler);

	EXTERN_API( ComponentResult  ) ADD_RTPRSSM_BASENAME(GetStreamHandler) (RTPRSSM_GLOBALS() ADD_RTPRSSM_COMMA ComponentInstance * outStreamHandler);

	EXTERN_API( ComponentResult  ) ADD_RTPRSSM_BASENAME(SendStreamHandlerChanged) (RTPRSSM_GLOBALS());

	EXTERN_API( ComponentResult  ) ADD_RTPRSSM_BASENAME(SetSampleDescription) (RTPRSSM_GLOBALS() ADD_RTPRSSM_COMMA SampleDescriptionHandle  inSampleDescription);

	EXTERN_API( ComponentResult  ) ADD_RTPRSSM_BASENAME(GetChunkAndIncrRefCount) (RTPRSSM_GLOBALS() ADD_RTPRSSM_COMMA UInt32  inChunkDataSize, const TimeValue64 * inChunkPresentationTime, SHChunkRecord ** outChunk);

	EXTERN_API( ComponentResult  ) ADD_RTPRSSM_BASENAME(SendChunkAndDecrRefCount) (RTPRSSM_GLOBALS() ADD_RTPRSSM_COMMA SHChunkRecord * inChunk, const SHServerEditParameters * inServerEdit);

	EXTERN_API( ComponentResult  ) ADD_RTPRSSM_BASENAME(SendLostChunk) (RTPRSSM_GLOBALS() ADD_RTPRSSM_COMMA const TimeValue64 * inChunkPresentationTime);

	EXTERN_API( ComponentResult  ) ADD_RTPRSSM_BASENAME(SendStreamBufferRange) (RTPRSSM_GLOBALS() ADD_RTPRSSM_COMMA RTPSendStreamBufferRangeParams * inParams);

	EXTERN_API( ComponentResult  ) ADD_RTPRSSM_BASENAME(ClearCachedPackets) (RTPRSSM_GLOBALS() ADD_RTPRSSM_COMMA SInt32  inFlags);

	EXTERN_API( ComponentResult  ) ADD_RTPRSSM_BASENAME(FillPacketListParams) (RTPRSSM_GLOBALS() ADD_RTPRSSM_COMMA RTPRssmPacket * inPacketListHead, SInt32  inNumWraparounds, SInt32  inFlags);

	EXTERN_API( ComponentResult  ) ADD_RTPRSSM_BASENAME(ReleasePacketList) (RTPRSSM_GLOBALS() ADD_RTPRSSM_COMMA RTPRssmPacket * inPacketListHead);

	EXTERN_API( ComponentResult  ) ADD_RTPRSSM_BASENAME(IncrChunkRefCount) (RTPRSSM_GLOBALS() ADD_RTPRSSM_COMMA SHChunkRecord * inChunk);

	EXTERN_API( ComponentResult  ) ADD_RTPRSSM_BASENAME(DecrChunkRefCount) (RTPRSSM_GLOBALS() ADD_RTPRSSM_COMMA SHChunkRecord * inChunk);

#endif

	/* MixedMode ProcInfo constants for component calls */
	enum {
		uppRTPRssmInitializeProcInfo = 0x000003F0,
		uppRTPRssmHandleNewPacketProcInfo = 0x00000FF0,
		uppRTPRssmComputeChunkSizeProcInfo = 0x00003FF0,
		uppRTPRssmAdjustPacketParamsProcInfo = 0x00000FF0,
		uppRTPRssmCopyDataToChunkProcInfo = 0x0000FFF0,
		uppRTPRssmSendPacketListProcInfo = 0x00003FF0,
		uppRTPRssmGetTimeScaleFromPacketProcInfo = 0x00000FF0,
		uppRTPRssmSetInfoProcInfo = 0x00000FF0,
		uppRTPRssmGetInfoProcInfo = 0x00000FF0,
		uppRTPRssmHasCharacteristicProcInfo = 0x00000FF0,
		uppRTPRssmResetProcInfo = 0x000003F0,
		uppRTPRssmSetCapabilitiesProcInfo = 0x00000FF0,
		uppRTPRssmGetCapabilitiesProcInfo = 0x000003F0,
		uppRTPRssmSetPayloadHeaderLengthProcInfo = 0x000003F0,
		uppRTPRssmGetPayloadHeaderLengthProcInfo = 0x000003F0,
		uppRTPRssmSetTimeScaleProcInfo = 0x000003F0,
		uppRTPRssmGetTimeScaleProcInfo = 0x000003F0,
		uppRTPRssmNewStreamHandlerProcInfo = 0x0000FFF0,
		uppRTPRssmSetStreamHandlerProcInfo = 0x000003F0,
		uppRTPRssmGetStreamHandlerProcInfo = 0x000003F0,
		uppRTPRssmSendStreamHandlerChangedProcInfo = 0x000000F0,
		uppRTPRssmSetSampleDescriptionProcInfo = 0x000003F0,
		uppRTPRssmGetChunkAndIncrRefCountProcInfo = 0x00003FF0,
		uppRTPRssmSendChunkAndDecrRefCountProcInfo = 0x00000FF0,
		uppRTPRssmSendLostChunkProcInfo = 0x000003F0,
		uppRTPRssmSendStreamBufferRangeProcInfo = 0x000003F0,
		uppRTPRssmClearCachedPacketsProcInfo = 0x000003F0,
		uppRTPRssmFillPacketListParamsProcInfo = 0x00003FF0,
		uppRTPRssmReleasePacketListProcInfo = 0x000003F0,
		uppRTPRssmIncrChunkRefCountProcInfo = 0x000003F0,
		uppRTPRssmDecrChunkRefCountProcInfo = 0x000003F0
	};

#endif	/* RTPRSSM_BASENAME */

#if CALL_NOT_IN_CARBON
#endif
/*
	Example usage:

		#define RTPMP_BASENAME()	Fred
		#define RTPMP_GLOBALS()	FredGlobalsHandle
		#include <QTStreamingComponents.k.h>

	To specify that your component implementation does not use globals, do not #define RTPMP_GLOBALS
*/
#ifdef RTPMP_BASENAME
	#ifndef RTPMP_GLOBALS
		#define RTPMP_GLOBALS() 
		#define ADD_RTPMP_COMMA 
	#else
		#define ADD_RTPMP_COMMA ,
	#endif
	#define RTPMP_GLUE(a,b) a##b
	#define RTPMP_STRCAT(a,b) RTPMP_GLUE(a,b)
	#define ADD_RTPMP_BASENAME(name) RTPMP_STRCAT(RTPMP_BASENAME(),name)

#if CALL_NOT_IN_CARBON
	EXTERN_API( ComponentResult  ) ADD_RTPMP_BASENAME(Initialize) (RTPMP_GLOBALS() ADD_RTPMP_COMMA SInt32  inFlags);

	EXTERN_API( ComponentResult  ) ADD_RTPMP_BASENAME(PreflightMedia) (RTPMP_GLOBALS() ADD_RTPMP_COMMA OSType  inMediaType, SampleDescriptionHandle  inSampleDescription);

	EXTERN_API( ComponentResult  ) ADD_RTPMP_BASENAME(Idle) (RTPMP_GLOBALS() ADD_RTPMP_COMMA SInt32  inFlags, SInt32 * outFlags);

	EXTERN_API( ComponentResult  ) ADD_RTPMP_BASENAME(SetSampleData) (RTPMP_GLOBALS() ADD_RTPMP_COMMA const RTPMPSampleDataParams * inSampleData, SInt32 * outFlags);

	EXTERN_API( ComponentResult  ) ADD_RTPMP_BASENAME(Flush) (RTPMP_GLOBALS() ADD_RTPMP_COMMA SInt32  inFlags, SInt32 * outFlags);

	EXTERN_API( ComponentResult  ) ADD_RTPMP_BASENAME(Reset) (RTPMP_GLOBALS() ADD_RTPMP_COMMA SInt32  inFlags);

	EXTERN_API( ComponentResult  ) ADD_RTPMP_BASENAME(SetInfo) (RTPMP_GLOBALS() ADD_RTPMP_COMMA OSType  inSelector, const void * ioParams);

	EXTERN_API( ComponentResult  ) ADD_RTPMP_BASENAME(GetInfo) (RTPMP_GLOBALS() ADD_RTPMP_COMMA OSType  inSelector, void * ioParams);

	EXTERN_API( ComponentResult  ) ADD_RTPMP_BASENAME(SetTimeScale) (RTPMP_GLOBALS() ADD_RTPMP_COMMA TimeScale  inTimeScale);

	EXTERN_API( ComponentResult  ) ADD_RTPMP_BASENAME(GetTimeScale) (RTPMP_GLOBALS() ADD_RTPMP_COMMA TimeScale * outTimeScale);

	EXTERN_API( ComponentResult  ) ADD_RTPMP_BASENAME(SetTimeBase) (RTPMP_GLOBALS() ADD_RTPMP_COMMA TimeBase  inTimeBase);

	EXTERN_API( ComponentResult  ) ADD_RTPMP_BASENAME(GetTimeBase) (RTPMP_GLOBALS() ADD_RTPMP_COMMA TimeBase * outTimeBase);

	EXTERN_API( ComponentResult  ) ADD_RTPMP_BASENAME(HasCharacteristic) (RTPMP_GLOBALS() ADD_RTPMP_COMMA OSType  inSelector, Boolean * outHasIt);

	EXTERN_API( ComponentResult  ) ADD_RTPMP_BASENAME(SetPacketBuilder) (RTPMP_GLOBALS() ADD_RTPMP_COMMA ComponentInstance  inPacketBuilder);

	EXTERN_API( ComponentResult  ) ADD_RTPMP_BASENAME(GetPacketBuilder) (RTPMP_GLOBALS() ADD_RTPMP_COMMA ComponentInstance * outPacketBuilder);

	EXTERN_API( ComponentResult  ) ADD_RTPMP_BASENAME(SetMediaType) (RTPMP_GLOBALS() ADD_RTPMP_COMMA OSType  inMediaType);

	EXTERN_API( ComponentResult  ) ADD_RTPMP_BASENAME(GetMediaType) (RTPMP_GLOBALS() ADD_RTPMP_COMMA OSType * outMediaType);

	EXTERN_API( ComponentResult  ) ADD_RTPMP_BASENAME(SetMaxPacketSize) (RTPMP_GLOBALS() ADD_RTPMP_COMMA UInt32  inMaxPacketSize);

	EXTERN_API( ComponentResult  ) ADD_RTPMP_BASENAME(GetMaxPacketSize) (RTPMP_GLOBALS() ADD_RTPMP_COMMA UInt32 * outMaxPacketSize);

	EXTERN_API( ComponentResult  ) ADD_RTPMP_BASENAME(SetMaxPacketDuration) (RTPMP_GLOBALS() ADD_RTPMP_COMMA UInt32  inMaxPacketDuration);

	EXTERN_API( ComponentResult  ) ADD_RTPMP_BASENAME(GetMaxPacketDuration) (RTPMP_GLOBALS() ADD_RTPMP_COMMA UInt32 * outMaxPacketDuration);

	EXTERN_API( ComponentResult  ) ADD_RTPMP_BASENAME(DoUserDialog) (RTPMP_GLOBALS() ADD_RTPMP_COMMA ModalFilterUPP  inFilterUPP, Boolean * canceled);

	EXTERN_API( ComponentResult  ) ADD_RTPMP_BASENAME(SetSettingsFromAtomContainerAtAtom) (RTPMP_GLOBALS() ADD_RTPMP_COMMA QTAtomContainer  inContainer, QTAtom  inParentAtom);

	EXTERN_API( ComponentResult  ) ADD_RTPMP_BASENAME(GetSettingsIntoAtomContainerAtAtom) (RTPMP_GLOBALS() ADD_RTPMP_COMMA QTAtomContainer  inOutContainer, QTAtom  inParentAtom);

	EXTERN_API( ComponentResult  ) ADD_RTPMP_BASENAME(GetSettingsAsText) (RTPMP_GLOBALS() ADD_RTPMP_COMMA Handle * text);

#endif

	/* MixedMode ProcInfo constants for component calls */
	enum {
		uppRTPMPInitializeProcInfo = 0x000003F0,
		uppRTPMPPreflightMediaProcInfo = 0x00000FF0,
		uppRTPMPIdleProcInfo = 0x00000FF0,
		uppRTPMPSetSampleDataProcInfo = 0x00000FF0,
		uppRTPMPFlushProcInfo = 0x00000FF0,
		uppRTPMPResetProcInfo = 0x000003F0,
		uppRTPMPSetInfoProcInfo = 0x00000FF0,
		uppRTPMPGetInfoProcInfo = 0x00000FF0,
		uppRTPMPSetTimeScaleProcInfo = 0x000003F0,
		uppRTPMPGetTimeScaleProcInfo = 0x000003F0,
		uppRTPMPSetTimeBaseProcInfo = 0x000003F0,
		uppRTPMPGetTimeBaseProcInfo = 0x000003F0,
		uppRTPMPHasCharacteristicProcInfo = 0x00000FF0,
		uppRTPMPSetPacketBuilderProcInfo = 0x000003F0,
		uppRTPMPGetPacketBuilderProcInfo = 0x000003F0,
		uppRTPMPSetMediaTypeProcInfo = 0x000003F0,
		uppRTPMPGetMediaTypeProcInfo = 0x000003F0,
		uppRTPMPSetMaxPacketSizeProcInfo = 0x000003F0,
		uppRTPMPGetMaxPacketSizeProcInfo = 0x000003F0,
		uppRTPMPSetMaxPacketDurationProcInfo = 0x000003F0,
		uppRTPMPGetMaxPacketDurationProcInfo = 0x000003F0,
		uppRTPMPDoUserDialogProcInfo = 0x00000FF0,
		uppRTPMPSetSettingsFromAtomContainerAtAtomProcInfo = 0x00000FF0,
		uppRTPMPGetSettingsIntoAtomContainerAtAtomProcInfo = 0x00000FF0,
		uppRTPMPGetSettingsAsTextProcInfo = 0x000003F0
	};

#endif	/* RTPMP_BASENAME */

/*
	Example usage:

		#define RTPPB_BASENAME()	Fred
		#define RTPPB_GLOBALS()	FredGlobalsHandle
		#include <QTStreamingComponents.k.h>

	To specify that your component implementation does not use globals, do not #define RTPPB_GLOBALS
*/
#ifdef RTPPB_BASENAME
	#ifndef RTPPB_GLOBALS
		#define RTPPB_GLOBALS() 
		#define ADD_RTPPB_COMMA 
	#else
		#define ADD_RTPPB_COMMA ,
	#endif
	#define RTPPB_GLUE(a,b) a##b
	#define RTPPB_STRCAT(a,b) RTPPB_GLUE(a,b)
	#define ADD_RTPPB_BASENAME(name) RTPPB_STRCAT(RTPPB_BASENAME(),name)

#if CALL_NOT_IN_CARBON
	EXTERN_API( ComponentResult  ) ADD_RTPPB_BASENAME(BeginPacketGroup) (RTPPB_GLOBALS() ADD_RTPPB_COMMA SInt32  inFlags, UInt32  inTimeStamp, RTPPacketGroupRef * outPacketGroup);

	EXTERN_API( ComponentResult  ) ADD_RTPPB_BASENAME(EndPacketGroup) (RTPPB_GLOBALS() ADD_RTPPB_COMMA SInt32  inFlags, RTPPacketGroupRef  inPacketGroup);

	EXTERN_API( ComponentResult  ) ADD_RTPPB_BASENAME(BeginPacket) (RTPPB_GLOBALS() ADD_RTPPB_COMMA SInt32  inFlags, RTPPacketGroupRef  inPacketGroup, UInt32  inPacketMediaDataLength, RTPPacketRef * outPacket);

	EXTERN_API( ComponentResult  ) ADD_RTPPB_BASENAME(EndPacket) (RTPPB_GLOBALS() ADD_RTPPB_COMMA SInt32  inFlags, RTPPacketGroupRef  inPacketGroup, RTPPacketRef  inPacket, UInt32  inTimeOffset, UInt32  inDuration);

	EXTERN_API( ComponentResult  ) ADD_RTPPB_BASENAME(AddPacketLiteralData) (RTPPB_GLOBALS() ADD_RTPPB_COMMA SInt32  inFlags, RTPPacketGroupRef  inPacketGroup, RTPPacketRef  inPacket, UInt8 * inData, UInt32  inDataLength, RTPPacketRepeatedDataRef * outDataRef);

	EXTERN_API( ComponentResult  ) ADD_RTPPB_BASENAME(AddPacketSampleData) (RTPPB_GLOBALS() ADD_RTPPB_COMMA SInt32  inFlags, RTPPacketGroupRef  inPacketGroup, RTPPacketRef  inPacket, RTPMPSampleDataParams * inSampleDataParams, UInt32  inSampleOffset, UInt32  inSampleDataLength, RTPPacketRepeatedDataRef * outDataRef);

	EXTERN_API( ComponentResult  ) ADD_RTPPB_BASENAME(AddPacketRepeatedData) (RTPPB_GLOBALS() ADD_RTPPB_COMMA SInt32  inFlags, RTPPacketGroupRef  inPacketGroup, RTPPacketRef  inPacket, RTPPacketRepeatedDataRef  inDataRef);

	EXTERN_API( ComponentResult  ) ADD_RTPPB_BASENAME(ReleaseRepeatedData) (RTPPB_GLOBALS() ADD_RTPPB_COMMA RTPPacketRepeatedDataRef  inDataRef);

	EXTERN_API( ComponentResult  ) ADD_RTPPB_BASENAME(SetPacketSequenceNumber) (RTPPB_GLOBALS() ADD_RTPPB_COMMA SInt32  inFlags, RTPPacketGroupRef  inPacketGroup, RTPPacketRef  inPacket, UInt32  inSequenceNumber);

	EXTERN_API( ComponentResult  ) ADD_RTPPB_BASENAME(GetPacketSequenceNumber) (RTPPB_GLOBALS() ADD_RTPPB_COMMA SInt32  inFlags, RTPPacketGroupRef  inPacketGroup, RTPPacketRef  inPacket, UInt32 * outSequenceNumber);

	EXTERN_API( ComponentResult  ) ADD_RTPPB_BASENAME(SetCallback) (RTPPB_GLOBALS() ADD_RTPPB_COMMA RTPPBCallbackUPP  inCallback, void * inRefCon);

	EXTERN_API( ComponentResult  ) ADD_RTPPB_BASENAME(GetCallback) (RTPPB_GLOBALS() ADD_RTPPB_COMMA RTPPBCallbackUPP * outCallback, void ** outRefCon);

	EXTERN_API( ComponentResult  ) ADD_RTPPB_BASENAME(SetInfo) (RTPPB_GLOBALS() ADD_RTPPB_COMMA OSType  inSelector, void * ioParams);

	EXTERN_API( ComponentResult  ) ADD_RTPPB_BASENAME(GetInfo) (RTPPB_GLOBALS() ADD_RTPPB_COMMA OSType  inSelector, void * ioParams);

#endif

	/* MixedMode ProcInfo constants for component calls */
	enum {
		uppRTPPBBeginPacketGroupProcInfo = 0x00003FF0,
		uppRTPPBEndPacketGroupProcInfo = 0x00000FF0,
		uppRTPPBBeginPacketProcInfo = 0x0000FFF0,
		uppRTPPBEndPacketProcInfo = 0x0003FFF0,
		uppRTPPBAddPacketLiteralDataProcInfo = 0x000FFFF0,
		uppRTPPBAddPacketSampleDataProcInfo = 0x003FFFF0,
		uppRTPPBAddPacketRepeatedDataProcInfo = 0x0000FFF0,
		uppRTPPBReleaseRepeatedDataProcInfo = 0x000003F0,
		uppRTPPBSetPacketSequenceNumberProcInfo = 0x0000FFF0,
		uppRTPPBGetPacketSequenceNumberProcInfo = 0x0000FFF0,
		uppRTPPBSetCallbackProcInfo = 0x00000FF0,
		uppRTPPBGetCallbackProcInfo = 0x00000FF0,
		uppRTPPBSetInfoProcInfo = 0x00000FF0,
		uppRTPPBGetInfoProcInfo = 0x00000FF0
	};

#endif	/* RTPPB_BASENAME */

#if CALL_NOT_IN_CARBON
#endif

#endif /* __QTSTREAMINGCOMPONENTS_K__ */
