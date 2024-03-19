import 'package:flutter/material.dart';
import 'package:socialapp/core/widgets/custom_text.dart';
import 'package:socialapp/futures/model/post_model.dart';
import 'package:socialapp/futures/model/user_model.dart';
import 'package:socialapp/futures/userposts/view/user_posts_body.dart';

// ignore: must_be_immutable
class UserPostsView extends StatelessWidget {
  UserPostsView({super.key, required this.post, required this.user});
  PostModel post;
  UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: '${user.userName} posts'),
      ),
      body: UserPostsBody(post: post, user: user),
    );
  }
}
