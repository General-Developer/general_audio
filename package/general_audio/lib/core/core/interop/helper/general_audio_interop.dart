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

import '../internal/generated/bindings.dart';

/// An interop helper for the general_audio and miniaudio library.
final class CoastAudioInterop with AudioResourceMixin {
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  CoastAudioInterop() {
    // Set the resource finalizer to free all the managed pointers if the holder instance fails to initialize.
    final captured = (memory, _managedPtrs);
    setResourceFinalizer(() {
      final (memory, managedPtrs) = captured;
      for (final ptr in managedPtrs) {
        memory.allocator.free(ptr);
      }
    });
  }

  final _memory = Memory();
  final _managedPtrs = <Pointer<Void>>[];
  var _isInitialized = false;
  var _isDisposed = false;

  /// A callback that is called when the holder is initialized successfully.
  void onInitialized() {
    clearResourceFinalizer();
    _isInitialized = true;
  }

  /// Native library bindings.
  NativeBindings get bindings {
    throwIfDisposed();
    return CoastAudioNative.bindings;
  }

  /// Memory allocator.
  Memory get memory {
    throwIfDisposed();
    return _memory;
  }

  @override
  bool get isDisposed {
    if (_isInitialized) {
      return _isDisposed;
    }

    return super.isDisposed;
  }

  /// Allocates a managed pointer.
  ///
  /// The allocated pointer will be freed when this interop is disposed.
  Pointer<T> allocateManaged<T extends NativeType>(int byteCount) {
    throwIfDisposed();
    final ptr = _memory.allocator.allocate<T>(byteCount);
    _managedPtrs.add(ptr.cast());
    return ptr;
  }

  /// Allocates a temporary pointer and disposes it after the action is executed.
  TResult allocateTemporary<T extends NativeType, TResult>(
    int byteCount,
    TResult Function(Pointer<T>) action,
  ) {
    throwIfDisposed();
    final ptr = _memory.allocator.allocate<Void>(byteCount);
    try {
      return action(ptr.cast());
    } finally {
      _memory.allocator.free(ptr);
    }
  }

  /// Disposes the interop and frees all the managed pointers.
  void dispose() {
    if (_isDisposed) {
      return;
    }
    for (final ptr in _managedPtrs) {
      _memory.allocator.free(ptr);
    }
    _managedPtrs.clear();
    _isDisposed = true;
  }
}
