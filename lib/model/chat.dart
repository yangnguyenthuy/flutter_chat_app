import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config/api_connection.dart';

Future<List<Chat>> fetchChat() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var id = prefs.getString('acc_id');
  final response = await http
      .post(Uri.parse(API.getChatCard),body: {"id": id});

  // Use the compute function to run parsePhotos in a separate isolate.
  return parseChat(response.body);
}

// A function that converts a response body into a List<Photo>.
List<Chat> parseChat(String responseBody) {
  List<Chat> chat = <Chat>[];

  var parsed = jsonDecode(responseBody) as List;
  parsed.forEach((element) { 
    chat.add(Chat.fromJson(element));
  });

  return chat;
  // //final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  // return parsed.map<Chat>((json) => Chat.fromJson(json)).toList();
}

class Chat {
  final int id_acc, id_room, msgCount;
  final String name, lastMessage, image, time;
  final bool isActive;

  Chat({
    this.id_room = 0,
    this.id_acc = 0,
    this.msgCount = 0,
    this.name = '',
    this.lastMessage = '',
    this.image = '',
    this.time = '',
    this.isActive = false,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    var y;
      if(json['status'] == 0) 
      {
        y = false;
      }
      else 
      {
        y = true;
      }
      var x = Chat(
        id_room: int.parse(json['id']),
        id_acc: int.parse(json['id_acc']),
        msgCount: int.parse(json['Count']),
        name: json['name'],
        lastMessage: json['LastChat'],
        image: json['img'],
        time: json['Time'],
        isActive: y,
      );
      return x;
  }

}

