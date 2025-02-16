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

import 'package:meta/meta.dart';

final _finalizer = Finalizer<int>((id) {
  final holder = _resourceHolders.remove(id);
  holder?.dispose();
});

final _resourceHolders = <int, _AudioResourceHolder>{};

class _AudioResource {
  const _AudioResource(this.id, this.name);
  final int id;
  final String name;
}

class _AudioResourceHolder {
  _AudioResourceHolder(
    this.resource,
    this.finalizer,
  );
  final _AudioResource resource;
  final void Function() finalizer;

  void dispose() {
    finalizer();
    if (AudioResourceManager.isDisposeLogEnabled) {
      print(
          '[general_audio/AudioResource] Disposed `${resource.name}` (id: ${resource.id})');
    }
  }
}

/// A manager that provides a way to dispose audio resources.
///
/// You can use this class to dispose audio resources manually.
final class AudioResourceManager {
  const AudioResourceManager._();

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  static var isDisposeLogEnabled = false;

  /// Disposes the audio resource with the given [resourceId].
  ///
  /// Returns `true` if the resource is successfully disposed.
  /// Otherwise, returns `false`.
  static bool dispose(int resourceId) {
    final holder = _resourceHolders.remove(resourceId);
    if (holder == null) {
      return false;
    }

    holder.dispose();
    _finalizer.detach(holder.resource);
    return true;
  }

  /// Disposes all audio resources.
  ///
  /// This method should be called when the isolate is shutting down.
  static void disposeAll() {
    final holders = _resourceHolders.entries.toList();
    for (final holder in holders) {
      holder.value.dispose();
      _finalizer.detach(holder.value.resource);
      _resourceHolders.remove(holder.key);
    }
  }
}

/// A mixin that provides a finalizer for audio resources.
///
/// Implement this mixin and call [setResourceFinalizer] to automatically dispose.
mixin AudioResourceMixin implements Finalizable {
  var _hasFinalizer = false;

  /// Whether this resource is already disposed.
  bool get isDisposed =>
      _hasFinalizer && !_resourceHolders.containsKey(resourceId);

  /// The unique identifier of this resource.
  late final resourceId = identityHashCode(this);

  /// Throws an [AudioResourceDisposedException] if this resource is already disposed.
  void throwIfDisposed() {
    if (isDisposed) {
      throw AudioResourceDisposedException(resourceId, runtimeType.toString());
    }
  }

  /// Sets a finalizer for this resource.
  ///
  /// The [onFinalize] function will be called when this resource is garbage collected.
  /// Please note that the [onFinalize] function should not reference instance members directly.
  /// Otherwise, it will prevent the object from being garbage collected.
  @protected
  void setResourceFinalizer<T>(void Function() onFinalize) {
    final resource = _AudioResource(resourceId, runtimeType.toString());
    final holder = _AudioResourceHolder(resource, onFinalize);
    _resourceHolders[resourceId] = holder;
    _hasFinalizer = true;

    _finalizer.attach(this, resourceId, detach: resource);
  }

  /// Clears the finalizer for this resource.
  @protected
  void clearResourceFinalizer() {
    final holder = _resourceHolders.remove(resourceId);
    if (holder != null) {
      _finalizer.detach(holder.resource);
      _hasFinalizer = false;
    }
  }
}

/// An exception that is thrown when an audio resource is already disposed.
class AudioResourceDisposedException implements Exception {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const AudioResourceDisposedException(this.id, this.name);

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final int id;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final String name;

  @override
  String toString() => 'The audio resource $name(id: $id) is already disposed';
}
