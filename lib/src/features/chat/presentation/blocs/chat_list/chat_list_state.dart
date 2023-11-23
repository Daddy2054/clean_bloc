part of 'chat_list_bloc.dart';

abstract class ChatListState extends Equatable {
  const ChatListState();

  @override
  List<Object> get props => [];
}

class ChatListLoading extends ChatListState {}

class ChatListLoaded extends ChatListState {
  final List<Chat> chats;

  const ChatListLoaded({this.chats = const <Chat>[]});

  @override
  List<Object> get props => [chats];
}
