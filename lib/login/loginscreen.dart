import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/config/api_connection.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_chat_app/home/homescreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginScreen extends StatefulWidget {
  static String routeName="/login";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data){
    return Future.delayed(loginTime).then((_) async {
      var res = await http.post(
        Uri.parse(API.userSignIn),
        body: {
          "Username": data.name,
          "Password": data.password,
        },
      );

      if(res.statusCode == 200)
      {
        var resBodyOfSignUp = jsonDecode(res.body);
        if(resBodyOfSignUp["Status"] == "Success")
        {
          var id = resBodyOfSignUp["id_acc"];
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('name', data.name);
          prefs.setString('acc_id', id);
          return null;
        }
        else
        {
          return 'User not exists';
        }
      }
    });
  }

  Future<String?> _signupUser(SignupData data) {
    // debugPrint('Signup Name: ${data.name}, Password: ${data.password}, Username: ${data.additionalSignupData?.values.toString()}');
    return Future.delayed(loginTime).then((_) async {
      var username;
      for(var value in data.additionalSignupData!.values)
      {
        username = value;
      }
      // debugPrint(username);
      var res = await http.post(
        Uri.parse(API.userSignUp),
        body: {
          "Username": data.name,
          "Password": data.password,
          "Name": username,
        },
      );

      if(res.statusCode == 200)
      {
        var resBodyOfSignUp = jsonDecode(res.body);
        if(resBodyOfSignUp["Status"] == "Success")
        {
          //var id = resBodyOfSignUp["id_acc"];
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('name', data.name!);
          //prefs.setString('acc_id', id);
          return null;
        }
        else
        {
          return 'Tài khoản này đã tồn tại';
        }
      }
      
      return null;
    });
  }

  Future<String?> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return null;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkLogin();
  }

  _checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var name = prefs.getString('name');
    if(name != null) {
    Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext ctx) => HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'TTS CHAT',
      logo: AssetImage('chatlogo.png'),
      onLogin: _authUser,
      onSignup: _signupUser,
      additionalSignupFields: 
        <UserFormField> [
          UserFormField(
            keyName: 'username',
            displayName: 'Tên người dùng',
            icon: Icon(Icons.person),
          ),
        ],
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}