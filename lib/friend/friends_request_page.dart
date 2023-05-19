import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../config/api_connection.dart';
import '../model/request.dart';
import '../widget/widget_class.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  List<FriendRequest> _request = [];

  @override
  void initState() {
    super.initState();
    _loadRequest();
  }

  Future<void> _loadRequest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('acc_id');
    http.Response response =
        await http.post(Uri.parse(API.getFriendRequest),body: {
          "id": id.toString(),
        });

    setState(() {
      _request = FriendRequest.allFromResponse(response.body);
    });
  }

  _friendAction(int requestID, String request) async {
    http.Response response =
      await http.post(Uri.parse(API.friendAction),body: {
        "id": requestID.toString(),
        "action": request,
      });

    if(response.statusCode == 200)
    {
        var resBodyOfSignUp = jsonDecode(response.body);
        if(resBodyOfSignUp["Status"] == "Success")
        {
          if(request == "Accept") {
            Fluttertoast.showToast(msg: "Thêm bạn thành công");
          }
          else if(request == "Decline") {
            Fluttertoast.showToast(msg: "Đã từ chối yêu cầu kết bạn");
          }
        }
    }

    setState(() {
      _loadRequest();
    });
  }

  Widget _buildRequestListTile(BuildContext context, int index) {
    var request = _request[index];

    return ListTile(
      leading: Hero(
        tag: index,
        child: CircleAvatar(
          backgroundImage: NetworkImage(request.avatar),
        ),
      ),
      title: Text(request.name),
      subtitle: Text(request.email),
      trailing: Wrap(
        direction: Axis.horizontal,
        children: [
          IconButton(
            onPressed: () {
              _friendAction(request.idRequest,'Accept'); 
            }, 
            icon: Icon(Icons.check),
            color: Colors.greenAccent,
          ),
          IconButton(
            onPressed: () {
              _friendAction(request.idRequest,'Decline'); 
            },
            icon: Icon(Icons.close),
            color: Colors.redAccent,
          ),
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
    Widget content;

    if (_request.isEmpty) {
      content = Center(
        child: Container(),
      );
    } else {
      content = ListView.builder(
        itemCount: _request.length,
        itemBuilder: _buildRequestListTile,
      );
    }

    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: const Text('Yêu cầu kết bạn'),
        leading: IconButton(
          onPressed: () {
            _globalKey.currentState!.openDrawer();
          },
          icon: Icon(Icons.menu,color: Colors.white),
        ),
      ),
      body: content,
      drawer: Drawer(
        width: 275,
        elevation: 30,
        backgroundColor: Color(0xF3393838),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(right: Radius.circular(40))),
        child: Container(
          decoration: const BoxDecoration(
              
              borderRadius: BorderRadius.horizontal(right: Radius.circular(40)),
              boxShadow: [
                BoxShadow(
                    color: Color(0x3D000000), spreadRadius: 30, blurRadius: 20)
              ]),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _globalKey.currentState?.closeDrawer();
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        
                        SizedBox(
                          width: 56,
                        ),
                        Text(
                          'Settings',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: const [
                        UserAvatar(filename: 'img3.jpeg'),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          'Tom Brenan',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    const DrawerItem(
                      title: 'Account',
                      icon: Icons.key,
                    ),
                    const DrawerItem(title: 'Chats', icon: Icons.chat_bubble),
                    const DrawerItem(
                        title: 'Notifications', icon: Icons.notifications),
                    const DrawerItem(
                        title: 'Data and Storage', icon: Icons.storage),
                    const DrawerItem(title: 'Help', icon: Icons.help),
                    const Divider(
                      height: 35,
                      color: Colors.green,
                    ),
                    const DrawerItem(
                        title: 'Invite a friend', icon: Icons.people_outline),
                  ],
                ),
                const DrawerItem(title: 'Log out', icon: Icons.logout)
              ],
            ),
          ),
        ),
      ),
    );
  }
}