import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/domain/entities/post.dart';
import '../../../../feed/domain/usecases/get_posts_by_user.dart';

part 'manage_content_event.dart';
part 'manage_content_state.dart';

class ManageContentBloc extends Bloc<ManageContentEvent, ManageContentState> {
  final GetPostsByUser _getPostsByUser;

  ManageContentBloc({
    required GetPostsByUser getPostsByUser,
  })  : _getPostsByUser = getPostsByUser,
        super(ManageContentLoading()) {
    on<ManageContentGetPostsByUser>(_onManageContentGetPostsByUser);
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
}
