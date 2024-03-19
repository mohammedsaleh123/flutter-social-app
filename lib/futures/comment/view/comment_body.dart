import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialapp/controller/comment_controller.dart';
import 'package:socialapp/futures/comment/view/widgets/list_comment.dart';
import 'package:socialapp/futures/comment/view/widgets/send_comment.dart';
import 'package:socialapp/model/post_model.dart';

// ignore: must_be_immutable
class CommentBody extends StatelessWidget {
  CommentBody({super.key, required this.post});
  CommentController commentController = Get.put(CommentController());
  PostModel post;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListComment(post: post),
          SendComment(commentController: commentController, post: post),
        ],
      ),
    );
  }
}
