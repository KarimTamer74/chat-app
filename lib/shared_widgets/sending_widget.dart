import 'package:chatapp/models/message.dart';
import 'package:chatapp/shared_widgets/custom_sending_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SendingWidget extends StatefulWidget {
  SendingWidget({
    super.key,
  });

  @override
  State<SendingWidget> createState() => _SendingWidgetState();
}

class _SendingWidgetState extends State<SendingWidget> {
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: messages.get(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList
                .add(Message.fromjson(snapshot.data!.docs[i]['message']));
          }
          
          return CustomSendingMessage();
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
