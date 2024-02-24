// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_whatsapp_clone_firebase_riverpod/features/select_contacts/repository/selct_contact_repository.dart';

final getContactsProvider = FutureProvider((ref) {
  final selctContactRepository = ref.watch(selectContactsRepositoryProvider);
  return selctContactRepository.getContacts();
});
final selectContactControllerProvider = Provider((ref) {
  final SelectContactRepository = ref.watch(selectContactsRepositoryProvider);
  return SelectContactController(
    ref: ref, selectContactReposiotry: SelectContactRepository,
  
  );
}); 

class SelectContactController {
  final ProviderRef ref;
  final SelectContactReposiotry selectContactReposiotry;
  SelectContactController( {
    required this.selectContactReposiotry,
    required this.ref,
  });
  void selectContact(Contact selctedContact, BuildContext context)  {
     selectContactReposiotry.selectContact(selctedContact, context);
  }
}
