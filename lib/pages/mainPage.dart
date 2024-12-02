import 'package:flutter/material.dart';
import 'package:movies/pages/WatchList/watchList.dart';
import 'package:movies/pages/favorite.dart';
import 'package:movies/pages/homePage.dart';
import 'package:movies/pages/moviesPage.dart';
import 'package:movies/pages/settings/settingspage.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;

  final PageController pageController = PageController();

  void onTapped(int index) {
    pageController.jumpToPage(index); // Navigate to the selected page
  }

  void onPageChanged(int index) {
    setState(() {
      selectedIndex = index; // Update selected index when page changes
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged, // Listen to page changes
        children: [
          const Homepage(),
          MovieGridPage(),
          const Favorite(),
          const Watchlist(),
          const Settingspage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.play_circle_outline_rounded), label: 'Movies'),
          BottomNavigationBarItem(
              icon: Icon(Icons.folder_outlined), label: 'TV Series'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_outline_rounded), label: 'Watch List'),
          BottomNavigationBarItem(
              icon: Icon(Icons.segment_rounded), label: 'More'),
        ],
        currentIndex: selectedIndex,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.amber,
        onTap: onTapped, // Handle taps on the BottomNavigationBar
      ),
    );
  }
}
