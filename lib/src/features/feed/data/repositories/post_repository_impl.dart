import '../../../../shared/domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/mock_feed_datasource.dart';

class PostRepositoryImpl implements PostRepository {
  final MockFeedDatasource mockFeedDatasource;
  // TODO: Add a local datasource using Hive

  PostRepositoryImpl(this.mockFeedDatasource);

  @override
  Future<List<Post>> getPosts() async {
    return mockFeedDatasource.getPosts();
  }

  @override
  Future<List<Post>> getPostsByUser(String userId) async {
    return mockFeedDatasource.getPostsByUser(userId);
  }
}
