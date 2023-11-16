import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/domain/entities/post.dart';
import '../../../../../shared/domain/usecases/usecases.dart';
import '../../../domain/usecases/get_posts.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final GetPosts _getPosts;

  FeedBloc({
    required GetPosts getPosts,
  })  : _getPosts = getPosts,
        super(FeedLoading()) {
    on<FeedGetPosts>(_onFeedGetPosts);
  }

  void _onFeedGetPosts(
    FeedGetPosts event,
    Emitter<FeedState> emit,
  ) async {
    debugPrint('Start getting posts with: _onFeedGetPosts');
    List<Post> posts = await _getPosts(NoParams());
    emit(FeedLoaded(posts: posts));
  }
}
