import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/createaccount.dart';
import 'package:flutter_chat_app/home/homescreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  Future signIn() async{
    var url = "http://192.168.1.7/flutter_chat/xuly/dangnhap.php";
    if(_username.text == "" || _password.text == "" )
    {
      Fluttertoast.showToast(msg: "Vui lòng điền đủ thông tin");
    }
    else
    {
      var res = await http.post(Uri.parse(url), body: {
        "Username": _username.text,
        "Password": _password.text,
      });

      var data = jsonDecode(res.body);
      if (data == "Success")
      {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => HomeScreen()));
      }
      else
      {
        Fluttertoast.showToast(msg: "Tài Khoản hoặc mật khẩu chưa đúng");
      }     
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: size.height / 20,
          ),
          /*Container(
            alignment: Alignment.centerLeft,
            width: size.width / 1.2,
            child:
                IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () {}),
          ),*/
          SizedBox(
            height: size.height / 50,
          ),
          Container(
            width: size.width / 1.3,
            alignment: Alignment.center,
            child: Text(
              "ĐĂNG NHẬP",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: size.height / 10,
          ),
          Container(
            width: size.width,
            alignment: Alignment.center,
            child: field(size, "Tài khoản", Icons.account_box, _username),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            child: Container(
              width: size.width,
              alignment: Alignment.center,
              child: field(size, "Mật khẩu", Icons.lock, _password),
            ),
          ),
          customButton(size),
          
          SizedBox(
            height: size.height / 5,
          ),
          GestureDetector(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => CreateAccount())),
            child: Text(
              "Đăng ký tài khoản",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget customButton(Size size) {
    return GestureDetector(
      onTap: signIn,
      child: Container(
        height: size.height / 14,
        width: size.width / 1.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue,
        ),
        alignment: Alignment.center,
        child: Text(
          "Đăng Nhập",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget field(
      Size size, String hintText, IconData icon, TextEditingController cont) {
    return Container(
      height: size.height / 12,
      width: size.width / 1.2,
      child: TextField(
        controller: cont,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
