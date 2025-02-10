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

/// [Memory] class handles pointer related operations.
/// You can customize the behavior by extending this class and provide it to memory related instances such as [AllocatedAudioFrames].
/// By default, [FfiMemory] will be used.
abstract class Memory {
  factory Memory() {
    return FfiMemory();
  }

  /// memory allocator that allocates and free memory.
  Allocator get allocator;

  /// Copies memory from [pSrc] to [pDst] with [size].
  Pointer<Void> copyMemory(Pointer<Void> pDst, Pointer<Void> pSrc, int size);

  /// Sets memory of [p] with [data] with [size].
  Pointer<Void> setMemory(Pointer<Void> p, int data, int size);

  /// Zeros memory of [p] with [size].
  Pointer<Void> zeroMemory(Pointer<Void> p, int size);
}

/// [FfiMemory] uses native functions to interact with memory operations.
/// For example, [setMemory] will use the `memset` function.
class FfiMemory implements Memory {
  factory FfiMemory() {
    return _instance;
  }

  FfiMemory._init();

  static final _instance = FfiMemory._init();

  final _lib = DynamicLibrary.process();

  late final _memcpyPtr = _lib.lookup<
      NativeFunction<
          Pointer<Void> Function(
              Pointer<Void>, Pointer<Void>, Size)>>('memcpy');
  late final _memcpy = _memcpyPtr
      .asFunction<Pointer<Void> Function(Pointer<Void>, Pointer<Void>, int)>(
          isLeaf: true);

  late final _memsetPtr = _lib
      .lookup<NativeFunction<Pointer<Void> Function(Pointer<Void>, Int, Size)>>(
          'memset');
  late final _memset =
      _memsetPtr.asFunction<Pointer<Void> Function(Pointer<Void>, int, int)>(
          isLeaf: true);

  @override
  Allocator get allocator => malloc;

  @override
  Pointer<Void> copyMemory(Pointer<Void> pDst, Pointer<Void> pSrc, int size) {
    return _memcpy(pDst, pSrc, size);
  }

  @override
  Pointer<Void> setMemory(Pointer<Void> p, int data, int size) {
    return _memset(p, data, size);
  }

  @override
  Pointer<Void> zeroMemory(Pointer<Void> p, int size) => setMemory(p, 0, size);
}
