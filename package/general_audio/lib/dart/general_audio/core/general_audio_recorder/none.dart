import 'package:general_audio/dart/general_audio/core/general_audio_recorder/base.dart';

class GeneralAudioRecorder extends GeneralAudioRecorderBase {
  GeneralAudioRecorder({
    required super.generalAudioRecorderMessage,
    required super.uniqueId,
    required super.onStop,
  });

  @override
  // TODO: implement isRecord
  bool get isRecord => false;

  @override
  Future<void> start() async {
    return;
  }

  @override
  Future<void> stop() async {
    return;
  }
}
