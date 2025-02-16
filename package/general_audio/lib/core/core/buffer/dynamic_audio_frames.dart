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

/// An audio buffer that can be resized dynamically.
class DynamicAudioFrames extends AudioFrames with AudioResourceMixin {
  /// Creates a [DynamicAudioFrames].
  ///
  /// [initialFrameLength] is the initial length of the buffer.
  /// If [maxFrames] is not null, the buffer will not be resized larger than [maxFrames].
  /// [format] is the audio format of the buffer.
  DynamicAudioFrames({
    int initialFrameLength = 512,
    this.maxFrames,
    required this.format,
  })  : _sizeInFrames = initialFrameLength,
        _sizeInBytes = format.bytesPerFrame * initialFrameLength;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final int? maxFrames;
  int _sizeInBytes;
  int _sizeInFrames;
  AllocatedAudioFrames? _internalBuffer;

  @override
  final AudioFormat format;

  @override
  int get sizeInBytes => _sizeInBytes;

  @override
  int get sizeInFrames => _sizeInFrames;

  /// Request the buffer size to be [frames].
  ///
  /// If [lazy] is true, the buffer will not be allocated until [lock] is called.
  /// If [shrink] is true, the buffer will not be reallocated if the requested size is smaller than the current size.
  bool requestFrames(
    int frames, {
    bool lazy = true,
    bool shrink = false,
  }) {
    if (maxFrames != null && frames > maxFrames!) {
      return false;
    }

    if (frames == _sizeInFrames) {
      return true;
    }

    _sizeInFrames = frames;
    _sizeInBytes = frames * format.bytesPerFrame;

    // If the requested frame count is less than sizeInFrames, reuse the last buffer.
    if (!shrink && frames < _sizeInFrames) {
      return true;
    }

    if (lazy) {
      _internalBuffer = null;
    } else {
      _internalBuffer = AllocatedAudioFrames(length: frames, format: format);
    }

    return true;
  }

  @override
  AudioBuffer lock() {
    final lastBuffer = _internalBuffer ??
        AllocatedAudioFrames(length: _sizeInFrames, format: format);
    _internalBuffer ??= lastBuffer;

    return lastBuffer.lock().limit(sizeInFrames);
  }

  @override
  void unlock() {
    _internalBuffer?.unlock();
  }
}
