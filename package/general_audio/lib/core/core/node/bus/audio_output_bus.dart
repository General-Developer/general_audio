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
import 'package:general_audio/core/core/node/bus/audio_input_bus.dart';

/// A resolver that resolves the output format of a [AudioOutputBus].
typedef OutputFormatResolver = AudioFormat? Function(AudioOutputBus bus);

/// [AudioOutputBus] represents a audio node's output format and connection.
class AudioOutputBus extends AudioBus {
  AudioOutputBus({
    required super.node,
    required OutputFormatResolver formatResolver,
  }) : _formatResolver = formatResolver;

  /// Create a [AudioOutputBus] with auto format resolution.
  ///
  /// The format of the bus will be resolved based on the [inputBus]'s format.
  factory AudioOutputBus.autoFormat(
      {required AudioNode node, required AudioInputBus inputBus}) {
    return AudioOutputBus(
      node: node,
      formatResolver: (bus) => inputBus.resolveFormat(),
    );
  }

  final OutputFormatResolver _formatResolver;

  @override
  AudioFormat? resolveFormat() => _formatResolver(this);

  AudioInputBus? _connectedBus;

  /// The connected [AudioInputBus] of this bus.
  ///
  /// [connectedBus]'s format must be the same as this bus's format.
  AudioInputBus? get connectedBus => _connectedBus;

  void connect(AudioInputBus inputBus) {
    if (node == inputBus.node) {
      throw const AudioBusConnectionException.sameNode();
    }

    if (!canConnect(inputBus)) {
      throw const AudioBusConnectionException.incompatibleFormat();
    }

    inputBus.tryConnect(this);
    _connectedBus = inputBus;
  }

  void disconnect() {
    _connectedBus?.onDisconnect();
    _connectedBus = null;
  }

  bool canConnect(AudioInputBus inputBus) {
    if (node == inputBus.node) {
      return false;
    }

    final outputFormat = resolveFormat();
    final inputFormat = inputBus.resolveFormat();

    if (outputFormat == null || inputFormat == null) {
      return true;
    }

    return outputFormat.isSameFormat(inputFormat);
  }

  /// Read audio data from the associated node.
  AudioReadResult read(AudioBuffer buffer) {
    return node.read(this, buffer);
  }
}
