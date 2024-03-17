import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:socialapp/core/extension/padding_extension.dart';
import 'package:socialapp/futures/controller/auth_controller.dart';
import 'package:socialapp/futures/auth/view/register/register_view.dart';
import 'package:socialapp/futures/auth/view/widgets/auth_banner.dart';
import 'package:socialapp/futures/auth/view/login/widgets/login_button.dart';
import 'package:socialapp/futures/auth/view/widgets/email_field.dart';
import 'package:socialapp/futures/auth/view/login/widgets/login_with_google.dart';
import 'package:socialapp/futures/auth/view/widgets/password_field.dart';
import 'package:socialapp/futures/auth/view/widgets/swith_betwen_login_and_register.dart';

class LogInBody extends StatelessWidget {
  const LogInBody({
    super.key,
    required this.controller,
  });

  final AuthController controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: controller.loginFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AuthBanner(),
              EmailField(emailController: controller.loginEmailController)
                  .padding(0, 14.h),
              PasswordField(
                      passwordController: controller.loginPasswordController,
                      obsecureText: true)
                  .padding(0, 14.h),
              SwitchBetwenLogInAndRegister(
                text: 'Register',
                switchText: 'New member?',
                onTap: () {
                  Get.off(() => const RegisterView());
                },
              ).padding(0, 14.h),
              LogInWithGoogle().padding(0, 14.h),
              LogInButton().padding(0, 14.h),
            ],
          ),
        ),
      ),
    );
  }
}
