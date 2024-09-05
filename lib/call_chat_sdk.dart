import 'package:flutter_call_chat_sdk/services/signalR_service_call.dart';
import 'package:flutter_call_chat_sdk/services/signalR_service_chat.dart';

abstract class ICallChatSDK {
  void setServerUrlCall(String url);
  String getServerUrlCall();
  void setServerUrlChat(String url);
  String getServerUrlChat();
  Future<void> initSignalRService({required String callerId, required String tokenFCM, required String tokenVoIP});
}

class CallChatSDK implements ICallChatSDK {
  static String _serverUrlCall = "";
  static String _serverUrlChat = "";

  @override
  void setServerUrlCall(String url) {
    _serverUrlCall = url;
  }

  @override
  String getServerUrlCall() {
    return _serverUrlCall;
  }

  @override
  void setServerUrlChat(String url) {
    _serverUrlChat = url;
  }

  @override
  String getServerUrlChat() {
    return _serverUrlChat;
  }

  @override
  Future<void> initSignalRService({required String callerId, required String tokenFCM, required String tokenVoIP}) async {
    await SignalRServiceChat.instance.init(callerId: callerId, tokenFCM: tokenFCM, tokenVoIP: tokenVoIP);
    await SignalRServiceCall.instance.init(callerId: callerId, tokenFCM: tokenFCM, tokenVoIP: tokenVoIP);
  }
}
