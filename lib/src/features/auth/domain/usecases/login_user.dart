import '../../../../shared/domain/entities/user.dart';
import '../../../../shared/domain/usecases/usecases.dart';
import '../entities/logged_in_user.dart';
import '../repositories/auth_repository.dart';

class LoginUser implements UseCase<void, LoginUserParams> {
  final AuthRepository authRepository;

  LoginUser(this.authRepository);

  @override
  Future<void> call(LoginUserParams params) {
    return authRepository.login(
      username: params.username,
      password: params.password,
    );
  }
}

class LoginUserParams extends Params {
  final Username username;
  final Password password;

  LoginUserParams({
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [username, password];
}
