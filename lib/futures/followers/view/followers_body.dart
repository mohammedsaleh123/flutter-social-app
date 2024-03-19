import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:socialapp/core/extension/center_extension.dart';
import 'package:socialapp/core/widgets/custom_text.dart';
import 'package:socialapp/futures/chat/view/chat_view.dart';
import 'package:socialapp/model/user_model.dart';
import 'package:socialapp/service/user_service.dart';
import 'package:socialapp/futures/user_profile/view/user_profile_view.dart';

// ignore: must_be_immutable
class FollowersBody extends StatelessWidget {
  FollowersBody({super.key});
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UserModel>>(
        stream: UserService().getAllUsers(),
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
          final followers = snapshot.data!
              .where((element) =>
                  element.following!.contains(auth.currentUser!.uid))
              .toList();
          return followers.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                      CustomText(
                        text: 'No followers yet!',
                        fontSize: 20.sp,
                      ).center(),
                      CircleAvatar(
                        radius: 70.sp,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100.sp),
                            child: Image.asset(
                              'assets/icons/followers.png',
                              fit: BoxFit.fill,
                            ).center()),
                      ),
                    ])
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: followers.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(8.sp),
                            child: ListTile(
                              leading: GestureDetector(
                                onTap: () {
                                  Get.to(() =>
                                      UserProfileView(user: followers[index]));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50.sp),
                                  child: Image.network(
                                    followers[index].profileImage,
                                    height: 50.h,
                                    width: 50.w,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title:
                                  CustomText(text: followers[index].userName),
                              trailing: GestureDetector(
                                onTap: () {
                                  Get.to(
                                      () => ChatView(user: followers[index]));
                                },
                                child: const Icon(Icons.chat_bubble_outline),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
        });
  }
}
