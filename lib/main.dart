import 'package:android_freelance_2/notifications/notifications_controller.dart';
import 'package:android_freelance_2/screens/on_boarding_screen/on_boarding_screen.dart';
import 'package:android_freelance_2/screens/preloader_screen/preloader_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;

late bool isFirstRun;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  // Portrait orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  // Time zone init
  tz.initializeTimeZones();

  // permission for Android
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.requestPermission();

  // Notification init
  NotificationsController.initialize(flutterLocalNotificationsPlugin)
      .then((value) {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  });

  // Cancel all notification
  NotificationsController.cancelAll();

  // Check on first run app
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isFirstRun = prefs.getBool('isFirstRun') ?? true;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const PreloaderScreen(),
      // home: const OnBoardingScreen(),
    );
  }
}
