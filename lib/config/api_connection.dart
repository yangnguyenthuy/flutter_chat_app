class API {
  static const host = "http://192.168.1.3/flutter_chat";

  //User
  static const userSignIn = "$host/user/dangnhap.php";
  static const userSignUp = "$host/user/dangky.php";
  static const search = "$host/user/search.php";
  
  //Chat
  static const getChatCard = "$host/chat/getchatcard.php";
  static const getChatPerson = "$host/chat/getchatperson.php";
  static const getChatMessage = "$host/chat/getchatmessage.php";
  
  //Send
  static const sendMessage = "$host/chat/sendmessage.php";

  //Friend
  static const getFriendList = "$host/friend/getfriendlist.php";
  static const sendFriendRequest = "$host/friend/sendfriendrequest.php";
  static const getFriendRequest = "$host/friend/getfriendrequest.php";
  static const friendAction = "$host/friend/friendaction.php";

  // static const follow = "$host/follow";
  // static const topic = "$host/topic";
  // static const user = "$host/user";

  // static const imageComment = "$host/image/comment";
  // static const imageTopic = "$host/image/topic";
  // static const imageUser = "$host/image/user";
}