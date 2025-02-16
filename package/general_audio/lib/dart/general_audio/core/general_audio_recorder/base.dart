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

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class GeneralAudioRecorderMessage {
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  dynamic audioDeviceBackend;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  dynamic audioDeviceId;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  String saveToFilePath;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  int? sampleRate;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  int? channels;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  GeneralAudioRecorderMessage({
    required this.audioDeviceBackend,
    required this.audioDeviceId,
    required this.saveToFilePath,
    this.sampleRate,
    this.channels,
  });
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
abstract class GeneralAudioRecorderBaseCore {
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  bool get isRecord;

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  Future<void> start();
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  Future<void> stop();
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
abstract class GeneralAudioRecorderBase
    implements GeneralAudioRecorderBaseCore {
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final String uniqueId;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  GeneralAudioRecorderMessage generalAudioRecorderMessage;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  void Function() onStop;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  GeneralAudioRecorderBase({
    required this.generalAudioRecorderMessage,
    required this.uniqueId,
    required this.onStop,
  });
}
