import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/domain/entities/post.dart';
import '../../../../feed/domain/usecases/get_posts_by_user.dart';
import '../../../domain/usecases/delete_post.dart';

part 'manage_content_event.dart';
part 'manage_content_state.dart';

class ManageContentBloc extends Bloc<ManageContentEvent, ManageContentState> {
  final GetPostsByUser _getPostsByUser;
  final DeletePostById _deletePostById;

  ManageContentBloc({
    required GetPostsByUser getPostsByUser,
    required DeletePostById deletePostById,
  })  : _getPostsByUser = getPostsByUser,
        _deletePostById = deletePostById,
        super(ManageContentLoading()) {
    on<ManageContentGetPostsByUser>(_onManageContentGetPostsByUser);
    on<ManageContentDeletePost>(_onManageContentDeletePost);
  }

  void _onManageContentGetPostsByUser(
    ManageContentGetPostsByUser event,
    Emitter<ManageContentState> emit,
  ) async {
    List<Post> posts = await _getPostsByUser(
      GetPostsByUserParams(
        userId: event.userId,
      ),
    );
    emit(ManageContentLoaded(posts: posts));
  }

    void _onManageContentDeletePost(
    ManageContentDeletePost event,
    Emitter<ManageContentState> emit,
  ) async {
    debugPrint(event.post.id);
    if (state is ManageContentLoaded) {
      final state = this.state as ManageContentLoaded;
      List<Post> posts = List.from(state.posts)..remove(event.post);
      emit(ManageContentLoaded(posts: posts));
      // await _deletePostById(DeletePostByIdParams(postId: event.post.id));
    }
  }
}
