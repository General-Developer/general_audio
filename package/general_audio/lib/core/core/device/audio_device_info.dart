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
import 'package:general_audio/core/core/ffi_extension.dart';

import '../interop/internal/generated/bindings.dart';
import '../interop/internal/ma_extension.dart';

/// An audio device information.
class AudioDeviceInfo {
  const AudioDeviceInfo._init({
    required this.id,
    required this.name,
    required this.isDefault,
    required this.type,
    required this.backend,
  });

  factory AudioDeviceInfo({
    required AudioDeviceType type,
    required AudioDeviceBackend backend,
    required void Function(Pointer<ma_device_info> handle) configure,
  }) {
    final memory = Memory();
    final pInfo =
        memory.allocator.allocate<ma_device_info>(sizeOf<ma_device_info>());
    try {
      configure(pInfo);

      // MEMO: Assuming id field is always the first field in ca_device_info.
      final id = switch (backend) {
        AudioDeviceBackend.coreAudio =>
          AudioDeviceId.fromPointer(pInfo.cast(), 256),
        AudioDeviceBackend.aaudio =>
          AudioDeviceId.fromPointer(pInfo.cast(), sizeOf<Int>()),
        AudioDeviceBackend.openSLES =>
          AudioDeviceId.fromPointer(pInfo.cast(), sizeOf<Int>()),
        AudioDeviceBackend.wasapi =>
          AudioDeviceId.fromPointer(pInfo.cast(), 256),
        AudioDeviceBackend.alsa => AudioDeviceId.fromPointer(pInfo.cast(), 256),
        AudioDeviceBackend.pulseAudio =>
          AudioDeviceId.fromPointer(pInfo.cast(), 256),
        AudioDeviceBackend.jack =>
          AudioDeviceId.fromPointer(pInfo.cast(), sizeOf<Int>()),
        AudioDeviceBackend.dummy =>
          AudioDeviceId.fromPointer(pInfo.cast(), sizeOf<Int>())
      };
      final name = pInfo.ref.name.getUtf8String(256);
      final isDefault = pInfo.ref.isDefault.asMaBool();

      return AudioDeviceInfo._init(
        id: id,
        name: name,
        isDefault: isDefault,
        type: type,
        backend: backend,
      );
    } finally {
      memory.allocator.free(pInfo);
    }
  }

  /// The device id.
  final AudioDeviceId id;

  /// The device name.
  final String name;

  /// Whether the device is the default device.
  final bool isDefault;

  /// The device type.
  final AudioDeviceType type;

  /// The device backend.
  final AudioDeviceBackend backend;
}
