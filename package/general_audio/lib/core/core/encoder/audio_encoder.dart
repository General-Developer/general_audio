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
import 'package:meta/meta.dart';

/// The result of [AudioEncoder.encode].
///
/// [frameCount] is the number of frames encoded.
class AudioEncodeResult {
  const AudioEncodeResult({
    required this.frameCount,
  });
  final int frameCount;
}

/// An abstract class for audio encoders.
abstract class AudioEncoder {
  /// Input format of the encoder.
  ///
  /// Call the [encode] method with an [AudioBuffer] in this format.
  AudioFormat get inputFormat;

  /// Whether the encoder is started or not.
  bool get isStarted;

  /// Starts encoding.
  ///
  /// Call this method before calling [encode].
  void start();

  /// Encodes the audio from [buffer].
  AudioEncodeResult encode(AudioBuffer buffer);

  /// Finishes encoding.
  void finalize();

  /// Throws a [StateError] if the encoder is not started.
  @protected
  void throwIfNotStarted() {
    if (!isStarted) {
      throw StateError('The encoder is not started.');
    }
  }
}
