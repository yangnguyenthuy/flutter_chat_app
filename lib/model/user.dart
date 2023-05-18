import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/api_connection.dart';

class User {
  var data = [];
  List<User> results = [];

  Future<List<User>> getuserList({String? query}) async {
    var url = Uri.parse(API.search);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
      
        data = json.decode(response.body);
        results = data.map((e) => User.fromJson(e)).toList();
        print("${results[0]}");
        if (query!= null){
          results = results.where((element) => element.name.toLowerCase().contains((query.toLowerCase()))).toList();
        }
      } else {
        print("fetch error");
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return results;
  }

  final String name, image, email, status;

  User({
    this.name = '',
    this.image = '',
    this.email = '',
    this.status = '',
  });

  factory User.fromJson(Map<String, dynamic> json) {
    var y;
      if(json['status'] == 0) 
      {
        y = "Offline";
      }
      else 
      {
        y = "Online";
      }
      var x = User(
        name: json['name'],
        image: json['img'],
        email: json['username'],
        status: y,
      );
      return x;
  }
}