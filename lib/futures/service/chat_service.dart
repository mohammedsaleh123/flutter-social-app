import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:socialapp/futures/model/chat_model.dart';

class ChatService {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<ChatModel>> getChats(String chatRoomId) {
    final snapshot = firestore
        .collection("chats")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy('createdAt', descending: false)
        .snapshots();
    return snapshot.map((event) =>
        event.docs.map((e) => ChatModel.fromJson(e.data())).toList());
  }

  Future<void> addMessage(String chatRoomId, chatMessageData) async {
    await firestore
        .collection("chats")
        .doc(chatRoomId)
        .collection("messages")
        .add(chatMessageData);
  }

  Stream getUserChats(String itIsMyName) {
    return firestore
        .collection("chatRoom")
        .where('users', arrayContains: itIsMyName)
        .snapshots();
  }
}
