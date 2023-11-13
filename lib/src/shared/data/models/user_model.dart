// class UserModel extends User {}


import '../../domain/entities/user.dart';

class UserModel {
  final String id;
  final String username;
  final int followers;
  final int followings;
  final String? imagePath;

  const UserModel({
    required this.id,
    required this.username,
    this.followers = 0,
    this.followings = 0,
    this.imagePath,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      imagePath: json['imagePath'],
      followers: json['followers'],
      followings: json['followings'],
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      username: user.username.value,
      imagePath: user.imagePath,
      followers: user.followers,
      followings: user.followings,
    );
  }

  User toEntity() {
    return User(
      id: id,
      username: Username.dirty(username),
      imagePath: imagePath,
      followers: followers,
      followings: followings,
    );
  }
}
