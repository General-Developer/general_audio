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
import 'dart:io';

import 'package:general_audio/core/general_audio.dart';

import '../internal/generated/bindings.dart';

/// A wrapper around the native general_audio library.
class CoastAudioNative {
  const CoastAudioNative._();

  static NativeBindings? _bindings;

  /// Returns the native bindings for the native general_audio library.
  static NativeBindings get bindings {
    final bindings = _bindings ?? initialize();
    _bindings ??= bindings;
    return bindings;
  }

  /// Initializes the native general_audio library.
  ///
  /// If [library] is not provided, the library will be loaded from the default location for the current platform.
  /// If [ignoreVersionVerification] is `true`, the version of the loaded library will not be verified.
  static NativeBindings initialize({
    DynamicLibrary? library,
    bool ignoreVersionVerification = false,
  }) {
    final DynamicLibrary lib;
    if (library != null) {
      lib = library;
    } else if (Platform.isMacOS || Platform.isIOS) {
      lib = DynamicLibrary.process();
    } else if (Platform.isAndroid) {
      lib = DynamicLibrary.open('libgeneral_audio.so');
    } else if (Platform.isLinux) {
      lib = DynamicLibrary.open('libgeneral_audio.so');
    } else {
      throw const CoastAudioNativeInitializationException.unsupportedPlatform();
    }

    final bindings = NativeBindings(lib);

    if (!ignoreVersionVerification &&
        !MaVersion.supportedVersion.isSupported(bindings.maVersion)) {
      throw CoastAudioNativeInitializationException.maVersionMismatch(
          bindings.maVersion);
    }

    if (!ignoreVersionVerification &&
        !CaVersion.supportedVersion.isSupported(bindings.caVersion)) {
      throw CoastAudioNativeInitializationException.caVersionMismatch(
          bindings.caVersion);
    }

    bindings.ca_dart_configure(NativeApi.postCObject.cast());
    _bindings = bindings;

    return bindings;
  }
}

/// An exception thrown when the native general_audio library fails to initialize.
class CoastAudioNativeInitializationException implements Exception {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const CoastAudioNativeInitializationException.unsupportedPlatform()
      : message = 'Unsupported platform.';

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const CoastAudioNativeInitializationException.maVersionMismatch(
      MaVersion version)
      : message =
            'Unsupported version of miniaudio detected. Expected ${MaVersion.supportedVersion}^, but got $version.';

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const CoastAudioNativeInitializationException.caVersionMismatch(
      CaVersion version)
      : message =
            'Unsupported version of native general_audio library detected. Expected ${CaVersion.supportedVersion}^, but got $version.';

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final String message;

  @override
  String toString() {
    return 'CoastAudioNativeInitializationException: $message';
  }
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
extension NativeBindingsExtension on NativeBindings {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  MaVersion get maVersion {
    final memory = Memory();
    final pMajor =
        memory.allocator.allocate<UnsignedInt>(sizeOf<UnsignedInt>());
    final pMinor =
        memory.allocator.allocate<UnsignedInt>(sizeOf<UnsignedInt>());
    final pRevision =
        memory.allocator.allocate<UnsignedInt>(sizeOf<UnsignedInt>());

    try {
      ma_version(pMajor, pMinor, pRevision);
      return MaVersion(
        pMajor.value,
        pMinor.value,
        pRevision.value,
      );
    } finally {
      memory.allocator.free(pMajor);
      memory.allocator.free(pMinor);
      memory.allocator.free(pRevision);
    }
  }

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  CaVersion get caVersion {
    final memory = Memory();
    final pMajor = memory.allocator.allocate<Char>(sizeOf<Char>());
    final pMinor = memory.allocator.allocate<Char>(sizeOf<Char>());
    final pRevision = memory.allocator.allocate<Char>(sizeOf<Char>());

    try {
      general_audio_get_version(pMajor, pMinor, pRevision);
      return CaVersion(
        pMajor.value,
        pMinor.value,
        pRevision.value,
      );
    } finally {
      memory.allocator.free(pMajor);
      memory.allocator.free(pMinor);
      memory.allocator.free(pRevision);
    }
  }
}
