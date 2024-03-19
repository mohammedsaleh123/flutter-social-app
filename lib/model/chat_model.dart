import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String chatId;
  final String senderId;
  final String receiverId;
  final String message;
  final Timestamp createdAt;
  String? messageImage;

  ChatModel({
    required this.chatId,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.createdAt,
    this.messageImage,
  });

  Map<String, dynamic> toJson() {
    return {
      'chatId': chatId,
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'createdAt': createdAt,
      'messageImage': messageImage,
    };
  }

  static ChatModel fromJson(Map<String, dynamic> json) {
    return ChatModel(
      chatId: json['chatId'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      message: json['message'],
      createdAt: json['createdAt'],
      messageImage: json['messageImage'],
    );
  }

  Stream<ChatModel> fromFirestore(DocumentSnapshot snapshot) {
    return snapshot.reference.snapshots().map((event) {
      return ChatModel.fromJson(event.data() as Map<String, dynamic>);
    });
  }
}
