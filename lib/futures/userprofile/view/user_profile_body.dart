import 'package:flutter/material.dart';
import 'package:socialapp/futures/model/user_model.dart';
import 'package:socialapp/futures/userprofile/view/widgets/user_profile_info.dart';
import 'package:socialapp/futures/userprofile/view/widgets/user_profile_posts.dart';

// ignore: must_be_immutable
class UserProfileBody extends StatelessWidget {
  UserProfileBody({super.key, required this.user});
  UserModel user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserProfileInfo(user: user),
        UserProfilePosts(user: user),
      ],
    );
  }
}
