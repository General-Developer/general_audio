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
