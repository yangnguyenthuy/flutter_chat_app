import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/chatroom/components/chatinputfield.dart';
import 'package:flutter_chat_app/chatroom/components/message.dart';
import 'package:flutter_chat_app/model/message.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_chat_app/config/api_connection.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';

class Body extends StatefulWidget {
  const Body({super.key, required this.id_room});
  final int id_room;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late String _now;
  late Timer _everySecond;
  List<ChatMessage> _messageHistory = [];
  final TextEditingController _controller = TextEditingController();
  bool emojiShowing = false;

  File? imagepath;
  String? imagename;
  // String? imagedata;

  ImagePicker imagePicker = ImagePicker();

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
      _controller.clear();
    }

    setState(() {
      _loadMessage();
    });
  }

  getImage() async {
    // FilePickerResult? result = await FilePicker.platform.pickFiles();
    XFile? getimage = await imagePicker.pickImage(source: ImageSource.gallery);
    imagepath = File(getimage!.path);
    imagename = getimage.path.split('/').last;

    print(imagepath);
    print(imagename);

    var imagedata = base64Encode(imagepath!.readAsBytesSync());
    print(imagedata);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('acc_id');
    var room = widget.id_room;

    var res = await http.post(Uri.parse(API.uploadImage), body: {
      "data": imagedata,
      "name": imagename,
      "acc_id": id,
      "room_id": room,
    });

    var response = jsonDecode(res.body);

    if(response["success"] == "true")
    {
      print("done");
    }
    else
    {
      print("No Okay");
    }
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
            child: ScrollablePositionedList.builder(
              itemCount: _messageHistory.length,
              itemBuilder: (context, index) =>
                  Message(message: _messageHistory[index]),
                  
            ),
          ),
        ),
        SizedBox(height: 10,),

        Container(
          height: 66.0,
          color: Colors.blue,
          child: Row(
            children: [
              Material(
                color: Colors.transparent,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      emojiShowing = !emojiShowing;
                    });
                  },
                  icon: const Icon(
                    Icons.emoji_emotions,
                    color: Colors.white,
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: IconButton(
                  onPressed: () {
                      getImage();
                  },
                  icon: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                      controller: _controller,
                      style: const TextStyle(
                          fontSize: 20.0, color: Colors.black87),
                      decoration: InputDecoration(
                        hintText: 'Nhập tin nhắn',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(
                            left: 16.0,
                            bottom: 8.0,
                            top: 8.0,
                            right: 16.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      )
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: IconButton(
                    onPressed: () {
                      // send message
                      _sendMessage(_controller.text);
                    },
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                    )
                ),
              )
            ],
          )
      ),
      Offstage(
        offstage: !emojiShowing,
        child: SizedBox(
            height: 250,
            child: EmojiPicker(
              textEditingController: _controller,
              config: Config(
                  columns: 7,
                  emojiSizeMax: 32 * (foundation.defaultTargetPlatform == TargetPlatform.iOS ? 1.30 : 1.0), // Issue: https://github.com/flutter/flutter/issues/28894
                  verticalSpacing: 0,
                  horizontalSpacing: 0,
                  gridPadding: EdgeInsets.zero,
                  initCategory: Category.RECENT,
                  bgColor: Color(0xFFF2F2F2),
                  indicatorColor: Colors.blue,
                  iconColor: Colors.grey,
                  iconColorSelected: Colors.blue,
                  backspaceColor: Colors.blue,
                  skinToneDialogBgColor: Colors.white,
                  skinToneIndicatorColor: Colors.grey,
                  enableSkinTones: true,
                  showRecentsTab: true,
                  recentsLimit: 28,
                  noRecents: const Text(
                    'No Recents',
                    style: TextStyle(fontSize: 20, color: Colors.black26),
                    textAlign: TextAlign.center,
                  ), // Needs to be const Widget
                  loadingIndicator: const SizedBox.shrink(), // Needs to be const Widget
                  tabIndicatorAnimDuration: kTabScrollDuration,    
                  categoryIcons: const CategoryIcons(),
                  buttonMode: ButtonMode.MATERIAL,
              ),
            )
          ),
      ),

        // Container(
        //   padding: EdgeInsets.symmetric(
        //     horizontal: 20.0,
        //     vertical: 20.0 / 2,
        //   ),
        //   decoration: BoxDecoration(
        //     color: Theme.of(context).scaffoldBackgroundColor,
        //     boxShadow: [
        //       BoxShadow(
        //         offset: Offset(0, 4),
        //         blurRadius: 32,
        //         color: Color(0xFF087949).withOpacity(0.08),
        //       ),
        //     ],
        //   ),
        //   child: SafeArea(
        //     child: Row(
        //       children: [
        //         Icon(Icons.mic, color: Theme.of(context).appBarTheme.backgroundColor),
        //         SizedBox(width: 20.0),
        //         Expanded(
        //           child: Container(
        //             padding: EdgeInsets.symmetric(
        //               horizontal: 20.0 * 0.75,
        //             ),
        //             decoration: BoxDecoration(
        //               color: Color(0xFF00BF6D).withOpacity(0.05),
        //               borderRadius: BorderRadius.circular(40),
        //             ),
        //             child: Row(
        //               children: [
        //                 Icon(
        //                   Icons.sentiment_satisfied_alt_outlined,
        //                   color: Theme.of(context)
        //                       .textTheme
        //                       .bodyLarge!
        //                       .color!
        //                       .withOpacity(0.64),
        //                 ),
        //                 SizedBox(width: 20.0 / 4),
        //                 Expanded(
        //                   child: TextField(
        //                     controller: inputContent,
        //                     decoration: InputDecoration(
        //                       hintText: "Type message",
        //                       border: InputBorder.none,
        //                     ),
        //                   ),
        //                 ),
        //                 IconButton(
        //                   onPressed: () {
        //                     var content = inputContent.text;
        //                     _sendMessage(content);
        //                   }, 
        //                   icon: Icon(
        //                           Icons.send,
        //                           color: Theme.of(context)
        //                               .textTheme
        //                               .bodyLarge!
        //                               .color!
        //                               .withOpacity(0.64),
        //                         ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),

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