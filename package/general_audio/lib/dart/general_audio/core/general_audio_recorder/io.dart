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
// ignore_for_file: empty_catches

import 'package:general_audio/core/experimental.dart';
import 'package:general_audio/core/general_audio.dart';
import 'package:general_audio/dart/general_audio/core/general_audio_recorder/base.dart';
import 'package:io_universe/io_universe.dart';
import "dart:math" as math;

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class GeneralAudioRecorder extends GeneralAudioRecorderBase {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
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
