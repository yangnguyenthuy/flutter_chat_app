import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/chatroom/chatroom.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config/api_connection.dart';
import '../model/friend.dart';
import '../search/search.dart';

class FriendsListPage extends StatefulWidget {
  @override
  _FriendsListPageState createState() => new _FriendsListPageState();
}

class _FriendsListPageState extends State<FriendsListPage> {
  List<Friend> _friends = [];

  @override
  void initState() {
    super.initState();
    _loadFriends();
  }

  Future<void> _loadFriends() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('acc_id');
    http.Response response =
        await http.post(Uri.parse(API.getFriendList),body: {
          "id": id.toString(),
        });

    setState(() {
      _friends = Friend.allFromResponse(response.body);
    });
  }

  Widget _buildFriendListTile(BuildContext context, int index) {
    var friend = _friends[index];

    return ListTile(
      onTap: () => _navigateToFriendChatRoom(friend, index),
      leading: Hero(
        tag: index,
        child: CircleAvatar(
          backgroundImage: NetworkImage(friend.avatar),
        ),
      ),
      title: Text(friend.name),
      subtitle: Text(friend.email),
    );
  }

  void _navigateToFriendChatRoom(Friend friend, Object avatarTag) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (c) {
          return ChatRoom(id_acc: int.parse(friend.idAcc), id_room: int.parse(friend.idRoom));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (_friends.isEmpty) {
      content = Center(
        child: CircularProgressIndicator(),
      );
    } else {
      content = ListView.builder(
        itemCount: _friends.length,
        itemBuilder: _buildFriendListTile,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Friends'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchUser());
            },
            icon: Icon(Icons.search_sharp),
          )
        ],
      ),
      body: content,
    );
  }
}