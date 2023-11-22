import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/entities/chat.dart';
import '../models/chat_model.dart';

abstract class LocalChatDatasource {
  Future<List<Chat>> getChats();
  Future<Chat?> getChatById(String chatId);
  Future<void> addChat(Chat chat);
  Future<void> updateChat(Chat chat);
}

class LocalChatDatasourceImpl implements LocalChatDatasource {
  String boxName = 'chats';
  Type boxType = ChatModel;

  @override
  Future<void> addChat(Chat chat) async {
    Box box = await _openBox();
    await box.put(chat.id, ChatModel.fromEntity(chat));
  }

  @override
  Future<Chat?> getChatById(String chatId) async {
    Box box = await _openBox();
    ChatModel? chatModel = box.get(chatId);
    return (chatModel == null) ? null : chatModel.toEntity();
  }

  @override
  Future<List<Chat>> getChats() async {
    Box<ChatModel> box = await _openBox() as Box<ChatModel>;
    return box.values.toList().map((chat) => chat.toEntity()).toList();
  }

  @override
  Future<void> updateChat(Chat chat) async {
    Box<ChatModel> box = await _openBox() as Box<ChatModel>;
    await box.put(chat.id, ChatModel.fromEntity(chat));
  }

  Future<Box> _openBox() async {
    return Hive.openBox<ChatModel>(boxName);
  }
}
