import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialapp/core/app_colors.dart';
import 'package:socialapp/futures/addpost/view/add_post_view.dart';
import 'package:socialapp/futures/followers/view/followers_view.dart';
import 'package:socialapp/futures/following/view/following_view.dart';
import 'package:socialapp/futures/savedposts/view/saved_posts_view.dart';
import 'package:socialapp/futures/home/view/home_view.dart';
import 'package:socialapp/futures/profile/view/profile_view.dart';

// ignore: must_be_immutable
class NavBarView extends StatefulWidget {
  const NavBarView({super.key});

  @override
  State<NavBarView> createState() => _NavBarViewState();
}

class _NavBarViewState extends State<NavBarView> {
  int currentIndex = 0;
  List<Widget> pages = [
    HomeView(),
    const ProfileView(),
    AddPostView(),
    const FollowingView(),
    const FollowersView(),
    const SavedPostsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        currentIndex: currentIndex,
        selectedItemColor: lightC,
        unselectedItemColor: offLightC,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Post',
          ),
          BottomNavigationBarItem(
            icon: ClipRRect(
                borderRadius: BorderRadius.circular(100.sp),
                child: Image.asset('assets/icons/following.png', height: 20.h)),
            label: 'Following',
          ),
          BottomNavigationBarItem(
            icon: ClipRRect(
                borderRadius: BorderRadius.circular(100.sp),
                child: Image.asset('assets/icons/followers.png', height: 20.h)),
            label: 'Followers',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'Saved posts',
          ),
        ],
      ),
      body: pages[currentIndex],
    );
  }
}
