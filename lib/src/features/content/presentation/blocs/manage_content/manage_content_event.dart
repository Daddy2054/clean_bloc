part of 'manage_content_bloc.dart';

abstract class ManageContentEvent extends Equatable {
  const ManageContentEvent();

  @override
  List<Object> get props => [];
}

class ManageContentGetPostsByUser extends ManageContentEvent {
  final String userId;

  const ManageContentGetPostsByUser({required this.userId});

  @override
  List<Object> get props => [userId];
}
