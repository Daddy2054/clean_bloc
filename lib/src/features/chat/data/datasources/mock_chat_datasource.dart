import '../../../../shared/data/datasources/chat_data.dart';
import '../../../../shared/data/datasources/user_data.dart';
import '../../domain/entities/chat.dart';
import '../models/chat_model.dart';

abstract class MockChatDatasource {
  Future<List<Chat>> getChatsByUser(String userId);
  Future<Chat> getChatById(String userId, String chatId);
  Future<void> updateChat(Chat chat);
}

class MockChatDatasourceImpl implements MockChatDatasource {
  @override
  Future<List<Chat>> getChatsByUser(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    return chats
        .where(
      (chat) => (chat['userIds'] as List).contains(userId),
    )
        .map((chat) {
      String currentUserId = userId;
      String otherUserId =
          (chat['userIds'] as List).where((id) => id != currentUserId).first;

      Map<String, dynamic> currentUser =
          users.where((user) => user['id'] == currentUserId).first;
      Map<String, dynamic> otherUser =
          users.where((user) => user['id'] == otherUserId).first;

      return ChatModel.fromJson(
        chat,
        currentUser,
        otherUser,
      ).toEntity();
    }).toList();
  }

  @override
  Future<Chat> getChatById(String userId, String chatId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    return chats
        .where(
      (chat) => chat['id'] == chatId,
    )
        .map((chat) {
      String currentUserId = userId;
      String otherUserId =
          (chat['userIds'] as List).where((id) => id != currentUserId).first;

      Map<String, dynamic> currentUser =
          users.where((user) => user['id'] == currentUserId).first;
      Map<String, dynamic> otherUser =
          users.where((user) => user['id'] == otherUserId).first;

      return ChatModel.fromJson(
        chat,
        currentUser,
        otherUser,
      ).toEntity();
    }).first;
  }

  @override
  Future<void> updateChat(Chat chat) {
    // TODO: implement updateChat
    throw UnimplementedError();
  }
}
