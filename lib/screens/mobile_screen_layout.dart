import 'package:flutter/material.dart';
import 'package:flutter_whatsapp_clone_firebase_riverpod/colors.dart';
import 'package:flutter_whatsapp_clone_firebase_riverpod/features/select_contacts/screens/select_contact_screen.dart';
import 'package:flutter_whatsapp_clone_firebase_riverpod/widgets/contacts_list.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(length: 3, child: Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          elevation: 0,
          title: const Text(
            "Whatsup", style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )
          ),
          centerTitle: false,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search, color: Colors.grey)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert, color: Colors.grey))
          ],
          bottom: const TabBar(
            indicatorColor: tabColor,
            indicatorWeight: 4,
            labelColor: tabColor,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold
            ),
            tabs: [
              Tab(text: 'Chats'),
              Tab(text: 'Status'),
              Tab(text: 'Calls')
            ]
          ),
        ),
        body: ContactsList(),
        floatingActionButton: FloatingActionButton(onPressed: () {
          Navigator.pushNamed(context, SelectContactsScreen.routeName); 
        },
          backgroundColor: tabColor,
          child: const Icon(Icons.comment, color: Colors.white)
        ),
      )),
    );
  }
}