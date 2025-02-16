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

import 'generated/bindings.dart';

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
extension IntExtension on int {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  void throwMaResultIfNeeded() {
    asMaResult().throwIfNeeded();
  }

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  MaResult asMaResult() {
    return MaResult.values.firstWhere((r) => r.code == this);
  }

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  bool asMaBool() {
    return this == 1;
  }

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  SampleFormat asSampleFormat() {
    return SampleFormat.values.firstWhere((r) => r.maFormat == this,
        orElse: () => throw Exception('Unsupported ma_format: $this'));
  }

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  T whenSeekOrigin<T>({
    required T Function() current,
    required T Function() start,
    required T Function() end,
  }) {
    switch (this) {
      case ma_seek_origin.ma_seek_origin_current:
        return current();
      case ma_seek_origin.ma_seek_origin_start:
        return start();
      case ma_seek_origin.ma_seek_origin_end:
        return end();
      default:
        throw ArgumentError.value(this, 'seekOrigin');
    }
  }
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
extension BoolExtension on bool {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  int toMaBool() {
    return this ? 1 : 0;
  }
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
extension SampleFormatExtension on SampleFormat {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  int get maFormat {
    switch (this) {
      case SampleFormat.uint8:
        return ma_format.ma_format_u8;
      case SampleFormat.int16:
        return ma_format.ma_format_s16;
      case SampleFormat.int24:
        return ma_format.ma_format_s24;
      case SampleFormat.int32:
        return ma_format.ma_format_s32;
      case SampleFormat.float32:
        return ma_format.ma_format_f32;
    }
  }
}
