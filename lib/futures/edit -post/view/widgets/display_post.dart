import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialapp/controller/edit_post_controller.dart';
import 'package:socialapp/model/post_model.dart';

class DisplayPost extends StatelessWidget {
  const DisplayPost({
    super.key,
    required this.post,
    required this.controller,
  });

  final PostModel post;
  final EditPostController controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditPostController>(builder: (controller) {
      return SizedBox(
        child: controller.cleanup == true
            ? SizedBox(
                height: Get.height * 0.4,
                width: Get.width,
              )
            : SizedBox(
                height: Get.height * 0.4,
                width: Get.width,
                child: controller.postImage == null &&
                        controller.postVideo == null
                    ? post.postImage != ''
                        ? Image.network(
                            post.postImage,
                            fit: BoxFit.cover,
                          )
                        : controller.displayVideo(post.postVideo!)
                    : controller.postImage != null
                        ? Image.file(
                            controller.postImage!,
                            fit: BoxFit.cover,
                          )
                        : controller.displayVideo(controller.postVideo!.path),
              ),
      );
    });
  }
}
