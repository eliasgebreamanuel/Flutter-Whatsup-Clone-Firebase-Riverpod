import 'package:flutter/material.dart';
import 'package:flutter_whatsapp_clone_firebase_riverpod/widgets/contacts_list.dart';
import 'package:flutter_whatsapp_clone_firebase_riverpod/widgets/web_profile_bar.dart';

class WebScreenLayout extends StatelessWidget {
  const WebScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  WebProfileBar(),
                  ContactsList()
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            decoration: const BoxDecoration(
              image: DecorationImage(
               image: AssetImage('assets/backgroundImage.png'),
               fit: BoxFit.cover 
              )
            ),
          )
        ],
      )
    );
  }
}