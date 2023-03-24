import 'package:flutter/material.dart';
import 'package:flutter_chat_app/add_members.dart';
import 'package:flutter_chat_app/chatroom.dart';
import 'package:flutter_chat_app/groupchatroom.dart';

class GroupChatScreen extends StatefulWidget {
  const GroupChatScreen({super.key});

  @override
  State<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Groups"),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context,index) {
          return ListTile(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => GroupChatRoom())),
            leading: Icon(Icons.group),
            title: Text("Group $index",),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.create),
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddMembers())),
      ),
    );
  }
}