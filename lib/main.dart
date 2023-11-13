// ignore_for_file: public_member_api_docs

import 'package:clean_bloc/src/config/app_router.dart';
import 'package:clean_bloc/src/config/app_theme.dart';
import 'package:clean_bloc/src/shared/presentation/widgets/custom_nav_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: CustomTheme().theme(),
      routerConfig: AppRouter().router,
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
