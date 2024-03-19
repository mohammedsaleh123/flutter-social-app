import 'package:flutter/material.dart';
import 'package:socialapp/futures/edit%20-post/view/edit_post_body.dart';
import 'package:socialapp/model/post_model.dart';
import 'package:socialapp/model/user_model.dart';

// ignore: must_be_immutable
class EditPostView extends StatelessWidget {
  EditPostView({super.key, required this.post, required this.user});
  PostModel post;
  UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: EditPostBody(post: post, user: user),
    );
  }
}
