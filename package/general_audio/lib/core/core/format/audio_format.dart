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
import 'package:general_audio/core/core/format/sample_format.dart';

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class AudioFormat {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const AudioFormat({
    required this.sampleRate,
    required this.channels,
    this.sampleFormat = SampleFormat.float32,
  });

  /// The sample rate in hertz.
  final int sampleRate;

  /// The number of channels.
  final int channels;

  /// The sample format.
  final SampleFormat sampleFormat;

  /// The number of bytes per frame.
  int get bytesPerFrame {
    return sampleFormat.size * channels;
  }

  /// Verifies that the format is same as [other].
  bool isSameFormat(AudioFormat other) {
    return sampleRate == other.sampleRate &&
        channels == other.channels &&
        sampleFormat == other.sampleFormat;
  }

  /// Creates a copy of the format with the specified parameters.
  AudioFormat copyWith({
    int? sampleRate,
    int? channels,
    SampleFormat? sampleFormat,
  }) {
    return AudioFormat(
      sampleRate: sampleRate ?? this.sampleRate,
      channels: channels ?? this.channels,
      sampleFormat: sampleFormat ?? this.sampleFormat,
    );
  }

  @override
  String toString() {
    return 'AudioFormat(${sampleRate}hz, ${channels}ch, ${sampleFormat.name})';
  }
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class AudioFormatError extends Error {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  AudioFormatError.unsupportedSampleFormat(SampleFormat format)
      : message = '${format.name} is not supported.';

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final String message;

  @override
  String toString() {
    return 'AudioFormatError: $message';
  }
}
