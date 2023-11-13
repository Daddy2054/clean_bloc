import '../../../../shared/domain/entities/user.dart';

class LoggedInUser extends User {
  final String? email;

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
    username: '-',
    email: '-',
  );

  @override
  List<Object?> get props =>
      [id, username, followers, followings, imagePath, email];

  LoggedInUser copyWith({
    String? id,
    String? username,
    String? email,
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
