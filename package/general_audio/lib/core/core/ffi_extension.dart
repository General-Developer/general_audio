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

import 'package:general_audio/core/general_audio.dart';
import 'package:ffi/ffi.dart';

extension ArrayCharExtension on Array<Char> {
  String getUtf8String(int maxLength, {bool zeroTerminated = true}) {
    final mem = Memory();
    final pStr = mem.allocator.allocate<Char>(maxLength);
    try {
      for (var i = 0; maxLength > i; i++) {
        pStr[i] = this[i];
        if (zeroTerminated && this[i] == 0) {
          break;
        }
      }
      return pStr.cast<Utf8>().toDartString();
    } finally {
      mem.allocator.free(pStr);
    }
  }

  String getAsciiString(int maxLength, {bool zeroTerminated = true}) {
    var str = '';
    for (var i = 0; maxLength > i; i++) {
      if (zeroTerminated && this[i] == 0) {
        break;
      }
      str += String.fromCharCode(this[i]);
    }
    return str;
  }

  void setUtf8String(String value) {
    final mem = Memory();
    final pStr = value.toNativeUtf8(allocator: mem.allocator).cast<Char>();
    for (var i = 0;; i++) {
      this[i] = pStr[i];
      if (pStr[i] == 0) {
        break;
      }
    }
    mem.allocator.free(pStr);
  }

  void setAsciiString(
    String value, {
    required bool nullTerminated,
  }) {
    for (var i = 0; value.length > i; i++) {
      this[i] = value.codeUnitAt(i);
    }
    if (nullTerminated) {
      this[value.length] = 0;
    }
  }
}
