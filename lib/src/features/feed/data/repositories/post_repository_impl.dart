import 'package:flutter/material.dart';

import '../../../../shared/domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/local_feed_datasource.dart';
import '../datasources/mock_feed_datasource.dart';

class PostRepositoryImpl implements PostRepository {
  final MockFeedDatasource mockFeedDatasource;
  final LocalFeedDatasource localFeedDatasource;

  PostRepositoryImpl(
    this.mockFeedDatasource,
    this.localFeedDatasource,
  );

  @override
  Future<List<Post>> getPosts() async {
    // TODO: Check internet connection. Get from database
    // if there is a active connection. Else get from local Hive.

    if ((await localFeedDatasource.getPosts()).isEmpty) {
      List<Post> posts = await mockFeedDatasource.getPosts();
      for (final post in posts) {
        localFeedDatasource.addPost(post);
      }
      return posts;
    } else {
      debugPrint('Getting the post from Hive');
      return localFeedDatasource.getPosts();
    }
  }

  @override
  Future<List<Post>> getPostsByUser(String userId) async {
      if ((await localFeedDatasource.getPostsByUser(userId)).isEmpty) {
      List<Post> posts = await mockFeedDatasource.getPostsByUser(userId);
      for (final post in posts) {
        localFeedDatasource.addPost(post);
      }
      return posts;
    } else {
      debugPrint('Getting the posts from Hive');
      return localFeedDatasource.getPostsByUser(userId);
    }
  }

  @override
  Future<void> createPost(Post post) {
    return localFeedDatasource.addPost(post);
  }


  @override
  Future<void> deletePostById(String postId) {
    return localFeedDatasource.deletePostById(postId);
  }
}
