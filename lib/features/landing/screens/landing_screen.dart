import 'package:flutter/material.dart';
import 'package:flutter_whatsapp_clone_firebase_riverpod/colors.dart';
import 'package:flutter_whatsapp_clone_firebase_riverpod/common/widgets/custom_button.dart';
import 'package:flutter_whatsapp_clone_firebase_riverpod/features/auth/screens/login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});
  void navigateToLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, LoginScreen.routeName);
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 50,),
        const Text('Welcome to Whatsup', style: TextStyle(fontSize: 33, fontWeight: FontWeight.w600)),
        SizedBox(height: size.height / 9,),
        Image.asset('assets/bg.png', height: 340, width: 340,color: tabColor),
        SizedBox(height: size.height / 9,),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: const Text("Read out Privacy Policy. Tap \"Agree and continue \" to accept the Terms of Services", style: TextStyle(color: greyColor), textAlign: TextAlign.center,),
        ),
        const SizedBox(height: 10,),
        SizedBox(
          width: size.width*0.75,
          child: CustomButton(text: 'AGREE AND CONTINUE', onPressed: () => navigateToLoginScreen(context),))
      ],
      )),
    );
  }
}