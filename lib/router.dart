import 'package:flutter/material.dart';
import 'package:flutter_whatsapp_clone_firebase_riverpod/common/widgets/error.dart';
import 'package:flutter_whatsapp_clone_firebase_riverpod/features/auth/screens/login_screen.dart';
import 'package:flutter_whatsapp_clone_firebase_riverpod/features/auth/screens/otp_screen.dart';
import 'package:flutter_whatsapp_clone_firebase_riverpod/features/auth/screens/user_information_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch(settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case OTPScreen.routeName:
      final verificationId = settings.arguments as String;
      return MaterialPageRoute(builder: (context) =>  OTPScreen(
        verificationId: verificationId,
      ));
    case UserInformationScreen.routeName:
      return MaterialPageRoute(builder: (context) => const UserInformationScreen());
    default:
      return MaterialPageRoute(builder: (context) => const Scaffold(
        body: ErrorScreen(error: 'This page doesn\'t exist')
      ));
  }
}