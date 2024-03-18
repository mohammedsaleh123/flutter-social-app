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

  Future<void> addMessage(
      String chatRoomId, chatMessageData, String otherUserId) async {
    await firestore
        .collection("chats")
        .doc(chatRoomId)
        .collection("messages")
        .add(chatMessageData);
    firestore.collection('users').doc(otherUserId).update({
      'savedChat': FieldValue.arrayUnion([chatRoomId])
    });
    firestore.collection('users').doc(auth.currentUser!.uid).update({
      'savedChat': FieldValue.arrayUnion([chatRoomId])
    });
  }

  Stream<List<ChatModel>> getUserChats(String chatRoomId) {
    final snapshot = firestore
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .snapshots();
    return snapshot.map((event) {
      return event.docs.map((e) => ChatModel.fromJson(e.data())).toList();
    });
  }
}
