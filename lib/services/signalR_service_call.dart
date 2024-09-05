import 'dart:io';

import 'package:flutter_call_chat_sdk/call_chat_sdk.dart';
import 'package:flutter_call_chat_sdk/utils/app_utils.dart';
import 'package:signalr_core/signalr_core.dart';

class SignalRServiceCall {
  HubConnection? hubCall;

  SignalRServiceCall._();
  static final instance = SignalRServiceCall._();

  CallChatSDK callChatSDK = CallChatSDK();

  Future<void> init({required String callerId, required String tokenFCM, required String tokenVoIP}) async {
    if (hubCall == null) {
      hubCall = _createHubConnection(callChatSDK.getServerUrlCall());
      await _startHubConnection(hubCall!);
    }

    await _joinServer(callerId: callerId, tokenFCM: tokenFCM, tokenVoIP: tokenVoIP);
  }

  HubConnection _createHubConnection(String url) {
    return HubConnectionBuilder()
        .withUrl(
          url,
          HttpConnectionOptions(
            logging: (level, message) => log(message),
          ),
        )
        .build()
      ..serverTimeoutInMilliseconds = 10 * 60 * 60 * 1000
      ..keepAliveIntervalInMilliseconds = 10 * 60 * 60 * 1000
      ..onclose((Exception? error) {
        log("SignalR Connection Closed: $url");
      });
  }

  Future<void> _startHubConnection(HubConnection hub) async {
    try {
      await hub.start();
      log("Hub connection started: ${hub.connectionId}");
    } catch (e) {
      log("Failed to start hub connection: $e");
    }
  }

  Future<void> _joinServer({required String callerId, required String tokenFCM, required String tokenVoIP}) async {
    String platform = Platform.isIOS
        ? "IOS"
        : Platform.isAndroid
            ? "ANDROID"
            : "UNKNOWN";

    try {
      await hubCall?.invoke("JoinServerCall", args: [callerId, platform, tokenFCM, tokenVoIP]);
      log("Joined server with ID: $callerId");
    } catch (e) {
      log("Failed to join server: $e");
    }
  }

  Future<void> start() async {
    await _startHubConnection(hubCall!);
  }

  Future<void> destroy() async {
    await hubCall?.stop();
    log("SignalR connections stopped.");
  }
}
