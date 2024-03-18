import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialapp/core/widgets/custom_text.dart';
import 'package:socialapp/futures/auth/view/login/login_view.dart';
import 'package:socialapp/futures/home/view/home_body.dart';
import 'package:socialapp/futures/service/user_service.dart';

// ignore: must_be_immutable
class HomeView extends StatelessWidget {
  HomeView({super.key});
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: 'Feed page'),
        actions: [
          IconButton(
            onPressed: () {
              UserService().signOut();
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
