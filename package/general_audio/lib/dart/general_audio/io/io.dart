// ignore_for_file: empty_catches

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
import 'package:general_audio/dart/general_audio/base.dart';
import 'package:general_audio/dart/general_audio/core/general_audio_recorder/general_audio_recorder.dart';
import 'package:general_lib/general_lib.dart';
import 'package:io_universe/io_universe.dart';

///
class GeneralAudio extends GeneralAudioBase {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  GeneralAudio({
    super.sharedLibraryPath,
  });

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final Map<AudioDeviceBackend, bool> backends = <AudioDeviceBackend, bool>{};

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  late final AudioDeviceContext audioDeviceContext;
  bool _isEnsureInitialized = false;
  bool _isDeviceSupport = false;
  bool _isCrash = false;
  @override
  Future<void> ensureInitialized() async {
    if (_isEnsureInitialized) {
      return;
    }
    _isEnsureInitialized = true;
    try {
      try {
        CoastAudioNative.initialize(
          library: DynamicLibrary.open(
            sharedLibraryPath,
          ),
        );
        _isCrash = true;
      } catch (e) {
        rethrow;
      }
      _isCrash = false;

      for (final backend in AudioDeviceBackend.values) {
        backends[backend] = switch (backend) {
          AudioDeviceBackend.coreAudio => Platform.isMacOS || Platform.isIOS,
          AudioDeviceBackend.aaudio => Platform.isAndroid,
          AudioDeviceBackend.openSLES => Platform.isAndroid,
          AudioDeviceBackend.wasapi => Platform.isWindows,
          AudioDeviceBackend.alsa => Platform.isLinux,
          AudioDeviceBackend.pulseAudio => Platform.isLinux,
          AudioDeviceBackend.jack => Platform.isLinux,
          AudioDeviceBackend.dummy => true,
        };
      }
      audioDeviceContext = AudioDeviceContext(
        backends:
            backends.entries.where((e) => e.value).map((e) => e.key).toList(),
      );
    } catch (e) {}
    _isDeviceSupport = true;
  }

  @override
  bool isCrash() {
    return _isCrash;
  }

  @override
  bool isDeviceSupport() {
    if (Dart.isWeb) {
      return false;
    }
    if (_isEnsureInitialized) {
      return _isDeviceSupport;
    }
    return false;
  }

  @override
  GeneralAudioRecorder createRecordOrGetRecord({
    required String outputRecordFilePath,
    int? sampleRate,
    String? uniqueId,
    int? channels,
  }) {
    final String audioUniqueId = uniqueId ?? generateUuid(10);
    final GeneralAudioRecorder? generalAudioRecorder =
        recorderStates[audioUniqueId];
    final GeneralAudioRecorderMessage generalAudioRecorderMessage =
        GeneralAudioRecorderMessage(
      audioDeviceBackend: audioDeviceContext.activeBackend,
      audioDeviceId: audioDeviceContext
          .getDevices(AudioDeviceType.capture)
          .where((d) => d.isDefault)
          .firstOrNull
          ?.id,
      saveToFilePath: outputRecordFilePath,
      sampleRate: sampleRate,
    );
    if (generalAudioRecorder is GeneralAudioRecorder) {
      generalAudioRecorder.generalAudioRecorderMessage =
          generalAudioRecorderMessage;
      generalAudioRecorder.onStop = () {
        recorderStates.remove(audioUniqueId);
      };
      return generalAudioRecorder;
    }
    final GeneralAudioRecorder generalAudioRecorderNew = GeneralAudioRecorder(
      generalAudioRecorderMessage: generalAudioRecorderMessage,
      uniqueId: audioUniqueId,
      onStop: () {
        recorderStates.remove(audioUniqueId);
      },
    );
    recorderStates[audioUniqueId] = generalAudioRecorderNew;
    return generalAudioRecorderNew;
  }
}
