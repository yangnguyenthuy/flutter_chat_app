import 'package:flutter/material.dart';
import 'package:flutter_chat_app/group_info.dart';

class GroupChatRoom extends StatefulWidget {
  const GroupChatRoom({super.key});

  @override
  State<GroupChatRoom> createState() => _GroupChatRoomState();
}

class _GroupChatRoomState extends State<GroupChatRoom> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Group Name"),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => GroupInfo())), 
            icon: Icon(Icons.more_vert),
          )
        ],
      ),
      body: Container(),
      bottomNavigationBar: Container(
        width: size.width,
        height: size.height / 10,
        alignment: Alignment.center,
        child: Container(
          height: size.height / 12,
          width: size.width / 1.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: size.width / 1.25,
                height: size.height / 15,
                child: TextField(
                  decoration: InputDecoration(
                    suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.photo),),
                    contentPadding: EdgeInsets.only(bottom: 10, left: 10),
                    hintText: "Send Messange",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))
                  ),
                ),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.send,),padding: EdgeInsets.only(left: 15),),
            ]
          ),
        ),
      ),
    );
  }
}