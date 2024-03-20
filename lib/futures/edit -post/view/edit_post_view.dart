import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialapp/controller/edit_post_controller.dart';
import 'package:socialapp/core/widgets/custom_text.dart';
import 'package:socialapp/futures/edit%20-post/view/edit_post_body.dart';
import 'package:socialapp/model/post_model.dart';
import 'package:socialapp/model/user_model.dart';

// ignore: must_be_immutable
class EditPostView extends StatefulWidget {
  EditPostView(
      {super.key,
      required this.post,
      required this.user,
      required this.caption});
  PostModel post;
  UserModel user;
  String caption;

  @override
  State<EditPostView> createState() => _EditPostViewState();
}

class _EditPostViewState extends State<EditPostView> {
  EditPostController controller = Get.put(EditPostController());

  @override
  void initState() {
    controller.updateCaptionController.text = widget.caption;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: 'Edit Post'),
        actions: [
          IconButton(
            onPressed: () {
              controller.onCloseScreen();
            },
            icon: const Icon(Icons.close),
          )
        ],
      ),
      body: EditPostBody(post: widget.post, user: widget.user),
    );
  }
}
