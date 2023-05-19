import 'dart:async';
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

class Body extends StatefulWidget {
  const Body({super.key, required this.id_room});
  final int id_room;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late String _now;
  late Timer _everySecond;
  final inputContent = TextEditingController();
  List<ChatMessage> _messageHistory = [];

  @override
  void initState() {
    _loadMessage();
    super.initState();

    _now = DateTime.now().second.toString();

    _everySecond = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        _loadMessage();
        _now = DateTime.now().second.toString();
      });
    });
  }

  Future<void> _loadMessage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id_acc = prefs.getString('acc_id');
    var id =  widget.id_room.toString();
    http.Response response =
        await http.post(Uri.parse(API.getChatMessage),body: {
          "id": id.toString(),
        });

    setState(() {
      _messageHistory = ChatMessage.allFromResponse(response.body,id_acc!);
    });
  }

  _sendMessage(String content) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('acc_id');
    var room = widget.id_room;
    final response = await http.post(
      Uri.parse(API.sendMessage), 
      body: {
        "content": content,
        "id": id.toString(),
        "room": room.toString(),
      });
    var resBodyOfSignUp = jsonDecode(response.body);
    if(resBodyOfSignUp["Status"] == "Success")
    {
      inputContent.clear();
    }

    setState(() {
      _loadMessage();
    });
  }

  // Future<List<ChatMessage>> fetchMessage() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var uid = prefs.getString('acc_id');
  //   var id =  widget.id_room.toString();
  //   final response = await http.post(Uri.parse(API.getChatMessage),body: {"id": id});
  //   return parseMessage(response.body, uid!);
  // }

  // List<ChatMessage> parseMessage(String responseBody, String uid) {
  //   List<ChatMessage> messageLog = <ChatMessage>[];
  //   var parsed = jsonDecode(responseBody) as List;
  //   parsed.forEach((element) { 
  //     messageLog.add(ChatMessage.fromJson(element,uid));
  //   });

  //   return messageLog;
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView.builder(
              itemCount: _messageHistory.length,
              itemBuilder: (context, index) =>
                  Message(message: _messageHistory[index]),
            ),
          ),
        ),

        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 20.0 / 2,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 32,
                color: Color(0xFF087949).withOpacity(0.08),
              ),
            ],
          ),
          child: SafeArea(
            child: Row(
              children: [
                Icon(Icons.mic, color: Theme.of(context).appBarTheme.backgroundColor),
                SizedBox(width: 20.0),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0 * 0.75,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFF00BF6D).withOpacity(0.05),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.sentiment_satisfied_alt_outlined,
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(0.64),
                        ),
                        SizedBox(width: 20.0 / 4),
                        Expanded(
                          child: TextField(
                            controller: inputContent,
                            decoration: InputDecoration(
                              hintText: "Type message",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            var content = inputContent.text;
                            _sendMessage(content);
                          }, 
                          icon: Icon(
                                  Icons.send,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color!
                                      .withOpacity(0.64),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // FutureBuilder<List<ChatMessage>>(
        //   future: fetchMessage(),
        //   builder: (context, snapshot) {
        //     if(snapshot.hasData) {
        //       return ListMessage(messList: snapshot.data!);
        //     }
        //     else 
        //     {
        //       return const Center(
        //         child: Expanded(
        //           child: Padding(
        //             padding: const EdgeInsets.symmetric(horizontal: 20.0),
        //             child: Text('Hiện các bạn đã là bạn bè hãy chat với nhau đi nào'),
        //           )
        //         ) 
        //       );
        //     }
        //   }, 
        // ),
        //ChatInputField(id_room: widget.id_room),
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

// class Body extends StatelessWidget {
//   const Body({super.key, required this.id_room});
//   final int id_room;

//   Future<List<ChatMessage>> fetchMessage() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     var uid = prefs.getString('acc_id');
//     var id = id_room.toString();
//     final response = await http.post(Uri.parse(API.getChatMessage),body: {"id": id});
//     return parseMessage(response.body, uid!);
//   }

//   List<ChatMessage> parseMessage(String responseBody, String uid) {
//     List<ChatMessage> messageLog = <ChatMessage>[];
//     var parsed = jsonDecode(responseBody) as List;
//     parsed.forEach((element) { 
//       messageLog.add(ChatMessage.fromJson(element,uid));
//     });

//     return messageLog;
//   }


//   @override
//   Widget build(BuildContext context) {
//      return Column(
//       children: [
//         FutureBuilder<List<ChatMessage>>(
//           future: fetchMessage(),
//           builder: (context, snapshot) {
//             if(snapshot.hasData) {
//               return ListMessage(messList: snapshot.data!);
//             }
//             else 
//             {
//               return const Center(
//                 child: Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                     child: Text('Hiện các bạn đã là bạn bè hãy chat với nhau đi nào'),
//                   )
//                 ) 
//               );
//             }
//           }, 
//         ),
//         ChatInputField(id_room: id_room),
//       ],
//     );
//   }
// }

// class ListMessage extends StatelessWidget {
//   final List<ChatMessage> messList;
//   const ListMessage({super.key, required this.messList});

//   @override
//   Widget build(BuildContext context) {
//     return 
//       Expanded(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//           child: ListView.builder(
//             itemCount: messList.length,
//             itemBuilder: (context, index) =>
//                 Message(message: messList[index]),
//           ),
//         ),
//       );
//   }
// }