import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/chat.dart';
import '../../../domain/entities/message.dart';
import '../../../domain/usecases/get_chat_by_id.dart';
import '../../../domain/usecases/update_chat.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetChatById _getChatById;
  final UpdateChat _updateChat;

  ChatBloc({
    required GetChatById getChatById,
    required UpdateChat updateChat,
  })  : _getChatById = getChatById,
        _updateChat = updateChat,
        super(ChatLoading()) {
    on<ChatGetChat>(_onChatGetChat);
    on<ChatUpdateChat>(_onChatUpdateChat);
  }

  void _onChatGetChat(
    ChatGetChat event,
    Emitter<ChatState> emit,
  ) async {
    debugPrint('Start getting chat with: _onChatGetChat');
    Chat chat = await _getChatById(GetChatByIdParams(
      userId: event.userId,
      chatId: event.chatId,
    ));

    emit(ChatLoaded(chat: chat));
  }

  void _onChatUpdateChat(
    ChatUpdateChat event,
    Emitter<ChatState> emit,
  ) async {
    debugPrint('Start creating a message with: _onChatUpdateChat');
    if (state is ChatLoaded) {
      final state = this.state as ChatLoaded;

      Message message = Message(
        chatId: state.chat.id,
        senderId: state.chat.currentUser.id,
        recipientId: state.chat.otherUser.id,
        text: event.text,
        createdAt: DateTime.now(),
      );

      Chat chat = state.chat.copyWith(
        messages: List.from(state.chat.messages!)..add(message),
      );
      _updateChat(UpdateChatParams(chat: chat));

      emit(ChatLoaded(chat: chat));
    }
  }
}
