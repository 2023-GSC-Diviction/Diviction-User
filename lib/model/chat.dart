class ChatRoom {
  String chatRoomId;
  ChatMember counselor;
  ChatMember user;
  List<Message> messages;

  ChatRoom(
      {required this.chatRoomId,
      required this.counselor,
      required this.user,
      required this.messages});

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
        chatRoomId: json['chatRoomId'],
        counselor: json['counselor']
            .map((counselor) => ChatMember.fromJson(counselor)),
        user: json['user'].map((user) => ChatMember.fromJson(user)),
        messages: json['messages']
            .map((message) => Message.fromJson(message))
            .toList());
  }

  Map<String, dynamic> toJson() {
    return {
      'chatRoomId': chatRoomId,
      'counselor': counselor.toJson(),
      'user': user.toJson(),
      'messages': messages.map((message) => message.toJson()).toList()
    };
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
  toJson() {
    return {
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'role': role,
    };
  }
}

class Message {
  String content;
  String sender;
  String createdAt;

  Message(
      {required this.content, required this.sender, required this.createdAt});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        content: json['content'],
        sender: json['sender'],
        createdAt: json['createdAt']);
  }
  toJson() {
    return {
      'content': content,
      'sender': sender,
      'createdAt': createdAt,
    };
  }
}

class MyChat {
  String chatRoomId;
  String email;
  String name;
  String photoUrl;
  String lastMessage;

  MyChat(
      {required this.chatRoomId,
      required this.email,
      required this.name,
      required this.photoUrl,
      required this.lastMessage});

  factory MyChat.fromJson(Map<String, dynamic> json) {
    return MyChat(
        chatRoomId: json['chatRoomId'],
        email: json['email'],
        name: json['name'],
        photoUrl: json['photoUrl'],
        lastMessage: json['lastMessage']);
  }
  toJson() {
    return {
      'chatRoomId': chatRoomId,
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
      'lastMessage': lastMessage,
    };
  }
}
