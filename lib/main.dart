import 'package:flutter/material.dart';
import 'package:flutter_chat_app/chatroom/chatroom.dart';
import 'package:flutter_chat_app/group_chat_screen.dart';
import 'package:flutter_chat_app/home/homescreen.dart';
import 'package:flutter_chat_app/login/loginscreen.dart';
import 'package:flutter_chat_app/splashpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
      routes: {
        '/login': (context) => LoginScreen(),
      },//
    );
  }
}
