import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/chat.dart';
import '../../../domain/usecases/get_chats_by_user.dart';

part 'chat_list_event.dart';
part 'chat_list_state.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  final GetChatsByUser _getChatsByUser;
  ChatListBloc({required GetChatsByUser getChatsByUser})
      : _getChatsByUser = getChatsByUser,
        super(ChatListLoading()) {
    on<ChatGetChats>(_onChatGetChats);
  }

  void _onChatGetChats(
    ChatGetChats event,
    Emitter<ChatListState> emit,
  ) async {
    debugPrint('Start getting chats with _onChatGetChats');

    List<Chat> chats = await _getChatsByUser(
      GetChatsByUserParams(userId: event.userId),
    );

    chats.map((chat) {
      chat.messages!.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    });

    emit(ChatListLoaded(chats: chats));
  }
}
