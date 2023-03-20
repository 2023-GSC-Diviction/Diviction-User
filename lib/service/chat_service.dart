import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diviction_user/model/chat.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatService {
  static final ChatService _chatService = ChatService._internal();
  factory ChatService() {
    return _chatService;
  }
  ChatService._internal() {
    getUserEmail();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<MyChat> userChatlist = [];
  late SharedPreferences prefs;

  String userEamil = '';

  getUserEmail() async {
    prefs = await SharedPreferences.getInstance();
    userEamil = prefs.getString('email')!.replaceAll('.', '');
  }

  Future<List<MyChat>> getChatList() async {
    try {
      final snapshot = await _firestore.collection('users').doc(userEamil).get();
      if (snapshot.exists) {
        final List<MyChat> chats = [];
        final data = snapshot.data()?.values.first as List;

        for (var e in data) {
          chats.add(MyChat.fromJson(e));
        }
        return chats;
      } else {
        return [];
      }
    } catch (e) {
      throw e;
    }
  }

  Stream<List<MyChat>> getChatListData() async* {
    try {
      final data =
          _firestore.collection('users').doc(userEamil).snapshots().map((event) {
        final List<MyChat> chats = [];
        final list = event.data()?.values.first as List;
        for (var e in list) {
          chats.add(MyChat.fromJson(e));
        }
        return chats;
      });
      yield* data;
    } catch (e) {
      throw e;
    }
  }

  Stream<ChatRoom> getChatRoomData(String chatroomId) {
    try {
      final stream = _firestore
          .collection('chatrooms')
          .doc(chatroomId)
          .snapshots()
          .map((event) => ChatRoom.fromDocumentSnapshot(event));

      return stream;
    } catch (e) {
      throw e;
    }
  }

  void sendMessage(String chatRoomId, Message message) async {
    try {
      final snapshot =
          await _firestore.collection('chatrooms').doc(chatRoomId).get();
      if (snapshot.exists) {
        final roomData = ChatRoom.fromDocumentSnapshot(snapshot);
        final messages = roomData.messages;
        messages.add(message);
        _firestore
            .collection('chatrooms')
            .doc(chatRoomId)
            .update({'messages': messages.map((e) => e.toJson()).toList()});
      }
    } catch (e) {
      print(e);
    }
  }

  // Future sendImage() {}

  Future newChatRoom(ChatRoom chatroom, Message message) async {
    final other =
        chatroom.counselor.email == userEamil ? chatroom.user : chatroom.counselor;
    final newChat = MyChat(
        chatRoomId: chatroom.chatRoomId,
        email: other.email,
        name: other.name,
        photoUrl: other.photoUrl ?? '1',
        lastMessage: message.content);

    final snapshot = await _firestore.collection('users').doc(userEamil).get();

    if (snapshot.exists) {
      List<MyChat> rooms = [];
      final data = snapshot.data()!['chatlist'];
      for (var e in data) {
        rooms.add(MyChat.fromJson(e));
      }
      userChatlist = rooms;

      if (userChatlist.isEmpty) {
        userChatlist = [newChat];
      } else {
        userChatlist.add(newChat);
      }
    }

    _firestore
        .collection('users')
        .doc(userEamil)
        .set({'chatlist': userChatlist.map((e) => e.toJson()).toList()});
    _firestore
        .collection('chatrooms')
        .doc(chatroom.chatRoomId)
        .set(chatroom.toJson());
  }
}
