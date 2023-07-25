import 'package:android_freelance_2/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../main.dart';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  print('recived');
}

class NotificationsController {
  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    void onDidReceiveNotificationResponse(
        NotificationResponse notificationResponse) async {}

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(onDidReceiveLocalNotification: null);

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
        onDidReceiveBackgroundNotificationResponse: notificationTapBackground);
  }

  // TODO -- change channel details
  static Future showBigTextNotification(
      {var id = 0,
      required String title,
      required String body,
      required Duration delay,
      var payload,
      required FlutterLocalNotificationsPlugin fln}) async {
    await fln.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.now(tz.local).add(delay),
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'android_freelance_2_channel', 'your channel name',
              channelDescription: 'your channel description'),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  static void cancelAll() async {
    await flutterLocalNotificationsPlugin.cancelAll();
    debugPrint('Notification is canceled');
  }

  // Init settings and start notification
  static void startNotifications(List<int> secondDelay) async {
    int i = 0;
    for (final element in secondDelay) {
      NotificationsController.showBigTextNotification(
          id: i,
          title: AppStrings.notificationTitle,
          body: AppStrings.notificationDescription,
          delay: Duration(seconds: element),
          fln: flutterLocalNotificationsPlugin);
      i++;
      debugPrint('NOTIFICATION CREATED');
    }
  }
}
