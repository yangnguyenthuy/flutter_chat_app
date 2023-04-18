import 'dart:convert';
import 'dart:html';
import 'dart:math';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/LoginScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {

  TextEditingController _name = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  Future signUp() async {
    var url = "http://192.168.1.7/flutter_chat/xuly/dangky.php";
    if(_name.text == "" || _username.text == "" || _password.text == "" )
    {
      Fluttertoast.showToast(msg: "Vui lòng điền đủ thông tin");
    }
    else
    {
      var res = await http.post(Uri.parse(url), body: {
          "Name": _name.text,
          "Username": _username.text,
          "Password": _password.text,
      });

      var data = jsonDecode(res.body);
      if (data == "Success")
      {
        Fluttertoast.showToast(msg: "Đăng Ký Thành Công");
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => LoginScreen()));
      }
      else
      {
        Fluttertoast.showToast(msg: "Tài Khoản đã tồn tại");
      }     
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height / 20,
            ),
            /*Container(
              alignment: Alignment.centerLeft,
              width: size.width / 1.2,
              child: IconButton(
                  icon: Icon(Icons.arrow_back_ios), onPressed: () {}),
            ),*/
            SizedBox(
              height: size.height / 50,
            ),
            Container(
              width: size.width / 1.3,
              alignment: Alignment.center,
              child: Text(
                "ĐĂNG KÝ",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: size.height / 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Container(
                width: size.width,
                alignment: Alignment.center,
                child: field(size, "Tên đăng nhập", Icons.account_box, _name),
              ),
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

            GestureDetector(
              onTap: signUp,
              child: customButton(size),
            ),

            SizedBox(
              height: size.height / 5,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => LoginScreen())),
              child: Text(
                "Đăng nhập",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customButton(Size size) {
    return Container(
      height: size.height / 14,
      width: size.width / 1.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue,
      ),
      alignment: Alignment.center,
      child: Text(
        "Đăng Ký",
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget field(Size size, String hintText, IconData icon, TextEditingController cont) {
    return Container(
      height: size.height / 12,
      width: size.width / 1.2,
      child: TextField(
        controller: cont,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
