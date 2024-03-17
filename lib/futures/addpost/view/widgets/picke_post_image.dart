import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:socialapp/core/extension/center_extension.dart';
import 'package:socialapp/futures/controller/add_post_controller.dart';

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
            controller.pickImage('camera');
          },
          icon: Icon(
            Icons.camera,
            size: 30.sp,
          ).center(),
        ),
        IconButton(
          onPressed: () {
            controller.pickImage('gallery');
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
