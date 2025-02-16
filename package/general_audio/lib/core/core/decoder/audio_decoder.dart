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

/// An abstract class for audio decoders.
abstract class AudioDecoder {
  /// Output format of the decoder.
  AudioFormat get outputFormat;

  /// The length of the audio in frames.
  int? get lengthInFrames;

  /// The current position of the decoder in frames.
  int get cursorInFrames;

  /// Sets the current position of the decoder in frames.
  set cursorInFrames(int value);

  /// Whether the decoder supports seeking.
  ///
  /// If false, [cursorInFrames] cannot be set.
  bool get canSeek;

  /// Decodes the audio into [destination].
  AudioDecodeResult decode({required AudioBuffer destination});
}

/// The result of [AudioDecoder.decode].
class AudioDecodeResult {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const AudioDecodeResult({
    required this.frameCount,
    required this.isEnd,
  });

  /// The number of frames decoded.
  final int frameCount;

  /// Whether the end of the audio stream has been reached.
  final bool isEnd;
}
