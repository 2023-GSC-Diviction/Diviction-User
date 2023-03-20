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
    getUserId();
  }

  final DatabaseReference _ref = FirebaseDatabase.instance.ref();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<MyChat> userChatlist = [];
  late SharedPreferences prefs;

  String user = '';

  getUserId() async {
    prefs = await SharedPreferences.getInstance();
    user = prefs.getString('email')!.replaceAll('.', '');
  }

  Future<List<MyChat>> getChatList() async {
    try {
      final snapshot = await _firestore.collection('users').doc(user).get();
      if (snapshot.exists) {
        final List<MyChat> chats = [];
        final data = snapshot.data()?.values.first as List;
        if (data != null) {
          for (var e in data) {
            chats.add(MyChat.fromJson(e));
          }
          return chats;
        } else {
          return [];
        }
      } else {
        return [];
      }
      // final snapshot = await _ref
      //     .child('users')
      //     .child(user)
      //     .get()
      //     .catchError((e) => print(e.toString()));
      // if (snapshot.exists) {
      //   final data = List<Map>.from((snapshot.value));
      //   return data.map((e) => MyChat.fromJson(e)).toList();
      // }
      // return userChatlist.map((e) => MyChat.fromJson(e)).toList();
    } catch (e) {
      throw e;
    }
  }

  Stream<List<MyChat>> getChatListData() async* {
    try {
      final data =
          _firestore.collection('users').doc(user).snapshots().map((event) {
        final data = List<Map>.from((event.data() as Map)['chatList']);
        return data.map((e) => MyChat.fromJson(e)).toList();
      });
      yield* data;
      // final data = _ref
      //     .child('users')
      //     .child(user)
      //     .onValue
      //     .map((event) => event.snapshot.value as List<Map>);
      // yield* data.map((e) => e.map((e) => MyChat.fromJson(e)).toList());
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
      // _ref.child(chatroomId).onValue.map((event) =>
      //     ChatRoom.fromJson(event.snapshot.value as Map<dynamic, dynamic>));
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
            .update({'messages': messages});
      }
      // final snapshot = await _ref.child(chatRoomId).get();
      // if (snapshot.exists && snapshot.value != null) {
      //   final messages = (snapshot.value! as Map<String, dynamic>)['messages'];
      //   messages.add({
      //     'content': message.content,
      //     'sender': message.sender,
      //     'createdAt': message.createdAt
      //   });
      //   _ref.child(chatRoomId).update({'messages': messages});
      // }
      // _ref.child(chatRoomId).update({
      //   'messages': {
      //     'content': message.content,
      //     'sender': message.sender,
      //     'createdAt': message.createdAt
      //   }
      // });
    } catch (e) {
      print(e);
    }
  }

  // Future sendImage() {}

  Future newChatRoom(ChatRoom chatroom, Message message) async {
    final other =
        chatroom.counselor.email == user ? chatroom.user : chatroom.counselor;
    final newChat = MyChat(
        chatRoomId: chatroom.chatRoomId,
        email: other.email,
        name: other.name,
        photoUrl: other.photoUrl ?? '1',
        lastMessage: message.content);

    final snapshot = await _firestore.collection('users').doc(user).get();

    if (snapshot.exists) {
      List<MyChat> rooms = [];
      final data = snapshot.data()!['chatlist'];
      for (var e in data) {
        rooms.add(MyChat.fromJson(e));
      }
      userChatlist = rooms;
      // userChatlist = snapshot
      //     .data()!['chatlist']
      //     .map<MyChat>((e) => MyChat.fromJson(e))
      //     .toList();
      if (userChatlist.isEmpty) {
        userChatlist = [newChat];
      } else {
        userChatlist.add(newChat);
      }
    }

    _firestore
        .collection('users')
        .doc(user)
        .set({'chatlist': userChatlist.map((e) => e.toJson()).toList()});
    _firestore
        .collection('chatrooms')
        .doc(chatroom.chatRoomId)
        .set(chatroom.toJson());

    // final snapshot = await _ref.child('users').child(user).get();

    // if (snapshot.exists) {
    //   userChatlist = snapshot.value as List<MyChat>;
    //   if (userChatlist.isEmpty) {
    //     userChatlist = [newChat];
    //   } else {
    //     userChatlist.add(newChat);
    //   }
    // } else {
    //   userChatlist = [newChat];
    // }
    // _ref
    //     .child('users')
    //     .child(user)
    //     .set(userChatlist.map((e) => e.toJson()).toList())
    //     .then((value) => print('success'));
    // _ref
    //     .child(chatroom.chatRoomId)
    //     .set(chatroom.toJson())
    //     .then((value) => print('success'));
  }
}
