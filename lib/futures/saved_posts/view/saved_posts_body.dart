import 'package:flutter/material.dart';
import 'package:socialapp/futures/home/view/widgets/postitem/post_item.dart';
import 'package:socialapp/model/post_model.dart';
import 'package:socialapp/model/user_model.dart';
import 'package:socialapp/service/user_service.dart';
import 'package:socialapp/service/post_service.dart';

class SavedPostsBody extends StatelessWidget {
  const SavedPostsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel>(
      stream: UserService().getCurrentUser(),
      builder: (context, user) {
        if (user.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (user.hasError) {
          return const Center(
            child: Text('Something went wrong!'),
          );
        }
        return StreamBuilder<List<PostModel>>(
          stream: PostServices().getPosts(),
          builder: (context, posts) {
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
            List<PostModel> data = posts.data != null
                ? posts.data!
                    .where(
                        (element) => element.userSaved.contains(user.data!.uid))
                    .toList()
                : [];
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return PostItem(post: data[index]);
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
