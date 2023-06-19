import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
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
  await server.setString('baseUrl', "http://api.myfin.id:6000");
  runApp(
    ChangeNotifierProvider(
      create: (_) => CheckProvider()..checkLoginStatus(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: FToastBuilder(),
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
        splash: Image.asset('assets/jpg/LogoUns.png'),
        // const LandingPage(),
        splashIconSize: 270.0,
        nextScreen: Consumer<CheckProvider>(
          builder: (context, checkProvider, _) {
            if (checkProvider.token != null) {
              return const NavigationPage();
            } else {
              return const LoginPage();
            }
          },
        ),
        splashTransition: SplashTransition.scaleTransition,
        pageTransitionType: PageTransitionType.rightToLeft,
        duration: 2000,
        animationDuration: const Duration(seconds: 1),
        curve: Curves.decelerate,
      ),
      getPages: AppPages.pages,
      initialBinding: AuthBinding(),
    );
  }
}
