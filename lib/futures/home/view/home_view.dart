import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialapp/core/widgets/custom_text.dart';
import 'package:socialapp/futures/auth/view/login/login_view.dart';
import 'package:socialapp/futures/home/view/home_body.dart';
import 'package:socialapp/futures/service/auth_service.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: 'Feed page'),
        actions: [
          IconButton(
            onPressed: () {
              AuthService().logout();
              Get.offAll(() => LogInView());
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: const HomeBody(),
    );
  }
}
