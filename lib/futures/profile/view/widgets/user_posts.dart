import 'package:flutter/material.dart';
import 'package:socialapp/futures/model/post_model.dart';
import 'package:socialapp/futures/model/user_model.dart';
import 'package:socialapp/futures/service/post_service.dart';

// ignore: must_be_immutable
class UserPosts extends StatelessWidget {
  UserPosts({super.key, required this.snapshot});
  AsyncSnapshot<UserModel> snapshot;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PostModel>>(
        stream: PostServices().getPosts(),
        builder: (context, posts) {
          final List<PostModel> data = posts.data != null
              ? posts.data!
                  .where((element) => element.uid == snapshot.data!.uid)
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
                return Image.network(data[index].postImage, fit: BoxFit.fill);
              },
            ),
          );
        });
  }
}
