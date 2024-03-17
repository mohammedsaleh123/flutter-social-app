import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialapp/core/widgets/custom_text.dart';
import 'package:socialapp/futures/comment/view/comment_body.dart';
import 'package:socialapp/futures/model/post_model.dart';
import 'package:socialapp/futures/model/user_model.dart';
import 'package:socialapp/futures/service/auth_service.dart';

// ignore: must_be_immutable
class CommentView extends StatelessWidget {
  CommentView({super.key, required this.post});
  PostModel post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<UserModel>(
            stream: AuthService().getUser(post.uid),
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
              return Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.sp),
                    child: Image.network(snapshot.data!.profileImage,
                        height: 40.sp, width: 40.sp),
                  ),
                  SizedBox(width: 10.sp),
                  CustomText(text: snapshot.data!.userName),
                ],
              );
            }),
        centerTitle: true,
      ),
      body: CommentBody(
        post: post,
      ),
    );
  }
}
