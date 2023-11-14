// ignore_for_file: public_member_api_docs

import 'package:clean_bloc/src/config/app_router.dart';
import 'package:clean_bloc/src/config/app_theme.dart';
import 'package:clean_bloc/src/shared/presentation/widgets/custom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/features/auth/data/datasources/mock_auth_datasource.dart';
import 'src/features/auth/data/repositories/auth_repository_impl.dart';
import 'src/features/auth/domain/usecases/get_auth_status.dart';
import 'src/features/auth/domain/usecases/get_logged_in_user.dart';
import 'src/features/auth/domain/usecases/login_user.dart';
import 'src/features/auth/domain/usecases/logout_user.dart';
import 'src/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'src/features/auth/presentation/blocs/login/login_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepositoryImpl(
            MockAuthDatasourceImpl(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              getAuthStatus: GetAuthStatus(
                context.read<AuthRepositoryImpl>(),
              ),
              getLoggedInUser: GetLoggedInUser(
                context.read<AuthRepositoryImpl>(),
              ),
              logoutUser: LogoutUser(
                context.read<AuthRepositoryImpl>(),
              ),
            ),
          ),
          BlocProvider(
            create: (context) => LoginCubit(
              loginUser: LoginUser(
                context.read<AuthRepositoryImpl>(),
              ),
            ),
          ),
        ],
        child: MaterialApp.router(
          title: 'Flutter Demo',
          theme: CustomTheme().theme(),
          routerConfig: AppRouter().router,
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter App with Clean Architecture',
        ),
      ),
      bottomNavigationBar: const CustomNavBar(),
    );
  }
}
