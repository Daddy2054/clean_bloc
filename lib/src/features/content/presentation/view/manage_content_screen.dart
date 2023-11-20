import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/presentation/widgets/custom_user_information.dart';
import '../../../../shared/presentation/widgets/custom_video_player.dart';
import '../../../auth/domain/entities/logged_in_user.dart';
import '../../../auth/presentation/blocs/auth/auth_bloc.dart';
import '../blocs/manage_content/manage_content_bloc.dart';

class ManageContentScreen extends StatelessWidget {
  const ManageContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LoggedInUser loggedInUser = context.read<AuthBloc>().state.user;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          loggedInUser.username.value,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        leading: BackButton(
          onPressed: () {
            context.goNamed('feed');
          },
        ),
      ),
      body: BlocBuilder<ManageContentBloc, ManageContentState>(
        builder: (context, state) {
          if (state is ManageContentLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ManageContentLoaded) {
            debugPrint(
                "This are the posts: ${state.posts.map((post) => post.id).toList()}");
            return DefaultTabController(
              length: 2,
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        CustomUserInformation(user: loggedInUser),
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
                body: TabBarView(
                  children: [
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.posts.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 9 / 16,
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onDoubleTap: () {
                            context.read<ManageContentBloc>().add(
                                  ManageContentDeletePost(
                                    post: state.posts[index],
                                  ),
                                );
                          },
                          child: CustomVideoPlayer(
                            key: UniqueKey(),
                            assetPath: state.posts[index].assetPath,
                          ),
                        );
                      },
                    ),
                    const Center(child: Text('Second tab')),
                  ],
                ),
              ),
            );
          } else {
            return const Text('Something went wrong.');
          }
        },
      ),
    );
  }
}
