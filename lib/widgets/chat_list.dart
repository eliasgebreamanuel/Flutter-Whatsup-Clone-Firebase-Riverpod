import 'package:flutter/material.dart';
import 'package:flutter_whatsapp_clone_firebase_riverpod/info.dart';
import 'package:flutter_whatsapp_clone_firebase_riverpod/widgets/my_message_card.dart';
import 'package:flutter_whatsapp_clone_firebase_riverpod/widgets/sender_message_cart.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
      if(messages[index]['isMe'] == true) {
        return MyMessageCard(message: messages[index]['text'].toString(), date: messages[index]['time'].toString());
      }
      return SenderMessageCard(message:  messages[index]['text'].toString(), date: messages[index]['time'].toString());
    }
    );
  }
}