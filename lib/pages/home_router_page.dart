import 'package:comeon/core/project_utilitys.dart';
import 'package:comeon/pages/community.dart';
import 'package:comeon/pages/create_post.dart';
import 'package:comeon/pages/events.dart';
import 'package:comeon/pages/home.dart';
import 'package:comeon/pages/my_posts.dart';
import 'package:comeon/pages/profile.dart';
import 'package:flutter/material.dart';

class homeRouterPage extends StatefulWidget {
  const homeRouterPage({super.key});

  @override
  State<homeRouterPage> createState() => _homeRouterPageState();
}

class _homeRouterPageState extends State<homeRouterPage> {
  List pages = [
    MyPosts(),
    events(),
    homePage(),
    createPost(),
    profilePage(),
  ];
  int currentIndex = 2;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: ProjectColors.DarkBlue,
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: ProjectColors.White,
        unselectedItemColor: ProjectColors.PassiveIcon,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.insert_drive_file_outlined),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.groups_outlined),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.home_outlined),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.note_add_outlined),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
    );
  }
}
