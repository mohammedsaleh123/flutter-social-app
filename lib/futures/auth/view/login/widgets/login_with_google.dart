import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:socialapp/controller/auth_controller.dart';
import 'package:socialapp/core/widgets/custom_text.dart';

class LogInWithGoogle extends StatelessWidget {
  LogInWithGoogle({super.key});

  final AuthController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(text: 'Or  '),
        CustomText(
          text: 'login with Google',
        ),
        SizedBox(width: 10.w),
        GetBuilder<AuthController>(builder: (controller) {
          return GestureDetector(
            onTap: () {
              controller.loginWithGoogle();
            },
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.sp),
                child: controller.isLoginWithGoogle == true
                    ? const CircularProgressIndicator()
                    : Image.asset('assets/icons/google.png',
                        height: 35.h, width: 35.w)),
          );
        }),
      ],
    );
  }
}
