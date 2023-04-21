import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/groupchatroom/chatroom.dart';
import 'package:flutter_chat_app/home/components/chatcard.dart';
import 'package:flutter_chat_app/home/components/groupchatcard.dart';
import 'package:flutter_chat_app/model/group.dart';

class GroupBody extends StatelessWidget {
  const GroupBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: groupsData.length,
            itemBuilder: (context, index) => GroupChatCard(
              group: groupsData[index],
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