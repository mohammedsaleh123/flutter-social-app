import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:socialapp/core/extension/padding_extension.dart';
import 'package:socialapp/core/widgets/custom_text.dart';
import 'package:socialapp/futures/followers/view/followers_view.dart';
import 'package:socialapp/futures/following/view/following_view.dart';
import 'package:socialapp/futures/model/post_model.dart';
import 'package:socialapp/futures/model/user_model.dart';
import 'package:socialapp/futures/service/post_service.dart';
import 'package:socialapp/futures/service/user_service.dart';

// ignore: must_be_immutable
class ProfileInfo extends StatelessWidget {
  ProfileInfo({super.key});
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel>(
        stream: UserService().getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
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
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50.sp),
                      child: Image.network(
                        snapshot.data != null
                            ? snapshot.data!.profileImage
                            : auth.currentUser!.photoURL.toString(),
                        height: 50.h,
                        width: 50.w,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    CustomText(
                      text: snapshot.data != null
                          ? snapshot.data!.userName
                          : auth.currentUser!.displayName!,
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
                                .where((element) =>
                                    element.uid == auth.currentUser!.uid)
                                .length
                                .toString(),
                          ),
                        ],
                      );
                    }),
              ),
              SizedBox(
                height: 100.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const FollowersView());
                      },
                      child: CustomText(
                        text: 'followers',
                      ),
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
                height: 100.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const FollowingView());
                      },
                      child: CustomText(
                        text: 'following',
                      ),
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
          ).padding(12.w, 6.h);
        });
  }
}
