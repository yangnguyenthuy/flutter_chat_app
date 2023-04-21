import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/add_members.dart';
import 'package:flutter_chat_app/home/components/homebody.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _bodyOption = <Widget> [
    HomeBody(),
    GroupBody(),
    FriendBody(),
    AccountDetail(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: HomeBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddMembers()));},
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: customBottomNavigationBar(),
    );
  }

  AppBar customAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text("TTS Chat"),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {}, 
        ),
      ],
    );
  }

  BottomNavigationBar customBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: (value) {
        setState(() {
          _selectedIndex = value;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.messenger), label: "Chats"),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: "Nhóm"),
        BottomNavigationBarItem(icon: Icon(Icons.person_add), label: "Bạn bè"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Tôi"),
      ],
    );
  }
}
