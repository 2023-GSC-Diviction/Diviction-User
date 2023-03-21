import 'package:cloud_firestore/cloud_firestore.dart';

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

  factory ChatRoom.fromJson(Map<dynamic, dynamic> json) {
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

  factory ChatRoom.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final List<Message> message = [];
    final messageSnapshot = List<Map>.from(snapshot['messages'] as List);
    for (var e in messageSnapshot) {
      message.add(Message.fromJson(e as Map<String, dynamic>));
    }
    return ChatRoom(
        chatRoomId: snapshot['chatRoomId'],
        counselor:
            ChatMember.fromJson(snapshot['counselor'] as Map<String, dynamic>),
        // .map((counselor a) => ChatMember.fromJson(counselor)),
        user: ChatMember.fromJson(snapshot['user'] as Map<String, dynamic>),
        messages: message);
    // .map((message) => Message.fromJson(message))
    // .toList());
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
  String otherEmail;
  String otherName;
  String otherPhotoUrl;
  String lastMessage;

  MyChat(
      {required this.chatRoomId,
      required this.otherEmail,
      required this.otherName,
      required this.otherPhotoUrl,
      required this.lastMessage});

  factory MyChat.fromJson(Map<dynamic, dynamic> json) {
    return MyChat(
        chatRoomId: json['chatRoomId'],
        otherEmail: json['otherEmail'],
        otherName: json['otherName'],
        otherPhotoUrl: json['otherPhotoUrl'],
        lastMessage: json['lastMessage']);
  }
  toJson() {
    return {
      'chatRoomId': chatRoomId,
      'otherEmail': otherEmail,
      'otherName': otherName,
      'otherPhotoUrl': otherPhotoUrl,
      'lastMessage': lastMessage,
    };
  }

  // factory MyChat.fromDocumentSnapshot
}
