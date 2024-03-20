import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:socialapp/controller/edit_post_controller.dart';
import 'package:socialapp/core/app_colors.dart';
import 'package:socialapp/core/extension/center_extension.dart';
import 'package:socialapp/core/extension/padding_extension.dart';
import 'package:socialapp/core/widgets/custom_button.dart';
import 'package:socialapp/core/widgets/custom_text.dart';
import 'package:socialapp/core/widgets/custom_text_field.dart';
import 'package:socialapp/futures/edit%20-post/view/widgets/display_post.dart';
import 'package:socialapp/futures/edit%20-post/view/widgets/picke_display_edit.dart';
import 'package:socialapp/model/post_model.dart';
import 'package:socialapp/model/user_model.dart';

// ignore: must_be_immutable
class EditPostBody extends StatelessWidget {
  EditPostBody({super.key, required this.post, required this.user});
  EditPostController controller = Get.find();
  PostModel post;
  UserModel user;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          DisplayPost(post: post, controller: controller),
          PickeDisplayEdit(controller: controller),
          CustomTextField(
            hintText: 'Caption',
            textController: controller.updateCaptionController,
            obsecureText: false,
            textInputType: TextInputType.text,
          ),
          GetBuilder<EditPostController>(builder: (controller) {
            return CustomButton(
              onPressed: () {
                controller.updatePost(
                  post.postId,
                  post.likes,
                  post.userSaved,
                  post.createdAt,
                  post.postImage,
                  post.postVideo!,
                );
              },
              color: offLightC.withOpacity(0.5),
              radius: 20.sp,
              minWidth: Get.width,
              child: controller.isEditing == true
                  ? const CircularProgressIndicator().center()
                  : CustomText(text: 'Edit Post').padding(0, 14.h),
            ).padding(0, 14.h);
          }),
        ],
      ),
    );
  }
}
