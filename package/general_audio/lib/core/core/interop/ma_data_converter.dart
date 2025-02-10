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
import 'package:general_audio/core/core/interop/internal/generated/bindings.dart';
import 'package:general_audio/core/core/interop/internal/ma_extension.dart';
import 'package:general_audio/core/core/interop/ma_resampler_config.dart';

class MaDataConverter {
  MaDataConverter({
    required this.inputFormat,
    required this.outputFormat,
    required AudioFormatConverterConfig config,
  }) {
    final nativeConfig = _interop.bindings.ma_data_converter_config_init(
      inputFormat.sampleFormat.maFormat,
      outputFormat.sampleFormat.maFormat,
      inputFormat.channels,
      outputFormat.channels,
      inputFormat.sampleRate,
      outputFormat.sampleRate,
    );
    nativeConfig.ditherMode = config.ditherMode.maValue;
    nativeConfig.channelMixMode = config.channelMixMode.maValue;
    nativeConfig.resampling = config.resampling.maConfig;
    _pConfig.ref = nativeConfig;

    _interop.bindings
        .ma_data_converter_init(_pConfig, nullptr, _pConverter)
        .throwMaResultIfNeeded();

    _interop.onInitialized();
  }

  final _interop = CoastAudioInterop();

  late final _pConfig = _interop.allocateManaged<ma_data_converter_config>(
      sizeOf<ma_data_converter_config>());
  late final _pConverter =
      _interop.allocateManaged<ma_data_converter>(sizeOf<ma_data_converter>());
  late final _pFramesIn =
      _interop.allocateManaged<UnsignedLongLong>(sizeOf<UnsignedLongLong>());
  late final _pFramesOut =
      _interop.allocateManaged<UnsignedLongLong>(sizeOf<UnsignedLongLong>());

  final AudioFormat inputFormat;
  final AudioFormat outputFormat;

  int get inputLatencyFrameCount =>
      _interop.bindings.ma_data_converter_get_input_latency(_pConverter);

  int get outputLatencyFrameCount =>
      _interop.bindings.ma_data_converter_get_output_latency(_pConverter);

  int getRequiredInputFrameCount({required int outputFrameCount}) {
    _pFramesIn.value = 0;
    _interop.bindings
        .ma_data_converter_get_required_input_frame_count(
            _pConverter, outputFrameCount, _pFramesIn)
        .throwMaResultIfNeeded();
    return _pFramesIn.value;
  }

  int getExpectedOutputFrameCount({required int inputFrameCount}) {
    _pFramesOut.value = 0;
    _interop.bindings
        .ma_data_converter_get_expected_output_frame_count(
            _pConverter, inputFrameCount, _pFramesOut)
        .throwMaResultIfNeeded();
    return _pFramesOut.value;
  }

  void reset() {
    _interop.bindings
        .ma_data_converter_reset(_pConverter)
        .throwMaResultIfNeeded();
  }

  AudioFormatConverterResult process(
      AudioBuffer bufferIn, AudioBuffer bufferOut) {
    _pFramesIn.value = bufferIn.sizeInFrames;
    _pFramesOut.value = bufferOut.sizeInFrames;

    _interop.bindings
        .ma_data_converter_process_pcm_frames(
            _pConverter,
            bufferIn.pBuffer.cast(),
            _pFramesIn,
            bufferOut.pBuffer.cast(),
            _pFramesOut)
        .throwMaResultIfNeeded();

    return AudioFormatConverterResult(
      inputFrameCount: _pFramesIn.value,
      outputFrameCount: _pFramesOut.value,
    );
  }

  void dispose() {
    _interop.bindings.ma_data_converter_uninit(_pConverter, nullptr);
    _interop.dispose();
  }
}
