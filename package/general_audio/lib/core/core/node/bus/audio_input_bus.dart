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
import 'package:general_audio/core/general_audio.dart';

/// A callback that resolves the format of the [AudioInputBus].
typedef InputFormatResolver = AudioFormat? Function(AudioInputBus bus);

/// When a [AudioOutputBus] is trying to connect to [AudioInputBus], this callback will be called.
///
/// You can throw an exception to prevent the connection.
typedef AttemptConnectBusCallback = void Function(AudioOutputBus bus);

/// [AudioInputBus] represents a audio node's input format and connection.
class AudioInputBus extends AudioBus {
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  AudioInputBus({
    required super.node,
    required InputFormatResolver formatResolver,
    AttemptConnectBusCallback? attemptConnectBus,
  })  : _formatResolver = formatResolver,
        _attemptConnectBus = attemptConnectBus;

  /// Create a [AudioInputBus] with auto format resolution.
  factory AudioInputBus.autoFormat({
    required AudioNode node,
    AttemptConnectBusCallback? attemptConnectBus,
  }) {
    return AudioInputBus(
      node: node,
      formatResolver: (bus) => bus.connectedBus?.resolveFormat(),
      attemptConnectBus: attemptConnectBus,
    );
  }

  final InputFormatResolver _formatResolver;

  final AttemptConnectBusCallback? _attemptConnectBus;

  @override
  AudioFormat? resolveFormat() => _formatResolver(this);

  AudioOutputBus? _connectedBus;

  /// The connected [AudioOutputBus] of this bus.
  ///
  /// [connectedBus]'s format must be the same as this bus's format.
  AudioOutputBus? get connectedBus => _connectedBus;
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
extension InternalAudioInputBusExtension on AudioInputBus {
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  void tryConnect(AudioOutputBus bus) {
    _attemptConnectBus?.call(bus);
    _connectedBus = bus;
  }

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  void onDisconnect() {
    _connectedBus = null;
  }
}
