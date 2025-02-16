/* <!-- START LICENSE -->


This Software / Program / Source Code Created By Developer From Company GLOBAL CORPORATION
Social Media:

   - Youtube: https://youtube.com/@Global_Corporation 
   - Github: https://github.com/globalcorporation
   - TELEGRAM: https://t.me/GLOBAL_CORP_ORG_BOT

All code script in here created 100% original without copy / steal from other code if we copy we add description source at from top code

If you wan't edit you must add credit me (don't change)

If this Software / Program / Source Code has you

Jika Program ini milik anda dari hasil beli jasa developer di (Global Corporation / apapun itu dari turunan itu jika ada kesalahan / bug / ingin update segera lapor ke sub)

Misal anda beli Beli source code di Slebew CORPORATION anda lapor dahulu di slebew jangan lapor di GLOBAL CORPORATION!

Jika ada kendala program ini (Pastikan sebelum deal project tidak ada negosiasi harga)
Karena jika ada negosiasi harga kemungkinan

1. Software Ada yang di kurangin
2. Informasi tidak lengkap
3. Bantuan Tidak Bisa remote / full time (Ada jeda)

Sebelum program ini sampai ke pembeli developer kami sudah melakukan testing

jadi sebelum nego kami sudah melakukan berbagai konsekuensi jika nego tidak sesuai ? 
Bukan maksud kami menipu itu karena harga yang sudah di kalkulasi + bantuan tiba tiba di potong akhirnya bantuan / software kadang tidak lengkap


<!-- END LICENSE --> */
import 'dart:ffi' as ffi;
import 'dart:ffi';

import 'package:general_audio/core/general_audio.dart';
import 'package:general_audio/core/core/codec/wav/wav_chunk.dart';
import 'package:general_audio/core/core/ffi_extension.dart';

/// An audio decoder for WAV format.
///
/// This decoder supports linear PCM with 8, 16, 24, and 32 bits per sample.
/// AIFF, A-law and μ-law are not supported.
class WavAudioDecoder extends AudioDecoder {
  WavAudioDecoder._fromInfo({
    required this.dataSource,
    required this.outputFormat,
    required this.dataChunkOffset,
    required this.dataChunkLength,
    required this.bytesPerSample,
    required this.channels,
  }) : bytesPerFrame = bytesPerSample * channels;

  /// Creates an audio decoder for WAV format.
  factory WavAudioDecoder({
    required AudioInputDataSource dataSource,
  }) {
    final memory = Memory();
    if (dataSource.canSeek) {
      dataSource.position = 0;
    }

    final chunkLength = ffi.sizeOf<WavChunk>();
    final pChunk = memory.allocator.allocate<WavChunk>(chunkLength);

    final riffLength = ffi.sizeOf<WavRiffData>();
    final pRiffData = memory.allocator.allocate<WavRiffData>(riffLength);

    final fmtLength = ffi.sizeOf<WavFmtData>();
    final pFmtData = memory.allocator.allocate<WavFmtData>(fmtLength);

    try {
      dataSource.readBytes(pChunk.cast<ffi.Uint8>().asTypedList(chunkLength));
      if (pChunk.ref.id.getAsciiString(4) != 'RIFF') {
        throw WavFormatException(
            'could not find the RIFF chunk. invalid audio file format.');
      }

      dataSource.readBytes(pRiffData.cast<ffi.Uint8>().asTypedList(riffLength));

      final riffFormat = pRiffData.ref.format.getAsciiString(4);
      if (riffFormat != 'WAVE') {
        throw WavFormatException(
            'unsupported format found in riff chunk: ${pRiffData.ref}');
      }

      while (true) {
        final byteCount = dataSource
            .readBytes(pChunk.cast<ffi.Uint8>().asTypedList(chunkLength));
        if (byteCount < chunkLength) {
          throw WavFormatException(
              'could not find the fmt chunk. invalid audio file format.');
        }

        if (pChunk.ref.id.getAsciiString(4) == 'fmt ') {
          break;
        } else if (dataSource.canSeek) {
          dataSource.position += pChunk.ref.size;
        } else {
          throw WavFormatException(
              'could not find the fmt chunk. invalid audio file format.');
        }
      }

      dataSource.readBytes(pFmtData.cast<ffi.Uint8>().asTypedList(fmtLength));

      final fmtChunk = pFmtData.ref;
      if (fmtChunk.encodingFormat != 1 && fmtChunk.encodingFormat != 3) {
        // Linear PCM is supported.
        throw WavFormatException(
            'unsupported encoding format found in fmt chunk: $fmtChunk');
      }

      final SampleFormat sampleFormat;
      switch (fmtChunk.bitsPerSample) {
        case 8:
          sampleFormat = SampleFormat.uint8;
        case 16:
          sampleFormat = SampleFormat.int16;
        case 24:
          sampleFormat = SampleFormat.int24;
        case 32:
          sampleFormat = SampleFormat.int32;
        default:
          throw WavFormatException(
              'unsupported bits per sample found in fmt chunk: $fmtChunk');
      }

      while (true) {
        final read = dataSource
            .readBytes(pChunk.cast<ffi.Uint8>().asTypedList(chunkLength));
        if (read < 4) {
          throw WavFormatException('could not find the data chunk');
        }

        if (pChunk.ref.id.getAsciiString(4) == 'data') {
          break;
        } else {
          dataSource.position += pChunk.ref.size;
        }
      }

      return WavAudioDecoder._fromInfo(
        dataSource: dataSource,
        outputFormat: AudioFormat(
          sampleRate: fmtChunk.sampleRate,
          channels: fmtChunk.channels,
          sampleFormat: sampleFormat,
        ),
        dataChunkOffset: dataSource.position,
        dataChunkLength: pChunk.ref.size,
        bytesPerSample: fmtChunk.bitsPerSample ~/ 8,
        channels: fmtChunk.channels,
      );
    } finally {
      memory.allocator.free(pChunk);
      memory.allocator.free(pRiffData);
      memory.allocator.free(pFmtData);
    }
  }

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final AudioInputDataSource dataSource;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final int dataChunkOffset;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final int dataChunkLength;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final int bytesPerSample;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final int channels;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final int bytesPerFrame;

  @override
  final AudioFormat outputFormat;

  @override
  int get cursorInFrames {
    return (dataSource.position - dataChunkOffset) ~/ bytesPerFrame;
  }

  @override
  set cursorInFrames(int value) {
    final position = value * bytesPerFrame;
    dataSource.position = dataChunkOffset + position;
  }

  @override
  int? get lengthInFrames {
    return dataChunkLength ~/ bytesPerFrame;
  }

  @override
  bool get canSeek => dataSource.canSeek;

  @override
  AudioDecodeResult decode({required AudioBuffer destination}) {
    final totalReadBytes =
        dataSource.readBytes(destination.asUint8ListViewBytes());
    return AudioDecodeResult(
      frameCount: totalReadBytes ~/ bytesPerFrame,
      isEnd: cursorInFrames == lengthInFrames,
    );
  }
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class WavFormatException implements Exception {
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const WavFormatException(this.message);
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final String message;

  @override
  String toString() {
    return message;
  }
}
