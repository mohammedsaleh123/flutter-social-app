import 'package:flutter/material.dart';
import 'package:socialapp/core/app_colors.dart';
import 'package:socialapp/futures/addpost/view/add_post_view.dart';
import 'package:socialapp/futures/savedposts/view/saved_posts_view.dart';
import 'package:socialapp/futures/home/view/home_view.dart';
import 'package:socialapp/futures/profile/view/profile_view.dart';
import 'package:socialapp/futures/savedchat/view/saved_chat_view.dart';
import 'package:socialapp/futures/search/view/search_view.dart';

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
    const AddPostView(),
    const SearchView(),
    const SavedPostsView(),
    const SavedChatView(),
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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.save_as),
            label: 'saved posts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'saved chats',
          ),
        ],
      ),
      body: pages[currentIndex],
    );
  }
}
