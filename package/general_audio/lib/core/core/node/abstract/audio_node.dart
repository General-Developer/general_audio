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

/// [AudioNode] is the base class for all audio nodes.
///
/// An audio node is a node that can be connected to other audio nodes to create a audio node graph.
/// You can create a custom audio node by extending [AudioNode] and subclasses like [AudioFilterNode].
abstract class AudioNode {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const AudioNode();

  /// The list of input buses.
  ///
  /// If you want to create a node that has only one input bus, you should mixin the [SingleInNodeMixin].
  List<AudioInputBus> get inputs;

  /// The list of output buses.
  ///
  /// If you want to create a node that has only one output bus, you should mixin the [SingleOutNodeMixin].
  List<AudioOutputBus> get outputs;

  /// Read audio data from the input bus and write audio data to the output bus.
  AudioReadResult read(AudioOutputBus outputBus, AudioBuffer buffer);
}

/// [AudioFilterNode] is the handy base class for audio filter nodes.
///
/// If you want to create an audio filter, you should extend this class and implement the process method.
abstract class AudioFilterNode extends AudioNode
    with
        SingleInNodeMixin,
        SingleOutNodeMixin,
        ProcessorNodeMixin,
        BypassNodeMixin {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  AudioFilterNode();
}
