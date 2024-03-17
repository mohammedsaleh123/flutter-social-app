import 'package:flutter/material.dart';
import 'package:socialapp/core/widgets/custom_text.dart';
import 'package:socialapp/futures/addpost/view/add_post_body.dart';

class AddPostView extends StatelessWidget {
  const AddPostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: 'Add Post'),
      ),
      body: AddPostBody(),
    );
  }
}
