import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialapp/controller/auth_controller.dart';
import 'package:socialapp/core/widgets/custom_text_field.dart';

// ignore: must_be_immutable
class NameField extends StatelessWidget {
  NameField({super.key, required this.nameController});
  AuthController controller = Get.find();
  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: 'name',
      textController: nameController,
      obsecureText: false,
      textInputType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your name';
        }
        return null;
      },
    );
  }
}
