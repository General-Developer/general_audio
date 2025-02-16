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
import 'package:general_audio/core/core/interop/ma_data_converter.dart';

/// The configuration of an audio format converter.
class AudioFormatConverterConfig {
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const AudioFormatConverterConfig({
    this.ditherMode = AudioDitherMode.none,
    this.channelMixMode = AudioChannelMixMode.rectangular,
    this.resampling = const LinearAudioSampleRateConverterConfig(),
  });

  /// The dither mode used by the converter to dither the audio.
  final AudioDitherMode ditherMode;

  /// The channel mix mode used by the converter to mix the channels.
  final AudioChannelMixMode channelMixMode;

  /// The resampler configuration used by the converter to resample the audio.
  final AudioSampleRateConverterConfig resampling;
}

/// The result of an audio format conversion.
class AudioFormatConverterResult {
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const AudioFormatConverterResult({
    required this.inputFrameCount,
    required this.outputFrameCount,
  });

  /// The number of frames consumed from the input buffer.
  final int inputFrameCount;

  /// The number of frames written to the output buffer.
  final int outputFrameCount;
}

/// Converts audio data from one format to another.
class AudioFormatConverter with AudioResourceMixin {
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  AudioFormatConverter({
    required this.inputFormat,
    required this.outputFormat,
    this.config = const AudioFormatConverterConfig(),
  }) {
    final captured = _native;
    setResourceFinalizer(() {
      captured.dispose();
    });
  }

  late final _native = MaDataConverter(
    inputFormat: inputFormat,
    outputFormat: outputFormat,
    config: config,
  );

  /// The input format of the audio.
  final AudioFormat inputFormat;

  /// The output format of the audio.
  final AudioFormat outputFormat;

  /// The configuration of the converter.
  final AudioFormatConverterConfig config;

  /// The input latency introduced by the converter.
  int get inputLatencyFrameCount => _native.inputLatencyFrameCount;

  /// The output latency introduced by the converter.
  int get outputLatencyFrameCount => _native.outputLatencyFrameCount;

  /// Resets the converter's internal state.
  ///
  /// This method should be called when the input audio data is discontinuous.
  void reset() => _native.reset();

  /// Gets the number of input frames required to produce [outputFrameCount] frames.
  int getRequiredInputFrameCount({required int outputFrameCount}) =>
      _native.getRequiredInputFrameCount(outputFrameCount: outputFrameCount);

  /// Gets the number of output frames expected to be produced from [inputFrameCount] frames.
  int getExpectedOutputFrameCount({required int inputFrameCount}) =>
      _native.getExpectedOutputFrameCount(inputFrameCount: inputFrameCount);

  /// Converts audio data format from [inputFormat] to [outputFormat] and writes the result to [output].
  AudioFormatConverterResult convert(
          {required AudioBuffer input, required AudioBuffer output}) =>
      _native.process(input, output);
}
