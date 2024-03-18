import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:socialapp/core/app_colors.dart';
import 'package:socialapp/core/extension/padding_extension.dart';
import 'package:socialapp/core/widgets/custom_button.dart';
import 'package:socialapp/core/widgets/custom_text.dart';
import 'package:socialapp/futures/model/user_model.dart';
import 'package:socialapp/futures/profile/view/widgets/profile_info.dart';
import 'package:socialapp/futures/profile/view/widgets/user_posts.dart';
import 'package:socialapp/futures/service/user_service.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileInfo(),
        CustomButton(
          onPressed: () {},
          color: offLightC.withOpacity(0.5),
          radius: 20.sp,
          minWidth: Get.width,
          child: CustomText(text: 'Edit Profile').padding(0, 14.h),
        ),
        SizedBox(height: 20.h),
        StreamBuilder<UserModel>(
            stream: UserService().getCurrentUser(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return UserPosts(snapshot: snapshot);
            }),
      ],
    );
  }
}
