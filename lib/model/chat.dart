class Chat {
  final String name, lastMessage, image, time;
  final bool isActive;

  Chat({
    this.name = '',
    this.lastMessage = '',
    this.image = '',
    this.time = '',
    this.isActive = false,
  });
}

List chatsData = [
  Chat(
    name: "Sơn Hoàng",
    lastMessage: "Đi học đi bro....",
    image: "assets/images/user.png",
    time: "3m ago",
    isActive: false,
  ),
  Chat(
    name: "Tài Nguyễn",
    lastMessage: "qa nào đồng chí...",
    image: "assets/images/user_2.png",
    time: "8m ago",
    isActive: true,
  ),
  Chat(
    name: "Thiện Khiêm",
    lastMessage: "Bớt chơi game đi m...",
    image: "assets/images/user_3.png",
    time: "5d ago",
    isActive: false,
  ),
  Chat(
    name: "Minh Mẫn",
    lastMessage: "You’re welcome :)",
    image: "assets/images/user_4.png",
    time: "5d ago",
    isActive: true,
  ),
  Chat(
    name: "Huy",
    lastMessage: "Thanks",
    image: "assets/images/user_5.png",
    time: "6d ago",
    isActive: false,
  ),
  Chat(
    name: "Đại Ka",
    lastMessage: "Hope you are doing well...",
    image: "assets/images/user.png",
    time: "3m ago",
    isActive: false,
  ),
  Chat(
    name: "Esther Howard",
    lastMessage: "Hello Abdullah! I am...",
    image: "assets/images/user_2.png",
    time: "8m ago",
    isActive: true,
  ),
  Chat(
    name: "Ralph Edwards",
    lastMessage: "Do you have update...",
    image: "assets/images/user_3.png",
    time: "5d ago",
    isActive: false,
  ),
];