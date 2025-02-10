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

/// [AllocatedAudioFrames] allocates requested frames of buffer.
///
/// If you want to fill the buffer with zero, set [fillZero] to `true`.
class AllocatedAudioFrames extends AudioFrames with AudioResourceMixin {
  factory AllocatedAudioFrames({
    required int length,
    required AudioFormat format,
    bool fillZero = false,
    Memory? memory,
    Mutex? mutex,
  }) {
    final mem = memory ?? Memory();
    final sizeInBytes = format.bytesPerFrame * length;
    final pBuffer = mem.allocator.allocate<Uint8>(sizeInBytes);

    return AllocatedAudioFrames._init(
      pBuffer: pBuffer,
      mutex: mutex ?? Mutex(),
      sizeInBytes: sizeInBytes,
      sizeInFrames: length,
      format: format,
      memory: mem,
    );
  }

  AllocatedAudioFrames._init({
    required Pointer<Uint8> pBuffer,
    required Mutex mutex,
    required this.sizeInBytes,
    required this.sizeInFrames,
    required this.format,
    required this.memory,
  })  : _pBuffer = pBuffer,
        _mutex = mutex {
    final captured = (memory, pBuffer);
    setResourceFinalizer(() {
      captured.$1.allocator.free(captured.$2);
    });
  }

  final Mutex _mutex;

  @override
  final AudioFormat format;

  @override
  final int sizeInBytes;

  @override
  final int sizeInFrames;

  /// internal buffer pointer.
  final Pointer<Uint8> _pBuffer;

  /// internal buffer memory allocator.
  final Memory memory;

  @override
  AudioBuffer lock() {
    _mutex.lock();
    return AudioBuffer(
      root: this,
      pBuffer: _pBuffer,
      sizeInBytes: sizeInBytes,
      sizeInFrames: sizeInFrames,
      format: format,
      memory: memory,
    );
  }

  @override
  void unlock() {
    _mutex.unlock();
  }
}
