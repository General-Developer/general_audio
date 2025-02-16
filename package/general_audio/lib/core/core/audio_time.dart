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
import 'package:general_audio/core/general_audio.dart';

/// A class for representing audio time.
class AudioTime {
  /// Constructs an [AudioTime] from [seconds].
  const AudioTime(this.seconds);

  /// Constructs an [AudioTime] from [frames] and [format].
  AudioTime.fromFrames(
    int frames, {
    required AudioFormat format,
  }) : seconds = (frames * format.bytesPerFrame) /
            (format.sampleRate * format.sampleFormat.size * format.channels);

  /// Constructs an [AudioTime] from [duration].
  AudioTime.fromDuration(Duration duration)
      : seconds = duration.inMicroseconds / Duration.microsecondsPerSecond;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  static AudioTime zero = const AudioTime(0);

  /// Time in seconds.
  final double seconds;

  /// Format [seconds] as MM:SS.
  String formatMMSS() {
    final minutes = (this.seconds / 60).floor();
    final seconds = (this.seconds - (minutes * 60)).floor();
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  /// Format [seconds] as HH:MM:SS.
  String formatHHMMSS() {
    final hours = (this.seconds / 3600).floor();
    final minutes = ((this.seconds - (hours * 3600)) / 60).floor();
    final seconds = (this.seconds - (hours * 3600) - (minutes * 60)).floor();
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  /// Compute the number of frames from [format].
  int computeFrames(AudioFormat format) {
    return (seconds *
            format.sampleRate *
            format.sampleFormat.size *
            format.channels) ~/
        format.bytesPerFrame;
  }

  /// Compute the [Duration] from [seconds].
  Duration get duration {
    return Duration(
        microseconds: (seconds * Duration.microsecondsPerSecond).toInt());
  }

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  AudioTime operator +(AudioTime other) {
    return AudioTime(seconds + other.seconds);
  }

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  AudioTime operator -(AudioTime other) {
    return AudioTime(seconds - other.seconds);
  }

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  AudioTime operator /(AudioTime other) {
    return AudioTime(seconds / other.seconds);
  }

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  AudioTime operator *(AudioTime other) {
    return AudioTime(seconds * other.seconds);
  }

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  bool operator >(AudioTime other) {
    return seconds > other.seconds;
  }

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  bool operator <(AudioTime other) {
    return seconds < other.seconds;
  }

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  bool operator >=(AudioTime other) {
    return seconds >= other.seconds;
  }

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  bool operator <=(AudioTime other) {
    return seconds <= other.seconds;
  }

  @override
  bool operator ==(Object other) {
    if (other is! AudioTime) {
      return false;
    }

    return seconds == other.seconds;
  }

  @override
  int get hashCode => seconds.hashCode;

  @override
  String toString() {
    return 'AudioTime(${formatHHMMSS()})';
  }
}
