// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, avoid_print

import 'package:chat_app/screens/cubits/chat_cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/chat_buble.dart';

class ChatScreen extends StatelessWidget {
  TextEditingController messageController = TextEditingController();
  static String id = 'chatScreen';
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                var messagesList =
                    BlocProvider.of<ChatCubit>(context).messagesList;
                return ListView.builder(
                  reverse: true,
                  controller: _controller,
                  itemCount: messagesList.length,
                  itemBuilder: ((context, index) {
                    return messagesList[index].id == email
                        ? ChatBuble(
                            message: messagesList[index],
                          )
                        : ChatBubleForFriend(
                            message: messagesList[index],
                          );
                  }),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: messageController,
              onSubmitted: (value) {},
              decoration: InputDecoration(
                hintText: 'Send message..',
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    if (messageController.text.isNotEmpty) {
                      BlocProvider.of<ChatCubit>(context).sendMessage(
                        message: messageController.text,
                        email: email,
                      );
                      messageController.clear();
                      _controller.animateTo(
                        _controller.position.minScrollExtent,
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
