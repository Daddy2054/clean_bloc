part of 'manage_content_bloc.dart';

abstract class ManageContentEvent extends Equatable {
  const ManageContentEvent();

  @override
  List<Object> get props => [];
}

class ManageContentDeletePost extends ManageContentEvent {
  final Post post;

  const ManageContentDeletePost({required this.post});

  @override
  List<Object> get props => [post];
}

class ManageContentGetPostsByUser extends ManageContentEvent {
  final String userId;

  const ManageContentGetPostsByUser({required this.userId});

  @override
  List<Object> get props => [userId];
}
