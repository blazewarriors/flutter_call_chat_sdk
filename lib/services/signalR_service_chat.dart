import 'dart:io';

import 'package:flutter_call_chat_sdk/call_chat_sdk.dart';
import 'package:flutter_call_chat_sdk/utils/app_utils.dart';
import 'package:signalr_core/signalr_core.dart';

class SignalRServiceChat {
  HubConnection? hubChat;

  SignalRServiceChat._();
  static final instance = SignalRServiceChat._();

  CallChatSDK callChatSDK = CallChatSDK();

  Future<void> init({required String callerId, required String tokenFCM, required String tokenVoIP}) async {
    if (hubChat == null) {
      hubChat = _createHubConnection(callChatSDK.getServerUrlChat());
      await _startHubConnection(hubChat!);
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
      await hubChat?.invoke("JoinServerChat", args: [callerId, platform, tokenFCM, tokenVoIP]);
      log("Joined server with ID: $callerId");
    } catch (e) {
      log("Failed to join server: $e");
    }
  }

  Future<void> start() async {
    await _startHubConnection(hubChat!);
  }

  Future<void> destroy() async {
    await hubChat?.stop();
    log("SignalR connections stopped.");
  }
}
