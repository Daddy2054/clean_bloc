import '../../../../shared/domain/entities/user.dart';
import '../../../../shared/domain/usecases/usecases.dart';
import '../repositories/user_repository.dart';

class GetUsers implements UseCase<List<User>, NoParams> {
  final UserRepository userRepository;

  GetUsers(this.userRepository);

  @override
  Future<List<User>> call(NoParams params) {
    return userRepository.getUsers();
  }
}
