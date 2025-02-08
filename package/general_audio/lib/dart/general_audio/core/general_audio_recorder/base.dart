// ignore_for_file: empty_catches

class GeneralAudioRecorderMessage {
  dynamic audioDeviceBackend;
  dynamic audioDeviceId;
  String saveToFilePath;
  GeneralAudioRecorderMessage({
    required this.audioDeviceBackend,
    required this.audioDeviceId,
    required this.saveToFilePath,
  });
}

abstract class GeneralAudioRecorderBaseCore {
  bool get isRecord;

  Future<void> start();
  Future<void> stop();
}

abstract class GeneralAudioRecorderBase implements GeneralAudioRecorderBaseCore {
  final String uniqueId;
  GeneralAudioRecorderMessage generalAudioRecorderMessage;
  void Function() onStop;
  GeneralAudioRecorderBase({
    required this.generalAudioRecorderMessage,
    required this.uniqueId,
    required this.onStop,
  });
}
