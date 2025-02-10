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

import '../interop/internal/generated/bindings.dart';

/// An audio device notification which is sent when the audio device state changes.
///
/// You can listen to these notifications by using `AudioDevice.notification.listen`.
class AudioDeviceNotification {
  const AudioDeviceNotification({
    required this.type,
    required this.state,
  });

  factory AudioDeviceNotification.fromPointer(
      Pointer<ca_device_notification> pNotification) {
    final notification = pNotification.ref;
    return AudioDeviceNotification(
      type: AudioDeviceNotificationType.values
          .firstWhere((e) => notification.type == e.maValue),
      state: AudioDeviceState.values
          .firstWhere((e) => notification.state == e.maValue),
    );
  }

  /// The notification type.
  final AudioDeviceNotificationType type;

  /// The device state.
  final AudioDeviceState state;
}

/// Types of audio device notifications.
enum AudioDeviceNotificationType {
  /// The device has started.
  started(ma_device_notification_type.ma_device_notification_type_started),

  /// The device has stopped.
  stopped(ma_device_notification_type.ma_device_notification_type_stopped),

  /// The old device is disconnected and the new device will be used.
  rerouted(ma_device_notification_type.ma_device_notification_type_rerouted),

  /// The device has been interrupted.
  ///
  /// This can happen on iOS when some situation occurs, such as a phone call.
  interruptionBegan(ma_device_notification_type
      .ma_device_notification_type_interruption_began),

  /// The device's interruption has ended.
  interruptionEnded(ma_device_notification_type
      .ma_device_notification_type_interruption_ended);

  const AudioDeviceNotificationType(this.maValue);
  final int maValue;
}
