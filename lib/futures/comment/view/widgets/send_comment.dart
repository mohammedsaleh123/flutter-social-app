import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:socialapp/core/widgets/custom_text_field.dart';
import 'package:socialapp/futures/controller/comment_controller.dart';
import 'package:socialapp/futures/model/post_model.dart';
import 'package:socialapp/futures/service/user_service.dart';

class SendComment extends StatelessWidget {
  const SendComment({
    super.key,
    required this.commentController,
    required this.post,
  });

  final CommentController commentController;
  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommentController>(builder: (commentController) {
      return Column(
        children: [
          SizedBox(
            child: commentController.commentImage == null
                ? const SizedBox()
                : Image.file(
                    commentController.commentImage!,
                    height: 100.h,
                    width: 100.w,
                    fit: BoxFit.fill,
                  ),
          ),
          Row(
            children: [
              StreamBuilder(
                  stream: UserService().getCurrentUser(),
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
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(50.sp),
                      child: Image.network(snapshot.data!.profileImage,
                          height: 50, width: 50),
                    );
                  }),
              Expanded(
                child: CustomTextField(
                  hintText: 'comment',
                  textController: commentController.commentController,
                  obsecureText: false,
                  textInputType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your comment';
                    }
                    return null;
                  },
                  suffixIcon: IconButton(
                    onPressed: () {
                      commentController.pickCommentImage();
                    },
                    icon: const Icon(Icons.photo_library),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  commentController.addComment(post.postId);
                },
                icon: const Icon(Icons.send),
              )
            ],
          ),
        ],
      );
    });
  }
}
