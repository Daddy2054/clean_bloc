import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/message.dart';
import '../blocs/chat/chat_bloc.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const _CustomAppBar(),
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is ChatLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }
          if (state is ChatLoaded) {
            return SafeArea(
              minimum: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.chat.messages!.length,
                      itemBuilder: (context, index) {
                        Message message = state.chat.messages![index];
                        return _MessageCard(
                          width: size.width,
                          message: message,
                        );
                      },
                    ),
                  ),
                  const _CustomTextFormField(),
                ],
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

class _CustomTextFormField extends StatelessWidget {
  const _CustomTextFormField();

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return TextFormField(
      controller: controller,
      style:
          Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'Type here...',
        hintStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.black),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0),
        ),
        contentPadding: const EdgeInsets.all(20.0),
        suffixIcon: IconButton(
          icon: const Icon(Icons.send),
          onPressed: () {
            context.read<ChatBloc>().add(
                  ChatUpdateChat(
                    text: controller.text,
                  ),
                );

            controller.clear();
          },
        ),
      ),
    );
  }
}

class _MessageCard extends StatelessWidget {
  const _MessageCard({
    required this.width,
    required this.message,
  });

  final double width;
  final Message message;

  @override
  Widget build(BuildContext context) {
    String userId =
        (context.read<ChatBloc>().state as ChatLoaded).chat.currentUser.id;

    Alignment alignment = (message.senderId == userId)
        ? Alignment.centerLeft
        : Alignment.centerRight;

    Color color = (message.senderId == userId)
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.secondary;

    return Align(
      alignment: alignment,
      child: Container(
        constraints: BoxConstraints(maxWidth: width * 0.66),
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(message.text),
      ),
    );
  }
}

// class _CustomAppBar extends StatelessWidget {
class _CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
    return AppBar(
      centerTitle: true,
      title: Column(
        children: [
          Text(
            'Username',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            'Online',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 10.0),
          child:  const CircleAvatar(
            backgroundColor: Colors.white,
     
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
