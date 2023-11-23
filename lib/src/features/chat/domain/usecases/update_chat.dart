
import '../../../../shared/domain/usecases/usecases.dart';
import '../entities/chat.dart';
import '../repositories/chat_repository.dart';

class UpdateChat implements UseCase<void, UpdateChatParams> {
  final ChatRepository chatRepository;

  UpdateChat(this.chatRepository);

  @override
  Future<void> call(UpdateChatParams params) {
    return chatRepository.updateChat(params.chat);
  }
}

class UpdateChatParams extends Params {
  final Chat chat;

  UpdateChatParams({required this.chat});

  @override
  List<Object?> get props => [chat];
}
