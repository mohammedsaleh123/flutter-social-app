import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:socialapp/controller/auth_controller.dart';
import 'package:socialapp/core/app_colors.dart';
import 'package:socialapp/core/extension/padding_extension.dart';
import 'package:socialapp/core/widgets/custom_button.dart';
import 'package:socialapp/core/widgets/custom_text.dart';

class LogInButton extends StatelessWidget {
  LogInButton({
    super.key,
  });

  final AuthController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (controller) {
      return CustomButton(
        onPressed: () {
          if (controller.loginFormKey.currentState!.validate()) {
            controller.login();
          }
        },
        color: offLightC.withOpacity(0.5),
        radius: 20.sp,
        minWidth: Get.width,
        child: controller.isLogin == true
            ? const CircularProgressIndicator().padding(0, 14.h)
            : CustomText(text: 'Log In').padding(0, 14.h),
      );
    });
  }
}
