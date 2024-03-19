import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:socialapp/controller/add_post_controller.dart';
import 'package:socialapp/core/extension/center_extension.dart';

class PickePostImage extends StatelessWidget {
  PickePostImage({
    super.key,
  });

  final AddPostController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {
              controller.postImage = null;
              controller.postVideo = null;
              controller.pickImage('gallery', true);
            },
            icon: Icon(Icons.video_camera_back, size: 30.sp).center()),
        IconButton(
          onPressed: () {
            controller.postImage = null;
            controller.postVideo = null;
            controller.pickImage('camera', false);
          },
          icon: Icon(
            Icons.camera,
            size: 30.sp,
          ).center(),
        ),
        IconButton(
          onPressed: () {
            controller.postImage = null;
            controller.postVideo = null;
            controller.pickImage('gallery', false);
          },
          icon: Icon(
            Icons.photo_library,
            size: 30.sp,
          ),
        ),
      ],
    );
  }
}
