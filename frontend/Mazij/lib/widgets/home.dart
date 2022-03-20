import 'package:flutter/material.dart';
import 'package:Mazaj/screens/feed/feed.dart';
import 'package:Mazaj/screens/collab/collab_mashup.dart';
import 'package:Mazaj/screens/library/libraries.dart';
import 'package:Mazaj/screens/profiles/profile_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _pageController =
      PageController(); // to control which page is visible in a pageview
  int _index = 0;

  static const List<Widget> _pages = <Widget>[
    // list of screens to be displayed
    Profile(),
    Feed(),
    Libraries(),
    CollabMashup(),
  ];

  void _onPageChanged(int indexAt) {
    // to set the index of the page clicked to _index
    setState(() {
      _index = indexAt;
    });
  }

  void _onItemTapped(int _index) {
    _pageController.jumpToPage(_index); // to change to the selected page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        // to display the pages mentioned above
        controller: _pageController,
        children: _pages,
        onPageChanged: _onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting, // animation
        backgroundColor: const Color(0xFFFFFFFF),
        selectedItemColor: const Color(0xFF326EF1),
        unselectedItemColor: Colors.black,
        selectedFontSize: 14,
        unselectedFontSize: 14,

        onTap:
            _onItemTapped, // to get the index of the page tapped in the bottom bar

        items: const [
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.person),
          ),
          BottomNavigationBarItem(
            label: "Feed",
            icon: Icon(Icons.photo_camera_back_outlined),
          ),
          BottomNavigationBarItem(
            label: "Libraries",
            icon: Icon(Icons.menu_book),
          ),
          BottomNavigationBarItem(
            label: "Collaborate and Mashup",
            icon: Icon(Icons.cut),
          ),
        ],
        currentIndex:
            _index, // index of item(page) in the currently used bottom bar
      ),
    );
  }
}
