// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_whatsapp_clone_firebase_riverpod/common/repositories/common_firebase_storage_repositories.dart';
import 'package:flutter_whatsapp_clone_firebase_riverpod/common/utils/utils.dart';
import 'package:flutter_whatsapp_clone_firebase_riverpod/features/auth/screens/otp_screen.dart';
import 'package:flutter_whatsapp_clone_firebase_riverpod/features/auth/screens/user_information_screen.dart';
import 'package:flutter_whatsapp_clone_firebase_riverpod/models/user_model.dart';
import 'package:flutter_whatsapp_clone_firebase_riverpod/screens/mobile_screen_layout.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  AuthRepository({
    required this.auth,
    required this.firestore,
  });
  Future<UserModel?> getCurrentUserData() async {
    var userData = await firestore.collection('users').doc(auth.currentUser?.uid).get();
    UserModel? user;
    if(userData.data() !=  null) {
      user = UserModel.fromMap(userData.data()!);
    }
    return user;
  }
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

  void verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String userOTP
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: userOTP);
      await auth.signInWithCredential(credential);
      Navigator.pushNamedAndRemoveUntil(context, UserInformationScreen.routeName, (route) => false);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message!);
    }
  }

  void saveUserDataToFirebase({
    required String name,
    required File? profilePic,
    required ProviderRef ref,
    required BuildContext context
  }) async {
    try {
      String uid = auth.currentUser!.uid;
      String photoUrl = 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAJQAnQMBIgACEQEDEQH/xAAaAAEAAgMBAAAAAAAAAAAAAAAABAUBAgMH/8QAMBABAAIBAgQEBQIHAQAAAAAAAAECAwQREiExYQUiUXETM0FCUnKhIyQygZGx0RX/xAAUAQEAAAAAAAAAAAAAAAAAAAAA/8QAFBEBAAAAAAAAAAAAAAAAAAAAAP/aAAwDAQACEQMRAD8A9RAAAAAABpkyY8cfxLxX3BuIs6/DE8uKfaGP/Qw+l/8AAJYjV1uCetpj3rLvjvTJG9LRaO0g2AAAAAAAAAAAAaZMlcdZtedobqjU5pzZN/tjpAOmbW3vvGPy1/dFneZ3mZmfUADYANma2mluKk7SwAs667DwxvPP68pdsWbHljfHbdTOumyzhyxb7Z5THYFwEdgAAAAAAAAHLVW4dPkntsp1p4hP8rb3j/aqgGQAAAAAAAW+jtx6bHM9dtpdkTw2d9Pt6WlLAAAAAAAABG8R56W3vCqhcauk5NNese6oAAAAAAAABYeGfKv+pNRPDa7YJn8rTKWAAAAAAAADjqs3wMcWiOKZnbZU2nzTPrPRY+I1308TH22jdWgAAAAAAMxtvz327MALnBwThr8P+nbk6OOjjh01I7buwAAAAAAAANM1PiYb19Y5KXbaV6r9Xpa46Wy1mevT0BCAAAAAAZrHFeK+ssSm6LTVmK5ptO8TPIE+I4axEdI5MgAAAAAAAAA1yUjJjtS3SY2bAKS9Zpaa26xOzVM8Sptlrf8AKOaGAAAADNY4rRWOszsucVPhY60j6QrvDqRbUbz9tZlaAAAAAAAAAAAAAg+KT5ccd5QErxG8WzRWPtj90UAAAAEzwv5uT9MLFVaHLFM+08otG2/91qAAAAAAAAAOObUYsPK1t7fjHOUHNrMuTeK+SvYE7NqMWHle3m9I6oWbXXtyxxwR6/VF25gHXnPUAAAAADZIw6zJi8s+evpKOAtMetw36zNZ7pETExvExMdlFs3x3vjnelprPYF2K/D4havzq7x616puPJTJXelot7A3AAlD1+a+OIpSduLrP1AFd3AAAAAAAAAAAAAAZra1LcVLTE+sMALXR5rZsW99t4+rv/wAf//Z';

    if(profilePic != null) {
      photoUrl = await ref.read(commonFirebaseStorageRepositoryProvider).storeFileToFirebase('profilePic/$uid', profilePic);
    }
    var user = UserModel(name: name, uid: uid, profilePic: photoUrl, isOnline: true, phoneNumber: auth.currentUser!.uid, groupId: []);
    await firestore.collection('users').doc(uid).set(user.toMap());
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MobileScreenLayout()), (route) => false);
    } catch(e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
