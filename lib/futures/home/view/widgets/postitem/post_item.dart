import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:socialapp/core/extension/padding_extension.dart';
import 'package:socialapp/futures/home/view/widgets/postitem/components/action_with_post.dart';
import 'package:socialapp/futures/home/view/widgets/postitem/components/caption.dart';
import 'package:socialapp/futures/home/view/widgets/postitem/components/info_bar.dart';
import 'package:socialapp/futures/home/view/widgets/postitem/components/post_info_bar.dart';
import 'package:socialapp/futures/home/view/widgets/postitem/components/post_time.dart';
import 'package:socialapp/futures/model/post_model.dart';

class PostItem extends StatelessWidget {
  const PostItem({super.key, required this.post});
  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          InfoBar(post: post),
          Image.network(
            post.postImage,
            height: Get.height * 0.4,
            width: Get.width,
            fit: BoxFit.fill,
          ).padding(6.w, 6.h),
          ActionWithPost(post: post),
          PostInfoBar(post: post),
          SizedBox(height: 10.sp),
          Caption(post: post),
          SizedBox(height: 10.sp),
          PostTime(post: post),
        ],
      ),
    );
  }
}
