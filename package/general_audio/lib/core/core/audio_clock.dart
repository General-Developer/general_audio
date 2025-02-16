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
import 'dart:async';

import 'package:general_audio/core/general_audio.dart';

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
typedef AudioClockCallback = void Function(AudioClock clock);

/// An audio clock that provides a time reference for audio tasks.
abstract class AudioClock {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  AudioClock();

  /// Whether the clock is started.
  bool get isStarted;

  /// The elapsed time of the clock.
  AudioTime get elapsedTime;

  /// Starts the clock.
  void start({required AudioClockCallback onTick});

  /// Stops the clock.
  void stop();

  /// Resets the clock.
  ///
  /// Please note that the clock is not stopped after reset.
  /// You should call [stop] if you want to stop the clock.
  void reset();
}

/// An audio clock that ticks at a fixed interval.
///
/// This clock is useful for running audio task without blocking the isolate.
class AudioIntervalClock extends AudioClock {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  AudioIntervalClock(this.interval);

  Timer? _timer;
  var _elapsed = AudioTime.zero;

  /// The interval of the clock.
  final AudioTime interval;

  @override
  bool get isStarted => _timer != null;

  @override
  AudioTime get elapsedTime => _elapsed;

  @override
  void start({required AudioClockCallback onTick}) {
    if (_timer != null) {
      return;
    }

    _timer = Timer.periodic(interval.duration, (timer) {
      _elapsed += interval;
      onTick(this);
    });
  }

  @override
  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void reset() {
    _elapsed = AudioTime.zero;
  }
}

/// An audio clock that ticks in a loop.
///
/// This clock is useful for running audio task as fast as possible like converting audio data.
/// You should stop the clock inside the callback to prevent the isolate from being blocked.
class AudioLoopClock extends AudioClock {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  AudioLoopClock();

  final _stopwatch = Stopwatch();

  @override
  bool get isStarted => _stopwatch.isRunning;

  @override
  AudioTime get elapsedTime =>
      AudioTime(_stopwatch.elapsedMicroseconds / 1000 / 1000);

  @override
  void start({required AudioClockCallback onTick}) {
    _stopwatch.start();
    while (_stopwatch.isRunning) {
      onTick(this);
    }
  }

  @override
  void stop() {
    _stopwatch.stop();
  }

  @override
  void reset() {
    _stopwatch.reset();
  }
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
extension AudioClockExtension on AudioClock {
  /// Runs the clock with an audio buffer while the [onTick] callback returns true.
  ///
  /// You need to await the returned future to wait for the clock to stop.
  Future<void> runWithBuffer({
    required AudioFrames frames,
    required bool Function(AudioClock, AudioBuffer) onTick,
  }) {
    final completer = Completer<void>();
    frames.acquireBuffer((buffer) {
      start(
        onTick: (clock) {
          try {
            if (!onTick(clock, buffer)) {
              stop();
              completer.complete();
            }
          } catch (e, stack) {
            stop();
            completer.completeError(e, stack);
          }
        },
      );
    });

    return completer.future;
  }
}
