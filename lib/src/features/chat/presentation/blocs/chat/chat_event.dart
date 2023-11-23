part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ChatGetChat extends ChatEvent {
  final String userId;
  final String chatId;

  const ChatGetChat({
    required this.userId,
    required this.chatId,
  });

  @override
  List<Object> get props => [userId, chatId];
}

class ChatUpdateChat extends ChatEvent {
  final String text;

  const ChatUpdateChat({required this.text});

  @override
  List<Object> get props => [text];
}
