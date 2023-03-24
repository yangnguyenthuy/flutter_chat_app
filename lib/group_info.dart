import 'package:flutter/material.dart';

class GroupInfo extends StatefulWidget {
  const GroupInfo({super.key});

  @override
  State<GroupInfo> createState() => _GroupInfoState();
}

class _GroupInfoState extends State<GroupInfo> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: BackButton(),
              ),          
              Container(
                height: size.height / 8,
                width: size.width / 1.1,
                child: Row(
                  children: [
                    Container(
                      height: size.height / 11,
                      width: size.height / 11,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                      child: Icon(
                        Icons.group,
                        color: Colors.white,
                        size: size.width / 10,
                      ),
                    ),
                    SizedBox(
                      width: size.width / 20,
                    ),
                    Expanded(
                      child: Container(
                        child: Text(
                          "Group Name",
                          style: TextStyle(
                            fontSize: size.width / 16, 
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height / 20,
              ),
              Container(
                width: size.width / 1.1,
                child: Text(
                  "60 members",
                  style: TextStyle(
                    fontSize: size.width /30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              SizedBox(
                height: size.height / 20,
              ),

              Flexible(
                child: ListView.builder(
                  itemCount: 60,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index) {
                    return ListTile(
                      leading: Icon(Icons.account_circle),
                      title: Text(
                        "User $index",
                        style: TextStyle(
                          fontSize: size.width / 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }
                )
              ),

              SizedBox(
                height: size.height / 20,
              ),

              ListTile(
                leading: Icon(Icons.logout, color: Colors.red,),
                title: Text(
                  "Rời khỏi đoạn chat",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: size.width / 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}