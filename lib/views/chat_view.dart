import 'package:chatapp/constants/constants.dart';
import 'package:chatapp/models/message.dart';
import 'package:chatapp/shared_widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  final CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  final TextEditingController controller = TextEditingController();
  final scrollcontroller = ScrollController();

  String formattedTime = '${DateTime.now().hour}:${DateTime.now().minute}';
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;

    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kMessageTime, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(Message.fromjson(snapshot.data!.docs[i]));
            }

            return Scaffold(
              appBar: AppBar(
                backgroundColor: const Color.fromARGB(255, 4, 24, 40),
                automaticallyImplyLeading: false,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      child: Image.asset(
                        'assets/images/chatcoin-chat-logo.png',
                        scale: 50,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    const Text(
                      '  Chat',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: scrollcontroller,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        if (messagesList[index].id == email) {
                          // print(messagesList[index].createdAt);

                          return ChatBubble(
                            message: messagesList[index],
                          );
                        } else {
                          return ChatBubbleForFriend(
                            message: messagesList[index],
                          );
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      onSubmitted: (value) {
                        messages.add({
                          kMessageTitle: value,
                          kMessageTime: formattedTime,
                          'id': email,
                        });

                        controller.clear();
                        scrollcontroller.animateTo(
                            scrollcontroller.position.minScrollExtent,
                            duration: const Duration(microseconds: 500),
                            curve: Curves.easeIn);
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter your message',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.send,
                              color: Color(0xff006389),
                            )),
                      ),
                      controller: controller,
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 5,
            ),
          );
        });
  }
}
