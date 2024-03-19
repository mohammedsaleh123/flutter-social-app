import 'package:flutter/material.dart';
import 'package:socialapp/futures/comment/view/widgets/comment_item.dart';
import 'package:socialapp/model/comment_model.dart';
import 'package:socialapp/model/post_model.dart';
import 'package:socialapp/service/comment_service.dart';

class ListComment extends StatelessWidget {
  const ListComment({super.key, required this.post});

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CommentModel>>(
        stream: CommentService().getComments(post.postId),
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
          return Expanded(
            child: ListView.builder(
                itemCount: snapshot.data!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CommentItem(
                      comment: snapshot.data![index], post: post);
                }),
          );
        });
  }
}
