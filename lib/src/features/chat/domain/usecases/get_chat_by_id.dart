
import '../../../../shared/domain/usecases/usecases.dart';
import '../entities/chat.dart';
import '../repositories/chat_repository.dart';

class GetChatById implements UseCase<Chat, GetChatByIdParams> {
  final ChatRepository chatRepository;

  GetChatById(this.chatRepository);

  @override
  Future<Chat> call(GetChatByIdParams params) {
    return chatRepository.getChatsById(params.userId, params.chatId);
  }
}

class GetChatByIdParams extends Params {
  final String userId;
  final String chatId;

  GetChatByIdParams({required this.userId, required this.chatId});

  @override
  List<Object?> get props => [userId, chatId];
}
