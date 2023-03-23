import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/LoginScreen.dart';
import 'package:flutter_chat_app/chatroom.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          /*Container(
            height: 50,
            color: Colors.amber[600],
            child: const Center(child: Text('Entry A')),
          ),
          Container(
            height: 50,
            color: Colors.amber[500],
            child: const Center(child: Text('Entry B')),
          ),
          Container(
            height: 50,
            color: Colors.amber[100],
            child: const Center(child: Text('Entry C')),
          ),*/
          /*Container(
            height: size.height / 14,
            width: size.width,
            alignment: Alignment.center,
            child: Container(
              height: size.height / 14,
              width: size.width / 1.2,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {}, 
            child: Text("Search"),
          ),*/
        ], 
      ),
    );
  }
}