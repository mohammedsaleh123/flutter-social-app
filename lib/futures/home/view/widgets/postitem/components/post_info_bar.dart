import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialapp/core/widgets/custom_text.dart';
import 'package:socialapp/futures/model/comment_model.dart';
import 'package:socialapp/futures/model/post_model.dart';
import 'package:socialapp/futures/service/comment_service.dart';

// ignore: must_be_immutable
class PostInfoBar extends StatelessWidget {
  PostInfoBar({super.key, required this.post});
  PostModel post;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomText(text: '${post.likes.length} likes'),
        SizedBox(width: 10.sp),
        StreamBuilder<List<CommentModel>>(
            stream: CommentService().getComments(post.postId),
            builder: (context, snapshot) {
              return CustomText(text: '${snapshot.data?.length} comments');
            }),
      ],
    );
  }
}
