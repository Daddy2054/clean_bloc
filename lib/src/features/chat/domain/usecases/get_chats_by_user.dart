
import '../../../../shared/domain/usecases/usecases.dart';
import '../entities/chat.dart';
import '../repositories/chat_repository.dart';

class GetChatsByUser implements UseCase<List<Chat>, GetChatsByUserParams> {
  final ChatRepository chatRepository;

  GetChatsByUser(this.chatRepository);

  @override
  Future<List<Chat>> call(GetChatsByUserParams params) {
    return chatRepository.getChatsByUser(params.userId);
  }
}

class GetChatsByUserParams extends Params {
  final String userId;

  GetChatsByUserParams({required this.userId});

  @override
  List<Object?> get props => [userId];
}
