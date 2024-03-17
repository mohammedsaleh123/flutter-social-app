import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialapp/core/widgets/custom_text_field.dart';

class EmailField extends StatelessWidget {
  const EmailField({
    super.key,
    required this.emailController,
  });

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: 'email',
      textController: emailController,
      obsecureText: false,
      textInputType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        if (!GetUtils.isEmail(value)) {
          return 'Please enter valid email';
        }
        return null;
      },
    );
  }
}
