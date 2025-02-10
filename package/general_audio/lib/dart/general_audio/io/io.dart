import 'dart:ffi';

import 'package:general_audio/core/general_audio.dart';
import 'package:general_audio/dart/general_audio/base.dart';
import 'package:general_audio/dart/general_audio/core/general_audio_recorder/general_audio_recorder.dart';
import 'package:general_lib/general_lib.dart';
import 'package:io_universe/io_universe.dart';

class GeneralAudio extends GeneralAudioBase {
  GeneralAudio({
    super.sharedLibraryPath,
  });

  final Map<AudioDeviceBackend, bool> backends = <AudioDeviceBackend, bool>{};

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
