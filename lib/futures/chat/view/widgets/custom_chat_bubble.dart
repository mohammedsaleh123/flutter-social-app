import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialapp/core/app_colors.dart';
import 'package:socialapp/core/extension/padding_extension.dart';
import 'package:socialapp/core/widgets/custom_text.dart';
import 'package:socialapp/model/chat_model.dart';
import 'package:socialapp/model/user_model.dart';

// ignore: must_be_immutable
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
                  ),
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
