import 'package:example/common/filled_outline_button.dart';
import 'package:example/constants/constants_color.dart';
import 'package:example/modules/main/screen/chats/bloc/chats_bloc.dart';
import 'package:example/modules/main/screen/chats/components/chat_card.dart';
import 'package:example/modules/main/screen/chats/models/Chat.dart';
import 'package:example/modules/main/screen/messages/messages_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatsBloc, ChatsState>(
      builder: (context, state) {
        if (state is ConnectionOpened) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(kDefaultPadding, 0, kDefaultPadding, kDefaultPadding),
                color: kPrimaryColor,
                child: Row(
                  children: [
                    FillOutlineButton(press: () {}, text: "Recent Message"),
                    const SizedBox(width: kDefaultPadding),
                    FillOutlineButton(
                      press: () {},
                      text: "Active",
                      isFilled: false,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: chatsData.length,
                  itemBuilder: (context, index) => ChatCard(
                    chat: chatsData[index],
                    press: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MessagesScreen(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else if (state is ConnectionFailed) {
          return Center(child: Text(state.error));
        } else {
          return Center(child: Text('Đang kết nối với server...'));
        }
      },
    );
  }
}
