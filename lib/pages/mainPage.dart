import 'package:flutter/material.dart';
import 'package:movies/pages/FavoritMovies/favoriteMovies.dart';
import 'package:movies/pages/TvSeries/TvSeriesScreen.dart';
import 'package:movies/pages/homePage.dart';
import 'package:movies/pages/moviesScreen/moviesPage.dart';
import 'package:movies/pages/settings/settingspage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 2;

  late final PageController pageController =
      PageController(initialPage: selectedIndex);

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
        children: const [
          Moviespage(),
          allTvSeries(),
          Homepage(),
          Favoritemovies(),
          Settingspage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.play_circle_outline_rounded), label: 'Movies'),
          BottomNavigationBarItem(
              icon: Icon(Icons.folder_outlined), label: 'TV Series'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_rounded,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline_rounded), label: 'Favorite'),
          BottomNavigationBarItem(
              icon: Icon(Icons.segment_rounded), label: 'More'),
        ],
        currentIndex: selectedIndex,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.amber,
        onTap: onTapped, // Handle taps on the BottomNavigationBar
        selectedIconTheme: const IconThemeData(size: 29),
      ),
    );
  }
}
