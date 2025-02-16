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

/// A node that mixes audio data from multiple input buses.
class MixerNode extends AudioNode with SingleOutNodeMixin {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  MixerNode({
    required this.format,
    this.isClampEnabled = true,
    Memory? memory,
  }) : memory = memory ?? Memory() {
    switch (format.sampleFormat) {
      case SampleFormat.float32:
        _mixerFunc = _mixFloat32;
      case SampleFormat.int16:
        _mixerFunc = _mixInt16;
      case SampleFormat.int32:
        _mixerFunc = _mixInt32;
      case SampleFormat.uint8:
        _mixerFunc = _mixUint8;
      case SampleFormat.int24:
        throw AudioFormatError.unsupportedSampleFormat(format.sampleFormat);
    }
  }

  /// The memory that this node uses to allocate internal audio buffer.
  final Memory memory;

  /// The format of the audio data that this node provides.
  final AudioFormat format;

  /// Whether to clamp the audio data after mixing.
  ///
  /// If this is true, the audio data will be clamped to the range of the format after mixing.
  /// e.g. If the sample format is [SampleFormat.float32], the value is clamped to the range of -1.0 to 1.0.
  bool isClampEnabled;

  late final void Function(
          AudioBuffer bufferIn, AudioBuffer mixerOut, int totalReadFrames)
      _mixerFunc;

  final _inputs = <AudioInputBus>[];

  late final _audioFrame = DynamicAudioFrames(format: format);

  @override
  late final outputBus =
      AudioOutputBus(node: this, formatResolver: (_) => format);

  @override
  List<AudioInputBus> get inputs => List.unmodifiable(_inputs);

  /// Append an input bus to this node.
  ///
  /// The format of the input bus must be the same as the format of this node.
  AudioInputBus appendInputBus() {
    final bus = AudioInputBus(node: this, formatResolver: (_) => format);
    _inputs.add(bus);
    return bus;
  }

  /// Remove the input bus from this node.
  ///
  /// If the bus is connected to another bus or the bus is associated to this node, it throws [MixerNodeException].
  void removeInputBus(AudioInputBus bus) {
    if (bus.connectedBus != null) {
      throw MixerNodeException.connectedInputBus();
    }

    if (bus.node != this) {
      throw MixerNodeException.invalidBus();
    }

    _inputs.remove(bus);
  }

  void _mixFloat32(
      AudioBuffer bufferIn, AudioBuffer mixerOut, int totalReadFrames) {
    final inFloatList = bufferIn.asFloat32ListView();
    final outFloatList = mixerOut.asFloat32ListView();
    for (var i = 0; (totalReadFrames * format.channels) > i; i++) {
      outFloatList[i] += inFloatList[i];
    }
  }

  void _mixInt16(
      AudioBuffer bufferIn, AudioBuffer mixerOut, int totalReadFrames) {
    final inInt16List = bufferIn.asInt16ListView();
    final outInt16List = mixerOut.asInt16ListView();
    for (var i = 0; (totalReadFrames * format.channels) > i; i++) {
      outInt16List[i] += inInt16List[i];
    }
  }

  void _mixInt32(
      AudioBuffer bufferIn, AudioBuffer mixerOut, int totalReadFrames) {
    final inInt32List = bufferIn.asInt32ListView();
    final outInt32List = mixerOut.asInt32ListView();
    for (var i = 0; (totalReadFrames * format.channels) > i; i++) {
      outInt32List[i] += inInt32List[i];
    }
  }

  void _mixUint8(
      AudioBuffer bufferIn, AudioBuffer mixerOut, int totalReadFrames) {
    final inUint8List = bufferIn.asUint8ListViewFrames();
    final outUint8List = mixerOut.asUint8ListViewFrames();
    for (var i = 0; (totalReadFrames * format.channels) > i; i++) {
      outUint8List[i] += inUint8List[i];
    }
  }

  @override
  AudioReadResult read(AudioOutputBus outputBus, AudioBuffer buffer) {
    if (_inputs.isEmpty) {
      return AudioReadResult(frameCount: 0, isEnd: true);
    }

    if (_inputs.length == 1) {
      return _inputs[0].connectedBus!.read(buffer);
    }

    buffer.fillBytes(0);
    _audioFrame.requestFrames(buffer.sizeInFrames);

    final result = _audioFrame.acquireBuffer((busBuffer) {
      var maxReadFrames = 0;
      var isEnd = true;

      for (var bus in _inputs) {
        var left = buffer.sizeInFrames;
        var readResult = bus.connectedBus!.read(busBuffer);
        if (!readResult.isEnd) {
          isEnd = false;
        }
        var totalReadFrames = readResult.frameCount;
        left -= readResult.frameCount;

        // read until the buffer is full or the source is ended
        while (left > 0 && readResult.frameCount > 0 && !readResult.isEnd) {
          readResult =
              bus.connectedBus!.read(busBuffer.offset(totalReadFrames));
          if (!readResult.isEnd) {
            isEnd = false;
          }
          totalReadFrames += readResult.frameCount;
          left -= readResult.frameCount;
        }

        _mixerFunc(busBuffer, buffer, totalReadFrames);
        maxReadFrames = max(totalReadFrames, maxReadFrames);
      }

      return AudioReadResult(frameCount: maxReadFrames, isEnd: isEnd);
    });

    if (isClampEnabled) {
      buffer.clamp(frames: result.frameCount);
    }

    return result;
  }
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class MixerNodeException implements Exception {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const MixerNodeException.connectedInputBus()
      : message = 'input bus is connected to another bus',
        code = -1;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const MixerNodeException.invalidBus()
      : message = 'the bus is not associated to this node',
        code = -2;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final String message;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final int code;

  @override
  String toString() {
    return 'MixerNodeException(code: $code, message: $message)';
  }
}
