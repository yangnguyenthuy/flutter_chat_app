import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/friend/friends_list_page.dart';
import 'package:flutter_chat_app/home/homescreen.dart';
import 'package:flutter_chat_app/login/loginscreen.dart';
import 'package:flutter_chat_app/profile/profile_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../chatroom/chatroom.dart';
import '../config/api_connection.dart';
import '../friend/friends_request_page.dart';
import '../home/components/chatcard.dart';
import '../model/chat.dart';

import 'package:http/http.dart' as http;

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  const DrawerItem({
    super.key,
    required this.title,
    required this.icon,
  });

  _swapStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id_acc = prefs.getString('acc_id');
    http.Response response =
      await http.post(Uri.parse(API.changeStatus),body: {
        "id": id_acc.toString(),
      });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if(title == "Bạn bè") {
          Navigator.push(context, MaterialPageRoute(builder: (_) => FriendsListPage()));
        }
        else if(title == "Thông báo") {
          Navigator.push(context, MaterialPageRoute(builder: (_) => Notifications()));
        }
        else if(title == "Chats") {
          Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
        }
        else if(title == "Tài khoản") {
          Navigator.push(context, MaterialPageRoute(builder: (_) => Profile()));
        }
        else if(title == "Đăng xuất") {
          _swapStatus();
          Fluttertoast.showToast(msg: "Đăng xuất thành công");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.clear();
          Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
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