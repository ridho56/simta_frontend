import 'dart:async';
import 'dart:io';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simta1/src/routes/app_bindings.dart';

import 'src/pages/screen/login_page.dart';
import 'src/providers/check_rovider.dart';
import 'src/routes/app_pages.dart';
import 'src/widget/navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences server = await SharedPreferences.getInstance();
  await server.setString('baseUrl', "http://api2.myfin.id:6000");
  await requestPermissions();
  FirebaseMessaging.instance.getToken().then((value) => print(value));
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  const initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/logounsbaru');
  const initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    ChangeNotifierProvider(
      create: (_) => CheckProvider()..checkLoginStatus(),
      child: const MyApp(),
    ),
  );
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await showNotification(message);
}

Future<void> requestPermissions() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.camera,
    Permission.storage,
    Permission.notification,
  ].request();

  // Periksa status perizinan
  if (statuses[Permission.camera]!.isDenied ||
      statuses[Permission.storage]!.isDenied ||
      statuses[Permission.notification]!.isDenied) {
    exit(0);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: FToastBuilder(),
      // onInit: initializeService,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'), // Bahasa Inggris
        Locale('id', 'ID'), // Bahasa Indonesia
      ],
      title: 'SIMTA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
        splash: Image.asset('assets/jpg/logounsbaru.png'),
        // const SplashScreen(),
        splashIconSize: 250.0,
        nextScreen: Consumer<CheckProvider>(
          builder: (context, checkProvider, _) {
            if (checkProvider.token != null && checkProvider.isValidToken) {
              return const NavigationPage();
            } else {
              return const LoginPage();
            }
          },
        ),
        splashTransition: SplashTransition.scaleTransition,
        duration: 2000,
        animationDuration: const Duration(seconds: 1),
        curve: Curves.decelerate,
      ),
      getPages: AppPages.pages,
      initialBinding: AuthBinding(),
    );
  }
}

Future<void> showNotification(RemoteMessage message) async {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'channel_id',
    'channel_name',
    channelDescription: 'channel_description',
    importance: Importance.max,
    priority: Priority.high,
    enableLights: true,
    ledColor: Colors.purple,
    ledOnMs: 1000,
    ledOffMs: 500,
    ticker: 'ticker',
    playSound: true,
    visibility: NotificationVisibility.public,
    styleInformation: DefaultStyleInformation(
      true,
      true,
    ),
  );

  const platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );

  final title = message.notification?.title ?? 'Notification Title';
  final body = message.notification?.body ?? 'Notification Body';

  await flutterLocalNotificationsPlugin.show(
    0,
    title,
    body,
    platformChannelSpecifics,
    payload: 'notification_payload',
  );
}
