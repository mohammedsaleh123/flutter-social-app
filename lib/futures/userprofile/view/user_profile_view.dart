import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialapp/core/widgets/custom_text.dart';
import 'package:socialapp/futures/chat/view/chat_view.dart';
import 'package:socialapp/model/user_model.dart';
import 'package:socialapp/futures/userprofile/view/user_profile_body.dart';

// ignore: must_be_immutable
class UserProfileView extends StatelessWidget {
  UserProfileView({super.key, required this.user});
  FirebaseAuth auth = FirebaseAuth.instance;
  UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: user.userName),
        actions: [
          SizedBox(
            child: user.uid != auth.currentUser!.uid
                ? IconButton(
                    onPressed: () {
                      Get.to(() => ChatView(user: user));
                    },
                    icon: const Icon(Icons.chat_bubble))
                : const SizedBox(),
          ),
        ],
      ),
      body: UserProfileBody(user: user),
    );
  }
}
