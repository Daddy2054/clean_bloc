part of 'discover_bloc.dart';

abstract class DiscoverState extends Equatable {
  const DiscoverState();

  @override
  List<Object> get props => [];
}

class DiscoverLoading extends DiscoverState {}

class DiscoverLoaded extends DiscoverState {
  final List<User> users;

  const DiscoverLoaded({this.users = const <User>[]});

  @override
  List<Object> get props => [users];
}
