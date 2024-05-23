import 'package:chatapp/models/message.dart';

class ChatState {}

class ChatInitialState extends ChatState {}

class ChatLoadingState extends ChatState {}

class ChatSuccessState extends ChatState {
  List<Message> messagesList;
  ChatSuccessState({required this.messagesList});
}

class ChatFailureState extends ChatState {
  final String errorMessage;
  ChatFailureState(this.errorMessage);
}
