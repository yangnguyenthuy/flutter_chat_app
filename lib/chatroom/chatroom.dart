import 'dart:convert';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/chatroom/components/body.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../config/api_connection.dart';
import '../model/user.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({super.key, required this.id_acc, required this.id_room});
  final int id_acc;
  final int id_room;

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  late User? user;

  getUserFromApi() async {
    int id = widget.id_acc;
    http.Response res = await http.post(
      Uri.parse(API.getChatPerson),
      body: {
        "id": id.toString(),
      }
    );

    var result = jsonDecode(res.body);
    // print(result[0]);
    //user bị lỗi
    
    if(res.statusCode == 200) {
      user = User.fromJson(result[0]);
      setState(() {});
    }
    else {
      debugPrint('${res.body}');
    }
  }
 
 @override
  void initState() {
    super.initState();
    getUserFromApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: Body(id_room: widget.id_room),
    );
  }

  AppBar customAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
              children: [
                BackButton(),
                CircleAvatar(
                  backgroundImage: AssetImage(user!.image),
                ),
                SizedBox(width: 20.0 * 0.75),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user!.name,
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      user!.status,
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                )
              ],
            ),
      actions: [
        IconButton(
          icon: Icon(Icons.local_phone),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.videocam),
          onPressed: () {},
        ),
        SizedBox(width: 20.0 / 2),
      ],
    );
  }
}