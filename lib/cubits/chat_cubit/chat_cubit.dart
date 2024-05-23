import 'package:chatapp/constants/constants.dart';
import 'package:chatapp/cubits/chat_cubit/chat_state.dart';
import 'package:chatapp/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitialState());
  final CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  void sendMessage(
      {required String message,
      required Object email,
      required String messageTime}) {
    messages.add({
      kMessageTitle: message,
      kMessageTime: messageTime,
      kMessageId: email,
    });
  }

  void getMessage() {
    messages
        .orderBy(kMessageTime, descending: true)
        .snapshots()
        .listen((event) {
      List<Message> messagesList = [];
      for (var doc in event.docs) {
        messagesList.add(Message.fromjson(doc));
      }
      emit(ChatSuccessState(messagesList: messagesList));
    });
  }
}
