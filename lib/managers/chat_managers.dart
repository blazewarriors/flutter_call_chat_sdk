import 'dart:io';

import 'package:flutter_call_chat_sdk/models/list_user_call_chat.dart';
import 'package:flutter_call_chat_sdk/services/signalR_service_chat.dart';
import 'package:flutter_call_chat_sdk/utils/app_utils.dart';

typedef UpdateListConversationCallback = void Function(List<dynamic> args);

class ChatManagers {
  final TAG = "ChatManagers";

  final _hubConnection = SignalRServiceChat.instance.hubChat;

  void onCloseConnectionChat() {
    _hubConnection?.off("UpdateListConversation");
    _hubConnection?.off("JoinRoom");
    _hubConnection?.off("UpdateListMessage");
    _hubConnection?.off("SendMessage");
    _hubConnection?.off("DeleteRoom");
  }

  /// [SignalR] Get a list of chat conversations
  void updateListConversation(List<dynamic>? args) {
    log("$TAG ===> UpdateListConversation: $args");
    if (args != null) {
      log("$TAG ===> UpdateListConversation: $args");
    }
  }

  /// [SignalR] Join a conversation
  void joinRoom(List<dynamic>? args) {
    if (args != null) {
      log("$TAG ===> JoinRoom: $args");
    }
  }

  /// [SignalR] Update chat content
  void updateListMessage(List<dynamic>? args) {
    if (args != null) {
      log("$TAG ===> UpdateListMessage: $args");
    }
  }

  /// [SignalR] Send message
  void sendMessage(List<dynamic>? args) {
    if (args != null) {
      log("$TAG ===> SendMessage: $args");
    }
  }

  /// [SignalR] Delete Conversation
  void deleteRoom(List<dynamic>? args) {
    if (args != null) {
      log("$TAG ===> DeleteRoom: $args");
    }
  }

  Future<void> openConnection(String callerId, String tokenFCM, String tokenVoIP) async {
    // Register SignalR event handlers
    _hubConnection?.on('UpdateListConversation', updateListConversation);
    _hubConnection?.on('JoinRoom', joinRoom);
    _hubConnection?.on('UpdateListMessage', updateListMessage);
    _hubConnection?.on('SendMessage', sendMessage);
    _hubConnection?.on('DeleteRoom', deleteRoom);

    // Join the server
    String platform = Platform.isIOS
        ? "IOS"
        : Platform.isAndroid
            ? "ANDROID"
            : "UNKNOWN";
    log("JoinServerChat: $callerId, $platform, $tokenFCM, $tokenVoIP");
    UserCallChat userCallChat = UserCallChat(userKey: callerId, userName: callerId, platform: platform, tokenFCM: tokenFCM, tokenVoIP: tokenVoIP);
    await _hubConnection?.invoke("JoinServerChat", args: <Object>[userCallChat.toJson()]);
  }
}
