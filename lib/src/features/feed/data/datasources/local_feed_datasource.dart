import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../shared/data/models/post_model.dart';
import '../../../../shared/domain/entities/post.dart';

abstract class LocalFeedDatasource {
  Future<List<Post>> getPosts();
  Future<List<Post>> getPostsByUser(String userId);
  Future<void> addPost(Post post);
  Future<void> deletePostById(String postId);
  Future<void> deleteAllPosts();
}

class LocalFeedDatasourceImpl implements LocalFeedDatasource {
  String boxName = 'posts';
  Type boxType = PostModel;

  @override
  Future<void> addPost(Post post) async {
    Box box = await _openBox();
    await box.put(post.id, PostModel.fromEntity(post));
  }

  @override
  Future<void> deleteAllPosts() async {
    Box box = await _openBox();
    await box.clear();
  }
  @override
  Future<void> deletePostById(String postId) async {
    Box box = await _openBox();
    PostModel post = box.get(postId);
    debugPrint("Delete post: ${post.id}");
    box.delete(postId);
  }
  @override
  Future<List<Post>> getPosts() async {
    Box<PostModel> box = await _openBox() as Box<PostModel>;
    return box.values.toList().map((post) => post.toEntity()).toList();
  }

  @override
  Future<List<Post>> getPostsByUser(String userId) async {
    Box<PostModel> box = await _openBox() as Box<PostModel>;
    return box.values
        .where((post) => post.user.id == userId)
        .toList()
        .map((post) => post.toEntity())
        .toList();
  }

  Future<Box> _openBox() async {
    return Hive.openBox<PostModel>(boxName);
  }
}
