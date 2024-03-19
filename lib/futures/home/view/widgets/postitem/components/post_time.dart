import 'package:flutter/material.dart';
import 'package:socialapp/core/widgets/custom_text.dart';
import 'package:socialapp/core/helper/helper.dart';
import 'package:socialapp/model/post_model.dart';

// ignore: must_be_immutable
class PostTime extends StatelessWidget {
  PostTime({super.key, required this.post});
  PostModel post;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomText(text: 'created at ${Helper().formatDate(post.createdAt)}'),
      ],
    );
  }
}
