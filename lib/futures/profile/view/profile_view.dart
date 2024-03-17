import 'package:flutter/material.dart';
import 'package:socialapp/core/widgets/custom_text.dart';
import 'package:socialapp/futures/profile/view/profile_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: 'Profile'),
      ),
      body: const ProfileBody(),
    );
  }
}
