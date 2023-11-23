import '../entities/chat.dart';

abstract class ChatRepository {
  Future<List<Chat>> getChatsByUser(String userId);
  Future<Chat> getChatsById(String userId, String chatId);
  Future<void> updateChat(Chat chat);
}
