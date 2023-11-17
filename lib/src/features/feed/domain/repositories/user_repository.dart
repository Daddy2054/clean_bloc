import '../../../../shared/domain/entities/user.dart';

abstract class UserRepository {
  Future<List<User>> getUsers();
  Future<User> getUser(String userId);
}
