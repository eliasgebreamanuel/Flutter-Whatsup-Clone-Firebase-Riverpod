import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_whatsapp_clone_firebase_riverpod/common/utils/utils.dart';
import 'package:flutter_whatsapp_clone_firebase_riverpod/models/user_model.dart';

final selectContactsRepositoryProvider = Provider(
  (ref) => SelectContactReposiotry(firestore: FirebaseFirestore.instance)

);


class SelectContactReposiotry {
  final FirebaseFirestore firestore;

  SelectContactReposiotry({
    required this.firestore,

  });

 Future<List<Contact>> getContacts() async {
    List<Contact> contacts = [];
    try {
      if(await FlutterContacts.requestPermission()) {
       contacts = await FlutterContacts.getContacts(withProperties: true); 
      }
    }catch(e) {
      debugPrint(e.toString());
    }
    return contacts;
  }
  void selectContact(Contact selctedContact, BuildContext context) async {
    try {
      var userCollection = await firestore.collection('users').get();
      bool isFound = false;

      for(var document in userCollection.docs) {
        var userData = UserModel.fromMap(document.data());
        print(selctedContact.phones[0].number);
      }
    }catch(e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

}