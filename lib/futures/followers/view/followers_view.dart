import 'package:flutter/material.dart';
import 'package:socialapp/futures/followers/view/followers_body.dart';

class FollowersView extends StatelessWidget {
  const FollowersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FollowersBody(),
    );
  }
}
