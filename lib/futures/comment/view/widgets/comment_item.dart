import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:socialapp/core/app_colors.dart';
import 'package:socialapp/core/extension/center_extension.dart';
import 'package:socialapp/core/extension/padding_extension.dart';
import 'package:socialapp/core/widgets/custom_text.dart';
import 'package:socialapp/futures/helper/helper.dart';
import 'package:socialapp/model/comment_model.dart';
import 'package:socialapp/model/post_model.dart';
import 'package:socialapp/model/user_model.dart';
import 'package:socialapp/service/user_service.dart';

// ignore: must_be_immutable
class CommentItem extends StatelessWidget {
  CommentItem({super.key, required this.comment, required this.post});
  CommentModel comment;
  PostModel post;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: offLightC.withOpacity(0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder<UserModel>(
              stream: UserService().getUser(comment.userId),
              builder: (context, user) {
                if (user.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (user.hasError) {
                  return const Center(
                    child: Text('Something went wrong!'),
                  );
                }
                return Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50.sp),
                      child: Image.network(user.data!.profileImage,
                          height: 50.h, width: 50.w),
                    ),
                    SizedBox(width: 10.w),
                    CustomText(text: user.data!.userName),
                  ],
                );
              }),
          SizedBox(height: 10.h),
          SizedBox(
            width: Get.width * 0.5,
            child: comment.commentImage == null
                ? const SizedBox()
                : Image.network(
                    comment.commentImage!,
                    fit: BoxFit.fill,
                    height: Get.height * 0.2,
                    width: Get.width * 0.5,
                  ),
          ).center(),
          ExpandableText(
            comment.comment,
            expandText: '...more',
            maxLines: 1,
            collapseText: '...less',
          ).padding(12.w, 4.h),
          SizedBox(height: 10.h),
          CustomText(
                  text: 'comment at ${Helper().formatDate(comment.createdAt)}')
              .padding(12.w, 4.h),
        ],
      ),
    );
  }
}
