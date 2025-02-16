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
import 'dart:isolate';

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
sealed class AudioIsolateWorkerMessage {
  const AudioIsolateWorkerMessage();
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
sealed class AudioIsolateWorkerResponse extends AudioIsolateWorkerMessage {
  static var _id = 0;

  static int _getId() {
    return _id++;
  }

  AudioIsolateWorkerResponse(this.requestId) : id = _getId();

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final int id;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final int requestId;
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class AudioIsolateWorkerSuccessResponse extends AudioIsolateWorkerResponse {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  AudioIsolateWorkerSuccessResponse(super.requestId, this.payload);

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final dynamic payload;
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class AudioIsolateWorkerFailedResponse extends AudioIsolateWorkerResponse {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  AudioIsolateWorkerFailedResponse(
      super.requestId, this.exception, this.stackTrace);

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final Object exception;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final StackTrace stackTrace;
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
final class AudioIsolateLaunchedResponse extends AudioIsolateWorkerMessage {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const AudioIsolateLaunchedResponse({required this.sendPort});

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final SendPort sendPort;
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
final class AudioIsolateShutdownResponse extends AudioIsolateWorkerMessage {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const AudioIsolateShutdownResponse({
    required this.reason,
    this.exception,
    this.stackTrace,
  });

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final AudioIsolateShutdownReason reason;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final Object? exception;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final StackTrace? stackTrace;
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
enum AudioIsolateShutdownReason {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  workerFinished,

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  hostRequested,

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  exception,
}
