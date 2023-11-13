import 'package:flutter/material.dart';

import '../../../../shared/presentation/widgets/widgets.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover'),
      ),
      bottomNavigationBar: const CustomNavBar(),
    );
  }
}
