import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

import '../../model/message.dart';

class VideoMessage extends StatelessWidget {
  final ChatMessage? message;
  const VideoMessage({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.45, // 45% of total width
      child: AspectRatio(
        aspectRatio: 1.6,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              //child: Image.asset("assets/images/Video Place Here.png"),
              child: Image.network('http://localhost/flutter_chat/upload/${message!.text}'),
            ),
            // Container(
            //   height: 25,
            //   width: 25,
            //   decoration: BoxDecoration(
            //     color: Color(0xFF00BF6D),
            //     shape: BoxShape.circle,
            //   ),
            //   child: Icon(
            //     Icons.play_arrow,
            //     size: 16,
            //     color: Colors.white,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}