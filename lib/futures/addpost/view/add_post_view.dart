import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialapp/controller/add_post_controller.dart';
import 'package:socialapp/core/widgets/custom_text.dart';
import 'package:socialapp/futures/addpost/view/add_post_body.dart';

// ignore: must_be_immutable
class AddPostView extends StatelessWidget {
  AddPostView({super.key});
  AddPostController controller = Get.put(AddPostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: 'Add Post'),
        actions: [
          IconButton(
            onPressed: () {
              controller.onCloseScreen();
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: AddPostBody(),
    );
  }
}
