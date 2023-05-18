// class Friend {
//   final int idAcc;
//   final String name, image;
//   final bool isActive;

//   Friend({
//     this.idAcc = 0,
//     this.name = '',
//     this.image = '',
//     this.isActive = false,
//   });
// }

import 'dart:convert';
import 'package:meta/meta.dart';

class Friend {
  Friend({
    required this.idAcc,
    required this.avatar,
    required this.name,
    required this.email,
    required this.idFriend,
    required this.idRoom,
  });

  final String idAcc;
  final String avatar;
  final String name;
  final String email;
  final String idFriend;
  final String idRoom;

  static List<Friend> allFromResponse(String response) {
    var decodedJson = json.decode(response);

    return decodedJson
        .map((obj) => Friend.fromMap(obj))
        .toList()
        .cast<Friend>();
  }

  static Friend fromMap(Map map) {
    return new Friend(
      idAcc: map['id_acc'],
      avatar: map['img'],
      name: map['name'],
      email: map['username'],
      idFriend: map['id'],
      idRoom: map['room'],
    );
  }

  static String _capitalize(String input) {
    return input.substring(0, 1).toUpperCase() + input.substring(1);
  }
}