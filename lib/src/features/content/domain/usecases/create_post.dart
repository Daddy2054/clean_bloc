
import '../../../../shared/domain/entities/post.dart';
import '../../../../shared/domain/usecases/usecases.dart';
import '../../../feed/domain/repositories/post_repository.dart';

class CreatePost implements UseCase<void, CreatePostParams> {
  final PostRepository postRepository;

  CreatePost(this.postRepository);

  @override
  Future<void> call(CreatePostParams params) {
    return postRepository.createPost(params.post);
  }
}

class CreatePostParams extends Params {
  final Post post;

  CreatePostParams({required this.post});

  @override
  List<Object?> get props => [post];
}
