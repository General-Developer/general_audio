// ignore_for_file: empty_catches

import 'package:general_audio/core/experimental.dart';
import 'package:general_audio/core/general_audio.dart';
import 'package:general_audio/dart/general_audio/core/general_audio_recorder/base.dart';
import 'package:io_universe/io_universe.dart';
import "dart:math" as math;

class GeneralAudioRecorder extends GeneralAudioRecorderBase {
  GeneralAudioRecorder({
    required super.generalAudioRecorderMessage,
    required super.uniqueId,
    required super.onStop,
  });
  final _isolate = AudioIsolate<GeneralAudioRecorderMessage>(_worker);

  @override
  bool get isRecord {
    return _isolate.isLaunched;
  }

  @override
  Future<void> start() async {
    await _isolate.launch(
      initialMessage: generalAudioRecorderMessage,
    );
  }

  @override
  Future<void> stop() async {
    await _isolate.shutdown();
  }

  // The worker function that runs in the isolate.
  static Future<void> _worker(
      dynamic initialMessage, AudioIsolateWorkerMessenger messenger) async {
    if (initialMessage is GeneralAudioRecorderMessage == false) {
      messenger.close();
    }

    final message = initialMessage as GeneralAudioRecorderMessage;
    final File saveToFile = File(message.saveToFilePath);

    if (saveToFile.parent.existsSync() == false) {
      saveToFile.parent.createSync(recursive: true);
    }
    AudioResourceManager.isDisposeLogEnabled = true;

    // Prepare the audio format and buffer, audio device and encoder.
    final format = AudioFormat(
      sampleRate: math.max(message.sampleRate ?? 48000, 16000),
      channels: math.max(message.channels ?? 2, 1),
      sampleFormat: SampleFormat.int16,
    );

    final context = AudioDeviceContext(backends: [message.audioDeviceBackend]);
    final device = context.createCaptureDevice(
      format: format,
      bufferFrameSize: const AudioTime(0.4).computeFrames(format),
      deviceId: message.audioDeviceId,
    );

    final dataSource = AudioFileDataSource(
      file: saveToFile,
      mode: FileMode.write,
    );
    final encoder =
        WavAudioEncoder(dataSource: dataSource, inputFormat: format);
    final clock = AudioIntervalClock(const AudioTime(0.2));
    final bufferFrames =
        AllocatedAudioFrames(length: device.bufferFrameSize, format: format);

    // Start the audio device, clock and encoder.
    encoder.start();
    device.start();

    clock.start(
      onTick: (_) {
        // Read the audio data from the device and encode it.
        bufferFrames.acquireBuffer((buffer) {
          final result = device.read(buffer);
          encoder.encode(buffer.limit(result.framesRead));
        });
      },
    );

    await messenger.listenShutdown(
      onShutdown: (reason, e, stackTrace) async {
        device.stop();
        clock.stop();

        // Finalize the encoder and close the data source.
        // If you don't finalize the encoder, the wav file will be corrupted.
        encoder.finalize();
      },
    );
  }
}
