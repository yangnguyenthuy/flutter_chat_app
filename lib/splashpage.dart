import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_app/login/loginscreen.dart';

class SplashPage extends StatelessWidget {
  static String routeName = "/splash";

  @override
  Widget build(BuildContext context) {
    new Future.delayed(new Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(
          context, LoginScreen.routeName, (Route<dynamic> route) => false);
    });
    return Scaffold(
        body: SafeArea(
            child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              decoration: BoxDecoration(
                  color: Colors.blue
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    strokeWidth: 5,
                  ),
                  SizedBox(height: 5,),
                  Text('Loading...', style: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),)
                ],
              ),
            )
        )
    );
  }
}