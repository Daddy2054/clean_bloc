import '../../../../shared/domain/entities/post.dart';

abstract class PostRepository {
  Future<List<Post>> getPosts();
  Future<List<Post>> getPostsByUser(String userId);
}
