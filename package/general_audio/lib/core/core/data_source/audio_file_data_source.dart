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
import 'dart:io';
import 'dart:typed_data';

import 'package:general_audio/core/general_audio.dart';

/// An audio data source for a file.
///
/// This class implements both [AudioInputDataSource] and [AudioOutputDataSource].
class AudioFileDataSource
    with AudioResourceMixin
    implements AudioInputDataSource, AudioOutputDataSource {
  /// Creates an audio data source for a file.
  ///
  /// If [cacheLength] is true, the length of the file will be cached as soon as instantiated.
  /// If [cachePosition] is true, the position of the file will be cached as soon as instantiated.
  factory AudioFileDataSource({
    required File file,
    required FileMode mode,
    bool cacheLength = true,
    bool cachePosition = true,
  }) {
    return AudioFileDataSource.fromRandomAccessFile(
      file: file.openSync(mode: mode),
      cacheLength: cacheLength,
      cachePosition: cachePosition,
    );
  }

  /// Creates an audio data source for a random access file.
  ///
  /// If [cacheLength] is true, the length of the file will be cached as soon as instantiated.
  /// If [cachePosition] is true, the position of the file will be cached as soon as instantiated.
  AudioFileDataSource.fromRandomAccessFile({
    required this.file,
    bool cacheLength = true,
    bool cachePosition = true,
  })  : _cachedLength = cacheLength ? file.lengthSync() : null,
        _cachedPosition = cachePosition ? file.positionSync() : null {
    final captured = file;
    setResourceFinalizer(() {
      captured.closeSync();
    });
  }

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final RandomAccessFile file;
  int? _cachedLength;
  int? _cachedPosition;
  var _isCursorDirty = false;
  var _isLengthDirty = false;

  @override
  int get length {
    if (_isLengthDirty && _cachedLength != null) {
      _cachedLength = file.lengthSync();
      _isLengthDirty = false;
    }

    return _cachedLength ?? file.lengthSync();
  }

  @override
  int get position {
    if (_isCursorDirty && _cachedPosition != null) {
      _cachedPosition = file.positionSync();
      _isCursorDirty = false;
    }

    return _cachedPosition ?? file.positionSync();
  }

  @override
  set position(int newPosition) {
    file.setPositionSync(newPosition);
    if (_cachedPosition != null) {
      _cachedPosition = newPosition;
    }
  }

  @override
  bool get canSeek => true;

  @override
  int readBytes(Uint8List buffer) {
    final readCount = file.readIntoSync(buffer);
    if (_cachedPosition != null) {
      _cachedPosition = _cachedPosition! + readCount;
    }
    return readCount;
  }

  @override
  int writeBytes(Uint8List buffer) {
    file.writeFromSync(buffer);

    _isCursorDirty = true;
    _isLengthDirty = true;

    return buffer.length;
  }

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  void closeSync() {
    AudioResourceManager.dispose(resourceId);
  }
}
