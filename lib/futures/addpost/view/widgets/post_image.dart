import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialapp/controller/add_post_controller.dart';

// ignore: must_be_immutable
class PostImage extends StatelessWidget {
  PostImage({
    super.key,
  });

  AddPostController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<AddPostController>(builder: (control) {
          return SizedBox(
            height: Get.height * 0.3,
            width: Get.width,
            child: control.postImage == null && control.postVideo == null
                ? const SizedBox()
                : control.postImage != null
                    ? control.postImage == null
                        ? const SizedBox()
                        : Image.file(
                            control.postImage!,
                            fit: BoxFit.fill,
                          )
                    : control.postVideo == null
                        ? const SizedBox()
                        : SizedBox(
                            height: Get.height * 0.3,
                            width: Get.width,
                            child: Expanded(
                              child: Stack(
                                children: [
                                  control.displayVideo()!,
                                ],
                              ),
                            ),
                          ),
          );
        }),
      ],
    );
  }
}
