import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:socialapp/controller/add_post_controller.dart';
import 'package:socialapp/core/app_colors.dart';
import 'package:socialapp/core/extension/padding_extension.dart';
import 'package:socialapp/core/widgets/custom_button.dart';
import 'package:socialapp/core/widgets/custom_text.dart';
import 'package:socialapp/core/widgets/custom_text_field.dart';
import 'package:socialapp/futures/addpost/view/widgets/picke_post_image.dart';
import 'package:socialapp/futures/addpost/view/widgets/post_image.dart';

// ignore: must_be_immutable
class AddPostBody extends StatelessWidget {
  AddPostBody({super.key});
  AddPostController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          PostImage(),
          SizedBox(height: 10.h),
          PickePostImage(),
          SizedBox(height: 10.h),
          CustomTextField(
            hintText: 'caption',
            textController: controller.captionController,
            obsecureText: false,
            textInputType: TextInputType.text,
          ),
          SizedBox(height: 20.h),
          GetBuilder<AddPostController>(builder: (controller) {
            return CustomButton(
              onPressed: () {
                if (controller.postImage != null ||
                    controller.postVideo != null) {
                  controller.addPost();
                }
              },
              color: offLightC.withOpacity(0.5),
              radius: 20.sp,
              minWidth: Get.width,
              child: controller.isPostLoading
                  ? const CircularProgressIndicator().padding(0, 14.h)
                  : CustomText(text: 'Add Post').padding(0, 14.h),
            );
          }),
        ],
      ),
    );
  }
}
