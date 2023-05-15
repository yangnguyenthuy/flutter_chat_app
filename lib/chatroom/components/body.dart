import 'dart:convert';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/chatroom/components/chatinputfield.dart';
import 'package:flutter_chat_app/chatroom/components/message.dart';
import 'package:flutter_chat_app/model/message.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_chat_app/config/api_connection.dart';


class Body extends StatelessWidget {
  const Body({super.key, required this.id_room});
  final int id_room;

  Future<List<ChatMessage>> fetchMessage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString('acc_id');
    var id = id_room.toString();
    final response = await http.post(Uri.parse(API.getChatMessage),body: {"id": id});
    return parseMessage(response.body, uid!);
  }

  List<ChatMessage> parseMessage(String responseBody, String uid) {
    List<ChatMessage> messageLog = <ChatMessage>[];
    var parsed = jsonDecode(responseBody) as List;
    parsed.forEach((element) { 
      messageLog.add(ChatMessage.fromJson(element,uid));
    });

    return messageLog;
    // //final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    // return parsed.map<Chat>((json) => Chat.fromJson(json)).toList();
}


  @override
  Widget build(BuildContext context) {
     return Column(
      children: [
        FutureBuilder<List<ChatMessage>>(
          future: fetchMessage(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              return ListMessage(messList: snapshot.data!);
            }
            else 
            {
              return const Center(
                child: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text('Hiện các bạn đã là bạn bè hãy chat với nhau đi nào'),
                  )
                ) 
              );
            }
          }, 
        ),
        ChatInputField(id_room: id_room),
      ],
    );
  }
}

class ListMessage extends StatelessWidget {
  final List<ChatMessage> messList;
  const ListMessage({super.key, required this.messList});

  @override
  Widget build(BuildContext context) {
    return 
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView.builder(
            itemCount: messList.length,
            itemBuilder: (context, index) =>
                Message(message: messList[index]),
          ),
        ),
      );
  }
}