import 'package:flutter/material.dart';
import 'package:socialapp/core/widgets/custom_text.dart';
import 'package:socialapp/futures/savedposts/view/saved_posts_body.dart';

class SavedPostsView extends StatelessWidget {
  const SavedPostsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: 'Saved Posts'),
      ),
      body: const SavedPostsBody(),
    );
  }
}
