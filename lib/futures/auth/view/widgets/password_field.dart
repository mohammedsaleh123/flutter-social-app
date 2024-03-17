import 'package:flutter/material.dart';
import 'package:socialapp/core/widgets/custom_text_field.dart';

// ignore: must_be_immutable
class PasswordField extends StatelessWidget {
  PasswordField({
    super.key,
    required this.passwordController,
    required this.obsecureText,
  });
  bool obsecureText;

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: 'password',
      textController: passwordController,
      obsecureText: obsecureText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
    );
  }
}
