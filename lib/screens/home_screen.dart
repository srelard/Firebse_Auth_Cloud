import 'package:firebase_backend/config/config.dart';
import 'package:firebase_backend/models/user_data.dart';
import 'package:firebase_backend/screens/feed_screen.dart';
import 'package:firebase_backend/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTab = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          FeedScreen(),
          SearchScreen(),
          CreatePostScreen(),
          ActivityScreen(),
          ProfileScreen(
              userID:
                  Provider.of<UserData>(context, listen: false).currentUserId),
        ],
        onPageChanged: (int index) {
          setState(() {
            _currentTab = index;
          });
        },
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _currentTab,
        onTap: (int index) {
          setState(() {
            _currentTab = index;
          });
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 300), curve: Curves.easeIn);
        },
        activeColor: Palette.activeColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 32,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 32,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.photo_camera,
              size: 32,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.map,
              size: 32,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 32,
            ),
          )
        ],
      ),
    );
  }
}
