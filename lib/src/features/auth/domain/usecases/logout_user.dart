import '../../../../shared/domain/usecases/usecases.dart';
import '../repositories/auth_repository.dart';

class LogoutUser implements UseCase<void, NoParams> {
  final AuthRepository authRepository;

  LogoutUser(this.authRepository);

  @override
  Future<void> call(NoParams params) {
    return authRepository.logout();
  }
}
