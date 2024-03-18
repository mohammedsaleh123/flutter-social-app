import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialapp/core/extension/padding_extension.dart';
import 'package:socialapp/core/widgets/custom_text.dart';
import 'package:socialapp/futures/model/post_model.dart';
import 'package:socialapp/futures/model/user_model.dart';
import 'package:socialapp/futures/service/user_service.dart';
import 'package:socialapp/futures/service/post_service.dart';

// ignore: must_be_immutable
class UserProfileInfo extends StatelessWidget {
  UserProfileInfo({super.key, required this.user});
  UserModel user;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 100.h,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50.sp),
                child: Image.network(
                  user.profileImage,
                  height: 50.h,
                  width: 50.w,
                ),
              ),
              SizedBox(height: 5.h),
              CustomText(
                text: user.userName,
                //fontSize: 16.sp,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 100.h,
          child: StreamBuilder<List<PostModel>>(
              stream: PostServices().getPosts(),
              builder: (context, posts) {
                if (posts.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (posts.hasError) {
                  return Text(posts.error.toString());
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomText(
                      text: 'Posts',
                    ),
                    CustomText(
                      text: posts.data!
                          .where((element) => element.uid == user.uid)
                          .length
                          .toString(),
                    ),
                  ],
                );
              }),
        ),
        StreamBuilder<UserModel>(
            stream: UserService().getUser(user.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 100.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomText(
                          text: 'followers',
                        ),
                        CustomText(
                          text: snapshot.data!.followers != null
                              ? snapshot.data!.followers!.length.toString()
                              : '0',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 50.w,
                  ),
                  SizedBox(
                    height: 100.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomText(
                          text: 'following',
                        ),
                        CustomText(
                          text: snapshot.data!.following != null
                              ? snapshot.data!.following!.length.toString()
                              : '0',
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ],
    ).padding(12.w, 6.h);
  }
}
