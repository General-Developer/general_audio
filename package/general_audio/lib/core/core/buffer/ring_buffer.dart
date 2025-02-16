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
import 'dart:math';

import 'package:general_audio/core/general_audio.dart';

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class RingBuffer with AudioResourceMixin {
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  RingBuffer({
    required this.capacity,
    Memory? memory,
  })  : memory = memory ?? Memory(),
        _pBuffer = (memory ?? Memory()).allocator.allocate(capacity) {
    final captured = (this.memory, _pBuffer);
    setResourceFinalizer(() {
      captured.$1.allocator.free(captured.$2);
    });
  }

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final int capacity;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final Memory memory;

  final Pointer<Void> _pBuffer;

  int _head = 0;
  int _length = 0;

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  int get length => _length;

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  int write(Pointer<Void> pInput, int offset, int size) {
    final writeSize = min(capacity - _length, size);
    if (writeSize == 0) {
      return 0;
    }

    final pOffsetInput = Pointer<Void>.fromAddress(pInput.address + offset);
    final pTail = Pointer<Void>.fromAddress(_pBuffer.address + (_head + _length) % capacity);
    final pWriteEnd = Pointer<Void>.fromAddress(_pBuffer.address + (_head + _length + writeSize) % capacity);

    if (pTail.address <= pWriteEnd.address) {
      memory.copyMemory(pTail, pOffsetInput, writeSize);
    } else {
      final pEnd = Pointer<Void>.fromAddress(_pBuffer.address + capacity);

      final firstWrite = pEnd.address - pTail.address;
      memory.copyMemory(pTail, pOffsetInput, firstWrite);

      final secondWrite = writeSize - firstWrite;
      memory.copyMemory(_pBuffer, Pointer.fromAddress(pOffsetInput.address + firstWrite), secondWrite);
    }

    _length += writeSize;
    return writeSize;
  }

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  int read(Pointer<Void> pOutput, int offset, int size, {bool advance = true}) {
    final readSize = min(size, _length);
    if (readSize == 0) {
      return 0;
    }

    final pOffsetOutput = Pointer<Void>.fromAddress(pOutput.address + offset);
    final pHead = Pointer<Void>.fromAddress(_pBuffer.address + _head);
    final pEndRead = Pointer<Void>.fromAddress(_pBuffer.address + ((_head + readSize) % capacity));

    if (pEndRead.address <= pHead.address) {
      final pEnd = Pointer<Void>.fromAddress(_pBuffer.address + capacity);

      final firstRead = pEnd.address - pHead.address;
      memory.copyMemory(pOffsetOutput, pHead, firstRead);

      final secondRead = readSize - firstRead;
      memory.copyMemory(Pointer.fromAddress(pOffsetOutput.address + firstRead), _pBuffer, secondRead);
    } else {
      memory.copyMemory(pOffsetOutput, pHead, readSize);
    }

    if (advance) {
      _head = (_head + readSize) % capacity;
      _length -= readSize;
    }
    return readSize;
  }

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  int copyTo(RingBuffer output, {required bool advance}) {
    final readSize = read(
      output._pBuffer,
      output._head,
      min(output.capacity - output.length, _length),
      advance: advance,
    );
    output._length += readSize;
    return readSize;
  }

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  void clear() {
    _head = 0;
    _length = 0;
  }
}
