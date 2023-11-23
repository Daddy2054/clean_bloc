import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/presentation/widgets/custom_nav_bar.dart';
import '../../domain/entities/chat.dart';
import '../../domain/entities/message.dart';
import '../blocs/chat_list/chat_list_bloc.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Chats'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: const CustomNavBar(),
      body: BlocBuilder<ChatListBloc, ChatListState>(
        builder: (context, state) {
          if (state is ChatListLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
          if (state is ChatListLoaded) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: state.chats.length,
                itemBuilder: (context, index) {
                  return _Chat(chat: state.chats[index]);
                });
          } else {
            return const Text('Something went wrong.');
          }
        },
      ),
    );
  }
}

class _Chat extends StatelessWidget {
  const _Chat({
    required this.chat,
  });

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    Message message = chat.messages!.reversed.first;

    return ListTile(
      onTap: () {
        context.go(
          context.namedLocation(
            'chat',
            // params: <String, String>{
            //   'chatId': chat.id,
            // },
          ),
        );
      },
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.white,
        backgroundImage: AssetImage(chat.otherUser.imagePath!),
      ),
      title: Text(
        chat.otherUser.username.value,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        message.text,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: Text(
        "${message.createdAt.hour}:${message.createdAt.minute}",
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
