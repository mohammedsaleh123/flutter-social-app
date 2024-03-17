import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:socialapp/core/extension/center_extension.dart';
import 'package:socialapp/core/widgets/custom_text.dart';

class AuthBanner extends StatelessWidget {
  const AuthBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.2,
      child: CustomText(
        text: 'Happy social',
        fontSize: 20.sp,
      ).center(),
    );
  }
}
