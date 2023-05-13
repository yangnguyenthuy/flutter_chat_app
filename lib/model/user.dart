class User {
  final String name, image, status;

  User({
    this.name = '',
    this.image = '',
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
        status: y,
      );
      return x;
  }
}