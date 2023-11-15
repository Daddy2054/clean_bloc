import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../shared/domain/entities/user.dart';
import '../../../domain/entities/logged_in_user.dart';
import '../../../domain/usecases/signup_user.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupUser _signupUser;

  SignupCubit({required SignupUser signupUser})
      : _signupUser = signupUser,
        super(SignupState.initial());

  void usernameChanged(String value) {
    final username = Username.dirty(value);
    emit(
      state.copyWith(
        username: username,
        status: Formz.validate(
          [username, state.email, state.password],
        ),
      ),
    );
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate(
          [state.username, email, state.password],
        ),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate(
          [state.username, state.email, password],
        ),
      ),
    );
  }

  Future<void> signupWithCredentials() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _signupUser(
        SignupUserParams(
          user: LoggedInUser(
            id: 'user_000',
            email: state.email,
            username: state.username,
            imagePath: 'assets/images/image_1.jpg',
          ),
        ),
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (err) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
