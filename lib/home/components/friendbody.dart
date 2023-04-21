import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/home/components/friendcard.dart';
import 'package:flutter_chat_app/model/friend.dart';

class FriendBody extends StatelessWidget {
  const FriendBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: 10,
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
        Expanded(
          child: ListView.builder(
            itemCount: friendsData.length,
            itemBuilder: (context, index) => FriendCard(
              friend: friendsData[index],
            ),
          ),
        ),
      ],
    );
  }
}