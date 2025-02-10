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
import 'dart:ffi';

import 'package:general_audio/core/general_audio.dart';

/// [AudioBuffer] is a [AudioFrames]'s internal audio buffer data.
/// [pBuffer] contains pointer to a raw pcm audio.
class AudioBuffer {
  /// Constructs the [AudioBuffer] from pointer.
  AudioBuffer({
    required this.root,
    required this.pBuffer,
    required this.sizeInBytes,
    required this.sizeInFrames,
    required this.format,
    required this.memory,
  }) {
    assert(sizeInBytes == (sizeInFrames * format.bytesPerFrame));
  }

  /// The root [AudioFrames] of this [AudioBuffer].
  final AudioFrames root;

  /// Pointer to the raw audio data.
  final Pointer<Uint8> pBuffer;

  /// size of [pBuffer] in bytes.
  final int sizeInBytes;

  /// size of [pBuffer] in frames.
  final int sizeInFrames;

  /// format of [pBuffer].
  final AudioFormat format;

  /// [pBuffer]'s memory allocator.
  final Memory memory;

  /// move the [pBuffer] forward by requested [frames] and returns a view of [AudioBuffer].
  AudioBuffer offset(int frames) {
    assert(frames <= sizeInFrames);
    return AudioBuffer(
      root: root,
      pBuffer: Pointer.fromAddress(
          pBuffer.address + (format.bytesPerFrame * frames)),
      sizeInBytes: sizeInBytes - (frames * format.bytesPerFrame),
      sizeInFrames: sizeInFrames - frames,
      format: format,
      memory: memory,
    );
  }

  /// limit the [pBuffer] to requested [frames] and returns a view of [AudioBuffer].
  AudioBuffer limit(int frames) {
    assert(frames <= sizeInFrames);
    return AudioBuffer(
      root: root,
      pBuffer: pBuffer,
      sizeInBytes: frames * format.bytesPerFrame,
      sizeInFrames: frames,
      format: format,
      memory: memory,
    );
  }
}
