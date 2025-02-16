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

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class MaDecoder {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  MaDecoder({
    required this.dataSource,
    SampleFormat? sampleFormat,
    int? channels,
    int? sampleRate,
    AudioChannelMixMode channelMixMode = AudioChannelMixMode.simple,
    AudioDitherMode ditherMode = AudioDitherMode.none,
  }) {
    _pConfig.ref = _interop.bindings.ma_decoder_config_init(
      sampleFormat?.maFormat ?? ma_format.ma_format_unknown,
      channels ?? 0,
      sampleRate ?? 0,
    );
    _pConfig.ref.channelMixMode = channelMixMode.maValue;
    _pConfig.ref.ditherMode = ditherMode.maValue;

    final pUserData = _MaDecoderCallback.register(this);
    _interop.bindings
        .ma_decoder_init(_MaDecoderCallback.onRead, _MaDecoderCallback.onSeek,
            pUserData, _pConfig, _pDecoder)
        .throwMaResultIfNeeded();

    originalFormat = AudioFormat(
      sampleFormat: _pDecoder.ref.converter.formatIn.asSampleFormat(),
      channels: _pDecoder.ref.converter.channelsIn,
      sampleRate: _pDecoder.ref.converter.sampleRateIn,
    );

    outputFormat = AudioFormat(
      sampleFormat: _pDecoder.ref.outputFormat.asSampleFormat(),
      channels: _pDecoder.ref.outputChannels,
      sampleRate: _pDecoder.ref.outputSampleRate,
    );

    _interop.onInitialized();
  }

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final AudioInputDataSource dataSource;

  final _interop = CoastAudioInterop();

  late final _pConfig =
      _interop.allocateManaged<ma_decoder_config>(sizeOf<ma_decoder_config>());
  late final _pDecoder =
      _interop.allocateManaged<ma_decoder>(sizeOf<ma_decoder>());
  late final _pFrames =
      _interop.allocateManaged<UnsignedLongLong>(sizeOf<UnsignedLongLong>());

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  int get cursorInFrames {
    _interop.bindings
        .ma_decoder_get_cursor_in_pcm_frames(_pDecoder, _pFrames)
        .throwMaResultIfNeeded();
    return _pFrames.value;
  }

  set cursorInFrames(int value) {
    _interop.bindings
        .ma_decoder_seek_to_pcm_frame(_pDecoder, value)
        .throwMaResultIfNeeded();
  }

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  int get lengthInFrames {
    _interop.bindings
        .ma_decoder_get_length_in_pcm_frames(_pDecoder, _pFrames)
        .throwMaResultIfNeeded();
    return _pFrames.value;
  }

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  int get availableFrames {
    _interop.bindings
        .ma_decoder_get_available_frames(_pDecoder, _pFrames)
        .throwMaResultIfNeeded();
    return _pFrames.value;
  }

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  late final AudioFormat originalFormat;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  late final AudioFormat outputFormat;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  AudioDecodeResult decode(AudioBuffer destination) {
    final result = _interop.bindings
        .ma_decoder_read_pcm_frames(_pDecoder, destination.pBuffer.cast(),
            destination.sizeInFrames, _pFrames)
        .asMaResult();
    if (result != MaResult.success && result != MaResult.atEnd) {
      throw MaException(result);
    }

    return AudioDecodeResult(
      frameCount: _pFrames.value,
      isEnd: result == MaResult.atEnd || availableFrames == 0,
    );
  }

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  void dispose() {
    _MaDecoderCallback.unregister(_pDecoder.ref.pUserData);
    _interop.bindings.ma_decoder_uninit(_pDecoder).throwMaResultIfNeeded();
    _interop.dispose();
  }

  MaResult _onRead(
      Pointer<Void> pBufferOut, int bytesToRead, Pointer<Size> pBytesRead) {
    pBytesRead.value =
        dataSource.readBytes(pBufferOut.cast<Uint8>().asTypedList(bytesToRead));
    return MaResult.success;
  }

  MaResult _onSeek(int byteOffset, int origin) {
    return origin.whenSeekOrigin(
      current: () {
        dataSource.position += byteOffset;
        return MaResult.success;
      },
      start: () {
        dataSource.position = byteOffset;
        return MaResult.success;
      },
      end: () {
        final length = dataSource.length;
        if (length == null) {
          return MaResult.error;
        }

        dataSource.position = dataSource.length! + byteOffset;
        return MaResult.success;
      },
    );
  }
}

class _MaDecoderCallback {
  static final onRead = Pointer.fromFunction<ma_decoder_read_procFunction>(
      _onRead, ma_result.MA_ERROR);
  static final onSeek = Pointer.fromFunction<ma_decoder_seek_procFunction>(
      _onSeek, ma_result.MA_ERROR);

  static final _instances = <Pointer<Void>, MaDecoder>{};

  static Pointer<Void> register(MaDecoder instance) {
    final pUserData = instance._interop.memory.allocator.allocate<Void>(1);
    _instances[pUserData] = instance;
    return pUserData;
  }

  static void unregister(Pointer<Void> pUserData) {
    final instance = _instances.remove(pUserData);
    instance!._interop.memory.allocator.free(pUserData);
  }

  static int _onRead(Pointer<ma_decoder> pDecoder, Pointer<Void> pBufferOut,
      int bytesToRead, Pointer<Size> pBytesRead) {
    final instance = _instances[pDecoder.ref.pUserData];
    if (instance == null) {
      return MaResult.unavailable.code;
    }
    return instance._onRead(pBufferOut, bytesToRead, pBytesRead).code;
  }

  static int _onSeek(Pointer<ma_decoder> pDecoder, int byteOffset, int origin) {
    final instance = _instances[pDecoder.ref.pUserData];
    if (instance == null) {
      return MaResult.unavailable.code;
    }
    return instance._onSeek(byteOffset, origin).code;
  }
}
