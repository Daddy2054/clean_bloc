import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/presentation/widgets/widgets.dart';
import '../blocs/feed/feed_bloc.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
        centerTitle: true,
      ),
      bottomNavigationBar: const CustomNavBar(),
          body: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          if (state is FeedLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }
          if (state is FeedLoaded) {
            debugPrint(state.posts.toString());
            return Container();
          } else {
            return const Text('Something went wrong!');
          }
        },
      ),
    );
  }
}
