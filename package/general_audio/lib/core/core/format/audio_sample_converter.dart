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
import 'dart:typed_data';

/// A converter to convert audio samples from one format to another.
abstract class AudioSampleConverter {
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const AudioSampleConverter({
    required this.inputBytes,
    required this.outputBytes,
  });

  /// The number of bytes per input sample.
  final int inputBytes;

  /// The number of bytes per output sample.
  final int outputBytes;

  /// Converts a single sample from [inputBuffer] and writes the result to [outputBuffer].
  void convertSample(Uint8List inputBuffer, Uint8List outputBuffer,
      [int inputOffset = 0, int outputOffset = 0]);

  /// Converts all samples from [inputBuffer] and writes the result to [outputBuffer].
  void convertSamples(Uint8List inputBuffer, Uint8List outputBuffer,
      [int inputOffset = 0, int outputOffset = 0]) {
    final sampleCount = inputBuffer.length ~/ inputBytes;
    for (var i = 0; sampleCount > i; i++) {
      convertSample(inputBuffer, outputBuffer, inputOffset, outputOffset);
      outputOffset += outputBytes;
      inputOffset += inputBytes;
    }
  }
}

/// Convert 24-bit samples to 32-bit samples.
///
/// The result will be multiplied by 256.
class AudioSampleConverterInt24ToInt32 extends AudioSampleConverter {
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const AudioSampleConverterInt24ToInt32()
      : super(inputBytes: 3, outputBytes: 4);

  @override
  void convertSample(Uint8List inputBuffer, Uint8List outputBuffer,
      [int inputOffset = 0, int outputOffset = 0]) {
    outputBuffer[outputOffset + 0] = 0;
    outputBuffer[outputOffset + 1] = inputBuffer[inputOffset + 0];
    outputBuffer[outputOffset + 2] = inputBuffer[inputOffset + 1];
    outputBuffer[outputOffset + 3] = inputBuffer[inputOffset + 2];
  }
}
