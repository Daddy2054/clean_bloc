import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import '../../../../../shared/domain/entities/post.dart';
import '../../../../../shared/domain/entities/user.dart';
import '../../../domain/usecases/create_post.dart';

part 'add_content_state.dart';

class AddContentCubit extends Cubit<AddContentState> {
  final CreatePost _createPost;

  AddContentCubit({
    required CreatePost createPost,
  })  : _createPost = createPost,
        super(AddContentState.initial());

  void videoChanged(File file) {
    emit(state.copyWith(
      video: file,
      status: AddContentStatus.loading,
    ));
  }

  void captionChanged(String caption) {
    emit(state.copyWith(
      caption: caption,
      status: AddContentStatus.loading,
    ));
  }

  void submit(User user) {
    try {
      final post = Post(
        id: const Uuid().v4(),
        user: user,
        caption: state.caption,
        assetPath: state.video!.path,
      );
      _createPost(CreatePostParams(post: post));
      debugPrint('The post has been created.');

      emit(state.copyWith(status: AddContentStatus.success));
    } catch (err) {}
  }

  void reset() {
    emit(AddContentState.initial());
  }
}
