import 'dart:convert';
import 'dart:html';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../config/api_connection.dart';
import '../model/user.dart';
import '../widget/widget_class.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  final double convertHeight = 250 ;
  final double profileHeight = 144 ;

  String? _userAvatar;
  String? _userName;

  User? _user; 

  @override
  void initState() {
    super.initState();
    _loadProfile();
    _getAvatarAndName();
  }

  Future<void> _getAvatarAndName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id_acc = prefs.getString('acc_id');
    http.Response response =
      await http.post(Uri.parse(API.getUserAvatar),body: {
        "id": id_acc.toString(),
      });

    var results = jsonDecode(response.body);
    String img = results['img'] as String;
    String name = results['name'] as String;

    setState(() {
      _userAvatar = img;
      _userName = name;
    });
  }

  Future<void> _loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('acc_id');
    http.Response response =
        await http.post(Uri.parse(API.getUserProfile),body: {
          "id": id.toString(),
        });
    
    var results = jsonDecode(response.body);
    
    String img = results['img'] as String;
    String name = results['name'] as String;
    String email = results['username'] as String;

    setState(() {
      _user = User(
        name: name,
        image: img,
        email: email,
        status: 'Online');
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: const Text('Thông tin tài khoản'),
        leading: IconButton(
          onPressed: () {
            _globalKey.currentState!.openDrawer();
          },
          icon: Icon(Icons.menu,color: Colors.white),
        ),
      ),
      body:ListView (
        padding: EdgeInsets.zero,
        children: <Widget>[
          buildTop(),
          buildUnder()
        ],
      ),
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
                          'Cài đặt',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        UserAvatar(filename: '${_userAvatar}'),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          '${_userName}',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    const DrawerItem(
                      title: 'Tài khoản',
                      icon: Icons.key,
                    ),
                    const DrawerItem(title: 'Chats', icon: Icons.chat_bubble),
                    const DrawerItem(
                        title: 'Thông báo', icon: Icons.notifications),
                    const DrawerItem(
                        title: 'Lưu trữ', icon: Icons.storage),
                    const DrawerItem(title: 'Trợ giúp', icon: Icons.help),
                    const Divider(
                      height: 35,
                      color: Colors.green,
                    ),
                    const DrawerItem(
                        title: 'Bạn bè', icon: Icons.people_outline),
                  ],
                ),
                const DrawerItem(title: 'Đăng xuất', icon: Icons.logout)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildUnder() =>Column(
    children: [
      const SizedBox(height: 8),
      Text("${_user?.name}",
      style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 16),
      Icon(Icons.email, color: Colors.blue, size: 30),
      Text("Email:${_user?.email}",
          style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal),
      ),
      const SizedBox(height: 16),
      Icon(Icons.phone, color: Colors.blue, size: 30),
      Text("SĐT: 0918902133",
          style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal),
      ),   
    ],
  );
  

  Widget buildTop() {
    final bottom = profileHeight / 2 ;
    final top = convertHeight - profileHeight / 2 ;
    return Stack(
      clipBehavior: Clip.none,  
      alignment: Alignment.center,
      children:[
      Container(
        margin: EdgeInsets.only(bottom:bottom),
      child : buildCoverImage(),
      ),
      Positioned(
        top: top,
        child: buildProfileImage(),
      )
      ],
      );
  }

  Widget buildCoverImage() => Container(
    color: Color.fromARGB(255, 38, 223, 248),
    child: Image.network('https://picsum.photos/250?image=19'),
    width: double.infinity,
    height: convertHeight,
    //fit:BoxFit.cover,
  );


  Widget buildProfileImage() => CircleAvatar(
    radius: profileHeight / 2,
    backgroundColor: Colors.grey.shade800,
    backgroundImage: Image.asset('${_user?.image}').image,
    // backgroundImage: NetworkImage("https://picsum.photos/250?image=9"),
  );
}