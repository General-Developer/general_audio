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

/// [AudioFrames] is a base class of audio buffers.
/// You can call [lock] to request internal lock and retrieve the [AudioBuffer].
/// When you call [lock], you must call [unlock] when the raw buffer operations is not necessary.
/// [Memory] will be used internal buffer allocations.
abstract class AudioFrames {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const AudioFrames();

  /// size of [pBuffer] in bytes.
  int get sizeInBytes;

  /// size of [pBuffer] in frames.
  int get sizeInFrames;

  /// format of [pBuffer].
  AudioFormat get format;

  /// lock the internal buffer and returns [AudioBuffer].
  /// You are responsible for calling [unlock] when you don't need it.
  /// You can use the [acquireBuffer] method to safely acquiring [AudioBuffer] instead.
  AudioBuffer lock();

  /// [unlock] the internal buffer.
  void unlock();
}
