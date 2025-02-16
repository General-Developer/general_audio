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
import 'dart:math' as math;

import 'package:general_audio/core/general_audio.dart';

/// The abstract class of a wave generator function.
/// You can implement custom waves by extending this class.
abstract class WaveFunction {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const WaveFunction();

  /// Compute 1Hz wave data at the [time].
  double compute(AudioTime time);
}

/// A wave generator function that returns a constant value.
class OffsetFunction extends WaveFunction {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  OffsetFunction(this.offset);

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  double offset;

  @override
  double compute(AudioTime time) {
    return offset;
  }
}

/// A wave generator function that returns a sine wave.
class SineFunction extends WaveFunction {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const SineFunction();

  @override
  double compute(AudioTime time) {
    return math.sin(2 * math.pi * time.seconds);
  }
}

/// A wave generator function that returns a square wave.
class SquareFunction extends WaveFunction {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const SquareFunction();

  @override
  double compute(AudioTime time) {
    final t = time.seconds - time.seconds.floorToDouble();
    if (t <= 0.5) {
      return 1;
    } else {
      return -1;
    }
  }
}

/// A wave generator function that returns a triangle wave.
class TriangleFunction extends WaveFunction {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const TriangleFunction();

  @override
  double compute(AudioTime time) {
    final t = time.seconds - time.seconds.floorToDouble();
    return 2 * (2 * (t - 0.5)).abs() - 1;
  }
}

/// A wave generator function that returns a sawtooth wave.
class SawtoothFunction extends WaveFunction {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const SawtoothFunction();

  @override
  double compute(AudioTime time) {
    final f = time.seconds - time.seconds.floorToDouble();
    return 2 * (f - 0.5);
  }
}
