import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:socialapp/controller/auth_controller.dart';
import 'package:socialapp/core/extension/padding_extension.dart';
import 'package:socialapp/futures/auth/view/login/login_view.dart';
import 'package:socialapp/futures/auth/view/widgets/swith_betwen_login_and_register.dart';
import 'package:socialapp/futures/auth/view/register/widgets/confirm_password_field.dart';
import 'package:socialapp/futures/auth/view/register/widgets/name_field.dart';
import 'package:socialapp/futures/auth/view/register/widgets/register_button.dart';
import 'package:socialapp/futures/auth/view/widgets/email_field.dart';
import 'package:socialapp/futures/auth/view/widgets/password_field.dart';

// ignore: must_be_immutable
class RegisterBody extends StatelessWidget {
  RegisterBody({super.key});
  AuthController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: controller.registerFormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  GetBuilder<AuthController>(builder: (controller) {
                    return CircleAvatar(
                      radius: 70,
                      child: Stack(children: [
                        CircleAvatar(
                          radius: 70,
                          child: controller.profileImage == null
                              ? const Icon(
                                  Icons.person,
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(70.sp),
                                  child: Image.file(
                                    controller.profileImage!,
                                  ),
                                ),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                controller.pickImage();
                              },
                              child: const Icon(Icons.add_a_photo),
                            ))
                      ]),
                    ).padding(0, 14.h);
                  }),
                ],
              ),
              NameField(nameController: controller.registerNameController)
                  .padding(0, 14.h),
              EmailField(emailController: controller.registerEmailController)
                  .padding(0, 14.h),
              PasswordField(
                      passwordController: controller.registerPasswordController,
                      obsecureText: true)
                  .padding(0, 14.h),
              ConfirmPasswordField(
                      confirmPasswordController:
                          controller.registerConfirmPasswordController,
                      obsecureText: true)
                  .padding(0, 14.h),
              SwitchBetwenLogInAndRegister(
                text: 'Login',
                switchText: 'Already have an account?',
                onTap: () {
                  Get.off(() => LogInView());
                },
              ),
              RegisterButton().padding(0, 14.h),
            ],
          ),
        ),
      ),
    );
  }
}
