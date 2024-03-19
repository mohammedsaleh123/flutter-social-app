import 'package:flutter/material.dart';
import 'package:socialapp/model/post_model.dart';
import 'package:socialapp/model/user_model.dart';

// ignore: must_be_immutable
class EditPostBody extends StatelessWidget {
  EditPostBody({super.key, required this.post, required this.user});
  PostModel post;
  UserModel user;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
