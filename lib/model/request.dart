import 'dart:convert';

class FriendRequest {
  final int idRequest;
  final String email;
  final String name;
  final String avatar;

  FriendRequest({
    this.idRequest = 0,
    this.email = '',
    this.name = '',
    this.avatar = '',
  });

  static List<FriendRequest> allFromResponse(String response) {
    var decodedJson = json.decode(response);

    return decodedJson
        .map((obj) => FriendRequest.fromMap(obj))
        .toList()
        .cast<FriendRequest>();
  }

  static FriendRequest fromMap(Map map) {
    return FriendRequest(
      idRequest: int.parse(map['id']),
      email: map['username'],
      name: map['name'],
      avatar: map['img'],
    );
  }
}