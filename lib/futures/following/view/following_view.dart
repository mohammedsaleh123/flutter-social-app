import 'package:flutter/material.dart';
import 'package:socialapp/futures/following/view/following_body.dart';

class FollowingView extends StatelessWidget {
  const FollowingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FollowingBody(),
    );
  }
}
