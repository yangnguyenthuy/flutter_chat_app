import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/chatroom.dart';
import 'package:flutter_chat_app/home/components/chatcard.dart';
import 'package:flutter_chat_app/model/chat.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: chatsData.length,
            itemBuilder: (context, index) => ChatCard(
              chat: chatsData[index],
              press: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatRoom(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}