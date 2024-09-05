import 'dart:io';

import 'package:example/constants/app_constants.dart';
import 'package:example/data/provider/local_data.dart';
import 'package:example/routes/app_routes.dart';
import 'package:example/utils/app_utils.dart';
import 'package:example/utils/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_call_chat_sdk/managers/notifications/local_notifications_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_call_chat_sdk/call_chat_sdk.dart';

Future<void> initChatCallSDK() async {
  final callChatSDK = CallChatSDK();
  callChatSDK.setServerUrlCall(CALL_URL_SERVER);
  callChatSDK.setServerUrlChat(CHAT_URL_SERVER);

  final userName = await LocalData.getUserName();
  //if (userName.isNotEmpty) {
  String tokenFCM = await LocalData.getTokenFCM();
  String tokenVoIP = await LocalData.getTokenVoIP();
  await callChatSDK.initSignalRService(callerId: userName, tokenFCM: tokenFCM, tokenVoIP: tokenVoIP);
  //}
}

void mainDelegate() async {
  try {
    // Firebase mesage
    WidgetsFlutterBinding.ensureInitialized();
    if (Platform.isAndroid) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } else {
      await Firebase.initializeApp();
    }
    await Firebase.initializeApp().whenComplete(() {
      FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
      foregroundMessageHandler();
    });

    /// Initialize the [ChatCallSDK].
    initChatCallSDK();
  } catch (e) {
    log(e.toString());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp],
    );
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'Arial'),
          initialRoute: AppRoutes.mainScreen,
          routes: AppRoutes.routes,
        );
      },
    );
  }
}

void main() {
  // BuildConstants.setEnvironment(Environment.dev);
  mainDelegate();
}
