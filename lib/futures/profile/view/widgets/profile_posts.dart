import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialapp/controller/profile_controller.dart';
import 'package:socialapp/model/post_model.dart';
import 'package:socialapp/model/user_model.dart';
import 'package:socialapp/service/post_service.dart';
import 'package:socialapp/futures/userposts/view/user_posts_view.dart';

// ignore: must_be_immutable
class ProfilePosts extends StatelessWidget {
  ProfilePosts({super.key, required this.snapshot});
  AsyncSnapshot<UserModel> snapshot;
  FirebaseAuth auth = FirebaseAuth.instance;
  ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PostModel>>(
        stream: PostServices().getPosts(),
        builder: (context, posts) {
          final List<PostModel> data = posts.data != null
              ? posts.data!
                  .where((element) => element.uid == auth.currentUser!.uid)
                  .toList()
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
                    Get.to(() =>
                        UserPostsView(post: data[index], user: snapshot.data!));
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
                                  )),
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
