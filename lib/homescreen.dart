import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/LoginScreen.dart';
import 'package:flutter_chat_app/chatroom.dart';
import 'package:flutter_chat_app/group_chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Home Screen"),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => LoginScreen())), 
            icon: Icon(Icons.logout)
          ),
        ],
      ),
      
      body: Column(
        children: [
          SizedBox(
            height: size.height / 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: size.height / 15,
                //width: size.width,
                alignment: Alignment.center,
                child: Container(
                  height: size.height / 15,
                  width: size.width / 1.2,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        //borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: Size(1.2, 47), shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero)),
                onPressed: () {}, 
                child: Text("Search", style: TextStyle(fontSize: 14),),
              ),
            ],
          ),
          //SizedBox(height: size.height / 20,),
          ListTile(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ChatRoom())),
            title: Text("User 1"),
            subtitle: Text("Online"),
            trailing: Icon(Icons.chat, color: Colors.black,),
          ),
          ListTile(
            onTap: () {},
            title: Text("User 2"),
            subtitle: Text("Offline"),
            trailing: Icon(Icons.chat, color: Colors.black,),
          ),
          ListTile(
            onTap: () {},
            title: Text("User 3"),
            subtitle: Text("Offline"),
            trailing: Icon(Icons.chat, color: Colors.black,),
          ),
          ListTile(
            onTap: () {},
            title: Text("User 4"),
            subtitle: Text("Offline"),
            trailing: Icon(Icons.chat, color: Colors.black,),
          ),
          ListTile(
            onTap: () {},
            title: Text("User 5"),
            subtitle: Text("Offline"),
            trailing: Icon(Icons.chat, color: Colors.black,),
          ),
          ListTile(
            onTap: () {},
            title: Text("User 6"),
            subtitle: Text("Offline"),
            trailing: Icon(Icons.chat, color: Colors.black,),
          ),
        ], 
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.group),
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => GroupChatScreen())),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Tài khoản',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}