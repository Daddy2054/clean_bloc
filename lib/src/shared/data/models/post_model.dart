
import '../../domain/entities/post.dart';
import 'package:hive/hive.dart';

import 'user_model.dart';


part 'post_model.g.dart';

@HiveType(typeId: 1)
class PostModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final UserModel user;
  @HiveField(2)
  final String caption;
  @HiveField(3)
  final String assetPath;

  PostModel({
    required this.id,
    required this.user,
    required this.caption,
    required this.assetPath,
  });

  factory PostModel.fromJson(
    Map<String, dynamic> post,
    Map<String, dynamic> user,
  ) {
    return PostModel(
      id: post['id'],
      user: UserModel.fromJson(user),
      caption: post['caption'],
      assetPath: post['assetPath'],
    );
  }

  factory PostModel.fromEntity(Post post) {
    return PostModel(
      id: post.id,
      user: UserModel.fromEntity(post.user),
      caption: post.caption,
      assetPath: post.assetPath,
    );
  }

  Post toEntity() {
    return Post(
      id: id,
      user: user.toEntity(),
      caption: caption,
      assetPath: assetPath,
    );
  }
}
