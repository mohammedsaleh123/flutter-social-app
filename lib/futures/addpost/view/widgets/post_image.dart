import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:socialapp/controller/add_post_controller.dart';

class PostImage extends StatelessWidget {
  PostImage({
    super.key,
  });

  final AddPostController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddPostController>(builder: (controller) {
      return SizedBox(
        height: Get.height * 0.3,
        width: Get.width,
        child: controller.postImage == null && controller.postVideo == null
            ? const SizedBox()
            : controller.postImage != null
                ? Image.file(
                    controller.postImage!,
                    fit: BoxFit.fill,
                  )
                : Stack(
                    children: [
                      controller.displayVideo()!,
                      Align(
                        alignment: Alignment.center,
                        child: GetBuilder<AddPostController>(
                            builder: (controller) {
                          return IconButton(
                            onPressed: () {
                              controller.switchBetweenImageAndVideo();
                              if (controller.isVideoPlaying == false) {
                                controller.postVideoController!.pause();
                              } else {
                                controller.postVideoController!.play();
                              }
                            },
                            icon: Icon(
                              controller.isVideoPlaying == true
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: Colors.white,
                              size: 40.sp,
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
      );
    });
  }
}
