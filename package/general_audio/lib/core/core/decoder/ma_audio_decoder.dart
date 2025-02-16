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
import 'package:general_audio/core/core/interop/ma_decoder.dart';

/// An audio decoder using the miniaudio library.
///
/// This decoder can read audio from various formats, such as WAV, MP3, and FLAC.
/// Also, it can convert the audio to a different format if necessary.
class MaAudioDecoder extends AudioDecoder with AudioResourceMixin {
  /// Creates a new decoder.
  ///
  /// [dataSource] is the source of the audio data.
  ///
  /// [expectedSampleFormat], [expectedChannels] and [expectedSampleRate] are the expected output format of the audio. If null, the decoder will use the format of the source audio.
  /// Please note that the 24-bit sample format is not supported by general_audio.
  MaAudioDecoder({
    required AudioInputDataSource dataSource,
    SampleFormat? expectedSampleFormat,
    int? expectedChannels,
    int? expectedSampleRate,
    this.cacheCursorAndLength = true,
    this.channelMixMode = AudioChannelMixMode.simple,
    this.ditherMode = AudioDitherMode.none,
  })  : _dataSource = dataSource,
        _native = MaDecoder(
          dataSource: dataSource,
          sampleFormat: expectedSampleFormat,
          channels: expectedChannels,
          sampleRate: expectedSampleRate,
          channelMixMode: channelMixMode,
          ditherMode: ditherMode,
        ) {
    final captured = _native;
    setResourceFinalizer(() {
      captured.dispose();
    });

    if (cacheCursorAndLength) {
      _cachedLengthInFrames = _native.lengthInFrames;
      _cachedCursorInFrames = _native.cursorInFrames;
    }
  }

  final AudioInputDataSource _dataSource;
  final MaDecoder _native;

  int? _cachedLengthInFrames;
  int? _cachedCursorInFrames;

  var _isCursorDirty = false;

  /// Whether to cache the cursor and length of the audio. If false, [cursorInFrames] and [lengthInFrames] will be calculated on each access.
  final bool cacheCursorAndLength;

  /// The channel mix mode used by the decoder to mix the channels.
  final AudioChannelMixMode channelMixMode;

  /// The dither mode used by the decoder to dither the audio.
  final AudioDitherMode ditherMode;

  @override
  int get cursorInFrames => _cachedCursorInFrames ?? _native.cursorInFrames;

  @override
  set cursorInFrames(int value) {
    if (_cachedCursorInFrames != null) {
      _cachedCursorInFrames = value;
      _isCursorDirty = true;
      return;
    }

    _native.cursorInFrames = value;
  }

  @override
  int? get lengthInFrames => _cachedLengthInFrames ?? _native.lengthInFrames;

  @override
  bool get canSeek => _dataSource.canSeek;

  /// The original format of the audio.
  late final AudioFormat originalFormat = _native.originalFormat;

  @override
  late final AudioFormat outputFormat = _native.outputFormat;

  @override
  AudioDecodeResult decode({required AudioBuffer destination}) {
    if (_isCursorDirty) {
      _native.cursorInFrames = _cachedCursorInFrames!;
      _isCursorDirty = false;
    }

    // If the destination is empty, ma_decoder will return MA_INVALID_ARGS so we need to handle it manually.
    if (destination.sizeInFrames == 0) {
      return AudioDecodeResult(
          frameCount: 0, isEnd: _native.availableFrames == 0);
    }

    final result = _native.decode(destination);
    if (_cachedCursorInFrames != null) {
      _cachedCursorInFrames = _cachedCursorInFrames! + result.frameCount;
    }
    return result;
  }
}
