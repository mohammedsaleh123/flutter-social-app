import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:socialapp/core/app_colors.dart';
import 'package:socialapp/core/extension/padding_extension.dart';
import 'package:socialapp/core/widgets/custom_text.dart';
import 'package:socialapp/futures/controller/chat_controller.dart';
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

class CustomChatBubble extends StatelessWidget {
  CustomChatBubble({
    super.key,
    required this.snapshot,
    required this.user,
    required this.currentUser,
    required this.index,
  });

  ChatModel snapshot;
  final UserModel user;
  final String currentUser;
  int index;

  @override
  Widget build(BuildContext context) {
    return ChatBubble(
      margin: EdgeInsets.all(8.sp),
      backGroundColor: snapshot.senderId == currentUser
          ? Colors.blue
          : offLightC.withOpacity(0.1),
      alignment: snapshot.senderId == currentUser
          ? Alignment.topRight
          : Alignment.topLeft,
      clipper: ChatBubbleClipper1(
        type: snapshot.senderId == currentUser
            ? BubbleType.sendBubble
            : BubbleType.receiverBubble,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            child: snapshot.messageImage == ''
                ? const SizedBox()
                : Image.network(
                    snapshot.messageImage!,
                    height: 150.h,
                    width: 150.w,
                    fit: BoxFit.fill,
                  ).padding(4.w, 4.h),
          ),
          CustomText(
            text: snapshot.message,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ).padding(4.w, 4.h),
        ],
      ),
    );
  }
}
