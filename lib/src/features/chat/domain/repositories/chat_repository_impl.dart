
import 'package:flutter/foundation.dart';

import '../../data/datasources/local_chat_datasource.dart';
import '../../data/datasources/mock_chat_datasource.dart';
import '../../domain/entities/chat.dart';
import '../../domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final MockChatDatasource chatDatasource;
  final LocalChatDatasource localChatDatasource;

  ChatRepositoryImpl(
    this.chatDatasource,
    this.localChatDatasource,
  );

  @override
  Future<Chat> getChatsById(String userId, String chatId) async {
    // TODO: Check for updates from remote database;
    Chat? chat = await localChatDatasource.getChatById(chatId);
    if (chat == null) {
      return chatDatasource.getChatById(userId, chatId);
    } else {
      debugPrint('We\'re using our local data source');
      return chat;
    }
  }

  @override
  Future<List<Chat>> getChatsByUser(String userId) async {
    if ((await localChatDatasource.getChats()).isEmpty) {
      List<Chat> chats = await chatDatasource.getChatsByUser(userId);
      for (final chat in chats) {
        localChatDatasource.addChat(chat);
      }
      return chats;
    } else {
      debugPrint('We\'re using our local data source');
      return localChatDatasource.getChats();
    }
  }

  @override
  Future<void> updateChat(Chat chat) {
    // TODO: Update the chat in the remote database.
    return localChatDatasource.updateChat(chat);
  }
}
