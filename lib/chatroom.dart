import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/homescreen.dart';

class ChatRoom extends StatelessWidget {
  const ChatRoom({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            alignment: Alignment.centerLeft,
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => HomeScreen())), 
            icon: Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title: Text("Name"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width,
              height: size.height / 1.25,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: size.width,
        height: size.height / 10,
        alignment: Alignment.center,
        child: Container(
          height: size.height / 12,
          width: size.width / 1.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: size.width / 1.25,
                height: size.height / 15,
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 10, left: 10),
                    hintText: "Send Messange",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))
                  ),
                ),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.send,),padding: EdgeInsets.only(left: 15),),
            ]
          ),
        ),
      ),
    );
  }
}