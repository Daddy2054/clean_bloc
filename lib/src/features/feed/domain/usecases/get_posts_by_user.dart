import '../../../../shared/domain/entities/post.dart';
import '../../../../shared/domain/usecases/usecases.dart';
import '../repositories/post_repository.dart';

class GetPostsByUser implements UseCase<List<Post>, GetPostsByUserParams> {
  final PostRepository postRepository;

  GetPostsByUser(this.postRepository);

  @override
  Future<List<Post>> call(GetPostsByUserParams params) {
    return postRepository.getPostsByUser(params.userId);
  }
}

class GetPostsByUserParams extends Params {
  final String userId;

  GetPostsByUserParams({required this.userId});

  @override
  List<Object?> get props => [userId];
}
