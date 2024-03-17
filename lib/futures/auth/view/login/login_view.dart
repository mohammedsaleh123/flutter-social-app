import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialapp/futures/controller/auth_controller.dart';
import 'package:socialapp/futures/auth/view/login/login_body.dart';

// ignore: must_be_immutable
class LogInView extends StatelessWidget {
  LogInView({super.key});
  AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LogInBody(controller: controller),
    );
  }
}
