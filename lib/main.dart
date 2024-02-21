import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_whatsapp_clone_firebase_riverpod/colors.dart';
import 'package:flutter_whatsapp_clone_firebase_riverpod/features/landing/screens/landing_screen.dart';
import 'package:flutter_whatsapp_clone_firebase_riverpod/firebase_options.dart';
import 'package:flutter_whatsapp_clone_firebase_riverpod/responsive/responsive_layout.dart';
import 'package:flutter_whatsapp_clone_firebase_riverpod/router.dart';
import 'package:flutter_whatsapp_clone_firebase_riverpod/screens/mobile_screen_layout.dart';
import 'package:flutter_whatsapp_clone_firebase_riverpod/screens/web_screen_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Whatsup Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: const AppBarTheme(
          color: appBarColor
        )
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const LandingScreen()
      //  ResponsiveLayout(mobileScreenLayout: MobileScreenLayout(), webScreenLayout: WebScreenLayout(),)
    );
  }
}
