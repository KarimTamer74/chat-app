part of 'chat_cubit_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitialState extends ChatState {}
final class ChatLoadingState extends ChatState {}
final class ChatFailureState extends ChatState {}
final class ChatSuccessState extends ChatState {}
