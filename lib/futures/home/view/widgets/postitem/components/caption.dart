import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/futures/model/user_model.dart';
import 'package:socialapp/futures/model/post_model.dart';
import 'package:socialapp/futures/service/user_service.dart';

// ignore: must_be_immutable
class Caption extends StatelessWidget {
  Caption({super.key, required this.post});
  PostModel post;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StreamBuilder<UserModel>(
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
              return Expanded(
                child: ExpandableText(
                  '${snapshot.data!.userName} ... ${post.caption}',
                  expandText: '...more',
                  collapseText: '...less',
                  maxLines: 1,
                  expandOnTextTap: true,
                  collapseOnTextTap: true,
                ),
              );
            }),
      ],
    );
  }
}
