import 'package:equatable/equatable.dart';
import 'package:example/constants/constants_color.dart';
import 'package:example/data/provider/local_data.dart';
import 'package:example/utils/app_utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_call_chat_sdk/call_chat_sdk.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  // Initialize the SignalR service.
  final callChatSDK = CallChatSDK();

  /// Initializes the [MainBloc] with the initial state [MainInitial].
  MainBloc() : super(MainInitial()) {
    on<InitializeMain>(_initializeMain);
    on<FetchNewTokenEvent>(_fetchNewToken);
  }

  /// Handles the [InitializeMain] event.
  Future<void> _initializeMain(
    InitializeMain event,
    Emitter<MainState> emit,
  ) async {
    try {
      String fcmToken = await FirebaseMessaging.instance.getToken() ?? '';
      log('$TAG ===> FcmToken: $fcmToken');
      LocalData.setTokenFCM(fcmToken);

      String tokenFCM = await LocalData.getTokenFCM();
      String tokenVoIP = await LocalData.getTokenVoIP();
      await callChatSDK.initSignalRService(callerId: "Thien", tokenFCM: tokenFCM, tokenVoIP: tokenVoIP);
    } catch (e) {
      log("$TAG ===> $e");
    }
  }

  /// Handles the [FetchNewTokenEvent] event.
  Future<void> _fetchNewToken(
    FetchNewTokenEvent event,
    Emitter<MainState> emit,
  ) async {
    try {
      FirebaseMessaging.instance.onTokenRefresh.listen(
        (token) async {
          log("$TAG ===> Refresh FcmToken: $token");
          LocalData.setTokenFCM(token);
        },
      );
    } catch (e) {
      log("$TAG ===> $e");
    }
  }
}
