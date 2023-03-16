class ChatRoom {
  String chatRoomId;
  String counselor;
  String user;
  List<Message> messages;

  ChatRoom(
      {required this.chatRoomId,
      required this.counselor,
      required this.user,
      required this.messages});

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
        chatRoomId: json['chatRoomId'],
        counselor: json['counselor'],
        user: json['user'],
        messages: json['messages']);
  }
}

class ChatMember {
  String name;
  String email;
  String? photoUrl;
  String role;

  ChatMember(
      {required this.name,
      required this.email,
      this.photoUrl,
      required this.role});

  factory ChatMember.fromJson(Map<String, dynamic> json) {
    return ChatMember(
        name: json['name'],
        email: json['email'],
        photoUrl: json['photoUrl'],
        role: json['role']);
  }
}

class Message {
  String message;
  String sender;
  String createdAt;

  Message(
      {required this.message, required this.sender, required this.createdAt});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        message: json['message'],
        sender: json['sender'],
        createdAt: json['createdAt']);
  }
}
