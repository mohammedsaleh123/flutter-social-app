import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:socialapp/controller/add_post_controller.dart';
import 'package:socialapp/futures/comment/view/comment_view.dart';
import 'package:socialapp/model/post_model.dart';
import 'package:socialapp/service/post_service.dart';

// ignore: must_be_immutable
class ActionWithPost extends StatelessWidget {
  ActionWithPost({super.key, required this.post});
  AddPostController addPostController = Get.put(AddPostController());
  FirebaseAuth auth = FirebaseAuth.instance;
  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddPostController>(builder: (controller) {
      return Row(
        children: [
          StreamBuilder<List<PostModel>>(
              stream: PostServices().getPosts(),
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
                return IconButton(
                  onPressed: () {
                    PostServices().addLike(
                        post.postId, auth.currentUser!.uid, post.likes);
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: auth.currentUser != null &&
                            post.likes.contains(auth.currentUser!.uid)
                        ? Colors.red
                        : Colors.grey,
                    size: auth.currentUser != null &&
                            post.likes.contains(auth.currentUser!.uid)
                        ? 30.sp
                        : 20.sp,
                  ),
                );
              }),
          IconButton(
            onPressed: () {
              Get.to(() => CommentView(post: post));
            },
            icon: const Icon(Icons.comment),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share),
          )
        ],
      );
    });
  }
}

class PostService {}
