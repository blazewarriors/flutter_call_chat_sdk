import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_call_chat_sdk/utils/app_utils.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

int id = 0;

const String portName = 'notification_send_port';

/// A notification action which triggers a App navigation event
const String navigationActionId = 'id_3';

/// Defines a iOS/MacOS notification category for text input actions.
const String darwinNotificationCategoryText = 'textCategory';

/// Defines a iOS/MacOS notification category for plain actions.
const String darwinNotificationCategoryPlain = 'plainCategory';

String? selectedNotificationPayload;

NotificationAppLaunchDetails? notificationAppLaunchDetails;

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
late final InitializationSettings initializationSettings;

/// Initializes Darwin (iOS/MacOS) settings with notification categories and permissions
DarwinInitializationSettings _initializeDarwinSettings() {
  final List<DarwinNotificationCategory> darwinNotificationCategories = _buildDarwinNotificationCategories();

  return DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
    onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {
      final Map<String, dynamic> dataNotification = json.decode(payload ?? '');
      onClickNotification(dataNotification);
    },
    notificationCategories: darwinNotificationCategories,
  );
}

/// Builds the list of notification categories for Darwin platforms (iOS/MacOS)
List<DarwinNotificationCategory> _buildDarwinNotificationCategories() {
  return [
    DarwinNotificationCategory(
      'text_category',
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.text(
          'text_1',
          'Action 1',
          buttonTitle: 'Send',
          placeholder: 'Placeholder',
        ),
      ],
    ),
    DarwinNotificationCategory(
      'plain_category',
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.plain('id_1', 'Action 1'),
        DarwinNotificationAction.plain(
          'id_2',
          'Action 2 (destructive)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.destructive,
          },
        ),
        DarwinNotificationAction.plain(
          'navigation_action',
          'Action 3 (foreground)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.foreground,
          },
        ),
        DarwinNotificationAction.plain(
          'id_4',
          'Action 4 (auth required)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.authenticationRequired,
          },
        ),
      ],
      options: <DarwinNotificationCategoryOption>{
        DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
      },
    ),
  ];
}

/// init Setting
Future<void> initSetting() async {
  // Initialize Android settings
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

  // Initialize iOS/MacOS settings
  final DarwinInitializationSettings initializationSettingsDarwin = _initializeDarwinSettings();

  // Initialize Linux settings
  final LinuxInitializationSettings initializationSettingsLinux = LinuxInitializationSettings(
    defaultActionName: 'Open notification',
    defaultIcon: AssetsLinuxIcon('icons/app_icon.png'),
  );

  // Combine all platform settings
  final initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
    macOS: initializationSettingsDarwin,
    linux: initializationSettingsLinux,
  );

  // Initialize the plugin with the settings
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: _onNotificationResponse,
    onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  );
}

/// Handles notification responses in the foreground
void _onNotificationResponse(NotificationResponse notificationResponse) {
  notificationTapForeground(notificationResponse);
}

/// Check isAndroidPermissionGranted
Future<bool> isAndroidPermissionGranted() async {
  if (Platform.isAndroid) {
    final bool granted = await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
            ?.areNotificationsEnabled() ??
        false;
    return granted;
  }
  return false;
}

/// Request Permissions for ANDROID and IOS
Future<void> requestNotificationPermissions() async {
  if (Platform.isIOS || Platform.isMacOS) {
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<MacOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  } else if (Platform.isAndroid) {
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    await androidImplementation?.requestNotificationsPermission();
  }
}

/// show Notification
Future<void> showNotification(Map<dynamic, dynamic> notificationData, Map<String, dynamic> payloadData) async {
  const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
    'channelId_notification',
    'channelName_notification',
    channelDescription: 'Kênh thông báo',
    importance: Importance.max,
    priority: Priority.high,
    fullScreenIntent: false,
    ticker: 'ticker',
    icon: 'launch_favicon',
    //sound: RawResourceAndroidNotificationSound('iphone_sound_notification'),
  );
  const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
  await flutterLocalNotificationsPlugin.show(
    id++,
    notificationData['title'] ?? '',
    notificationData['body'] ?? '',
    notificationDetails,
    payload: jsonEncode(payloadData),
  );
}

/// Handler Click Notification when app Background (App đang tắt hoặc đã bị kill)
@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  Map dataNotification = json.decode(notificationResponse.payload ?? '');
  onClickNotification(dataNotification);
}

