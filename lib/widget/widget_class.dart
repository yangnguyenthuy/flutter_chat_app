import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/friend/friends_list_page.dart';

import '../chatroom/chatroom.dart';
import '../friend/friends_request_page.dart';
import '../home/components/chatcard.dart';
import '../model/chat.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  const DrawerItem({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(title == "Invite a friend") {
          Navigator.push(context, MaterialPageRoute(builder: (_) => FriendsListPage()));
        }
        else if(title == "Notifications") {
          Navigator.push(context, MaterialPageRoute(builder: (_) => Notifications()));
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(
              width: 40,
            ),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class UserAvatar extends StatelessWidget {
  final String filename;
  const UserAvatar({
    super.key,
    required this.filename,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 32,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: 29,
        backgroundImage: Image.asset('$filename').image,
      ),
    );
  }
}

class ListChat extends StatelessWidget {
  final List<Chat> chatroom;
  const ListChat({super.key, required this.chatroom});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(left: 25),
      itemCount: chatroom.length,
      itemBuilder: (context, index) => ChatCard(
        chat: chatroom[index],
        press: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatRoom(id_acc: chatroom[index].id_acc, id_room: chatroom[index].id_room),
          ),
        ),
      ),
    );
  }
}