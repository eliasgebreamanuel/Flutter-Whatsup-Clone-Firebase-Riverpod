// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_whatsapp_clone_firebase_riverpod/common/utils/utils.dart';
import 'package:flutter_whatsapp_clone_firebase_riverpod/features/auth/screens/otp_screen.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  AuthRepository({
    required this.auth,
    required this.firestore,
  });

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await auth.verifyPhoneNumber(phoneNumber: phoneNumber,verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      }, verificationFailed: (e) {
        throw Exception(e.message);
      }, codeSent: ((String verificationId, int? resendToken) async {
        Navigator.pushNamed(context, OTPScreen.routeName, arguments: verificationId);
      }), codeAutoRetrievalTimeout: (String verificationId) {});
    } on FirebaseAuthException catch (e){
      showSnackBar(context: context, content: e.message!);
    }
  }
}