class Group {
  final String name, lastMessage, image, time;
  final bool isActive;

  Group({
    this.name = '',
    this.lastMessage = '',
    this.image = '',
    this.time = '',
    this.isActive = false,
  });
}

List groupsData = [
  Group(
    name: "Group giải trí",
    lastMessage: "Đi học đi bro....",
    image: "assets/images/user.png",
    time: "3m ago",
    isActive: false,
  ),
  Group(
    name: "Group nghiên cứu",
    lastMessage: "qa nào đồng chí...",
    image: "assets/images/user_2.png",
    time: "8m ago",
    isActive: true,
  ),
  Group(
    name: "Group tin học",
    lastMessage: "Bớt chơi game đi m...",
    image: "assets/images/user_3.png",
    time: "5d ago",
    isActive: false,
  ),
];