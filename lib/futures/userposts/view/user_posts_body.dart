import 'package:flutter/material.dart';
import 'package:socialapp/futures/home/view/widgets/postitem/post_item.dart';
import 'package:socialapp/futures/model/post_model.dart';
import 'package:socialapp/futures/model/user_model.dart';

// ignore: must_be_immutable
class UserPostsBody extends StatelessWidget {
  UserPostsBody({super.key, required this.post, required this.user});
  PostModel post;
  UserModel user;

  @override
  Widget build(BuildContext context) {
    return PostItem(post: post);
  }
}
