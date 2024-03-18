import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:socialapp/core/app_colors.dart';
import 'package:socialapp/futures/model/post_model.dart';
import 'package:socialapp/futures/model/user_model.dart';
import 'package:socialapp/futures/service/user_service.dart';
import 'package:socialapp/futures/service/post_service.dart';
import 'package:socialapp/futures/userprofile/view/user_profile_view.dart';

// ignore: must_be_immutable
class InfoBar extends StatelessWidget {
  InfoBar({
    super.key,
    required this.post,
  });

  final PostModel post;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel>(
        stream: UserService().getUser(post.uid),
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
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => UserProfileView(user: snapshot.data!));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.sp),
                      child: Image.network(
                        snapshot.data!.profileImage,
                        width: 50.sp,
                        height: 50.sp,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.sp),
                  Text(snapshot.data!.userName),
                ],
              ),
              const Spacer(),
              DropdownMenu(
                trailingIcon: const Icon(Icons.more_vert),
                inputDecorationTheme: const InputDecorationTheme(
                  fillColor: darkC,
                ),
                onSelected: (value) {
                  if (value == 'delete') {
                    PostServices().deletePost(post.postId);
                  }
                  if (value == 'save') {
                    PostServices().savePost(post.postId, auth.currentUser!.uid);
                  }
                  if (value == 'unsave') {
                    PostServices()
                        .unsavePost(post.postId, auth.currentUser!.uid);
                  }
                },
                menuStyle: const MenuStyle(
                    side: MaterialStatePropertyAll(BorderSide.none)),
                dropdownMenuEntries: auth.currentUser != null &&
                        post.uid == auth.currentUser!.uid
                    ? [
                        const DropdownMenuEntry(
                            label: 'Delete', value: 'delete'),
                        const DropdownMenuEntry(label: 'Edit', value: 'edit'),
                        DropdownMenuEntry(
                            label:
                                post.userSaved.contains(auth.currentUser!.uid)
                                    ? 'Unsave'
                                    : 'Save',
                            value:
                                post.userSaved.contains(auth.currentUser!.uid)
                                    ? 'unsave'
                                    : 'save'),
                      ]
                    : [
                        DropdownMenuEntry(
                            label: auth.currentUser != null &&
                                    post.userSaved
                                        .contains(auth.currentUser!.uid)
                                ? 'Unsave'
                                : 'Save',
                            value: auth.currentUser != null &&
                                    post.userSaved
                                        .contains(auth.currentUser!.uid)
                                ? 'unsave'
                                : 'save'),
                      ],
              )
            ],
          );
        });
  }
}
