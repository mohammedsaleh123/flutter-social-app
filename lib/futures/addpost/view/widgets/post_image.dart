import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialapp/futures/controller/add_post_controller.dart';

class PostImage extends StatelessWidget {
  PostImage({
    super.key,
  });

  final AddPostController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.3,
      width: Get.width,
      child: controller.postImage == null
          ? const Center()
          : Image.file(
              controller.postImage!,
              fit: BoxFit.fill,
            ),
    );
  }
}
