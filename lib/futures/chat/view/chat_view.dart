import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialapp/core/widgets/custom_text.dart';
import 'package:socialapp/futures/chat/view/chat_body.dart';
import 'package:socialapp/model/user_model.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50.sp),
              child: Image.network(
                user.profileImage,
                height: 40.h,
                width: 40.w,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(width: 10.sp),
            CustomText(
              text: user.userName,
            ),
          ],
        ),
      ),
      body: ChatBody(user: user),
    );
  }
}
