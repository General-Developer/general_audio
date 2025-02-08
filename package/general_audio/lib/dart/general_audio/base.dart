// ignore_for_file: public_member_api_docs

import 'package:general_audio/dart/general_audio/core/general_audio_recorder/general_audio_recorder.dart';

abstract class GeneralAudioBaseCore {
  Future<void> ensureInitialized();

  bool isCrash();

  bool isDeviceSupport();

  GeneralAudioRecorder createRecordOrGetRecord({
    required String outputRecordFilePath,
    String? uniqueId,
  });
}

abstract class GeneralAudioBase implements GeneralAudioBaseCore {
  String sharedLibraryPath = "";
  GeneralAudioBase({
    String? sharedLibraryPath,
  }) {
    this.sharedLibraryPath = sharedLibraryPath ?? defaultSharedLibraryPath();
  }

  final Map<String, GeneralAudioRecorder> recorderStates = {};

  static String defaultSharedLibraryPath() {
    return "libgeneral_audio.so";
  }

  GeneralAudioRecorder? getRecordByUniqueId({
    required String uniqueId,
  }) {
    return recorderStates[uniqueId];
  }
}
