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
import 'dart:ffi';
import 'dart:isolate';

import 'package:general_audio/core/core/interop/helper/general_audio_interop.dart';
import 'package:general_audio/core/core/interop/internal/generated/bindings.dart';
import 'package:general_audio/core/core/interop/internal/ma_extension.dart';
import 'package:ffi/ffi.dart';

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
enum MaLogLevel {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  debug(ma_log_level.MA_LOG_LEVEL_DEBUG),

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  info(ma_log_level.MA_LOG_LEVEL_INFO),

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  warning(ma_log_level.MA_LOG_LEVEL_WARNING),

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  error(ma_log_level.MA_LOG_LEVEL_ERROR),
  ;

  const MaLogLevel(this.maValue);

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final int maValue;
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class MaLogData {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const MaLogData({
    required this.level,
    required this.message,
  });

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final MaLogLevel level;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final String message;
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class CaLog {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  CaLog() {
    _interop.bindings.ca_log_init(_pLog).throwMaResultIfNeeded();
    _interop.bindings
        .ca_log_set_notification(_pLog, _receivePort.sendPort.nativePort);

    _interop.onInitialized();

    _receivePort.cast<int>().listen((messageCount) {
      final logs = _getLogs(count: messageCount);
      for (final log in logs) {
        onLog?.call(log.level, log.message);
      }
    });
  }

  final _interop = CoastAudioInterop();

  late final _pLog = _interop.allocateManaged<ca_log>(sizeOf<ca_log>());

  final _receivePort = ReceivePort();

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  Pointer<ma_log> get ref => _interop.bindings.ca_log_get_ref(_pLog);

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  void Function(MaLogLevel level, String message)? onLog;

  List<MaLogData> _getLogs({int count = 256}) {
    return _interop.allocateTemporary<UnsignedInt, List<MaLogData>>(
      sizeOf<UnsignedInt>(),
      (pCount) {
        return _interop.allocateTemporary<IntPtr, List<MaLogData>>(
          sizeOf<IntPtr>(),
          (ppMessages) {
            pCount.value = count;
            _interop.bindings
                .ca_log_get_messages(_pLog, ppMessages.cast(), pCount);

            final pMessages = Pointer.fromAddress(ppMessages.value);
            final logs = List.generate(
              pCount.value,
              (index) {
                final pMessage = Pointer<ca_log_message>.fromAddress(
                    pMessages.address + index * sizeOf<ca_log_message>());
                return MaLogData(
                  level: MaLogLevel.values
                      .firstWhere((l) => l.maValue == pMessage.ref.level),
                  message: pMessage.ref.pMessage.cast<Utf8>().toDartString(),
                );
              },
            );

            _interop.bindings.ca_log_release_messages(_pLog, pCount.value);

            return logs;
          },
        );
      },
    );
  }

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  void dispose() {
    _interop.bindings.ca_log_uninit(_pLog);
    _interop.dispose();
    _receivePort.close();
  }
}