/// Handler Click Notification when app Foreground (App đang mở)
void notificationTapForeground(NotificationResponse notificationResponse) {
  Map dataNotification = json.decode(notificationResponse.payload ?? '');
  onClickNotification(dataNotification);
}

void onClickNotification(Map dataNotification) {
  var infoNotify = dataNotification['info'];
  var response = jsonDecode(infoNotify);
  final String fCMType = response['fcmType'] ?? '';

  if (fCMType.isNotEmpty) {
    if (fCMType == 'General') {
      //   if (notificationId.isNotEmpty) {
      //     Get.toNamed(AppRoutes.notificationDetailScreen, arguments: {'notificationId': notificationId});
      //   }
      // } else if (fCMType == 'Review') {
      //   if (placeId.isNotEmpty) {
      //     Get.toNamed(AppRoutes.placeDetailScreen, arguments: {'placeId': placeId});
      //   }
      // } else if (fCMType == 'PushPromotion') {
      //   if (servicePromotionId.isNotEmpty) {
      //     Get.toNamed(AppRoutes.promotionDetailScreen, arguments: {'servicePromotionId': servicePromotionId, 'isHideButton': false});
      //   }
      // } else if (fCMType == 'PushProduct') {
      //   if (serviceProductId.isNotEmpty) {
      //     Get.toNamed(AppRoutes.productDetailScreen, arguments: {'serviceProductId': serviceProductId});
      //   }
    }
  }
}

/// Receive and display notifications when the app is in the foreground
Future<void> foregroundMessageHandler() async {
  initSetting();
  if (Platform.isIOS) {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage) async {
    if (remoteMessage == null) {
      return;
    }
    Map<dynamic, dynamic> notificationData = remoteMessage.data;
    log('foreground: ${remoteMessage.notification?.title} : $notificationData');
    if (!isNullEmpty(notificationData['type']) && notificationData['type'] == "BACKEND_MESSAGE") {
      if (!isNullEmpty(notificationData['info'])) {
        var info = jsonDecode(notificationData['info']);
        if (!isNullEmpty(info['fcmType'])) {
          if (info['fcmType'] == "START_CALL") {
            if (Platform.isAndroid) {
              final extra = info["data"];
              if (!isNullEmpty(extra)) {
                // CallInfo? callInfo = CallInfo.fromJson(extra);
                // log('foreground: ${callInfo.toJson()}');
                // showCallkitIncoming(callInfo);
              }
            }
          }
        } else {
          showNotification(notificationData, remoteMessage.data);
        }
      } else {
        showNotification(notificationData, remoteMessage.data);
      }
    }
  });
}

/// Receive and display notifications when the app is off (background) or has been killed
@pragma('vm:entry-point')
Future<void> backgroundMessageHandler(RemoteMessage? remoteMessage) async {
  initSetting();
  if (remoteMessage == null) {
    return;
  }
  Map<dynamic, dynamic> notificationData = remoteMessage.data;
  log('background: ${remoteMessage.notification?.title} : $notificationData');
  if (!isNullEmpty(notificationData['type']) && notificationData['type'] == "BACKEND_MESSAGE") {
    if (!isNullEmpty(notificationData['info'])) {
      var info = jsonDecode(notificationData['info']);
      if (!isNullEmpty(info['fcmType'])) {
        if (info['fcmType'] == "START_CALL") {
          if (Platform.isAndroid) {
            final extra = info["data"];
            if (!isNullEmpty(extra)) {
              // CallInfo? callInfo = CallInfo.fromJson(extra);
              // log('background: ${callInfo.toJson()}');
              // showCallkitIncoming(callInfo);
              // listenerEvent((CallEvent event) async {
              //   // Nếu android từ chối cuộc gọi lúc app skill, lúc app skill thì hubCall == null chưa được khởi tạo
              //   if (event.event == Event.actionCallDecline) {
              //     log('background: actionCallDecline');
              //     var userName = await LocalData.getUserName();
              //     if (userName.isNotEmpty) {
              //       await SignalService.instance.init(callerId: userName);
              //       var hubConnection = SignalService.instance.hubCall;
              //       await hubConnection?.invoke("AnswerCall", args: <Object>[
              //         false,
              //         callInfo.caller!.toJson(),
              //         callInfo.receiver!.toJson(),
              //       ]);
              //     }
              //   }
              // });
            }
          }
        } else {
          showNotification(notificationData, remoteMessage.data);
        }
      } else {
        showNotification(notificationData, remoteMessage.data);
      }
    } else {
      showNotification(notificationData, remoteMessage.data);
    }
  }
}
