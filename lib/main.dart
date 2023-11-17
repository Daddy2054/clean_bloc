// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'src/config/app_router.dart';
import 'src/config/app_theme.dart';
import 'src/features/auth/data/datasources/mock_auth_datasource.dart';
import 'src/features/auth/data/repositories/auth_repository_impl.dart';
import 'src/features/auth/domain/usecases/get_auth_status.dart';
import 'src/features/auth/domain/usecases/get_logged_in_user.dart';
import 'src/features/auth/domain/usecases/login_user.dart';
import 'src/features/auth/domain/usecases/logout_user.dart';
import 'src/features/auth/domain/usecases/signup_user.dart';
import 'src/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'src/features/auth/presentation/blocs/login/login_cubit.dart';
import 'src/features/auth/presentation/blocs/signup/signup_cubit.dart';
import 'src/features/feed/data/datasources/mock_feed_datasource.dart';
import 'src/features/feed/data/repositories/post_repository_impl.dart';
import 'src/features/feed/data/repositories/user_repository_impl.dart';
import 'src/shared/data/models/post_model.dart';
import 'src/shared/data/models/user_model.dart';
import 'src/shared/presentation/widgets/custom_nav_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(PostModelAdapter());
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
        RepositoryProvider(
          create: (context) => PostRepositoryImpl(
            MockFeedDatasourceImpl(),
          ),
        ),
        RepositoryProvider(
          create: (context) => UserRepositoryImpl(
            MockFeedDatasourceImpl(),
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
          BlocProvider(
            create: (context) => SignupCubit(
              signupUser: SignupUser(
                context.read<AuthRepositoryImpl>(),
              ),
            ),
          ),
        ],
        child: Builder(builder: (context) {
          return MaterialApp.router(
            title: 'Flutter Demo',
            theme: CustomTheme().theme(),
            routerConfig: AppRouter(context.read<AuthBloc>()).router,
          );
        }),
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
