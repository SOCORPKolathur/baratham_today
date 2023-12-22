import 'package:baratham_today/views/choose_topics_view.dart';
import 'package:baratham_today/views/home_view.dart';
import 'package:baratham_today/views/main_view.dart';
import 'package:baratham_today/views/news_detail_view.dart';
import 'package:baratham_today/views/splash_view.dart';
import 'package:baratham_today/views/verification_complete_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  //await FirebaseApi().initNotifications();
  // var delegate = await LocalizationDelegate.create(
  //     basePath: 'assets/i18n/',
  //     fallbackLocale: 'en_US',
  //     supportedLocales: ['ta','te','ml','kn','en_US','bn','hi','es','pt','fr','nl','de','it','sv']);
  // runApp(LocalizedApp(delegate, MyApp()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baratham Today',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Constants.primaryAppColor),
        useMaterial3: true,
        scaffoldBackgroundColor: Constants.appBackgroundColor,
      ),
      home: FirebaseAuth.instance.currentUser != null ? const MainView() : const SplashView(),
    );
  }
}

