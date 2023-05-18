import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_chat_app/config/api_connection.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';
import 'package:http/http.dart' as http;

class SearchUser extends SearchDelegate {
  User _userList = User();

  _addFriend(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('acc_id');
    var res = await http.post(Uri.parse(API.sendFriendRequest),
     body: {
      "id": id,
      "email": email,
     }
    );
    if(res.statusCode == 200)
    {
      var resBodyOfSignUp = jsonDecode(res.body);
       if(resBodyOfSignUp["Status"] == "Success")
       {
          Fluttertoast.showToast(msg: "Gửi kết bạn thành công");
       }
       else 
       {
          Fluttertoast.showToast(msg: "Các bạn đã là bạn bè");
       }
    }
    else
    {
      print("error");
    }
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<User>>(
        future: _userList.getuserList(query: query),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<User>? data = snapshot.data;
          return ListView.builder(
              itemCount: data?.length,
              itemBuilder: (context, index) {
                return ListTile(                            
                        leading: Hero(
                          tag: index,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage('${data?[index].image}'),
                          ),
                        ),
                        title: Text('${data?[index].name}'),
                        subtitle: Text('${data?[index].email}'),
                        trailing: IconButton(
                          onPressed: () {
                            _addFriend(data?[index].email as String);
                          },
                          icon: Icon(Icons.add)
                        ),
                      );
              });
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Search User'),
    );
  }
}