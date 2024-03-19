import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:socialapp/core/app_colors.dart';
import 'package:socialapp/core/extension/padding_extension.dart';
import 'package:socialapp/core/widgets/custom_button.dart';
import 'package:socialapp/core/widgets/custom_text.dart';
import 'package:socialapp/model/user_model.dart';
import 'package:socialapp/service/user_service.dart';

// ignore: must_be_immutable
class ProfileButton extends StatelessWidget {
  ProfileButton({super.key, required this.user});
  FirebaseAuth auth = FirebaseAuth.instance;
  UserModel user;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel>(
        stream: UserService().getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return CustomButton(
              onPressed: () {
                if (snapshot.data!.following != null &&
                    snapshot.data!.following!.contains(user.uid)) {
                  UserService().unfollowUser(user.uid);
                } else {
                  UserService().followUser(user.uid);
                }
              },
              minWidth: Get.width,
              radius: 20.sp,
              color: offLightC.withOpacity(0.5),
              child: CustomText(
                text: user.uid == auth.currentUser!.uid
                    ? 'Edit Profile'
                    : snapshot.data!.following != null &&
                            snapshot.data!.following!.contains(user.uid)
                        ? 'Unfollow'
                        : 'Follow',
              ).padding(0, 12.h));
        });
  }
}
