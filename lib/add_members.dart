import 'package:flutter/material.dart';
import 'package:flutter_chat_app/group_chat_screen.dart';

class AddMembers extends StatefulWidget {
  const AddMembers({super.key});

  @override
  State<AddMembers> createState() => _AddMembersState();
}

class _AddMembersState extends State<AddMembers> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Thêm thành viên",),
      ),

      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context,index) {
                  return ListTile(
                    onTap: () {},
                    leading: Icon(Icons.account_circle),
                    title: Text("User $index"),
                    trailing: Icon(Icons.close),
                  );
                }
              ), 
            ),
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
          ]
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.forward),
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => GroupChatScreen())),
      ),
    );
  }
}