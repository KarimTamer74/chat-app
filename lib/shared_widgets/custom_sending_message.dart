import 'package:chatapp/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomSendingMessage extends StatelessWidget {
  CustomSendingMessage({
    super.key,
  });
 final TextEditingController controller = TextEditingController();
 final CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        onSubmitted: (value) {
          messages.add({kMessageTitle: value, kMessageTime: DateTime.now()});

          controller.clear();
        },
        decoration: InputDecoration(
          hintText: 'Enter your message',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.send,
                color: Color(0xff006389),
              )),
        ),
        controller: controller,
      ),
    );
  }
}
