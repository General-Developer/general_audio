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
import 'dart:core';
import 'dart:isolate';

import 'package:general_audio/core/core/isolate/audio_isolate_host_message.dart';
import 'package:general_audio/core/core/isolate/audio_isolate_worker_message.dart';

class AudioIsolateHostMessenger {
  final _receivePort = ReceivePort();
  SendPort? _sendPort;

  SendPort get workerToHostSendPort => _receivePort.sendPort;

  late final message = _receivePort
      .where((r) => r is AudioIsolateWorkerMessage)
      .cast<AudioIsolateWorkerMessage>()
      .asBroadcastStream();

  void attach(SendPort sendPort) {
    _sendPort = sendPort;
  }

  void detach() {
    _sendPort = null;
  }

  Future<TResponse?> request<TRequest, TResponse>(TRequest payload) async {
    final sendPort = _sendPort;
    if (sendPort == null) {
      throw StateError('Messenger is not attached to an worker');
    }

    final request = AudioIsolateHostRequest(payload);
    final responseFuture = message.firstWhere(
        (r) => r is AudioIsolateWorkerResponse && r.requestId == request.id);
    sendPort.send(request);

    final AudioIsolateWorkerResponse response;
    try {
      response = await responseFuture as AudioIsolateWorkerResponse;
    } on StateError {
      return null;
    }

    switch (response) {
      case AudioIsolateWorkerSuccessResponse():
        if (response.payload is TResponse) {
          return response.payload as TResponse;
        } else {
          throw StateError(
              'Unexpected response type: ${response.payload.runtimeType}');
        }
      case AudioIsolateWorkerFailedResponse():
        return Future.error(response.exception, response.stackTrace);
    }
  }

  void requestShutdown() {
    final sendPort = _sendPort;
    if (sendPort == null) {
      throw StateError('Messenger is not attached to an worker');
    }

    sendPort.send(const AudioIsolateShutdownRequest());
  }

  void close() {
    detach();
    _receivePort.close();
  }
}

class AudioIsolateWorkerMessenger {
  AudioIsolateWorkerMessenger();
  final _receivePort = ReceivePort();
  SendPort? _sendPort;

  final _shutdownCompleter = Completer<AudioIsolateShutdownReason>();

  StreamSubscription<AudioIsolateHostRequest>? _requestSubscription;

  SendPort get hostToWorkerSendPort => _receivePort.sendPort;

  late final message = _receivePort
      .where((r) => r is AudioIsolateHostMessage)
      .cast<AudioIsolateHostMessage>()
      .asBroadcastStream();

  late final _requestStream = message
      .where((r) => r is AudioIsolateHostRequest)
      .cast<AudioIsolateHostRequest>()
      .asBroadcastStream();

  void attach(SendPort sendPort) {
    _sendPort = sendPort;
  }

  void detach() {
    _sendPort = null;
  }

  void onShutdownRequested(AudioIsolateShutdownRequest request) {
    _shutdownCompleter.complete(AudioIsolateShutdownReason.hostRequested);
  }

  void onWorkerFinished() {
    _shutdownCompleter.complete(AudioIsolateShutdownReason.workerFinished);
  }

  void listenRequest<TRequestPayload>(
      FutureOr<dynamic> Function(TRequestPayload) onRequest) {
    final sendPort = _sendPort;
    if (sendPort == null) {
      throw StateError('Messenger is not attached to an host');
    }

    if (_requestSubscription != null) {
      throw StateError('Messenger is already listening');
    }

    _requestSubscription = _requestStream.listen((request) async {
      try {
        final response = await onRequest(request.payload as TRequestPayload);
        sendPort.send(AudioIsolateWorkerSuccessResponse(request.id, response));
      } catch (e, stack) {
        sendPort.send(AudioIsolateWorkerFailedResponse(request.id, e, stack));
        _shutdownCompleter.completeError(e, stack);
      }
    });
  }

  Future<void> listenShutdown(
      {FutureOr<void> Function(AudioIsolateShutdownReason reason, Object? e,
              StackTrace? stackTrace)?
          onShutdown}) async {
    try {
      final reason = await _shutdownCompleter.future;
      await onShutdown?.call(reason, null, null);
    } catch (e, stack) {
      await onShutdown?.call(AudioIsolateShutdownReason.exception, e, stack);
    } finally {
      await _requestSubscription?.cancel();
      _requestSubscription = null;
    }
  }

  void close() {
    detach();
    _receivePort.close();
  }
}
