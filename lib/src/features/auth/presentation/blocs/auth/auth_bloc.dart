import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/domain/usecases/usecases.dart';
import '../../../data/datasources/mock_auth_datasource.dart';
import '../../../domain/entities/logged_in_user.dart';
import '../../../domain/usecases/get_auth_status.dart';
import '../../../domain/usecases/get_logged_in_user.dart';
import '../../../domain/usecases/logout_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LogoutUser _logoutUser;
  final GetAuthStatus _getAuthStatus;
  final GetLoggedInUser _getLoggedInUser;

  late StreamSubscription<AuthStatus> _authStatusSubscription;

  AuthBloc({
    required LogoutUser logoutUser,
    required GetAuthStatus getAuthStatus,
    required GetLoggedInUser getLoggedInUser,
  })  : _logoutUser = logoutUser,
        _getAuthStatus = getAuthStatus,
        _getLoggedInUser = getLoggedInUser,
        super(const AuthState.unknown()) {
    on<AuthGetStatus>(_onAuthGetStatus);
    on<AuthLogoutUser>(_onAuthLogoutUser);

    _authStatusSubscription = _getAuthStatus(NoParams()).listen((status) {
      add(AuthGetStatus(status));
    });
  }

  Future<void> _onAuthGetStatus(
    AuthGetStatus event,
    Emitter<AuthState> emit,
  ) async {
    debugPrint('Get AuthGetStatus: ${event.status}');

    switch (event.status) {
      case AuthStatus.unauthenticated:
        return emit(const AuthState.unauthenticated());
      case AuthStatus.unknown:
        return emit(const AuthState.unknown());
      case AuthStatus.authenticated:
        final user = await _getLoggedInUser(NoParams());
        debugPrint(user.toString());
        return emit(
          AuthState.authenticated(user: user),
        );
    }
  }

  void _onAuthLogoutUser(
    AuthLogoutUser event,
    Emitter<AuthState> emit,
  ) async {
    debugPrint('Start user logout with _onAuthLogoutUser');
    await _logoutUser(NoParams());
    emit(const AuthState.unauthenticated());
  }

  @override
  Future<void> close() {
    _authStatusSubscription.cancel();
    return super.close();
  }
}
