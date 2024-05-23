class ChatState{}
class ChatInitialState extends ChatState{}
class ChatLoadingState extends ChatState{}
class ChatSuccessState extends ChatState{}
class ChatFailureState extends ChatState{
  final String errorMessage;
  ChatFailureState(this.errorMessage);
}