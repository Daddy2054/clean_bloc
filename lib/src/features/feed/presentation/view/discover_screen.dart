import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/presentation/widgets/widgets.dart';
import '../blocs/discover/discover_bloc.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover'),
        centerTitle: true,
      ),
      bottomNavigationBar: const CustomNavBar(),
      body: BlocBuilder<DiscoverBloc, DiscoverState>(
        builder: (context, state) {
          if (state is DiscoverLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is DiscoverLoaded) {
            debugPrint(state.users.toString());
            return Container();
          } else {
            return const Text('Something went wrong.');
          }
        },
      ),
    );
  }
}
