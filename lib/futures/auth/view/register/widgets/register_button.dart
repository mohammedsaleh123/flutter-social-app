import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:socialapp/controller/auth_controller.dart';
import 'package:socialapp/core/app_colors.dart';
import 'package:socialapp/core/extension/padding_extension.dart';
import 'package:socialapp/core/widgets/custom_button.dart';
import 'package:socialapp/core/widgets/custom_text.dart';

class RegisterButton extends StatelessWidget {
  RegisterButton({super.key});

  final AuthController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (controller) {
      return CustomButton(
        onPressed: () {
          if (controller.registerFormKey.currentState!.validate()) {
            controller.register();
          }
        },
        color: offLightC.withOpacity(0.5),
        radius: 20.sp,
        minWidth: Get.width,
        child: controller.isRegister == true
            ? const CircularProgressIndicator().padding(0, 14.h)
            : CustomText(text: 'Register').padding(0, 14.h),
      );
    });
  }
}
