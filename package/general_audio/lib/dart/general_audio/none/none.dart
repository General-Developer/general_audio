import 'package:general_audio/dart/general_audio/base.dart';
import 'package:general_audio/dart/general_audio/core/general_audio_recorder/general_audio_recorder.dart';
import 'package:general_lib/general_lib.dart';

class GeneralAudio extends GeneralAudioBase {
  GeneralAudio({
    super.sharedLibraryPath,
  });

  @override
  Future<void> ensureInitialized() async {
    return;
  }

  @override
  bool isCrash() {
    return false;
  }

  @override
  bool isDeviceSupport() {
    return true;
  }

  @override

  /// Auomatic Create OR Get Record Or Update
  /// Automatic create if not found unique id
  /// automatic get record if found unique
  /// and automatic update if found get unique id and update output
  GeneralAudioRecorder createRecordOrGetRecord({
    required String outputRecordFilePath,
    String? uniqueId,
    int? sampleRate,
    int? channels,
  }) {
    final String audioUniqueId = uniqueId ?? generateUuid(10);
    final GeneralAudioRecorder? generalAudioRecorder =
        recorderStates[audioUniqueId];
    final GeneralAudioRecorderMessage generalAudioRecorderMessage =
        GeneralAudioRecorderMessage(
      audioDeviceBackend: null,
      audioDeviceId: null,
      saveToFilePath: outputRecordFilePath,
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
