import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/domain/entities/post.dart';
import '../../../../shared/domain/entities/user.dart';
import '../../../../shared/presentation/widgets/custom_user_information.dart';
import '../../../../shared/presentation/widgets/custom_video_player.dart';

class ManageContentScreen extends StatelessWidget {
  const ManageContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Get the currently logged-in user.
    User user = const User(
      id: '_',
      username: Username.dirty('Massimo'),
      imagePath: 'assets/images/image_1.jpg',
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          user.username.value,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  CustomUserInformation(user: user),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.goNamed('add_content');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF006E),
                          fixedSize: const Size(180, 50),
                        ),
                        child: Text(
                          'Add a Video',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF006E),
                          fixedSize: const Size(180, 50),
                        ),
                        child: Text(
                          'Update Picture',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const TabBar(
                    indicatorColor: Colors.white,
                    tabs: [
                      Tab(icon: Icon(Icons.grid_view_rounded)),
                      Tab(icon: Icon(Icons.favorite))
                    ],
                  )
                ],
              ),
            ),
          ],
          body: TabBarView(children: [
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 9 / 16,
              ),
              itemBuilder: (context, index) {
                Post post = Post(
                  id: 'id',
                  user: user,
                  caption: 'Test',
                  assetPath: 'assets/videos/city115052.mp4',
                );
                return CustomVideoPlayer(assetPath: post.assetPath);
              },
            ),
            const Center(child: Text('Second tab')),
          ]),
        ),
      ),
    );
  }
}
