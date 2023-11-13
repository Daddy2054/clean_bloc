import 'package:formz/formz.dart';

import '../../../../shared/domain/entities/user.dart';

class LoggedInUser extends User {
  final Email? email;

  const LoggedInUser({
    required super.id,
    required super.username,
    super.imagePath,
    super.followers,
    super.followings,
    this.email,
  });

  static const empty = LoggedInUser(
    id: '-',
    username: Username.pure(),
    email: Email.pure(),
  );

  @override
  List<Object?> get props =>
      [id, username, followers, followings, imagePath, email];

  LoggedInUser copyWith({
    String? id,
    Username? username,
    Email? email,
    String? imagePath,
    int? followers,
    int? followings,
  }) {
    return LoggedInUser(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      imagePath: imagePath ?? this.imagePath,
      followers: followers ?? this.followers,
      followings: followings ?? this.followings,
    );
  }
}

enum EmailValidationError { invalid }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');

  const Email.dirty([String value = '']) : super.dirty(value);

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  EmailValidationError? validator(String value) {
    return _emailRegExp.hasMatch(value) ? null : EmailValidationError.invalid;
  }
}

enum PasswordValidationError { invalid }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');

  const Password.dirty([String value = '']) : super.dirty(value);

  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  @override
  PasswordValidationError? validator(String value) {
    return _passwordRegExp.hasMatch(value)
        ? null
        : PasswordValidationError.invalid;
  }
}
