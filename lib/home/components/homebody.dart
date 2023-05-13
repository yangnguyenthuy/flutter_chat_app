import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/chatroom/chatroom.dart';
import 'package:flutter_chat_app/home/components/chatcard.dart';
import 'package:flutter_chat_app/model/chat.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: 
            FutureBuilder<List<Chat>>(
              future: fetchChat(),
              builder: (context, snapshot) {
                if(snapshot.hasData)
                {
                  return ListChat(chatroom: snapshot.data!);
                }
                if(snapshot.hasError) {
                  return const Center(
                    child: Text('An error has occurred!'),
                  );
                }
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Text("Loading..."));
                }
                return Center(child: Text("Loading..."));
              },
            )
          )
      ],
    );
  }
}

class ListChat extends StatelessWidget {
  final List<Chat> chatroom;
  const ListChat({super.key, required this.chatroom});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chatroom.length,
      itemBuilder: (context, index) => ChatCard(
        chat: chatroom[index],
        press: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatRoom(id: chatroom[index].id),
          ),
        ),
      ),
    );
  }
}