import 'dart:math';

import 'package:diviction_user/model/chat.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatService {
  static final ChatService _chatService = ChatService._internal();
  factory ChatService() {
    return _chatService;
  }
  ChatService._internal() {
    getUserId();
  }

  final DatabaseReference _ref = FirebaseDatabase.instance.ref();
  List<MyChat> userChatlist = [];
  late SharedPreferences prefs;

  String user = '';

  getUserId() async {
    prefs = await SharedPreferences.getInstance();
    user = prefs.getString('email')!.replaceAll('.', '');
  }

  Future<List<MyChat>> getChatList() async {
    try {
      final snapshot = await _ref
          .child('users')
          .child(user)
          .get()
          .catchError((e) => print(e.toString()));
      if (snapshot.exists) {
        return snapshot.value as List<MyChat>;
      }
      // return userChatlist.map((e) => MyChat.fromJson(e)).toList();
      return [];
    } catch (e) {
      throw e;
    }
  }

  Stream<List<MyChat>> getChatListData() {
    try {
      final data = _ref
          .child('users')
          .child(user)
          .onValue
          .map((event) => event.snapshot.value as List<Map<String, dynamic>>);
      return data.map((e) => e.map((e) => MyChat.fromJson(e)).toList());
    } catch (e) {
      throw e;
    }
  }

  Stream<ChatRoom> getChatRoomData(String chatroomId) {
    try {
      return _ref.child(chatroomId).onValue.map((event) =>
          ChatRoom.fromJson(event.snapshot.value as Map<String, dynamic>));
    } catch (e) {
      throw e;
    }
  }

  void sendMessage(String chatRoomId, Message message) async {
    try {
      final snapshot = await _ref.child(chatRoomId).get();
      if (snapshot.exists && snapshot.value != null) {
        final messages = (snapshot.value! as Map<String, dynamic>)['messages'];
        messages.add({
          'content': message.content,
          'sender': message.sender,
          'createdAt': message.createdAt
        });
        _ref.child(chatRoomId).update({'messages': messages});
      }
      _ref.child(chatRoomId).update({
        'messages': {
          'content': message.content,
          'sender': message.sender,
          'createdAt': message.createdAt
        }
      });
    } catch (e) {
      print(e);
    }
  }

  // Future sendImage() {}

  Future newChatRoom(ChatRoom chatroom, Message message) async {
    final other =
        chatroom.counselor.email == user ? chatroom.user : chatroom.counselor;

    final snapshot = await _ref.child('users').child(user).get();
    final newChat = MyChat(
        chatRoomId: chatroom.chatRoomId,
        email: other.email,
        name: other.name,
        photoUrl: other.photoUrl ?? '1',
        lastMessage: message.content);
    if (snapshot.exists) {
      userChatlist = snapshot.value as List<MyChat>;
      if (userChatlist.isEmpty) {
        userChatlist = [newChat];
      } else {
        userChatlist.add(newChat);
      }
    } else {
      userChatlist = [newChat];
    }

    _ref
        .child('users')
        .child(user)
        .set(userChatlist.map((e) => e.toJson()).toList())
        .then((value) => print('success'));
    _ref
        .child(chatroom.chatRoomId)
        .set(chatroom.toJson())
        .then((value) => print('success'));
  }
}
