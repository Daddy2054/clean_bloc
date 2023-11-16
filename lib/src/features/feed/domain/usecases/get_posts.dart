import '../../../../shared/domain/entities/post.dart';
import '../../../../shared/domain/usecases/usecases.dart';
import '../repositories/post_repository.dart';

class GetPosts implements UseCase<List<Post>, NoParams> {
  final PostRepository postRepository;

  GetPosts(this.postRepository);

  @override
  Future<List<Post>> call(NoParams params) {
    return postRepository.getPosts();
  }
}
