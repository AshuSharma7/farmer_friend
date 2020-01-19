import 'package:farmers_clubbing/Diary.dart';
import 'package:farmers_clubbing/FeedPage.dart';
import 'package:farmers_clubbing/Profie.dart';
import 'package:farmers_clubbing/WeatherPage.dart';
import 'package:farmers_clubbing/alert.dart';
import 'package:farmers_clubbing/bottom_navy_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Messages.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title, this.uid}) : super(key: key);
  final String title;
  final String uid;
  //static String id;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  //PageController _pageController;

  FirebaseUser currentUser;
  final List<Widget> _children = [
    FeedPage(),
    Chat(),
    DiaryWidget(),
    Alert(),
  ];
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: false,
        backgroundColor: Color(0xFFf7418c),
        items: [
          BottomNavyBarItem(
              icon: Icon(Icons.web),
              title: Text('जानकारी'),
              inactiveColor: Colors.black,
              activeColor: Colors.white),
          BottomNavyBarItem(
              icon: Icon(Icons.message),
              title: Text('संदेश'),
              inactiveColor: Colors.black,
              activeColor: Colors.white),
          BottomNavyBarItem(
              icon: Icon(Icons.book),
              title: Text('लेन-देन'),
              inactiveColor: Colors.black,
              activeColor: Colors.white),
          BottomNavyBarItem(
              icon: Icon(Icons.wb_sunny),
              title: Text('मौसम'),
              inactiveColor: Colors.black,
              activeColor: Colors.white),
        ],
        onItemSelected: (index) => setState(() {
          _currentIndex = index;
          // _pageController.animateToPage(index,
          //     duration: Duration(milliseconds: 300), curve: Curves.ease);
        }),
        //Handle button tap
      ),
    );
  }
}
