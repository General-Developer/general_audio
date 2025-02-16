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

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class FrameRingBuffer {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  FrameRingBuffer({
    required this.capacity,
    required this.format,
    Memory? memory,
  }) : _ringBuffer = RingBuffer(
          capacity: format.bytesPerFrame * capacity,
          memory: memory,
        );

  late final RingBuffer _ringBuffer;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final AudioFormat format;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final int capacity;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  int get length => _ringBuffer.length ~/ format.bytesPerFrame;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  int write(AudioBuffer buffer) {
    assert(buffer.format.isSameFormat(format));
    return _ringBuffer.write(buffer.pBuffer.cast(), 0, buffer.sizeInBytes) ~/
        format.bytesPerFrame;
  }

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  int read(AudioBuffer buffer, {bool advance = true}) {
    assert(buffer.format.isSameFormat(format));
    return _ringBuffer.read(buffer.pBuffer.cast(), 0, buffer.sizeInBytes,
            advance: advance) ~/
        format.bytesPerFrame;
  }

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  int copyTo(FrameRingBuffer buffer, {required bool advance}) {
    assert(buffer.format.isSameFormat(format));
    return _ringBuffer.copyTo(buffer._ringBuffer, advance: advance) ~/
        format.bytesPerFrame;
  }

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  void clear() {
    _ringBuffer.clear();
  }
}
