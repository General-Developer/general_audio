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
import 'package:general_audio/core/general_audio.dart';

class DelayNode extends AudioFilterNode {
  DelayNode({
    required this.delayFrames,
    required this.delayStart,
    required this.format,
    required this.decay,
    this.dry = 1,
    this.wet = 1,
  }) : _delayBuffer = List.filled(delayFrames * format.channels, 0);

  final int delayFrames;
  final bool delayStart;
  final AudioFormat format;

  @override
  late final inputBus =
      AudioInputBus(node: this, formatResolver: (_) => format);

  @override
  late final outputBus =
      AudioOutputBus(node: this, formatResolver: (_) => format);

  double decay;
  double dry;
  double wet;

  final List<double> _delayBuffer;
  var _cursor = 0;

  void reset() {
    _delayBuffer.fillRange(0, _delayBuffer.length, 0);
    _cursor = 0;
  }

  @override
  AudioReadResult process(AudioBuffer buffer, bool isEnd) {
    final floatList = buffer.asFloat32ListView();

    for (var frame = 0; buffer.sizeInFrames > frame; frame++) {
      for (var channel = 0; format.channels > channel; channel++) {
        final delayBufferIndex = (_cursor * format.channels) + channel;
        final bufferIndex = (frame * format.channels) + channel;

        if (delayStart) {
          final sample = floatList[bufferIndex];
          floatList[bufferIndex] = _delayBuffer[delayBufferIndex] * wet;
          _delayBuffer[delayBufferIndex] =
              (_delayBuffer[delayBufferIndex] * decay) + (sample * dry);
        } else {
          _delayBuffer[delayBufferIndex] =
              (_delayBuffer[delayBufferIndex] * decay) +
                  (floatList[bufferIndex] * dry);
          floatList[bufferIndex] = _delayBuffer[delayBufferIndex] * wet;
        }

        _cursor = (_cursor + 1) % delayFrames;
      }
    }

    return AudioReadResult(frameCount: buffer.sizeInFrames, isEnd: false);
  }
}
