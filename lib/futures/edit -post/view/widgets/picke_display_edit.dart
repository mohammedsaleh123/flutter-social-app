import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialapp/controller/edit_post_controller.dart';
import 'package:socialapp/core/extension/center_extension.dart';

class PickeDisplayEdit extends StatelessWidget {
  const PickeDisplayEdit({
    super.key,
    required this.controller,
  });

  final EditPostController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            controller.pickImage('gallery', true);
          },
          icon: Icon(Icons.video_camera_back, size: 30.sp).center(),
        ),
        IconButton(
          onPressed: () {
            controller.pickImage('camera', false);
          },
          icon: Icon(
            Icons.camera,
            size: 30.sp,
          ).center(),
        ),
        IconButton(
          onPressed: () {
            controller.pickImage('gallery', false);
          },
          icon: Icon(
            Icons.photo_library,
            size: 30.sp,
          ).center(),
        ),
      ],
    );
  }
}
