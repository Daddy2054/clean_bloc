import '../../../../shared/domain/entities/user.dart';
import '../../../../shared/domain/usecases/usecases.dart';
import '../repositories/user_repository.dart';

class GetUser implements UseCase<User, GetUserParams> {
  final UserRepository userRepository;

  GetUser(this.userRepository);

  @override
  Future<User> call(GetUserParams params) {
    return userRepository.getUser(params.userId);
  }
}

class GetUserParams extends Params {
  final String userId;

  GetUserParams({required this.userId});

  @override
  List<Object?> get props => [userId];
}
