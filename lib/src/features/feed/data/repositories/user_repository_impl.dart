import '../../../../shared/domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/mock_feed_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  final MockFeedDatasource mockFeedDatasource;

  UserRepositoryImpl(this.mockFeedDatasource);

  @override
  Future<User> getUser(String userId) {
    return mockFeedDatasource.getUser(userId);
  }

  @override
  Future<List<User>> getUsers() {
    return mockFeedDatasource.getUsers();
  }
}
