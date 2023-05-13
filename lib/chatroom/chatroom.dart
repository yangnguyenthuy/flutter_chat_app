import 'dart:convert';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/chatroom/components/body.dart';
import 'package:http/http.dart' as http;

import '../config/api_connection.dart';
import '../model/user.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({super.key, required this.id});
  final int id;

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  Future<User> fetchUser() async {
    int i = widget.id;
    final response = await http.post(Uri.parse(API.getChatPerson),body: {"id": i});
    // Use the compute function to run parsePhotos in a separate isolate.
    return parseUser(response.body);
  }

  User parseUser(String responseBody) {

    var parsed = jsonDecode(responseBody);
    print(parsed);
    User userTemp = User(name: parsed['name'],image: parsed['img'],status: parsed['status']); 

    
    return userTemp;
    // //final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    // return parsed.map<Chat>((json) => Chat.fromJson(json)).toList();
  }
  // void getUserFormApi() async {
  //   var res = await http.post(
  //     Uri.parse(API.getChatPerson),
  //     body: {
  //       "id": widget.id
  //     }
  //   );

  //   var data = jsonDecode(res.body);
  //   print(res.body);
  //   User userTemp = User(name: data['name'],image: data['img'],status: data['status']);
  //   setState(() {
  //     print('ok');
  //   });
  //   // await http.post(Uri.parse(API.getChatPerson), body: {"id": widget.id}).then((res) {
  //   //   var data = jsonDecode(res.body);
  //   //   this.user = User(name: data['name'],image: data['img'],status: data['status']);
  //   //   setState(() {
  //   //     print('ok');
  //   //   });
  //     // user = data.map((e) => User.fromJson(e));
  //   // });
  // }

  // @override
  // void initState() {
  //   fetchUser(widget.id);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      //body: Body(),
    );
  }

  AppBar customAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: FutureBuilder<User>(
        future: fetchUser(),
        builder:(context, snapshot) {
          if(snapshot.hasData)
          {
            return Row(
              children: [
                BackButton(),
                CircleAvatar(
                  backgroundImage: AssetImage(snapshot.data!.image),
                ),
                SizedBox(width: 20.0 * 0.75),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${snapshot.data!.name}",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "${snapshot.data!.status}",
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                )
              ],
            );
          }
          else return Text("Error");
        },
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