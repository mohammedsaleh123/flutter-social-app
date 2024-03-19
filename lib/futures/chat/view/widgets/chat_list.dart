import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialapp/controller/chat_controller.dart';
import 'package:socialapp/futures/chat/view/widgets/custom_chat_bubble.dart';
import 'package:socialapp/futures/model/chat_model.dart';
import 'package:socialapp/futures/model/user_model.dart';
import 'package:socialapp/futures/service/chat_service.dart';

// ignore: must_be_immutable
class ListChat extends StatelessWidget {
  ListChat({super.key, required this.user});
  UserModel user;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  ChatController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    List<String> chatRoom = [auth.currentUser!.uid, user.uid];
    chatRoom.sort();
    String chatId = chatRoom.join('-');
    return StreamBuilder<List<ChatModel>>(
        stream: ChatService().getChats(chatId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong!'),
            );
          }
          if (snapshot.data == null) {
            return const Center(
              child: Text('No messages found!'),
            );
          }
          return Expanded(
            child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return CustomChatBubble(
                    snapshot: snapshot.data![index],
                    user: user,
                    currentUser: auth.currentUser!.uid,
                    index: index,
                  );
                }),
          );
        });
  }
}
