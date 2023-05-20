import 'dart:convert';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/add_members.dart';
import 'package:flutter_chat_app/home/components/friendbody.dart';
import 'package:flutter_chat_app/home/components/groupbody.dart';
// import 'package:flutter_chat_app/home/components/homebody.dart';
import 'package:flutter_chat_app/widget/widget_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../chatroom/chatroom.dart';
import '../config/api_connection.dart';
import '../model/chat.dart';
import 'components/chatcard.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  String? _userAvatar;
  String? _userName;

  // int _selectedIndex = 0;

  // static const List<Widget> _bodyOption = <Widget> [
  //   HomeBody(),
  //   GroupBody(),
  //   FriendBody(),
  //   AccountDetail(),
  // ];
  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {

    Future<List<Chat>> chat = fetchChat();

    // return Scaffold(
    //   appBar: customAppBar(),
    //   body: _bodyOption.elementAt(_selectedIndex),
    //   floatingActionButton: _selectedIndex == 1  ? FloatingActionButton(
    //     onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddMembers()));},
    //     child: Icon(Icons.add),
    //   ) : Container(),
    //   bottomNavigationBar: customBottomNavigationBar(),
    // );
    return Scaffold(
      key: _globalKey,
      backgroundColor: Color.fromRGBO(41, 128, 185, 1.0),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          _globalKey.currentState!.openDrawer();
                        },
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(top: 10, left: 25, right: 25),
              height: 220,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(109, 213, 250, 1),
                //color: Color.fromRGBO(106, 203, 255, 1),
                // color: Colors.blue,
                  // color: Color(0xFF27c1a9),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Đang hoạt động",
                        style: TextStyle(color: Colors.white),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.more_horiz,
                            color: Colors.white,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 90,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        buildContactAvatar('Alla', 'images/img1.jpeg'),
                        buildContactAvatar('July', 'images/img2.jpeg'),
                        buildContactAvatar('Mikle', 'images/img3.jpeg'),
                        buildContactAvatar('Kler', 'images/img4.jpg'),
                        buildContactAvatar('Moane', 'images/img5.jpeg'),
                        buildContactAvatar('Julie', 'images/img6.jpeg'),
                        buildContactAvatar('Allen', 'images/img7.jpeg'),
                        buildContactAvatar('John', 'images/img8.jpg'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
              top: 200,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Color(0xFFEFFFFC),
                ),
                child: FutureBuilder<List<Chat>>(
                  future: chat,
                  builder: (context, snapshot) {
                    if(snapshot.hasData)
                    {
                      return ListView.builder(
                        padding: const EdgeInsets.only(left: 25),
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                            return buildConversationRow(
                              snapshot.data?[index].name as String,
                              snapshot.data?[index].lastMessage as String, 
                              snapshot.data?[index].image as String, 
                              snapshot.data?[index].id_acc as int,
                              snapshot.data?[index].id_room as int,
                              0,
                              context,
                            );
                        },
                      );
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
                ),
              ))
        ],
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      // floatingActionButton: SizedBox(
      //   height: 65,
      //   width: 65,
      //   child: FloatingActionButton(
      //     backgroundColor: const Color.fromRGBO(41, 128, 185, 1.0),
      //     child: const Icon(
      //       Icons.edit_outlined,
      //       size: 30,
      //     ),
      //     onPressed: () {},
      //   ),
      // ),
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

  InkWell buildConversationRow(
      String name, String message, String filename, int idAcc, int idRoom, int msgCount, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatRoom(id_acc: idAcc, id_room: idRoom),
          )
        );
      },
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  UserAvatar(filename: filename),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        message,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 25, top: 5),
                child: Column(
                  children: [
                    const Text(
                      '16:35',
                      style: TextStyle(fontSize: 10),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    if (msgCount > 0)
                      CircleAvatar(
                        radius: 7,
                        backgroundColor: const Color.fromRGBO(41, 128, 185, 1.0),
                        child: Text(
                          msgCount.toString(),
                          style:
                              const TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      )
                  ],
                ),
              )
            ],
          ),
          const Divider(
            indent: 70,
            height: 20,
          )
        ],
      ),
    );
  }

  Padding buildContactAvatar(String name, String filename) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Column(
        children: [
          UserAvatar(
            filename: filename,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            name,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          )
        ],
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
      itemBuilder: (context, index) {
        
      },
      // itemBuilder: (context, index) => ChatCard(
      //   chat: chatroom[index],
      //   press: () => Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => ChatRoom(id_acc: chatroom[index].id_acc, id_room: chatroom[index].id_room),
      //     ),
      //   ),
      // ),
    );
  }
}

  // AppBar customAppBar() {
  //   return AppBar(
  //     automaticallyImplyLeading: false,
  //     title: Text("TTS Chat"),
  //     actions: [
  //       IconButton(
  //         icon: Icon(Icons.search),
  //         onPressed: () {}, 
  //       ),
  //     ],
  //   );
  // }

//   BottomNavigationBar customBottomNavigationBar() {
//     return BottomNavigationBar(
//       type: BottomNavigationBarType.fixed,
//       currentIndex: _selectedIndex,
//       onTap: (value) {
//         setState(() {
//           _selectedIndex = value;
//         });
//       },
//       items: [
//         BottomNavigationBarItem(icon: Icon(Icons.messenger), label: "Chats"),
//         BottomNavigationBarItem(icon: Icon(Icons.people), label: "Nhóm"),
//         BottomNavigationBarItem(icon: Icon(Icons.person_add), label: "Bạn bè"),
//         BottomNavigationBarItem(icon: Icon(Icons.person), label: "Tôi"),
//       ],
//     );
//   }
// }


