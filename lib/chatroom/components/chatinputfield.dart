import 'dart:convert';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/api_connection.dart';

class ChatInputField extends StatefulWidget {
  const ChatInputField({super.key, required this.id_room});
  final int id_room;
  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final inputContent = TextEditingController();

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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    // SizedBox(width: 20.0 / 4),
                    // Icon(
                    //   Icons.camera_alt_outlined,
                    //   color: Theme.of(context)
                    //       .textTheme
                    //       .bodyLarge!
                    //       .color!
                    //       .withOpacity(0.64),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class ChatInputField extends StatelessWidget {
//   const ChatInputField({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(
//         horizontal: 20.0,
//         vertical: 20.0 / 2,
//       ),
//       decoration: BoxDecoration(
//         color: Theme.of(context).scaffoldBackgroundColor,
//         boxShadow: [
//           BoxShadow(
//             offset: Offset(0, 4),
//             blurRadius: 32,
//             color: Color(0xFF087949).withOpacity(0.08),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         child: Row(
//           children: [
//             Icon(Icons.mic, color: Theme.of(context).appBarTheme.backgroundColor),
//             SizedBox(width: 20.0),
//             Expanded(
//               child: Container(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 20.0 * 0.75,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Color(0xFF00BF6D).withOpacity(0.05),
//                   borderRadius: BorderRadius.circular(40),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(
//                       Icons.sentiment_satisfied_alt_outlined,
//                       color: Theme.of(context)
//                           .textTheme
//                           .bodyLarge!
//                           .color!
//                           .withOpacity(0.64),
//                     ),
//                     SizedBox(width: 20.0 / 4),
//                     Expanded(
//                       child: TextField(
//                         decoration: InputDecoration(
//                           hintText: "Type message",
//                           border: InputBorder.none,
//                         ),
//                       ),
//                     ),
//                     Icon(
//                       Icons.attach_file,
//                       color: Theme.of(context)
//                           .textTheme
//                           .bodyLarge!
//                           .color!
//                           .withOpacity(0.64),
//                     ),
//                     SizedBox(width: 20.0 / 4),
//                     Icon(
//                       Icons.camera_alt_outlined,
//                       color: Theme.of(context)
//                           .textTheme
//                           .bodyLarge!
//                           .color!
//                           .withOpacity(0.64),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }