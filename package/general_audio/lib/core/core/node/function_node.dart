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

/// An audio node that generates audio data by a function.
class FunctionNode extends DataSourceNode {
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  FunctionNode({
    required this.function,
    required AudioFormat format,
    required double frequency,
    this.time = const AudioTime(0),
  })  : outputFormat = format,
        _advance = AudioTime(1.0 / (format.sampleRate / frequency)),
        _frequency = frequency {
    switch (format.sampleFormat) {
      case SampleFormat.float32:
        _readFunc = _readFloat32;
      case SampleFormat.int16:
        _readFunc = _readInt16;
      case SampleFormat.int32:
        _readFunc = _readInt32;
      case SampleFormat.uint8:
        _readFunc = _readUint8;
      case SampleFormat.int24:
        throw AudioFormatError.unsupportedSampleFormat(format.sampleFormat);
    }
  }

  @override
  final AudioFormat outputFormat;

  late final void Function(AudioOutputBus outputBus, AudioBuffer buffer)
      _readFunc;

  AudioTime _advance;

  double _frequency;

  /// The frequency of the audio data.
  double get frequency => _frequency;

  set frequency(double freq) {
    _frequency = freq;
    _advance = AudioTime(freq / outputFormat.sampleRate);
  }

  /// Current time of this node.
  AudioTime time;

  /// The function that generates audio data.
  WaveFunction function;

  void _readFloat32(AudioOutputBus outputBus, AudioBuffer buffer) {
    final list = buffer.asFloat32ListView();
    for (var i = 0; list.length > i; i += outputFormat.channels) {
      final sample = function.compute(time);
      for (var ch = 0; outputFormat.channels > ch; ch++) {
        list[i + ch] = sample;
      }
      time += _advance;
    }
  }

  void _readInt16(AudioOutputBus outputBus, AudioBuffer buffer) {
    final list = buffer.asInt16ListView();
    for (var i = 0; list.length > i; i += outputFormat.channels) {
      final sample = function.compute(time);
      for (var ch = 0; outputFormat.channels > ch; ch++) {
        list[i + ch] = max((sample * SampleFormat.int16.max).toInt(),
            SampleFormat.int16.min.toInt());
      }
      time += _advance;
    }
  }

  void _readInt32(AudioOutputBus outputBus, AudioBuffer buffer) {
    final list = buffer.asInt32ListView();
    for (var i = 0; list.length > i; i += outputFormat.channels) {
      final sample = function.compute(time);
      for (var ch = 0; outputFormat.channels > ch; ch++) {
        list[i + ch] = max((sample * SampleFormat.int32.max).toInt(),
            SampleFormat.int32.min.toInt());
      }
      time += _advance;
    }
  }

  void _readUint8(AudioOutputBus outputBus, AudioBuffer buffer) {
    final list = buffer.asUint8ListViewFrames();
    for (var i = 0; list.length > i; i += outputFormat.channels) {
      final sample = function.compute(time);
      for (var ch = 0; outputFormat.channels > ch; ch++) {
        list[i + ch] = max((sample * SampleFormat.uint8.max).toInt(),
            SampleFormat.uint8.min.toInt());
      }
      time += _advance;
    }
  }

  @override
  AudioReadResult read(AudioOutputBus outputBus, AudioBuffer buffer) {
    _readFunc(outputBus, buffer);
    return AudioReadResult(frameCount: buffer.sizeInFrames, isEnd: false);
  }
}
