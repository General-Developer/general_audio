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
import 'dart:math';

import 'package:general_audio/core/general_audio.dart';

/// [ConverterNode] is a node that converts the audio data to the specified format.
class ConverterNode extends AudioNode
    with SingleInNodeMixin, SingleOutNodeMixin {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  ConverterNode({
    required this.outputFormat,
    this.bufferFrameCount = 1024,
  });

  /// The output format of the audio data.
  final AudioFormat outputFormat;

  /// The buffer size for
  final int bufferFrameCount;

  AudioFormat? _cachedInputFormat;

  _Converter? _converter;

  _Converter _createOrGetConverter(AudioFormat inputFormat) {
    final lastConverter = _converter;
    if (lastConverter != null && lastConverter.isCompatible(inputFormat)) {
      return lastConverter;
    }

    _converter = _Converter(
      inputFormat: inputFormat,
      outputFormat: outputFormat,
      bufferFrameCount: bufferFrameCount,
    );
    return _converter!;
  }

  @override
  late final inputBus = AudioInputBus.autoFormat(
    node: this,
    attemptConnectBus: (bus) {
      // cache the input format if available
      _cachedInputFormat = bus.resolveFormat();
    },
  );

  @override
  late final outputBus =
      AudioOutputBus(node: this, formatResolver: (_) => outputFormat);

  @override
  AudioReadResult read(AudioOutputBus outputBus, AudioBuffer buffer) {
    final inputFormat = _cachedInputFormat ?? outputBus.resolveFormat();
    assert(inputFormat != null);

    final converter = _createOrGetConverter(inputFormat!);
    return converter.convert(inputBus, buffer);
  }
}

class _Converter {
  _Converter({
    required AudioFormat inputFormat,
    required AudioFormat outputFormat,
    required int bufferFrameCount,
  })  : _converter = AudioFormatConverter(
          inputFormat: inputFormat,
          outputFormat: outputFormat,
        ),
        _frames =
            AllocatedAudioFrames(format: inputFormat, length: bufferFrameCount);

  final AudioFormatConverter _converter;
  final AllocatedAudioFrames _frames;

  late final _inputBuffer = _frames.lock();

  bool isCompatible(AudioFormat inputFormat) =>
      _converter.inputFormat.isSameFormat(inputFormat);

  AudioReadResult convert(AudioInputBus inputBus, AudioBuffer outputBuffer) {
    var framesRead = 0;
    var isEnd = false;
    while (framesRead < outputBuffer.sizeInFrames) {
      final readResult = inputBus.connectedBus!.read(
        _inputBuffer.limit(min(
            outputBuffer.sizeInFrames - framesRead, _inputBuffer.sizeInFrames)),
      );

      framesRead += readResult.frameCount;
      _converter.convert(
          input: _inputBuffer.limit(readResult.frameCount),
          output: outputBuffer.offset(framesRead));

      if (readResult.isEnd) {
        isEnd = true;
        break;
      }
    }

    return AudioReadResult(
      frameCount: framesRead,
      isEnd: isEnd,
    );
  }

  void dispose() {
    _frames.unlock();
  }
}
