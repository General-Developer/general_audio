import 'package:general_audio/general_audio.dart';
import 'package:io_universe/io_universe.dart';

void main(List<String> args) async {
  print("Start");
  GeneralAudio generalAudio = GeneralAudio(
    sharedLibraryPath: "/home/galaxeus/Documents/galaxeus/app/general_audio/package/general_audio/example/build/linux/x64/debug/bundle/lib/libgeneral_audio.so",
  );
  await generalAudio.ensureInitialized();
  final GeneralAudioRecorder generalAudioRecorder = generalAudio.createRecordOrGetRecord(
    outputRecordFilePath: "new_record.wav",
  );
  await generalAudioRecorder.start();
  print(generalAudioRecorder.isRecord);

  stdin.listen((e) async {
    if (generalAudioRecorder.isRecord) {
      await generalAudioRecorder.stop();
    }
    print(generalAudioRecorder.isRecord);
    exit(0);
  });
}
