import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialapp/controller/auth_controller.dart';
import 'package:socialapp/core/widgets/custom_text_field.dart';

// ignore: must_be_immutable
class ConfirmPasswordField extends StatelessWidget {
  ConfirmPasswordField(
      {super.key,
      required this.confirmPasswordController,
      required this.obsecureText});
  AuthController controller = Get.find();
  final TextEditingController confirmPasswordController;
  bool obsecureText;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: 'confirm password',
      textController: confirmPasswordController,
      obsecureText: obsecureText,
      textInputType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your confirm password';
        }
        if (controller.registerPasswordController.text !=
            confirmPasswordController.text) {
          return 'Password does not match';
        }
        return null;
      },
    );
  }
}
