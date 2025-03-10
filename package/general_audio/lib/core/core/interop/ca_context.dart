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
import 'package:general_audio/core/core/interop/ca_device.dart';
import 'package:general_audio/core/core/interop/internal/generated/bindings.dart';
import 'package:general_audio/core/core/interop/internal/ma_extension.dart';

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class CaContext {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  CaContext({
    required List<AudioDeviceBackend> backends,
    Pointer<ma_log>? pLog,
  }) {
    _interop.allocateTemporary<Int32, void>(sizeOf<Int32>() * backends.length,
        (pBackends) {
      final list = pBackends.asTypedList(backends.length);
      for (var i = 0; i < backends.length; i++) {
        list[i] = backends[i].maValue;
      }

      _interop.allocateTemporary<ma_context_config, void>(
        sizeOf<ma_context_config>(),
        (pConfig) {
          pConfig.ref = _interop.bindings.ma_context_config_init();
          pConfig.ref.coreaudio.noAudioSessionActivate = true.toMaBool();
          pConfig.ref.coreaudio.noAudioSessionDeactivate = true.toMaBool();
          pConfig.ref.pLog = pLog ?? nullptr;

          _interop.bindings
              .ca_context_init(pBackends, backends.length, pConfig, _pContext)
              .throwMaResultIfNeeded();
        },
      );
    });

    _interop.onInitialized();
  }

  final _interop = CoastAudioInterop();

  final _associatedDevices = <CaDevice>[];

  late final _pContext =
      _interop.allocateManaged<ca_context>(sizeOf<ma_context>());

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  Pointer<ma_context> get ref =>
      _interop.bindings.ca_context_get_ref(_pContext);

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  AudioDeviceBackend get activeBackend {
    _interop.throwIfDisposed();
    return AudioDeviceBackend.values.firstWhere(
      (v) => ref.ref.backend == v.maValue,
    );
  }

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  List<AudioDeviceInfo> getDevices(AudioDeviceType type) {
    _interop.throwIfDisposed();
    final devices = <AudioDeviceInfo>[];
    _interop.allocateTemporary<UnsignedInt, void>(sizeOf<UnsignedInt>(),
        (pCount) {
      _interop.allocateTemporary<IntPtr, void>(
        sizeOf<IntPtr>(),
        (ppDevices) {
          switch (type) {
            case AudioDeviceType.capture:
              _interop.bindings
                  .ma_context_get_devices(
                      ref, nullptr, nullptr, ppDevices.cast(), pCount)
                  .throwMaResultIfNeeded();
            case AudioDeviceType.playback:
              _interop.bindings
                  .ma_context_get_devices(
                      ref, ppDevices.cast(), pCount, nullptr, nullptr)
                  .throwMaResultIfNeeded();
          }
          final pDevices =
              Pointer.fromAddress(ppDevices.value).cast<ma_device_info>();
          for (var i = 0; pCount.value > i; i++) {
            final info = AudioDeviceInfo(
              type: type,
              backend: activeBackend,
              configure: (handle) {
                final pDevice = Pointer<ma_device_info>.fromAddress(
                    pDevices.address + i * sizeOf<ma_device_info>());
                handle.ref = pDevice.ref;
              },
            );
            devices.add(info);
          }
        },
      );
    });
    return devices;
  }

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  CaDevice createDevice({
    required AudioFormat format,
    required int bufferFrameSize,
    required AudioDeviceType type,
    AudioDeviceId? deviceId,
    bool noFixedSizedProcess = true,
    AudioDevicePerformanceProfile performanceProfile =
        AudioDevicePerformanceProfile.lowLatency,
    AudioFormatConverterConfig converter = const AudioFormatConverterConfig(),
  }) {
    _interop.throwIfDisposed();
    final device = CaDevice(
      context: this,
      format: format,
      type: type,
      bufferFrameSize: bufferFrameSize,
      deviceId: deviceId,
      noFixedSizedProcess: noFixedSizedProcess,
      performanceProfile: performanceProfile,
      converter: converter,
    );
    _associatedDevices.add(device);
    return device;
  }

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  void dispose() {
    for (final device in _associatedDevices) {
      device.dispose();
    }
    _associatedDevices.clear();
    _interop.bindings.ca_context_uninit(_pContext).throwMaResultIfNeeded();
    _interop.dispose();
  }
}
