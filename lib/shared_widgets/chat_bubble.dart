import 'package:chatapp/models/message.dart';
import 'package:flutter/material.dart';

//0xff006389
class ChatBubble extends StatelessWidget {
  ChatBubble({super.key, required this.message});
  // final Timestamp time;
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            padding: EdgeInsets.all(13),
            decoration: BoxDecoration(
                color: Color(0xff006389),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25))),
            child: Text(
              message.message!,
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubbleForFriend extends StatelessWidget {
  ChatBubbleForFriend({super.key, required this.message});

  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        padding: EdgeInsets.all(13),
        decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                topLeft: Radius.circular(25),
                bottomLeft: Radius.circular(25))),
        child: Text(
          message.message!,
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
    );
  }
}
