import 'package:flutter/material.dart';
import 'package:socialapp/model/post_model.dart';
import 'package:socialapp/model/user_model.dart';
import 'package:socialapp/service/post_service.dart';

import 'package:get/get.dart';
import 'package:socialapp/controller/user_profile_controller.dart';
import 'package:socialapp/futures/user_posts/view/user_posts_view.dart';

// ignore: must_be_immutable
class UserProfilePosts extends StatelessWidget {
  UserProfilePosts({super.key, required this.user});
  UserProfileController controller = Get.put(UserProfileController());
  UserModel user;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PostModel>>(
        stream: PostServices().getPosts(),
        builder: (context, posts) {
          final List<PostModel> data = posts.data != null
              ? posts.data!.where((element) => element.uid == user.uid).toList()
              : [];
          if (posts.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (posts.hasError) {
            return const Center(
              child: Text('Something went wrong!'),
            );
          }
          return Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(() => UserPostsView(post: data[index], user: user));
                  },
                  child: SizedBox(
                    child: data[index].postImage != ''
                        ? Image.network(data[index].postImage, fit: BoxFit.fill)
                        : Stack(
                            children: [
                              controller.displayVideo(data[index].postVideo!),
                              Align(
                                alignment: Alignment.center,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.play_arrow),
                                ),
                              ),
                            ],
                          ),
                  ),
                );
              },
            ),
          );
        });
  }
}
