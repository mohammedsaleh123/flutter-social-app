import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialapp/futures/chat/view/widgets/chat_list.dart';
import 'package:socialapp/futures/chat/view/widgets/send_chat.dart';
import 'package:socialapp/futures/controller/chat_controller.dart';
import 'package:socialapp/futures/model/user_model.dart';

// ignore: must_be_immutable
class ChatBody extends StatelessWidget {
  ChatBody({super.key, required this.user});
  ChatController controller = Get.put(ChatController());
  UserModel user;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ListChat(user: user),
        SendChat(user: user),
      ],
    );
  }
}
