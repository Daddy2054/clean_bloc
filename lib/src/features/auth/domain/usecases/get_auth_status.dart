import '../../../../shared/domain/usecases/usecases.dart';
import '../../data/datasources/mock_auth_datasource.dart';
import '../repositories/auth_repository.dart';

class GetAuthStatus implements UseCase<AuthStatus, NoParams> {
  final AuthRepository authRepository;

  GetAuthStatus(this.authRepository);

  @override
  Stream<AuthStatus> call(NoParams params) {
    return authRepository.status;
  }
}
