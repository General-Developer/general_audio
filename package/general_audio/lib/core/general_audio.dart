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
library general_audio;

export 'core/audio_clock.dart';
export 'core/audio_resource.dart';
export 'core/audio_time.dart';
export 'core/buffer/allocated_audio_frames.dart';
export 'core/buffer/audio_buffer.dart';
export 'core/buffer/audio_buffer_extension.dart';
export 'core/buffer/audio_frames.dart';
export 'core/buffer/dynamic_audio_frames.dart';
export 'core/buffer/frame_ring_buffer.dart';
export 'core/buffer/ring_buffer.dart';
export 'core/data_source/abstract/audio_input_data_source.dart';
export 'core/data_source/abstract/audio_output_data_source.dart';
export 'core/data_source/audio_file_data_source.dart';
export 'core/data_source/audio_memory_data_source.dart';
export 'core/decoder/audio_decoder.dart';
export 'core/decoder/ma_audio_decoder.dart';
export 'core/decoder/wav/wav_audio_decoder.dart';
export 'core/device/audio_device.dart';
export 'core/device/audio_device_backend.dart';
export 'core/device/audio_device_id.dart';
export 'core/device/audio_device_info.dart';
export 'core/device/audio_device_notification.dart';
export 'core/device/audio_device_performance_profile.dart';
export 'core/device/audio_device_state.dart';
export 'core/device/audio_device_type.dart';
export 'core/encoder/audio_encoder.dart';
export 'core/encoder/wav/wav_audio_encoder.dart';
export 'core/format/audio_channel_mix_mode.dart';
export 'core/format/audio_dither_mode.dart';
export 'core/format/audio_format.dart';
export 'core/format/audio_format_converter.dart';
export 'core/format/audio_sample_rate_converter.dart';
export 'core/format/sample_format.dart';
export 'core/interop/ca_version.dart';
export 'core/interop/helper/general_audio_interop.dart';
export 'core/interop/helper/general_audio_native.dart';
export 'core/interop/ma_result.dart';
export 'core/interop/ma_version.dart';
export 'core/node/abstract/audio_node.dart';
export 'core/node/abstract/data_source_node.dart';
export 'core/node/bus/audio_bus.dart';
export 'core/node/bus/audio_bus_connection_exception.dart';
export 'core/node/bus/audio_endpoint_bus.dart';
export 'core/node/bus/audio_input_bus.dart' hide InternalAudioInputBusExtension;
export 'core/node/bus/audio_output_bus.dart';
export 'core/node/bus/audio_read_result.dart';
export 'core/node/capture_node.dart';
export 'core/node/decoder_node.dart';
export 'core/node/delay_node.dart';
export 'core/node/function_node.dart';
export 'core/node/mixer_node.dart';
export 'core/node/mixin/bypass_node_mixin.dart';
export 'core/node/mixin/processor_node_mixin.dart';
export 'core/node/mixin/single_in_out_node_mixin.dart';
export 'core/node/playback_node.dart';
export 'core/node/volume_node.dart';
export 'core/utils/memory.dart';
export 'core/utils/mutex.dart';
export 'core/utils/wave_function.dart';
